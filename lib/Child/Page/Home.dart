import 'dart:async';

import 'package:eloquentapp/Child/Page/Eloquent_Phases/EloquentPhasesPage.dart';
import 'package:eloquentapp/Child/Page/Page1.dart';
import 'package:eloquentapp/Child/Page/WarmUpExercises/WarmUpExercises.dart';
import 'package:eloquentapp/Child/screens/ChildWelcome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eloquentapp/Child/screens/ChildWelcome.dart';
import 'package:url_launcher/url_launcher.dart';

class ChildScreen extends StatefulWidget {
  final String childId;
  final String page;

  ChildScreen({required this.childId, required this.page});

  @override
  _ChildScreenState createState() => _ChildScreenState();
}

class _ChildScreenState extends State<ChildScreen> {
  //this page have 3 function 1-Manage screen time 2-Usage Rate 3- get last used date
  DateTime? _startTime;
  DateTime? _endTime;
  late String ChildID = widget.childId;
  Timer? _timer;
  late User singedInUser;

//usageRate varible-----------
  DateTime? _startTimePage;

  //مدة الاستخدام
  late CollectionReference<Map<String, dynamic>> usageCollection;
//Manage screen time function--------
  Future<void> _loadScreenTime() async {
    DocumentSnapshot? snapshot = await FirebaseFirestore.instance
        .collection('screenTime')
        .doc(widget.childId)
        .get();

    if (snapshot != null && snapshot.exists) {
      final data = snapshot.data() as Map<String, dynamic>?;

      if (data != null) {
        _startTime = data['startTime']?.toDate();
        _endTime = data['endTime']?.toDate();
      }
    }
  }

  void timerCallback() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ChildWelcome(),
        ));
  }

  Future<Duration> getScreenTime() async {
    return await FirebaseFirestore.instance
        .collection('screenTime')
        .doc(ChildID)
        .get()
        .then((doc) => doc.exists
            ? Duration(minutes: doc.data()!['duration'])
            : const Duration(minutes: 45));
  }

  Future<void> initChildScreen() async {
    await _loadScreenTime();
    await getChildData();
    final doc = await getLastUsed();
    final Duration allowedDuration = await getScreenTime();
    if (!doc.exists) {
      await updateLastUsed();
      _timer = Timer(allowedDuration, timerCallback);
    } else {
      final Timestamp lastUsed = doc.data()!['lastUsed'];
      final Duration timeDiff = DateTime.now().difference(lastUsed.toDate());
      if (timeDiff.inDays > 0) {
        await updateLastUsed();
        _timer = Timer(allowedDuration, timerCallback);
      } else if (timeDiff < allowedDuration && timeDiff.inSeconds > 0) {
        _timer = Timer(allowedDuration - timeDiff, timerCallback);
      } else {
        timerCallback();
      }
    }
  }

  @override
  void initState() {
    getCurrentUser();
    getUserData();
    getChildData();
    super.initState();
    // usageCollection =
    //     FirebaseFirestore.instance.collection('Child/${widget.childId}/usage');
  }

//usageRate function---------------------
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _startTimePage = DateTime.now();
  }

  @override
  void dispose() {
    //manage screen time--------------
    if (_timer != null) {
      _timer!.cancel();
      _timer = null;
    }
    //usageRate condation-------
    if (_startTimePage != null) {
      final DateTime endTime = DateTime.now();
      addUsageData(widget.page, _startTimePage!, endTime);
    }

    super.dispose();
  }
