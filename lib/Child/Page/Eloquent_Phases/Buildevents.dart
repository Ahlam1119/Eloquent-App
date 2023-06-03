import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eloquentapp/Child/Page/Eloquent_Phases/Buildevents/firsStory/firstEvent.dart';

import 'package:eloquentapp/Child/Page/Eloquent_Phases/Buildevents/fourthStory/firstEvent.dart';
import 'package:eloquentapp/Child/Page/Eloquent_Phases/Buildevents/secStory/firstEventSec.dart';
import 'package:eloquentapp/Child/Page/Eloquent_Phases/Buildevents/thirdStory/firstEvent.dart';
import 'package:eloquentapp/Child/Page/Eloquent_Phases/EloquentPhasesPage.dart';
import 'package:flutter/material.dart';

class Buildevents extends StatefulWidget {
  final String childId;
  final String page;
  const Buildevents({required this.childId, required this.page});

  @override
  State<Buildevents> createState() => _BuildeventsState();
}

class _BuildeventsState extends State<Buildevents> {
  //usageRate varible-----------
  late String ChildID = widget.childId;
  DateTime? _startTimePage;

  //usageRate function---------------------
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _startTimePage = DateTime.now();
  }

  @override
  void dispose() {
    //usageRate condation-------
    if (_startTimePage != null) {
      final DateTime endTime = DateTime.now();
      addUsageData(widget.page, _startTimePage!, endTime);
    }

    super.dispose();
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
      child: Container(
          color: Color.fromARGB(255, 244, 245, 245),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              children: [
                Container(
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "مرحلة ترتيب الاحداث ",
                            style: TextStyle(
                              color: Color(0xff385a4a),
                              fontSize: 24,
                              fontFamily: "Cairo",
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          //baaaaaackkkkkkk home
                          IconButton(
                            icon: Icon(
                              Icons.arrow_forward_ios_outlined,
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EloquentPhasesPage(
                                        childId: ChildID,
                                        page: 'EloquentPhasesPage'),
                                  ));
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "تشمل هذه المرحلة مجموعة من القصص\nلتنمية اللغة التعبيرية والتدريب عىل سرد الاحداث",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Color(0xff687c71),
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ]),
                ),
                SizedBox(
                  height: 25,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              firstEvent(childId: ChildID, page: 'firstEvent'),
                        ));
                  },
                  child: Container(
                    width: 351,
                    height: 151,
                    child: Card(
                      color: Color(0x2dfda099),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(17)),
                      elevation: 4,
                      shadowColor: Color(0x19000000),
                      child: Stack(
                        children: [
                          Positioned(
                            top: -110,
                            right: -70,
                            child: Transform.rotate(
                              angle: -1.97,
                              child: Container(
                                width: 239,
                                height: 223,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0x91ff8c83),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 28,
                            right: 14,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "التعبير عن",
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        color: Color(0xfffbfbfb),
                                        fontSize: 30,
                                        fontFamily: "Cairo",
                                        fontWeight: FontWeight.w600,
                                        height: 0.8),
                                  ),
                                  Text(
                                    " الحدث الاول ",
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      color: Color(0xff7c6063),
                                      fontSize: 35,
                                      fontFamily: "Cairo",
                                      fontWeight: FontWeight.w700,
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
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => firstEventSec(
                              childId: ChildID, page: 'fristEventSec'),
                        ));
                  },
                  child: Container(
                    width: 351,
                    height: 151,
                    child: Card(
                      color: Color(0xffeff4f0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(17)),
                      elevation: 4,
                      shadowColor: Color(0x19000000),
                      child: Stack(
                        children: [
                          Positioned(
                            top: -110,
                            right: -70,
                            child: Transform.rotate(
                              angle: -1.97,
                              child: Container(
                                width: 239,
                                height: 223,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xffd3e7d8),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 28,
                            right: 14,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "التعبير عن",
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        color: Color(0xfffbfbfb),
                                        fontSize: 30,
                                        fontFamily: "Cairo",
                                        fontWeight: FontWeight.w600,
                                        height: 0.8),
                                  ),
                                  Text(
                                    "الحدث الثاني ",
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      color: Color(0xff385a4a),
                                      fontSize: 35,
                                      fontFamily: "Cairo",
                                      fontWeight: FontWeight.w700,
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
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => firstEventThird(
                              childId: ChildID, page: 'thirdEvent'),
                        ));
                  },
                  child: Container(
                    width: 351,
                    height: 151,
                    child: Card(
                      color: Color(0xfff7ebd7),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(17)),
                      elevation: 4,
                      shadowColor: Color.fromARGB(127, 0, 0, 0),
                      child: Stack(
                        children: [
                          Positioned(
                            top: -110,
                            right: -70,
                            child: Transform.rotate(
                              angle: -1.97,
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
                            top: 28,
                            right: 14,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "التعبير عن",
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        color: Color(0xfffbfbfb),
                                        fontSize: 30,
                                        fontFamily: "Cairo",
                                        fontWeight: FontWeight.w600,
                                        height: 0.8),
                                  ),
                                  Text(
                                    "الحدث الثالث ",
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      color: Color(0xff7c6063),
                                      fontSize: 35,
                                      fontFamily: "Cairo",
                                      fontWeight: FontWeight.w700,
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
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => firstEventFourth(
                              childId: ChildID, page: 'fourthEvent'),
                        ));
                  },
                  child: Container(
                    width: 351,
                    height: 151,
                    child: Card(
                      color: Color(0x14a8a3ec),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(17)),
                      elevation: 4,
                      shadowColor: Color(0x19000000),
                      child: Stack(
                        children: [
                          Positioned(
                            top: -110,
                            right: -70,
                            child: Transform.rotate(
                              angle: -1.97,
                              child: Container(
                                width: 239,
                                height: 223,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xffa8a3ec),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 28,
                            right: 14,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "التعبير عن",
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        color: Color(0xfffbfbfb),
                                        fontSize: 30,
                                        fontFamily: "Cairo",
                                        fontWeight: FontWeight.w600,
                                        height: 0.8),
                                  ),
                                  Text(
                                    "الحدث الرابع ",
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      color: Color(0xff562a75),
                                      fontSize: 35,
                                      fontFamily: "Cairo",
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ]),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
    )));
  }
}
