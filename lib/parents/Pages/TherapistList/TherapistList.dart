import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eloquentapp/parents/Pages/Therapis_Profile/ProfileTherapist.dart';
import 'package:eloquentapp/therapist/available_times/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class TherapistList extends StatefulWidget {
  static String id = 'therapistList_screen';

  @override
  State<TherapistList> createState() => _TherapistListState();
}

class _TherapistListState extends State<TherapistList> {
  //instance for cloud firestore
  final _firestore = FirebaseFirestore.instance;

  late String _ParentName;
  late String _TherapistName;
  late String _TherapistID;

//get therapistList up-to-date
  void TherpaistStreem() async {
    await for (var snapshot in _firestore.collection('Therapist').snapshots()) {
      for (var therapist in snapshot.docs) {
        print(therapist.data());
      }
    }
    ;
  }

  void initState() {
    super.initState();

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
        _ParentName = ds.get("Name");
      }).catchError((e) {
        print(e);
      });
  }

  //----------------------------------

  Future getAverageRating(String therapistId) async {
    final CollectionReference ratingsCollection =
        FirebaseFirestore.instance.collection('ratings');
    final QuerySnapshot ratingsSnapshot = await ratingsCollection
        .where('TherapistID', isEqualTo: therapistId)
        .get();

    final List<DocumentSnapshot> ratingDocs = ratingsSnapshot.docs;

    final List ratings = ratingDocs.map((doc) => doc['rating']).toList();

    final double averageRating = ratings.isNotEmpty
        ? ratings.reduce((a, b) => a + b) / ratings.length
        : 0.0;

    return averageRating;
  }

  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  final CollectionReference usersRef = _db.collection('Therapist');
  late Query query = usersRef.where('active', isEqualTo: true);

  late Stream<QuerySnapshot> usersStream = query.snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0XFFFBFBFB),
        body: StreamBuilder<QuerySnapshot>(
          stream: usersStream,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text('Loading...');
            }

            final List<DocumentSnapshot> therapistDocs = snapshot.data!.docs;

            return ListView.builder(
              itemCount: therapistDocs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot therapistDoc = therapistDocs[index];
                return FutureBuilder<Widget>(
                  future: buildTherapistCard(therapistDoc),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return snapshot.data!;
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                );
              },
            );
          },
        ));
  }

  String getTimeRanges(String timeRanges) {
    final List<String> timeRangesList = timeRanges.split('-');
    final List<TimeOfDay> formattedTimeRanges = [];
    for (int i = 0; i < timeRangesList.length; i++) {
      final List<int> nums =
          timeRangesList[i].split(':').map((e) => int.parse(e)).toList();
      final TimeOfDay timeOfDay = TimeOfDay(
        hour: nums.first,
        minute: nums.last,
      );
      formattedTimeRanges.add(timeOfDay);
    }
    return '${formattedTimeRanges.first.format(context)} - ${formattedTimeRanges.last.format(context)}';
  }

  Future<Widget> buildTherapistCard(DocumentSnapshot documentSnapshot) async {
    final double averageRating =
        await getAverageRating(documentSnapshot['uid']);

    return Card(
      elevation: 4,
      shadowColor: Color.fromARGB(105, 0, 0, 0),
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(17.80)),
      child: Container(
        // width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 13),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  child: CircleAvatar(
                    backgroundColor: Color(0xffEFF5F2),
                    foregroundColor: Color(0xffEFF5F2),
                    backgroundImage:
                        AssetImage(documentSnapshot['TherapistAvatar']),
                  ),
                ),
                SizedBox(
                  width: 6,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Therapist  Name
                    Text(
                      documentSnapshot['name'],
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Color(0xff385a4a),
                        fontSize: 15,
                        fontFamily: "Cairo",
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    //Therapist  Email
                    Text(
                      documentSnapshot['email'],
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Color(0xff6888a0),
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Row(
                  children: [
                    RatingBar.builder(
                      itemSize: 15,
                      initialRating: averageRating,
                      minRating: 1,
                      maxRating: 5,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        // Handle rating updates here.
                      },
                    ),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 40),
                  child: Row(
                    children: [
                      Image.asset("images/CenterName.png"),
                      SizedBox(
                        width: 2,
                      ),
                      Text(
                        documentSnapshot['centerName'],
                        style: TextStyle(
                          color: Color(0xff687c71),
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection(
                          'Therapist/${documentSnapshot["uid"]}/AvilableTime')
                      .get(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState != ConnectionState.done) {
                      return const SizedBox(
                        width: 10,
                        child: FittedBox(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                    if (!snapshot.hasData || snapshot.data!.size == 0) {
                      return Row(
                        children: [
                          Image.asset("images/timer.png"),
                          SizedBox(
                            width: 10,
                          ),
                          const Text(
                            'لا يوجد وقت متاح',
                            style: TextStyle(
                              color: Color.fromARGB(255, 161, 148, 147),
                              fontSize: 11,
                            ),
                          ),
                        ],
                      );
                    }
                    String? nearestAvailableTime;
                    int monthIndex = DateTime.now().month;
                    for (int docIndex = 0;
                        docIndex < snapshot.data!.size;
                        docIndex++) {
                      if (nearestAvailableTime != null) break;
                      if (int.parse(snapshot.data!.docs[docIndex].id) <
                          monthIndex) continue;
                      final availableTimes =
                          parseTimes(snapshot.data!.docs[docIndex].data());
                      int weekIndex = (DateTime.now().day / 7).ceil();
                      int dayOfWeekIndex = ((DateTime.now().day - 1) % 7) + 1;
                      for (weekIndex;
                          weekIndex <= availableTimes.length;
                          weekIndex++) {
                        if (nearestAvailableTime != null) break;
                        for (dayOfWeekIndex;
                            dayOfWeekIndex <=
                                availableTimes[weekIndex.toString()]!.length;
                            dayOfWeekIndex++) {
                          if (nearestAvailableTime != null) break;
                          final Map<String, bool>? weekSheet = availableTimes[
                              weekIndex.toString()]![dayOfWeekIndex.toString()];
                          if (weekSheet != null &&
                              weekSheet.containsValue(true)) {
                            final String timeIndex = weekSheet.entries
                                .firstWhere((element) => element.value == true)
                                .key;
                            nearestAvailableTime =
                                'اقرب وقت متاح اليوم\n${getTimeRanges(timeIndex)}';
                          }
                        }
                        dayOfWeekIndex = 1;
                      }
                      monthIndex++;
                    }
                    if (nearestAvailableTime == null) {
                      return const Text(
                        '',
                        style: TextStyle(
                          fontSize: 11,
                        ),
                      );
                    }
                    return Row(
                      children: [
                        Image.asset("images/timer.png"),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          nearestAvailableTime,
                          style: const TextStyle(
                            color: Color(0xff687c71),
                            fontSize: 11,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(129, 33),
                      backgroundColor: Color(0xff394445),
                      elevation: 3,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                      )),
                  onPressed: () {
                    late String name = documentSnapshot['name'];
                    late String uid = documentSnapshot['uid'];

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Profilet(
                            therapisid: uid,
                          ),
                        ));
                  },
                  child: Text(
                    'احجز جلستك  ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: "Cairo",
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