//---------------------------------------
  //مدة الإستخدام الاسبوعي

  Future<void> addUsageData(
      String page, DateTime startTime, DateTime endTime) async {
    final CollectionReference<Map<String, dynamic>> usageCollection =
        FirebaseFirestore.instance.collection('usage');
    await usageCollection.add({
      'childId': widget.childId,
      'page': page,
      'startTime': Timestamp.fromDate(startTime.toUtc()),
      'endTime': Timestamp.fromDate(endTime.toUtc())
    });
    await _calculateAverageWeeklyUsage();
  }

  Future<void> _calculateAverageWeeklyUsage() async {
    final CollectionReference<Map<String, dynamic>> usageCollection =
        FirebaseFirestore.instance.collection('usage');
    final DateTime now = DateTime.now();
    final DateTime oneWeekAgo = now.subtract(Duration(days: 7));
    final QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await usageCollection
            .where('childId', isEqualTo: widget.childId)
            .where('startTime',
                isGreaterThanOrEqualTo: Timestamp.fromDate(oneWeekAgo.toUtc()))
            .get();
    final List<DocumentSnapshot<Map<String, dynamic>>> documents =
        querySnapshot.docs;
    final Map<String, double> pageDurations = {};
    // Calculate the total duration and count the number of visits for each page
    for (final document in documents) {
      final String page = document.get('page');
      final DateTime startTime =
          (document.get('startTime') as Timestamp).toDate();
      final DateTime endTime = (document.get('endTime') as Timestamp).toDate();
      final double duration =
          endTime.difference(startTime).inSeconds.toDouble();
      pageDurations[page] = (pageDurations[page] ?? 0) + duration;
    }
    final double totalDuration = pageDurations.values.fold(0, (a, b) => a + b);
    final double averageWeeklyDuration =
        totalDuration / 604800; // 7 days in seconds
    // Save the average weekly duration for each page to Cloud Firestore
    final batch = FirebaseFirestore.instance.batch();
    for (final entry in pageDurations.entries) {
      final String page = entry.key;
      final double duration = entry.value;
      final double averageDuration = duration / 604800;
      batch.set(
        FirebaseFirestore.instance.doc('Child/${widget.childId}/pages/$page'),
        {'average_weekly_duration': averageDuration},
        SetOptions(merge: true),
      );
    }
    await batch.commit();
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        singedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  Map<String, dynamic> ParentInfo = {};
  bool isLoded = true;
  getUserData() async {
    await FirebaseFirestore.instance
        .collection('Parent')
        .where("uid", isEqualTo: singedInUser.uid)
        .get()
        .then((v) {
      for (var element in v.docs) {
        ParentInfo.addAll(element.data());
        setState(() {
          isLoded = false;
        });
      }
    });
  }

  late String ParentAvatar = ParentInfo['ParentAvatar'];

  /// last use
  updateLastUsed() {
    FirebaseFirestore.instance
        .collection('lastUsed')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({
          'lastUsed': DateTime.now(),
        }, SetOptions(merge: true))
        .then((_) => print('Last used date updated successfully'))
        .catchError(
            (error) => print('Failed to update last used date: $error'));
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getLastUsed() async {
    return await FirebaseFirestore.instance
        .collection('lastUsed')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
  }

//----------------------------------------------------
  //get Child Date  and store it to ChildInfo Map
  Map<String, dynamic> ChildInfo = {};
  getChildData() async {
    await FirebaseFirestore.instance
        .collection('Child')
        .where("uid", isEqualTo: widget.childId)
        .get()
        .then((v) {
      for (var element in v.docs) {
        ChildInfo.addAll(element.data());
      }
    });
  }

  late String Name = ChildInfo['name'];
  late String ChildAvatar = ChildInfo['ChildAvatar'];
  final Uri _url = Uri.parse('unitydl://unityBookARlink');

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: initChildScreen(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting)
              return const Center(child: CircularProgressIndicator());
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: SafeArea(
                  child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                " أهلًا،" + " " + Name,
                                style: TextStyle(
                                  color: Color(0xff385a4a),
                                  fontSize: 20,
                                  fontFamily: "Cairo",
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    'لنتعلم اليوم شيئًا\nجديدًا مع صديقك حازم',
                                    style: TextStyle(
                                      color: Color(0xff9bb0a5),
                                      fontSize: 15,
                                    ),
                                    textAlign: TextAlign.right,
                                  ),
                                ],
                              )
                            ],
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ChildWelcome(),
                                  ));
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 45),
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                backgroundImage: AssetImage(ParentAvatar),
                                radius: 24,
                              ),
                            ),
                          ),
                        ],
                      )),
                      SizedBox(
                        height: 25,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => WarmUpExercisesPage(
                                    childId: ChildID,
                                    page: 'WarmUpExercisesPage'),
                              ));
                        },
                        child: Container(
                          width: 351,
                          height: 228,
                          child: Card(
                            color: Color(0xffeff4f0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(17.80),
                            ),
                            elevation: 8,
                            shadowColor: Color.fromARGB(127, 0, 0, 0),
                            child: Stack(
                              children: [
                                Positioned(
                                    top: -60,
                                    right: -50,
                                    child: Transform.rotate(
                                      angle: -2.97,
                                      child: Container(
                                        width: 239,
                                        height: 223,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xffd3e7d8),
                                        ),
                                      ),
                                    )),
                                Positioned(
                                  bottom: 0,
                                  left: 0,
                                  child: Container(
                                    width: 193,
                                    height: 182,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage('images/Rabbit.png'),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 70,
                                  right: 30,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "أولاً",
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                          color: Color(0xfffbfbfb),
                                          fontSize: 35,
                                          fontFamily: "Cairo",
                                          fontWeight: FontWeight.w600,
                                          height: 0.8,
                                        ),
                                      ),
                                      Text(
                                        "تمارين الأحماء",
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                          color: Color(0xff385a4a),
                                          fontSize: 35,
                                          fontFamily: "Cairo",
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 28,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EloquentPhasesPage(
                                    childId: ChildID,
                                    page: 'EloquentPhasesPage'),
                              ));
                        },
                        child: Container(
                          width: 351,
                          height: 228,
                          child: Card(
                            color: Color(0xfff7ebd7),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(17)),
                            elevation: 4,
                            shadowColor: Color.fromARGB(127, 0, 0, 0),
                            child: Stack(
                              children: [
                                Positioned(
                                  top: -60,
                                  right: -50,
                                  child: Transform.rotate(
                                    angle: -2.97,
                                    child: Container(
                                      width: 239,
                                      height: 223,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0x99f1bb67),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 0,
                                  bottom: 0,
                                  child: Container(
                                    width: 193,
                                    height: 182,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'images/OrangeRabbit.png'),
                                            fit: BoxFit.cover)),
                                  ),
                                ),
                                Positioned(
                                  top: 70,
                                  right: 30,
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "ثانيًا",
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                              color: Color(0xfff9efea),
                                              fontSize: 35,
                                              fontFamily: "Cairo",
                                              fontWeight: FontWeight.w600,
                                              height: 0.8),
                                        ),
                                        Text(
                                          "مراحل بليغ",
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            color: Color(0xffc77a07),
                                            fontSize: 40,
                                            fontFamily: "Cairo",
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                      ]),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: InkWell(
                          onTap: _launchUrl,
                          child: Image(
                            image: AssetImage('images/CameraChild.png'),
                            width: 95,
                            height: 95,
                          ),
                        ),
                      ),
                    ]),
              )),
            );
          }),
    );
  }
}




