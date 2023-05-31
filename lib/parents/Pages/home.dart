import 'package:eloquentapp/Child/screens/ChildWelcome.dart';
import 'package:eloquentapp/parents/Pages/ChildFile/childProfileOLD.dart';
import 'package:eloquentapp/parents/Pages/ChildFile/childProfileP.dart';
import 'package:eloquentapp/parents/Pages/TherapistList/TherapistListPage.dart';
import 'package:eloquentapp/parents/Pages/blogs/allblogs.dart';
import 'package:eloquentapp/parents/Pages/blogs/bloglist.dart';
import 'package:eloquentapp/parents/Pages/blogs/mybloglist.dart';
import 'package:eloquentapp/parents/Register_Login_Page/child_Registration.dart';
import 'package:eloquentapp/screens/callPage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class ParentHomeScreen extends StatefulWidget {
  static String id = 'Home_screen';

  @override
  State<ParentHomeScreen> createState() => _ParentHomeScreenState();
}

class _ParentHomeScreenState extends State<ParentHomeScreen> {
  //instance of  firestore auth
  final _auth = FirebaseAuth.instance;
  late User singedInUser;
  //get current user
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

  void initState() {
    super.initState();
    getCurrentUser();
    getUserData();
    getChildData();
    getSessionData();
    todaySessions();
    getLastUsedDate();
  }

  bool isLoded = true;
  //get Parent Date  and store it to Map
  Map<String, dynamic> ParentData = {};
  getUserData() async {
    await FirebaseFirestore.instance
        .collection('Parent')
        .where("uid", isEqualTo: singedInUser.uid)
        .get()
        .then((v) {
      for (var element in v.docs) {
        ParentData.addAll(element.data());
        setState(() {
          isLoded = false;
        });
      }
    });
  }

  bool hasChild = true;
  //get Child Date  and store it to ChildInfo Map
  Map<String, dynamic> ChildInfo = {};
  getChildData() async {
    await FirebaseFirestore.instance
        .collection('Child')
        .where("uidParent", isEqualTo: singedInUser.uid)
        .get()
        .then((v) {
      for (var element in v.docs) {
        ChildInfo.addAll(element.data());

        setState(() {
          hasChild = false;
        });
      }
    });
  }

  late String ChildName = ChildInfo['name'];
  late String Name = ParentData['name'];
  late String ChildID = ChildInfo['uid'];
  late String ChildAvatar = ChildInfo['ChildAvatar'];

  Map<String, dynamic> SessionData = {};

  getSessionData() async {
    await FirebaseFirestore.instance
        .collection('acceptedSessions')
        .where("ParentId", isEqualTo: singedInUser.uid)
        .get()
        .then((v) {
      for (var element in v.docs) {
        SessionData.addAll(element.data());
      }
    });
  }

  late String SessionID = SessionData['sessionID'];
  late String childName = SessionData['ChildName'];

  //جلسة اليوم
  bool hasTodaySession = true;
  Map<String, dynamic> TodaySesion = {};
  DateTime currentDate = DateTime.now();
  late String formattedCurrentDate =
      DateFormat('dd/M/yyyy').format(currentDate);
  todaySessions() async {
    await FirebaseFirestore.instance
        .collection('acceptedSessions')
        .where('ParentId', isEqualTo: singedInUser.uid)
        .where('Parentstatus', isEqualTo: 'accepted')
        .where('Date', isEqualTo: formattedCurrentDate)
        .get()
        .then((v) {
      for (var element in v.docs) {
        TodaySesion.addAll(element.data());

        setState(() {
          hasTodaySession = false;
        });
      }
    });
  }

  late String timeRange = TodaySesion['TimeRange'];

  //Get lastUsed Date

