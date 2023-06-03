import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eloquentapp/Child/Page/Eloquent_Phases/Buildingconcepts/bodyPart.dart';
import 'package:eloquentapp/Child/Page/Eloquent_Phases/Buildingconcepts/transports.dart';
import 'package:flutter/material.dart';

class Buildingconcepts extends StatefulWidget {
  final String childId;
  final String page;
  Buildingconcepts({required this.childId, required this.page});

  @override
  State<Buildingconcepts> createState() => _BuildingconceptsState();
}

class _BuildingconceptsState extends State<Buildingconcepts> {
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
        backgroundColor: Color.fromARGB(255, 244, 245, 245),
        body: SafeArea(
            child: Container(
                color: Color.fromARGB(255, 244, 245, 245),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: SingleChildScrollView(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        Container(
                          child: Column(children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 5),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "مرحلة بناء المفاهيم ",
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        color: Color(0xff385a4a),
                                        fontSize: 24,
                                        fontFamily: "Cairo",
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                    IconButton(
                                      icon: Icon(
                                          Icons.arrow_forward_ios_outlined),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ]),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 5),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "تشمل هذه المرحلة محموعة من \nالكلمات لبناء المفاهيم وتنمية اللغة الإدراكية",
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    color: Color(0xff687c71),
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            )
                          ]),
                        ),
                        SizedBox(
                          height: 35,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(13),
                            color: Colors.white,
                          ),
                          padding: const EdgeInsets.only(
                            top: 15,
                            bottom: 30,
                          ),
                          child: Column(
                            // mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => bodyPart(
                                          childId: ChildID,
                                          page: 'bodyPart',
                                        ),
                                      ));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 20, top: 6, bottom: 7),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(11),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Color(0x19000000),
                                            blurRadius: 4,
                                            offset: Offset(4, 4))
                                      ],
                                      color: Color(0xff394445),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 18,
                                      vertical: 5,
                                    ),
                                    child: Text(
                                      "اجزاء الجسم",
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        color: Color(0xfffbfbfb),
                                        fontSize: 16,
                                        fontFamily: "Tajawal",
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Column(
                                // mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    // mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        // mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              right: 25,
                                            ),
                                            child: Row(
                                              // mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [],
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 55,
                                        width: 60,
                                        child: GestureDetector(
                                          onTap: (() {}),
                                          child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(11),
                                                color: Color(0xffeef1f4),
                                              ),
                                              child: Image.asset(
                                                  "images/Hand.png")),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      SizedBox(
                                        height: 55,
                                        width: 60,
                                        child: GestureDetector(
                                          onTap: (() {}),
                                          child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(11),
                                                color: Color(0xffeef1f4),
                                              ),
                                              child: Image.asset(
                                                  "images/eyes.png")),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      SizedBox(
                                        height: 55,
                                        width: 60,
                                        child: GestureDetector(
                                          onTap: (() {}),
                                          child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(11),
                                                color: Color(0xffeef1f4),
                                              ),
                                              child: Image.asset(
                                                  "images/foot.png")),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      SizedBox(
                                        height: 55,
                                        width: 60,
                                        child: GestureDetector(
                                          onTap: (() {}),
                                          child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(11),
                                                color: Color(0xffeef1f4),
                                              ),
                                              child: Image.asset(
                                                  "images/Hair.png")),
                                        ),
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 25.0, top: 20),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          height: 55,
                                          width: 60,
                                          child: GestureDetector(
                                            onTap: (() {}),
                                            child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(11),
                                                  color: Color(0xffeef1f4),
                                                ),
                                                child: Image.asset(
                                                    "images/ears.png")),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(13),
                            color: Colors.white,
                          ),
                          padding: const EdgeInsets.only(
                            top: 15,
                            bottom: 30,
                          ),
                          child: Column(
                              // mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: (() {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => transports(
                                              childId: ChildID,
                                              page: 'transports'),
                                        ));
                                  }),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        right: 20, top: 6, bottom: 7),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(11),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Color(0x19000000),
                                              blurRadius: 4,
                                              offset: Offset(4, 4))
                                        ],
                                        color: Color(0xff394445),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 18,
                                        vertical: 5,
                                      ),
                                      child: Text(
                                        "وسائل المواصلات ",
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                          color: Color(0xfffbfbfb),
                                          fontSize: 16,
                                          fontFamily: "Tajawal",
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Column(
                                    // mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        // mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            // mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  right: 25,
                                                ),
                                                child: Row(
                                                  // mainAxisSize: MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [],
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 55,
                                            width: 60,
                                            child: GestureDetector(
                                              onTap: (() {}),
                                              child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            11),
                                                    color: Color(0xffeef1f4),
                                                  ),
                                                  child: Image.asset(
                                                      "images/bicycle.png")),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          SizedBox(
                                            height: 55,
                                            width: 60,
                                            child: GestureDetector(
                                              onTap: (() {}),
                                              child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            11),
                                                    color: Color(0xffeef1f4),
                                                  ),
                                                  child: Image.asset(
                                                      "images/car.png")),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          SizedBox(
                                            height: 55,
                                            width: 60,
                                            child: GestureDetector(
                                              onTap: (() {}),
                                              child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            11),
                                                    color: Color(0xffeef1f4),
                                                  ),
                                                  child: Image.asset(
                                                      "images/ship.png")),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          SizedBox(
                                            height: 55,
                                            width: 60,
                                            child: GestureDetector(
                                              onTap: (() {}),
                                              child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            11),
                                                    color: Color(0xffeef1f4),
                                                  ),
                                                  child: Image.asset(
                                                      "images/train.png")),
                                            ),
                                          )
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 25.0, top: 20),
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              height: 55,
                                              width: 60,
                                              child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            11),
                                                    color: Color(0xffeef1f4),
                                                  ),
                                                  child: Image.asset(
                                                      "images/bridge.png")),
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            SizedBox(
                                              height: 55,
                                              width: 60,
                                              child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            11),
                                                    color: Color(0xffeef1f4),
                                                  ),
                                                  child: Image.asset(
                                                      "images/bus.png")),
                                            ),
                                          ],
                                        ),
                                      )
                                    ]),
                              ]),
                        ),
                      ])),
                ))));
  }
}