// import 'dart:async';

// import 'package:eloquentapp/Child/Page/Eloquent_Phases/EloquentPhasesPage.dart';
// import 'package:eloquentapp/Child/Page/Page1.dart';
// import 'package:eloquentapp/Child/Page/WarmUpExercises/WarmUpExercises.dart';
// import 'package:eloquentapp/Child/screens/ChildWelcome.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:eloquentapp/Child/screens/ChildWelcome.dart';

// class ChildScreen extends StatefulWidget {
//   final String childId;
//   final String page;

//   ChildScreen({required this.childId, required this.page});

//   @override
//   _ChildScreenState createState() => _ChildScreenState();
// }

// class _ChildScreenState extends State<ChildScreen> {
//   //this page have 3 function 1-Manage screen time 2-Usage Rate 3- get last used date
//   DateTime? _startTime;
//   DateTime? _endTime;
//   late String ChildID = widget.childId;
//   Timer? _timer;
// //usageRate varible-----------
//   DateTime? _startTimePage;

//   //مدة الاستخدام
//   late CollectionReference<Map<String, dynamic>> usageCollection;
// //Manage screen time function--------
//   Future<void> _loadScreenTime() async {
//     DocumentSnapshot? snapshot = await FirebaseFirestore.instance
//         .collection('screenTime')
//         .doc(widget.childId)
//         .get();