  Map<String, dynamic> lastUsed = {};
  late String lastUsedDateString;
  bool HasLastUsed = true;
  getLastUsedDate() async {
    await FirebaseFirestore.instance
        .collection('lastUsed')
        .doc(singedInUser.uid)
        .get()
        .then((doc) {
      if (doc.exists) {
        lastUsed = doc.data()!;
        Timestamp timestamp = lastUsed['lastUsed'];
        DateTime dateTime = timestamp.toDate();
        String monthName = DateFormat.MMMM().format(dateTime);
        setState(() {
          lastUsedDateString =
              DateFormat('dd/MM/yyyy', 'en_US').format(dateTime);
          HasLastUsed = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      //9BB0A5

      body: isLoded == true
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: SafeArea(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
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
                                    " اهلاَ " + Name,
                                    style: TextStyle(
                                      color: Color(0xff385a4a),
                                      fontSize: 20,
                                      fontFamily: "Cairo",
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    'اليوم يومًا جميلًا\n لتعلم شيء جديد مع طفلك',
                                    style: TextStyle(
                                      color: Color(0xff9bb0a5),
                                      fontSize: 13,
                                    ),
                                    textAlign: TextAlign.right,
                                  )
                                ],
                              ),
                              Spacer(),
                              hasChild == true
                                  ? Text("")
                                  : GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ChildWelcome(),
                                            ));
                                      },
                                      child: CircleAvatar(
                                        backgroundColor: Colors.white,
                                        child: Image.asset(ChildAvatar),
                                        radius: 24,
                                      ),
                                    )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        hasChild == true
                            ? Card(
                                elevation: 4,
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(17.80)),
                                child: Column(
                                  children: [
                                    ListTile(
                                      title: Text(
                                        "اضف بيانات طفلك وابدأ في تتبع تقدمه وتقاريره",
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                          color: Color(0xff687c71),
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    Color(0xff394445),
                                              ),
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          ChildRegistration(),
                                                    ));
                                              },
                                              child: Text("انشاء حساب الطفل")),
                                        ]),
                                  ],
                                ),
                              )
                            : Card(
                                elevation: 4,
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(17.80)),
                                child: Column(
                                  children: [
                                    ListTile(
                                      leading: GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ChildProfile(
                                                        Childid: ChildID),
                                              ));
                                        },
                                        child: CircleAvatar(
                                          radius: 24,
                                          backgroundColor: Color(0xffEFF5F2),
                                          foregroundColor: Color(0xffEFF5F2),
                                          backgroundImage:
                                              AssetImage(ChildAvatar),
                                        ),
                                      ),
                                      title: Text(
                                        ChildName,
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                          color: Color(0xff385a4a),
                                          fontSize: 16,
                                          fontFamily: "Cairo",
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      subtitle: HasLastUsed == true
                                          ? Text(
                                              "اخر استخدام: لا يوجد تاريخ اخر استخدام بعد  ",
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                                color: Color(0xff6888a0),
                                                fontSize: 12,
                                              ),
                                            )
                                          : Text(
                                              "اخر استخدام: $lastUsedDateString ",
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                                color: Color(0xff6888a0),
                                                fontSize: 12,
                                              ),
                                            ),
                                      trailing: Icon(Icons.more_vert),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              minimumSize: Size(90, 33),
                                              backgroundColor:
                                                  Color(0xff394445),
                                              elevation: 3,
                                              shape:
                                                  const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(6)),
                                              )),
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ChildProfile(
                                                          Childid: ChildID),
                                                ));
                                          },
                                          child: Text(
                                            'التقارير',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 13,
                                              fontFamily: "Cairo",
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              minimumSize: Size(90, 33),
                                              backgroundColor:
                                                  Color(0xff394445),
                                              elevation: 3,
                                              shape:
                                                  const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(6)),
                                              )),
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ChildProfile(
                                                          Childid: ChildID),
                                                ));
                                          },
                                          child: Text(
                                            'تتبع حالة الطفل',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 13,
                                              fontFamily: "Cairo",
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),

                        //----------------------جلسة اليوم--------------------------------
                        SizedBox(
                          height: 18,
                        ),
                        Text(
                          "جلسة اليوم ",
                          style: TextStyle(
                            color: Color(0xff385a4a),
                            fontSize: 16,
                            fontFamily: "Cairo",
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: 18,
                        ),
                        hasTodaySession == true
                            ? Card(
                                elevation: 4,
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(17.80)),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(25.0),
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  Color(0xff394445),
                                            ),
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        TherapistListPage(),
                                                  ));
                                            },
                                            child: Text(
                                                "احجز الآن جلسة طفلك الاولى مع الاخصائي")),
                                      ),
                                    ]),
                              )
                            : Card(
                                elevation: 0,
                                color: Color(0x0c9bb0a5),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(11)),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),

                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: Column(
                                          children: [
                                            Text(timeRange.split(' - ')[
                                                0]), // Display the start time
                                            Container(
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 8.0),
                                              height: 28.0,
                                              child: VerticalDivider(
                                                  color: Color.fromARGB(
                                                      255, 0, 0, 0)),
                                            ), // Display the vertical line
                                            Text(timeRange.split(' - ')[
                                                1]), // Display the end time
                                          ],
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                'جلسة ' +
                                                    TodaySesion['SessionName'],
                                                textAlign: TextAlign.right,
                                                style: TextStyle(
                                                  color: Color(0xff385a4a),
                                                  fontSize: 17,
                                                  fontFamily: "Cairo",
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            children: [
                                              Image.asset(
                                                "images/NameCard.png",
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                'د/ ' +
                                                    TodaySesion[
                                                        'TherapistName'],
                                                // TodaySesion['Date'],
                                                style: const TextStyle(
                                                  color: Color(0xff6888a0),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          ElevatedButton(
                                            onPressed: () async {},
                                            child: Text(
                                              "حضور الجلسة ",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontFamily: "Cairo",
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            style: ElevatedButton.styleFrom(
                                                minimumSize: Size(20, 30),
                                                backgroundColor:
                                                    Color(0xff394445),
                                                shape:
                                                    const RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10)),
                                                )),
                                          ),
                                          // ElevatedButton(
                                          //   onPressed: () async {},
                                          //   child: Text(
                                          //     "تفاصيل الجلسة ",
                                          //     style: TextStyle(
                                          //       color: Color.fromARGB(255, 0, 0, 0),
                                          //       fontSize: 12,
                                          //       fontFamily: "Cairo",
                                          //       fontWeight: FontWeight.w500,
                                          //     ),
                                          //   ),
                                          //   style: ElevatedButton.styleFrom(
                                          //       elevation: 0,
                                          //       minimumSize: Size(40, 30),
                                          //       backgroundColor: Color.fromARGB(
                                          //           0, 155, 176, 165),
                                          //       shape: const RoundedRectangleBorder(
                                          //         borderRadius: BorderRadius.all(
                                          //             Radius.circular(10)),
                                          //       )),
                                          // ),
                                        ],
                                      ),
                                    ],
                                  ),

                                  // title: Text(
                                  //   documentSnapshot['name'],
                                  //   textAlign: TextAlign.right,
                                  //   style: TextStyle(
                                  //     color: Color(0xff385a4a),
                                  //     fontSize: 15,
                                  //     fontFamily: "Cairo",
                                  //     fontWeight: FontWeight.w700,
                                  //   ),
                                  // ),
                                  // subtitle: Text(
                                  //   documentSnapshot['ParentName'],
                                  //   textAlign: TextAlign.right,
                                  //   style: TextStyle(
                                  //     color: Color(0xff6888a0),
                                  //     fontSize: 12,
                                  //   ),
                                  // ),
                                ),
                              ),

                        //------------------------------------------------------
                        // ElevatedButton(
                        //   onPressed: () {
                        //     Navigator.push(context, MaterialPageRoute(
                        //       builder: (context) {
                        //         return CallPage(
                        //           callID: SessionID,
                        //           UserId: singedInUser.uid,
                        //           Name: childName,
                        //         );
                        //       },
                        //     ));
                        //   },
                        //   child: Text(
                        //     "حضور الجلسة ",
                        //     style: TextStyle(
                        //       color: Colors.white,
                        //       fontSize: 12,
                        //       fontFamily: "Rubik",
                        //       fontWeight: FontWeight.w500,
                        //     ),
                        //   ),
                        //   style: ElevatedButton.styleFrom(
                        //       minimumSize: Size(40, 30),
                        //       backgroundColor: Color(0xff406553),
                        //       shape: const RoundedRectangleBorder(
                        //         borderRadius: BorderRadius.all(Radius.circular(10)),
                        //       )),
                        // ),
                        // ElevatedButton(
                        //   onPressed: () {
                        //     Navigator.push(context, MaterialPageRoute(
                        //       builder: (context) {
                        //         return CallPage(
                        //           callID: "call",
                        //           UserId: singedInUser.uid,
                        //         );
                        //       },
                        //     ));
                        //   },
                        //   child: Text('vediocall'),
                        // ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "المدونات",
                          style: TextStyle(
                            color: Color(0xff385a4a),
                            fontSize: 23,
                            fontFamily: "Cairo",
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Expanded(
                          child: allblogs(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}

// class TowCardButton extends StatelessWidget {
//   final String buttonText;
//   final Function onpressed;
//   TowCardButton({required this.buttonText, required this.onpressed});

//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       style: ElevatedButton.styleFrom(
//           minimumSize: Size(90, 33),
//           backgroundColor: Color.fromARGB(255, 50, 128, 135),
//           elevation: 3,
//           shape: const RoundedRectangleBorder(
//             borderRadius: BorderRadius.all(Radius.circular(6)),
//           )),
//       onPressed: onpressed(),
//       child: Text(
//         buttonText,
//         style: TextStyle(
//           color: Colors.white,
//           fontSize: 13,
//           fontFamily: "Cairo",
//           fontWeight: FontWeight.w500,
//         ),
//       ),
//     );
//   }
// }

/*
  //instance for auth
  final _auth = FirebaseAuth.instance;
  //instance for cloud firestore
  final _firestore = FirebaseFirestore.instance;
  final _parentRef = FirebaseFirestore.instance.collection("Parent");
  late User singedInUser;
  late String _name;
  // late String _uID;

  void initState() {
    super.initState();
    getCurrentUser();
    _fetch();
  }

  //Get User info from database
  _fetch() async {
    final firebaseUser = await FirebaseAuth.instance.currentUser;
    if (firebaseUser != null)
      await FirebaseFirestore.instance
          .collection("Parent")
          .doc(firebaseUser.uid)
          .get()
          .then((ds) {
        _name = ds.get("Name");
      }).catchError((e) {
        print(e);
      });
  }

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

  // void getUserDataById() async {
  //   final _therapist = FirebaseFirestore.instance.collection("Parent");
  //   final QuerySnapshot snapshot =
  //       await _therapist.where("Uuid", isEqualTo: UserId).get();

  //   snapshot.docs.forEach((DocumentSnapshot doc) {
  //     print(doc.get("Name"));
  //   });
  // }
*/
