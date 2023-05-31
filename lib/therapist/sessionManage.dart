import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eloquentapp/therapist/Pages/AppointmentRequests.dart';
import 'package:eloquentapp/therapist/Pages/sceduleds/Scheduledsessions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import 'available_times/available_times_page.dart';

class therapistsessionManage extends StatefulWidget {
  const therapistsessionManage({super.key});
  static String id = 'therapistsessionManage';

  @override
  State<therapistsessionManage> createState() => _therapistsessionManageState();
}

class _therapistsessionManageState extends State<therapistsessionManage> {
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
    var textStyle = TextStyle(fontSize: 12, fontWeight: FontWeight.w700);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Color.fromARGB(255, 246, 248, 248),
          title: Padding(
            padding: const EdgeInsets.only(left: 19, top: 44, bottom: 23),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                "إدارة الجلسات",
                style: TextStyle(
                  color: Color(0xff385a4a),
                  fontSize: 25,
                  fontFamily: "Cairo",
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 25, right: 10, left: 10),
          child: Column(children: [
            Container(
              height: 45,
              decoration: BoxDecoration(
                  color: Color(0xff9bb0a5),
                  borderRadius: BorderRadius.circular(11)),
              child: TabBar(
                indicator: BoxDecoration(
                  color: Color(0xff385a4a),
                  borderRadius: BorderRadius.circular(11),
                ),
                labelColor: Colors.white,
                tabs: [
                  Tab(
                    child: Text(
                      "الجلسات المجدولة",
                      style: textStyle,
                    ),
                  ),
                  Tab(
                    child: Text(
                      "طلبات المواعيد",
                      style: textStyle,
                    ),
                  ),
                  Tab(
                    child: Text(
                      "الاوقات المتاحة",
                      style: textStyle,
                    ),
                  )
                ],
              ),
            ),
            Container(
              child: Expanded(
                child: TabBarView(
                  children: [
                    scheduledSession(),
                    AppointmentRequests(),
                    AvailableTimes(),
                  ],
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}

//   Future selectedTime(BuildContext context, bool ifPickedTime,
//       TimeOfDay initialTime, Function(TimeOfDay) onTimePicked) async {
//     var _pickedTime =
//         await showTimePicker(context: context, initialTime: initialTime);
//     if (_pickedTime != null) {
//       onTimePicked(_pickedTime);
//     }
//   }



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