//     if (snapshot != null && snapshot.exists) {
//       final data = snapshot.data() as Map<String, dynamic>?;

//       if (data != null) {
//         setState(() {
//           _startTime = data['startTime']?.toDate();
//           _endTime = data['endTime']?.toDate();
//         });

//         if (_endTime != null) {
//           _startTimer();
//         }
//       }
//     }
//   }

//   void _startTimer() {
//     if (_endTime == null) {
//       return;
//     }

//     if (_timer != null) {
//       _timer!.cancel();
//       _timer = null;
//     }

//     Duration duration = _endTime!.difference(DateTime.now());

//     if (duration.inSeconds > 0) {
//       _timer = Timer(duration, () {
//         _endTime = null;
//         Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => ChildWelcome(),
//             ));

//         //   Navigator.pushNamedAndRemoveUntil(
//         //       context, '/screens/ChildWelcome', (route) => false);
//       });
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     _loadScreenTime();
//     updateLastUsed();
//     getChildData();

//     // usageCollection =
//     //     FirebaseFirestore.instance.collection('Child/${widget.childId}/usage');
//   }

// //usageRate function---------------------
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     _startTimePage = DateTime.now();
//   }

//   @override
//   void dispose() {
//     //manage screen time--------------
//     if (_timer != null) {
//       _timer!.cancel();
//       _timer = null;
//     }
//     //usageRate condation-------
//     if (_startTimePage != null) {
//       final DateTime endTime = DateTime.now();
//       addUsageData(widget.page, _startTimePage!, endTime);
//     }

//     super.dispose();
//   }
// //---------------------------------------
//   //مدة الإستخدام الاسبوعي

//   Future<void> addUsageData(
//       String page, DateTime startTime, DateTime endTime) async {
//     final CollectionReference<Map<String, dynamic>> usageCollection =
//         FirebaseFirestore.instance.collection('usage');
//     await usageCollection.add({
//       'childId': widget.childId,
//       'page': page,
//       'startTime': Timestamp.fromDate(startTime.toUtc()),
//       'endTime': Timestamp.fromDate(endTime.toUtc())
//     });
//     await _calculateAverageWeeklyUsage();
//   }

//   Future<void> _calculateAverageWeeklyUsage() async {
//     final CollectionReference<Map<String, dynamic>> usageCollection =
//         FirebaseFirestore.instance.collection('usage');
//     final DateTime now = DateTime.now();
//     final DateTime oneWeekAgo = now.subtract(Duration(days: 7));
//     final QuerySnapshot<Map<String, dynamic>> querySnapshot =
//         await usageCollection
//             .where('childId', isEqualTo: widget.childId)
//             .where('startTime',
//                 isGreaterThanOrEqualTo: Timestamp.fromDate(oneWeekAgo.toUtc()))
//             .get();
//     final List<DocumentSnapshot<Map<String, dynamic>>> documents =
//         querySnapshot.docs;
//     final Map<String, double> pageDurations = {};
//     // Calculate the total duration and count the number of visits for each page
//     for (final document in documents) {
//       final String page = document.get('page');
//       final DateTime startTime =
//           (document.get('startTime') as Timestamp).toDate();
//       final DateTime endTime = (document.get('endTime') as Timestamp).toDate();
//       final double duration =
//           endTime.difference(startTime).inSeconds.toDouble();
//       pageDurations[page] = (pageDurations[page] ?? 0) + duration;
//     }
//     final double totalDuration = pageDurations.values.fold(0, (a, b) => a + b);
//     final double averageWeeklyDuration =
//         totalDuration / 604800; // 7 days in seconds
//     // Save the average weekly duration for each page to Cloud Firestore
//     final batch = FirebaseFirestore.instance.batch();
//     for (final entry in pageDurations.entries) {
//       final String page = entry.key;
//       final double duration = entry.value;
//       final double averageDuration = duration / 604800;
//       batch.set(
//         FirebaseFirestore.instance.doc('Child/${widget.childId}/pages/$page'),
//         {'average_weekly_duration': averageDuration},
//         SetOptions(merge: true),
//       );
//     }
//     await batch.commit();
//   }

