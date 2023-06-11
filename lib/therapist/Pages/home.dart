import 'package:eloquentapp/therapist/Pages/sceduleds/TodaySession.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import 'package:table_calendar/table_calendar.dart';

class TherapistHomeScreen extends StatefulWidget {
  static String id = 'TherapistHome_screen';

  @override
  State<TherapistHomeScreen> createState() => _TherapistHomeScreenState();
}

class _TherapistHomeScreenState extends State<TherapistHomeScreen> {
  //instance for cloud firestore
  final _auth = FirebaseAuth.instance;

  late User singedInUser;
  @override
  void initState() {
    super.initState();
    getCurrentUser();
    getUserData();
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

  Map<String, dynamic> TherapisData = {};
  bool isLoded = true;
  //get all user data and store to Map
  getUserData() async {
    await FirebaseFirestore.instance
        .collection('Therapist')
        .where("uid", isEqualTo: singedInUser.uid)
        .get()
        .then((v) {
      for (var element in v.docs) {
        TherapisData.addAll(element.data());

        setState(() {
          isLoded = false;
        });
      }
    });
  }

  late String TherapistAvatar = TherapisData['TherapistAvatar'];

  //add Therapist AvilableTime
  Future AddUserDitals(DateTime today) async {
    await FirebaseFirestore.instance
        .collection("AvilableTime")
        .add({'DateTime': today});
  }

  final _timeC = TextEditingController();
  TimeOfDay timeOfDay = TimeOfDay.now();
  DateTime today = DateTime.now();
  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
  }

  DateTime currentDate = DateTime.now();
  late String formattedCurrentDate =
      DateFormat('dd/M/yyyy').format(currentDate);

  //

  Future<List<DateTime>> getTherapistSessions(String therapistId) async {
    final CollectionReference acceptedSessionsCollection =
        FirebaseFirestore.instance.collection('acceptedSessions');

    // Query the acceptedSessions collection for sessions with a specific therapist ID
    QuerySnapshot therapistSessionsSnapshot = await acceptedSessionsCollection
        .where('TherapistID', isEqualTo: therapistId)
        .get();

    // Extract the session dates from the documents
    List<DateTime> sessionDates = therapistSessionsSnapshot.docs
        .map((doc) {
          DateFormat dateFormat = DateFormat('dd/MM/yyyy');
          return dateFormat.parse(doc['Date']);
        })
        .toSet()
        .toList();

    return sessionDates;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoded == true
          ? Center(child: CircularProgressIndicator())
          : SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: ListView(children: [
                  Container(
                    child: Column(children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "اهلاَ " + TherapisData['name'],
                              style: TextStyle(
                                  color: Color(0xff385a4a),
                                  fontSize: 20,
                                  fontFamily: "Cairo",
                                  fontWeight: FontWeight.w700),
                            ),
                            //Avatar
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Image.asset(TherapistAvatar),
                              radius: 24,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "اليوم يومًا جميلًا\nلتعليم الأطفال شيئًا جديد",
                              style: TextStyle(
                                color: Color(0xff9bb0a5),
                                fontSize: 15,
                              ),
                              textAlign: TextAlign.right,
                            )),
                      ),
                    ]),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 14, left: 210),
                    child: Text(
                      "الجلسات المجدولة",
                      textAlign: TextAlign.end,
                      style: TextStyle(
                          color: Color(0xff385a4a),
                          fontSize: 20,
                          fontFamily: "Cairo",
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(11),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0x19000000),
                              blurRadius: 4,
                              offset: Offset(4, 4),
                            ),
                          ],
                          color: Colors.white,
                        ),
                        child: FutureBuilder(
                            future: getTherapistSessions(singedInUser.uid),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                List<DateTime> sessionDates =
                                    snapshot.data as List<DateTime>;

                                return TableCalendar(
                                  eventLoader: (day) => sessionDates
                                      .where((date) => isSameDay(date, day))
                                      .toList(),
                                  selectedDayPredicate: (day) =>
                                      isSameDay(day, today),
                                  focusedDay: today,
                                  firstDay: DateTime.utc(2018, 10, 16),
                                  lastDay: DateTime.utc(2030, 10, 16),
                                  onDaySelected: _onDaySelected,
                                );
                              } else {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            })),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 29),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Row(
                        children: [
                          Text(
                            "مواعيدك في |",
                            textAlign: TextAlign.end,
                            style: TextStyle(
                                color: Color(0xff385a4a),
                                fontSize: 17,
                                fontFamily: "Cairo",
                                fontWeight: FontWeight.w300),
                          ),
                          Text(
                            " $formattedCurrentDate",
                            textAlign: TextAlign.end,
                            style: TextStyle(
                                color: Color(0xff385a4a),
                                fontSize: 18,
                                fontFamily: "Cairo",
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                  ),
                  TodaySession()
                ]),
              ),
            ),
    );
  }
}


  // ElevatedButton(
                    //     onPressed: () => AddUserDitals(today),
                    //     child: Text("date")),
                    // ElevatedButton(onPressed: () {}, child: Text("Request")),
                    // ElevatedButton(
                    //   onPressed: () {
                    //     Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //           builder: (context) => test(),
                    //         ));
                    //   },
                    //   child: Text('test'),
                    // ),
                    // ElevatedButton(
                    //     onPressed: () {
                    //       Navigator.push(
                    //           context,
                    //           MaterialPageRoute(
                    //             builder: (context) => therapistsessionManage(),
                    //           ));
                    //     },
                    //     child: Text('therapistsessionManage')),
                    // ElevatedButton(
                    //     onPressed: () {
                    //       Navigator.push(
                    //           context,
                    //           MaterialPageRoute(
                    //             builder: (context) => Timeslot(),
                    //           ));
                    //     },
                    //     child: Text('therapistsessionManage')),
                    // ElevatedButton(
                    //     onPressed: () {
                    //       Navigator.push(
                    //           context,
                    //           MaterialPageRoute(
                    //             builder: (context) => ChildrenList(),
                    //           ));
                    //     },
                    //     child: Text('childrenList')),
