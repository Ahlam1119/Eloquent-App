import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eloquentapp/therapist/Pages/sceduleds/preivoues.dart';
import 'package:eloquentapp/therapist/Pages/sceduleds/upcoming.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class scheduledSession extends StatefulWidget {
  const scheduledSession({super.key});
  static String id = 'therapistsessionManage';

  @override
  State<scheduledSession> createState() => _scheduledSessionState();
}

class _scheduledSessionState extends State<scheduledSession> {
  final _auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
  DateTime date = DateTime.now();
  late User singedInUser;

  void initState() {
    super.initState();
    getCurrentUser();
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

  Future AddDateTime(
    DateTime today,
    DateTime startTime,
    DateTime EndTime,
  ) async {
    await FirebaseFirestore.instance
        .collection("Therapist")
        .doc(singedInUser.uid)
        .collection('AvilableTime')
        .doc()
        .set({'DateTime': today, 'startTime': startTime, 'endTime': EndTime});
  }

  final _timeC = TextEditingController();
  TimeOfDay timeOfDay = TimeOfDay.now();
  DateTime today = DateTime.now();
  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
  }

  TimeOfDay startTime = TimeOfDay.now();
  TimeOfDay endTime = TimeOfDay.now();

  late DateTime _startTim;
  late DateTime _endTim;
  DateTime join(DateTime date, TimeOfDay time) {
    return new DateTime(
        date.year, date.month, date.day, time.hour, time.minute);
  }

  @override
  Widget build(BuildContext context) {
    var textStyle = TextStyle(fontSize: 13, fontWeight: FontWeight.w700);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(top: 25, right: 10, left: 10),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Color.fromARGB(21, 166, 181, 173),
            ),
            child: Column(children: [
              Container(
                height: 45,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(25)),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: TabBar(
                    indicator: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: Color.fromARGB(111, 66, 65, 65),
                                width: 2))),
                    labelColor: Colors.black,
                    tabs: [
                      Tab(
                        child: Text(
                          "القادمة ",
                          style: TextStyle(
                            fontSize: 13,
                            fontFamily: "Cairo",
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Tab(
                        child: Text(
                          "السابقة ",
                          style: TextStyle(
                            fontSize: 13,
                            fontFamily: "Cairo",
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                child: Expanded(
                  child: TabBarView(
                    children: [upcoming(), preivouse()],
                  ),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}




//   Widget _buildTimePick(String title, bool ifPickedTime, TimeOfDay currentTime,
//       Function(TimeOfDay) onTimePicked) {
//     return Row(
//       children: [
//         SizedBox(
//           width: 80,
//           child: Text(
//             title,
//           ),
//         ),
//         Container(
//           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
//           decoration: BoxDecoration(
//             border: Border.all(),
//             borderRadius: BorderRadius.circular(20),
//           ),
//           child: GestureDetector(
//             child: Text(
//               currentTime.format(context),
//             ),
//             onTap: () {
//               selectedTime(context, ifPickedTime, currentTime, onTimePicked);
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }
//  TabBarView(
// children: [
// Icon(Icons.directions_car),
// Icon(Icons.directions_car),
// TableCalendar(
// selectedDayPredicate: (day) => isSameDay(day, today),
// focusedDay: today,
// firstDay: DateTime.utc(2018, 10, 16),
// lastDay: DateTime.utc(2030, 10, 16),
// onDaySelected: _onDaySelected,
// ),
// ],
// ),
    // Center(
    //                       child: _buildTimePick("Start", true, startTime, (x) {
    //                         setState(() {
    //                           startTime = x;
    //                           print("The picked time is: $x");
    //                         });
    //                       }),
    //                     ),
    //                     SizedBox(height: 10),
    //                     Center(
    //                         child: _buildTimePick("End", true, endTime, (x) {
    //                       setState(() {
    //                         endTime = x;
    //                         print("The picked time is: $x");
    //                       });
    //                     })),