//   /// last use
//   updateLastUsed() {
//     FirebaseFirestore.instance
//         .collection('lastUsed')
//         .doc(FirebaseAuth.instance.currentUser!.uid)
//         .set({
//           'lastUsed': DateTime.now(),
//         }, SetOptions(merge: true))
//         .then((_) => print('Last used date updated successfully'))
//         .catchError(
//             (error) => print('Failed to update last used date: $error'));
//   }

// //----------------------------------------------------
//   bool isLoded = true;
//   //get Child Date  and store it to ChildInfo Map
//   Map<String, dynamic> ChildInfo = {};
//   getChildData() async {
//     await FirebaseFirestore.instance
//         .collection('Child')
//         .where("uid", isEqualTo: widget.childId)
//         .get()
//         .then((v) {
//       for (var element in v.docs) {
//         ChildInfo.addAll(element.data());

//         setState(() {
//           isLoded = false;
//         });
//       }
//     });
//   }

//   late String Name = ChildInfo['name'];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: isLoded == true
//             ? Center(child: CircularProgressIndicator())
//             : Padding(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
//                 child: SafeArea(
//                     child: SingleChildScrollView(
//                   child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Container(
//                             child: Row(
//                           children: [
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   " أهلًا،" + " " + Name,
//                                   style: TextStyle(
//                                     color: Color(0xff385a4a),
//                                     fontSize: 20,
//                                     fontFamily: "Cairo",
//                                     fontWeight: FontWeight.w700,
//                                   ),
//                                 ),
//                                 Row(
//                                   children: [
//                                     Text(
//                                       'لنتعلم اليوم شيئًا\nجديدًا مع صديقك حازم',
//                                       style: TextStyle(
//                                         color: Color(0xff9bb0a5),
//                                         fontSize: 15,
//                                       ),
//                                       textAlign: TextAlign.right,
//                                     ),
//                                   ],
//                                 )
//                               ],
//                             ),
//                             Spacer(),
//                             GestureDetector(
//                               onTap: () {
//                                 Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                       builder: (context) => ChildWelcome(),
//                                     ));
//                               },
//                               child: Padding(
//                                 padding: const EdgeInsets.only(bottom: 45),
//                                 child: CircleAvatar(
//                                   backgroundColor: Colors.white,
//                                   child: Image.asset("images/Mother.png"),
//                                   radius: 24,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         )),
//                         SizedBox(
//                           height: 25,
//                         ),

//                         GestureDetector(
//                           onTap: () {
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => WarmUpExercisesPage(),
//                                 ));
//                           },
//                           child: Container(
//                             width: 351,
//                             height: 228,
//                             child: Card(
//                               color: Color(0xffeff4f0),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(17.80),
//                               ),
//                               elevation: 8,
//                               shadowColor: Color.fromARGB(127, 0, 0, 0),
//                               child: Stack(
//                                 children: [
//                                   Positioned(
//                                       top: -60,
//                                       right: -50,
//                                       child: Transform.rotate(
//                                         angle: -2.97,
//                                         child: Container(
//                                           width: 239,
//                                           height: 223,
//                                           decoration: BoxDecoration(
//                                             shape: BoxShape.circle,
//                                             color: Color(0xffd3e7d8),
//                                           ),
//                                         ),
//                                       )),
//                                   Positioned(
//                                     bottom: 0,
//                                     left: 0,
//                                     child: Container(
//                                       width: 193,
//                                       height: 182,
//                                       decoration: BoxDecoration(
//                                         image: DecorationImage(
//                                           image:
//                                               AssetImage('images/Rabbit.png'),
//                                           fit: BoxFit.cover,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   Positioned(
//                                     top: 70,
//                                     right: 30,
//                                     child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                           "أولاً",
//                                           textAlign: TextAlign.right,
//                                           style: TextStyle(
//                                             color: Color(0xfffbfbfb),
//                                             fontSize: 35,
//                                             fontFamily: "Cairo",
//                                             fontWeight: FontWeight.w600,
//                                             height: 0.8,
//                                           ),
//                                         ),
//                                         Text(
//                                           "تمارين الأحماء",
//                                           textAlign: TextAlign.right,
//                                           style: TextStyle(
//                                             color: Color(0xff385a4a),
//                                             fontSize: 35,
//                                             fontFamily: "Cairo",
//                                             fontWeight: FontWeight.w900,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           height: 28,
//                         ),
//                         GestureDetector(
//                           onTap: () {
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => EloquentPhasesPage(),
//                                 ));
//                           },
//                           child: Container(
//                             width: 351,
//                             height: 228,
//                             child: Card(
//                               color: Color(0xfff7ebd7),
//                               shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(17)),
//                               elevation: 4,
//                               shadowColor: Color.fromARGB(127, 0, 0, 0),
//                               child: Stack(
//                                 children: [
//                                   Positioned(
//                                     top: -60,
//                                     right: -50,
//                                     child: Transform.rotate(
//                                       angle: -2.97,
//                                       child: Container(
//                                         width: 239,
//                                         height: 223,
//                                         decoration: BoxDecoration(
//                                           shape: BoxShape.circle,
//                                           color: Color(0x99f1bb67),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   Positioned(
//                                     left: 0,
//                                     bottom: 0,
//                                     child: Container(
//                                       width: 193,
//                                       height: 182,
//                                       decoration: BoxDecoration(
//                                           image: DecorationImage(
//                                               image: AssetImage(
//                                                   'images/OrangeRabbit.png'),
//                                               fit: BoxFit.cover)),
//                                     ),
//                                   ),
//                                   Positioned(
//                                     top: 70,
//                                     right: 30,
//                                     child: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Text(
//                                             "ثانيًا",
//                                             textAlign: TextAlign.right,
//                                             style: TextStyle(
//                                                 color: Color(0xfff9efea),
//                                                 fontSize: 35,
//                                                 fontFamily: "Cairo",
//                                                 fontWeight: FontWeight.w600,
//                                                 height: 0.8),
//                                           ),
//                                           Text(
//                                             "مراحل بليغ",
//                                             textAlign: TextAlign.right,
//                                             style: TextStyle(
//                                               color: Color(0xffc77a07),
//                                               fontSize: 40,
//                                               fontFamily: "Cairo",
//                                               fontWeight: FontWeight.w900,
//                                             ),
//                                           ),
//                                         ]),
//                                   )
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           height: 20,
//                         ),
//                         Align(
//                           alignment: Alignment.center,
//                           child: InkWell(
//                             onTap: () {
//                               // Handle button tap
//                             },
//                             child: Image(
//                               image: AssetImage('images/CameraChild.png'),
//                               width: 95,
//                               height: 95,
//                             ),
//                           ),
//                         ),

//                         // if (_endTime != null)
//                         //   Text(
//                         //     'Time remaining: ${_endTime!.difference(DateTime.now()).inSeconds} seconds',
//                         //     style: TextStyle(fontSize: 18),
//                         //   ),
//                         // ElevatedButton(
//                         //     onPressed: () async {
//                         //       Navigator.push(
//                         //         context,
//                         //         MaterialPageRoute(
//                         //             builder: (context) => ChildPage(
//                         //                 childId: ChildID, page: 'Page1')),
//                         //       );
//                         //     },
//                         //     child: Text("Page1"))
//                       ]),
//                 )),
//               ));
//   }
// }
