import 'dart:ui';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
// import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/services.dart';
import 'dart:typed_data';

class transports extends StatefulWidget {
  final String childId;
  final String page;
  const transports({required this.childId, required this.page});

  @override
  State<transports> createState() => _transportsState();
}

class _transportsState extends State<transports> {
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
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "وسائل المواصلات",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Color(0xff385a4a),
                            fontSize: 23,
                            fontFamily: "Cairo",
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.arrow_forward_ios_outlined,
                            size: 25,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
              SizedBox(
                height: 35,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 353,
                    height: 175,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Align(
                            alignment: Alignment.center,
                            child: Container(
                              width: 400,
                              height: 175,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 330,
                                    height: 130,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(11),
                                        color:
                                            Color.fromARGB(255, 253, 245, 230)),
                                    padding: const EdgeInsets.only(
                                      left: 16,
                                      right: 171,
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "دراجة",
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            color: Color(0xff7c6063),
                                            fontSize: 35,
                                            fontFamily: "Tajawal",
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        Container(
                                          width: 28.05,
                                          height: 28.05,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: GestureDetector(
                                            onTap: () async {
                                              // AssetsAudioPlayer.newPlayer()
                                              // .open(
                                              // Audio("images/AASounds.wav"),
                                              // autoStart: true,
                                              // showNotification: true,
                                              // );
                                            },
                                            child: Image.asset(
                                                "images/VolumUp.png"),
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
                        Positioned(
                          left: 190,
                          top: 0,
                          child: Container(
                            width: 135,
                            height: 160,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                    width: 135,
                                    height: 160,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(18),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color(0x19000000),
                                          blurRadius: 4,
                                          offset: Offset(4, 4),
                                        ),
                                      ],
                                      color: Colors.white,
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    child: SizedBox(
                                        child: Image.asset(
                                      "images/bicycleBig.png",
                                    ))),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  //----------------------------------
                  SizedBox(
                    width: 353,
                    height: 175,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Align(
                            alignment: Alignment.center,
                            child: SizedBox(
                              width: 400,
                              height: 175,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 330,
                                    height: 130,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(11),
                                        color: Color(0xffeff4f0)),
                                    padding: const EdgeInsets.only(
                                      left: 16,
                                      right: 171,
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "سيارة",
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            color: Color(0xff385a4a),
                                            fontSize: 35,
                                            fontFamily: "Tajawal",
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        Container(
                                          width: 28.05,
                                          height: 28.05,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: GestureDetector(
                                            onTap: () async {
                                              AssetsAudioPlayer.newPlayer()
                                                  .open(
                                                Audio("images/Aw.wav"),
                                                autoStart: true,
                                                showNotification: true,
                                              );
                                            },
                                            child: Image.asset(
                                                "images/VolumUp.png"),
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
                        Positioned(
                          left: 190,
                          top: 0,
                          child: Container(
                            width: 135,
                            height: 160,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 135,
                                  height: 160,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(18),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color(0x19000000),
                                        blurRadius: 4,
                                        offset: Offset(4, 4),
                                      ),
                                    ],
                                    color: Colors.white,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  child: Row(
                                    // mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Center(
                                          child: SizedBox(
                                              width: 95,
                                              height: 110,
                                              child: Image.asset(
                                                  "images/carBig.png")))
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 10),
                  //----------------------------------
                  Container(
                    width: 353,
                    height: 175,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Align(
                            alignment: Alignment.center,
                            child: Container(
                              width: 400,
                              height: 175,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 330,
                                    height: 130,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(11),
                                        color: Color(0xfff4f4fa)),
                                    padding: const EdgeInsets.only(
                                      left: 18,
                                      right: 171,
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "سفينة",
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            color: Color(0xff562a75),
                                            fontSize: 35,
                                            fontFamily: "Tajawal",
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        Container(
                                          width: 28.05,
                                          height: 28.05,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: GestureDetector(
                                            onTap: () async {
                                              AssetsAudioPlayer.newPlayer()
                                                  .open(
                                                Audio("images/AY.wav"),
                                                autoStart: true,
                                                showNotification: true,
                                              );
                                            },
                                            child: Image.asset(
                                                "images/VolumUp.png"),
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
                        Positioned(
                          left: 190,
                          top: 0,
                          child: Container(
                            width: 135,
                            height: 160,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 135,
                                  height: 160,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(18),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color(0x19000000),
                                        blurRadius: 4,
                                        offset: Offset(4, 4),
                                      ),
                                    ],
                                    color: Colors.white,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Center(
                                          child: SizedBox(
                                        width: 95,
                                        height: 100,
                                        child:
                                            Image.asset("images/shipBig.png"),
                                      ))
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  //----------------------------------
                  SizedBox(
                    width: 353,
                    height: 175,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Align(
                            alignment: Alignment.center,
                            child: SizedBox(
                              width: 400,
                              height: 175,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 330,
                                    height: 130,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(11),
                                        color: Color(0x2dfda099)),
                                    padding: const EdgeInsets.only(
                                      left: 16,
                                      right: 171,
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "قطار",
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            color: Color(0xff7c6063),
                                            fontSize: 35,
                                            fontFamily: "Tajawal",
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        Container(
                                          width: 28.05,
                                          height: 28.05,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: GestureDetector(
                                            onTap: () async {
                                              AssetsAudioPlayer.newPlayer()
                                                  .open(
                                                Audio("images/Aw.wav"),
                                                autoStart: true,
                                                showNotification: true,
                                              );
                                            },
                                            child: Image.asset(
                                                "images/VolumUp.png"),
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
                        Positioned(
                          left: 190,
                          top: 0,
                          child: Container(
                            width: 135,
                            height: 160,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 135,
                                  height: 160,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(18),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color(0x19000000),
                                        blurRadius: 4,
                                        offset: Offset(4, 4),
                                      ),
                                    ],
                                    color: Colors.white,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  child: Row(
                                    // mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Center(
                                          child: Image.asset(
                                              "images/trainBig.png"))
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  //----------------------------------
                  SizedBox(
                    width: 353,
                    height: 175,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Align(
                            alignment: Alignment.center,
                            child: SizedBox(
                              width: 400,
                              height: 175,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 330,
                                    height: 130,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(11),
                                        color: Color(0xfff3f7f8)),
                                    padding: const EdgeInsets.only(
                                      left: 16,
                                      right: 171,
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "جسر",
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            color: Color(0xff7688a2),
                                            fontSize: 35,
                                            fontFamily: "Tajawal",
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        // SizedBox(width: 75),
                                        Container(
                                          width: 28.05,
                                          height: 28.05,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: GestureDetector(
                                            onTap: () async {
                                              AssetsAudioPlayer.newPlayer()
                                                  .open(
                                                Audio("images/Aw.wav"),
                                                autoStart: true,
                                                showNotification: true,
                                              );
                                            },
                                            child: Image.asset(
                                                "images/VolumUp.png"),
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
                        Positioned(
                          left: 190,
                          top: 0,
                          child: Container(
                            width: 135,
                            height: 160,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 135,
                                  height: 160,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(18),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color(0x19000000),
                                        blurRadius: 4,
                                        offset: Offset(4, 4),
                                      ),
                                    ],
                                    color: Colors.white,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  child: Row(
                                    // mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Center(
                                          child: SizedBox(
                                        width: 95,
                                        child:
                                            Image.asset("images/bridgeBig.png"),
                                      ))
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 353,
                    height: 175,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Align(
                            alignment: Alignment.center,
                            child: SizedBox(
                              width: 400,
                              height: 175,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 330,
                                    height: 130,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(11),
                                        color: Color(0xffeff4f0)),
                                    padding: const EdgeInsets.only(
                                      left: 16,
                                      right: 171,
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "باص",
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            color: Color(0xff385a4a),
                                            fontSize: 35,
                                            fontFamily: "Tajawal",
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        // SizedBox(width: 75),
                                        Container(
                                          width: 28.05,
                                          height: 28.05,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: GestureDetector(
                                            onTap: () async {
                                              AssetsAudioPlayer.newPlayer()
                                                  .open(
                                                Audio("images/Aw.wav"),
                                                autoStart: true,
                                                showNotification: true,
                                              );
                                            },
                                            child: Image.asset(
                                                "images/VolumUp.png"),
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
                        Positioned(
                          left: 190,
                          top: 0,
                          child: Container(
                            width: 135,
                            height: 160,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 135,
                                  height: 160,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(18),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color(0x19000000),
                                        blurRadius: 4,
                                        offset: Offset(4, 4),
                                      ),
                                    ],
                                    color: Colors.white,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  child: Row(
                                    // mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                          width: 95,
                                          child:
                                              Image.asset("images/busBig.png"))
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 25,
              ),
              // padding: const EdgeInsets.only(
              //   top: 40,
              //   bottom: 39,
              // ),

              SizedBox(
                height: 25,
              ),
              // Container(
              //   width: 373,
              //   child: Row(
              //     mainAxisSize: MainAxisSize.min,
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     crossAxisAlignment: CrossAxisAlignment.center,
              //     children: [
              //       Container(
              //         width: 119,
              //         height: 179,
              //         child: Stack(
              //           children: [
              //             Positioned.fill(
              //               child: Align(
              //                 alignment: Alignment.bottomLeft,
              //                 child: Container(
              //                   width: 119,
              //                   height: 131,
              //                   decoration: BoxDecoration(
              //                     borderRadius: BorderRadius.circular(11),
              //                     color: Color(0xfff3f7f8),
              //                   ),
              //                   // padding: const EdgeInsets.only(
              //                   //   top: 92,
              //                   //   bottom: 16,
              //                   // ),
              //                   child: Row(
              //                     mainAxisSize: MainAxisSize.min,
              //                     mainAxisAlignment: MainAxisAlignment.center,
              //                     crossAxisAlignment: CrossAxisAlignment.end,
              //                     children: [
              //                       Row(
              //                         mainAxisSize: MainAxisSize.min,
              //                         mainAxisAlignment:
              //                             MainAxisAlignment.start,
              //                         crossAxisAlignment:
              //                             CrossAxisAlignment.start,
              //                         children: [
              //                           Container(
              //                             width: 20,
              //                             height: 20,
              //                             decoration: BoxDecoration(
              //                               borderRadius:
              //                                   BorderRadius.circular(8),
              //                             ),
              //                             child: GestureDetector(
              //                               onTap: () {},
              //                               child: Image.asset(
              //                                   "images/VolumUp.png"),
              //                             ),
              //                           ),
              //                           SizedBox(width: 10),
              //                           Text(
              //                             "دواء",
              //                             textAlign: TextAlign.right,
              //                             style: TextStyle(
              //                               color: Color(0xff394445),
              //                               fontSize: 24,
              //                               fontFamily: "Tajawal",
              //                               fontWeight: FontWeight.w700,
              //                             ),
              //                           ),
              //                         ],
              //                       ),
              //                     ],
              //                   ),
              //                 ),
              //               ),
              //             ),
              //             Positioned.fill(
              //               child: Align(
              //                 alignment: Alignment.topCenter,
              //                 child: Container(
              //                   width: 102,
              //                   height: 118,
              //                   child: Row(
              //                     mainAxisSize: MainAxisSize.min,
              //                     mainAxisAlignment: MainAxisAlignment.center,
              //                     crossAxisAlignment: CrossAxisAlignment.center,
              //                     children: [
              //                       Container(
              //                         width: 102,
              //                         height: 118,
              //                         decoration: BoxDecoration(
              //                           borderRadius: BorderRadius.circular(18),
              //                           boxShadow: [
              //                             BoxShadow(
              //                               color: Color(0x19000000),
              //                               blurRadius: 4,
              //                               offset: Offset(4, 4),
              //                             ),
              //                           ],
              //                           color: Colors.white,
              //                         ),
              //                         padding: const EdgeInsets.only(
              //                           top: 33,
              //                           bottom: 25,
              //                         ),
              //                         child: Row(
              //                           mainAxisSize: MainAxisSize.min,
              //                           mainAxisAlignment:
              //                               MainAxisAlignment.center,
              //                           crossAxisAlignment:
              //                               CrossAxisAlignment.center,
              //                           children: [
              //                             Container(
              //                               width: 60,
              //                               height: 60,
              //                               decoration: BoxDecoration(
              //                                 borderRadius:
              //                                     BorderRadius.circular(8),
              //                               ),
              //                               child: GestureDetector(
              //                                 onTap: () {},
              //                                 child: Image.asset(
              //                                     "images/VolumUp.png"),
              //                               ),
              //                             ),
              //                           ],
              //                         ),
              //                       ),
              //                     ],
              //                   ),
              //                 ),
              //               ),
              //             ),
              //           ],
              //         ),
              //       ),
              //       SizedBox(width: 8),
              //       Container(
              //         width: 119,
              //         height: 179,
              //         child: Stack(
              //           children: [
              //             Positioned.fill(
              //               child: Align(
              //                 alignment: Alignment.bottomLeft,
              //                 child: Container(
              //                   width: 119,
              //                   height: 131,
              //                   decoration: BoxDecoration(
              //                     borderRadius: BorderRadius.circular(11),
              //                     color: Color(0xfff3f7f8),
              //                   ),
              //                   padding: const EdgeInsets.only(
              //                     top: 92,
              //                     bottom: 16,
              //                   ),
              //                   child: Row(
              //                     mainAxisSize: MainAxisSize.min,
              //                     mainAxisAlignment: MainAxisAlignment.center,
              //                     crossAxisAlignment: CrossAxisAlignment.end,
              //                     children: [
              //                       Row(
              //                         mainAxisSize: MainAxisSize.min,
              //                         mainAxisAlignment:
              //                             MainAxisAlignment.start,
              //                         crossAxisAlignment:
              //                             CrossAxisAlignment.start,
              //                         children: [
              //                           Container(
              //                             width: 20,
              //                             height: 20,
              //                             decoration: BoxDecoration(
              //                               borderRadius:
              //                                   BorderRadius.circular(8),
              //                             ),
              //                             child: FlutterLogo(size: 20),
              //                           ),
              //                           SizedBox(width: 10),
              //                           Text(
              //                             "باب",
              //                             textAlign: TextAlign.right,
              //                             style: TextStyle(
              //                               color: Color(0xff394445),
              //                               fontSize: 24,
              //                               fontFamily: "Tajawal",
              //                               fontWeight: FontWeight.w700,
              //                             ),
              //                           ),
              //                         ],
              //                       ),
              //                     ],
              //                   ),
              //                 ),
              //               ),
              //             ),
              //             Positioned.fill(
              //               child: Align(
              //                 alignment: Alignment.topCenter,
              //                 child: Container(
              //                   width: 102,
              //                   height: 118,
              //                   child: Row(
              //                     mainAxisSize: MainAxisSize.min,
              //                     mainAxisAlignment: MainAxisAlignment.center,
              //                     crossAxisAlignment: CrossAxisAlignment.center,
              //                     children: [
              //                       Container(
              //                         width: 102,
              //                         height: 118,
              //                         decoration: BoxDecoration(
              //                           borderRadius: BorderRadius.circular(18),
              //                           boxShadow: [
              //                             BoxShadow(
              //                               color: Color(0x19000000),
              //                               blurRadius: 4,
              //                               offset: Offset(4, 4),
              //                             ),
              //                           ],
              //                           color: Colors.white,
              //                         ),
              //                         padding: const EdgeInsets.only(
              //                           left: 26,
              //                           right: 25,
              //                         ),
              //                         child: Row(
              //                           mainAxisSize: MainAxisSize.min,
              //                           mainAxisAlignment:
              //                               MainAxisAlignment.center,
              //                           crossAxisAlignment:
              //                               CrossAxisAlignment.center,
              //                           children: [
              //                             Container(
              //                               width: 51,
              //                               height: 86,
              //                               padding: const EdgeInsets.only(
              //                                 left: 4,
              //                                 right: 7,
              //                                 top: 5,
              //                                 bottom: 6,
              //                               ),
              //                               child: Row(
              //                                 mainAxisSize: MainAxisSize.min,
              //                                 mainAxisAlignment:
              //                                     MainAxisAlignment.center,
              //                                 crossAxisAlignment:
              //                                     CrossAxisAlignment.center,
              //                                 children: [
              //                                   Container(
              //                                     width: 39.15,
              //                                     height: 75.05,
              //                                     child: Stack(
              //                                       children: [
              //                                         Positioned.fill(
              //                                           child: Align(
              //                                             alignment:
              //                                                 Alignment.topLeft,
              //                                             child: Container(
              //                                               width: 38.92,
              //                                               height: 75.05,
              //                                               child: Stack(
              //                                                 children: [
              //                                                   Container(
              //                                                     width: 38.92,
              //                                                     height: 75.05,
              //                                                     decoration:
              //                                                         BoxDecoration(
              //                                                       borderRadius:
              //                                                           BorderRadius
              //                                                               .circular(8),
              //                                                     ),
              //                                                     child: Stack(
              //                                                       children: [
              //                                                         Positioned(
              //                                                           left:
              //                                                               4.63,
              //                                                           top:
              //                                                               3.91,
              //                                                           child:
              //                                                               Opacity(
              //                                                             opacity:
              //                                                                 0.70,
              //                                                             child:
              //                                                                 Container(
              //                                                               width:
              //                                                                   2.90,
              //                                                               height:
              //                                                                   67.94,
              //                                                               decoration:
              //                                                                   BoxDecoration(
              //                                                                 borderRadius: BorderRadius.circular(8),
              //                                                                 gradient: LinearGradient(
              //                                                                   begin: Alignment.topCenter,
              //                                                                   end: Alignment.bottomCenter,
              //                                                                   colors: [
              //                                                                     Color(0xffa44b5e),
              //                                                                     Color(0xffd4c7cd)
              //                                                                   ],
              //                                                                 ),
              //                                                               ),
              //                                                             ),
              //                                                           ),
              //                                                         ),
              //                                                         Positioned(
              //                                                           left:
              //                                                               32.48,
              //                                                           top:
              //                                                               4.14,
              //                                                           child:
              //                                                               Opacity(
              //                                                             opacity:
              //                                                                 0.70,
              //                                                             child:
              //                                                                 Container(
              //                                                               width:
              //                                                                   1.73,
              //                                                               height:
              //                                                                   67.47,
              //                                                               decoration:
              //                                                                   BoxDecoration(
              //                                                                 borderRadius: BorderRadius.circular(8),
              //                                                                 gradient: LinearGradient(
              //                                                                   begin: Alignment.bottomLeft,
              //                                                                   end: Alignment.topRight,
              //                                                                   colors: [
              //                                                                     Color(0xffa44b5e),
              //                                                                     Color(0xffd4c7cd)
              //                                                                   ],
              //                                                                 ),
              //                                                               ),
              //                                                             ),
              //                                                           ),
              //                                                         ),
              //                                                         Positioned(
              //                                                           left:
              //                                                               4.63,
              //                                                           top:
              //                                                               3.91,
              //                                                           child:
              //                                                               Opacity(
              //                                                             opacity:
              //                                                                 0.70,
              //                                                             child:
              //                                                                 Container(
              //                                                               width:
              //                                                                   29.58,
              //                                                               height:
              //                                                                   1.49,
              //                                                               decoration:
              //                                                                   BoxDecoration(
              //                                                                 borderRadius: BorderRadius.circular(8),
              //                                                                 gradient: LinearGradient(
              //                                                                   begin: Alignment.centerRight,
              //                                                                   end: Alignment.centerLeft,
              //                                                                   colors: [
              //                                                                     Color(0xffa44b5e),
              //                                                                     Color(0xffd4c7cd)
              //                                                                   ],
              //                                                                 ),
              //                                                               ),
              //                                                             ),
              //                                                           ),
              //                                                         ),
              //                                                         Positioned(
              //                                                           left:
              //                                                               6.43,
              //                                                           top:
              //                                                               70.83,
              //                                                           child:
              //                                                               Container(
              //                                                             width:
              //                                                                 27.23,
              //                                                             height:
              //                                                                 1.02,
              //                                                             decoration:
              //                                                                 BoxDecoration(
              //                                                               borderRadius:
              //                                                                   BorderRadius.circular(8),
              //                                                               color:
              //                                                                   Color(0xffffc40c),
              //                                                             ),
              //                                                           ),
              //                                                         ),
              //                                                         Positioned
              //                                                             .fill(
              //                                                           child:
              //                                                               Align(
              //                                                             alignment:
              //                                                                 Alignment.topLeft,
              //                                                             child:
              //                                                                 Container(
              //                                                               width:
              //                                                                   23.46,
              //                                                               height:
              //                                                                   17.20,
              //                                                               child:
              //                                                                   Stack(
              //                                                                 children: [
              //                                                                   Positioned.fill(
              //                                                                     child: Align(
              //                                                                       alignment: Alignment.topLeft,
              //                                                                       child: Container(
              //                                                                         width: 23.46,
              //                                                                         height: 17.12,
              //                                                                         decoration: BoxDecoration(
              //                                                                           borderRadius: BorderRadius.circular(8),
              //                                                                         ),
              //                                                                       ),
              //                                                                     ),
              //                                                                   ),
              //                                                                   Container(
              //                                                                     width: 23.46,
              //                                                                     height: 17.20,
              //                                                                     decoration: BoxDecoration(
              //                                                                       borderRadius: BorderRadius.circular(8),
              //                                                                     ),
              //                                                                     child: FlutterLogo(size: 17.19999885559082),
              //                                                                   ),
              //                                                                 ],
              //                                                               ),
              //                                                             ),
              //                                                           ),
              //                                                         ),
              //                                                         Positioned
              //                                                             .fill(
              //                                                           child:
              //                                                               Align(
              //                                                             alignment:
              //                                                                 Alignment.center,
              //                                                             child:
              //                                                                 Container(
              //                                                               width:
              //                                                                   23.38,
              //                                                               height:
              //                                                                   23.77,
              //                                                               child:
              //                                                                   Stack(
              //                                                                 children: [
              //                                                                   Positioned.fill(
              //                                                                     child: Align(
              //                                                                       alignment: Alignment.topLeft,
              //                                                                       child: Container(
              //                                                                         width: 23.38,
              //                                                                         height: 23.69,
              //                                                                         decoration: BoxDecoration(
              //                                                                           borderRadius: BorderRadius.circular(8),
              //                                                                         ),
              //                                                                       ),
              //                                                                     ),
              //                                                                   ),
              //                                                                   Container(
              //                                                                     width: 23.38,
              //                                                                     height: 23.77,
              //                                                                     decoration: BoxDecoration(
              //                                                                       borderRadius: BorderRadius.circular(8),
              //                                                                     ),
              //                                                                     child: FlutterLogo(size: 23.38153839111328),
              //                                                                   ),
              //                                                                 ],
              //                                                               ),
              //                                                             ),
              //                                                           ),
              //                                                         ),
              //                                                         Positioned
              //                                                             .fill(
              //                                                           child:
              //                                                               Align(
              //                                                             alignment:
              //                                                                 Alignment.bottomRight,
              //                                                             child:
              //                                                                 Container(
              //                                                               width:
              //                                                                   23.46,
              //                                                               height:
              //                                                                   16.57,
              //                                                               child:
              //                                                                   Stack(
              //                                                                 children: [
              //                                                                   Positioned.fill(
              //                                                                     child: Align(
              //                                                                       alignment: Alignment.topLeft,
              //                                                                       child: Container(
              //                                                                         width: 23.46,
              //                                                                         height: 16.50,
              //                                                                         decoration: BoxDecoration(
              //                                                                           borderRadius: BorderRadius.circular(8),
              //                                                                         ),
              //                                                                       ),
              //                                                                     ),
              //                                                                   ),
              //                                                                   Positioned.fill(
              //                                                                     child: Align(
              //                                                                       alignment: Alignment.topLeft,
              //                                                                       child: Container(
              //                                                                         width: 23.38,
              //                                                                         height: 16.57,
              //                                                                         decoration: BoxDecoration(
              //                                                                           borderRadius: BorderRadius.circular(8),
              //                                                                         ),
              //                                                                         child: FlutterLogo(size: 16.574542999267578),
              //                                                                       ),
              //                                                                     ),
              //                                                                   ),
              //                                                                 ],
              //                                                               ),
              //                                                             ),
              //                                                           ),
              //                                                         ),
              //                                                         Positioned(
              //                                                           left:
              //                                                               2.90,
              //                                                           top:
              //                                                               72.24,
              //                                                           child:
              //                                                               Opacity(
              //                                                             opacity:
              //                                                                 0.70,
              //                                                             child:
              //                                                                 Container(
              //                                                               width:
              //                                                                   3.69,
              //                                                               height:
              //                                                                   2.81,
              //                                                               decoration:
              //                                                                   BoxDecoration(
              //                                                                 borderRadius: BorderRadius.circular(8),
              //                                                                 gradient: LinearGradient(
              //                                                                   begin: Alignment.centerLeft,
              //                                                                   end: Alignment.centerRight,
              //                                                                   colors: [
              //                                                                     Color(0xffa44b5e),
              //                                                                     Color(0xffd4c7cd)
              //                                                                   ],
              //                                                                 ),
              //                                                               ),
              //                                                             ),
              //                                                           ),
              //                                                         ),
              //                                                         Positioned
              //                                                             .fill(
              //                                                           child:
              //                                                               Align(
              //                                                             alignment:
              //                                                                 Alignment.topLeft,
              //                                                             child:
              //                                                                 Opacity(
              //                                                               opacity:
              //                                                                   0.70,
              //                                                               child:
              //                                                                   Container(
              //                                                                 width: 4.63,
              //                                                                 height: 3.91,
              //                                                                 decoration: BoxDecoration(
              //                                                                   borderRadius: BorderRadius.circular(8),
              //                                                                   gradient: LinearGradient(
              //                                                                     begin: Alignment.centerLeft,
              //                                                                     end: Alignment.centerRight,
              //                                                                     colors: [
              //                                                                       Color(0xffa44b5e),
              //                                                                       Color(0xffd4c7cd)
              //                                                                     ],
              //                                                                   ),
              //                                                                 ),
              //                                                               ),
              //                                                             ),
              //                                                           ),
              //                                                         ),
              //                                                         Positioned(
              //                                                           left:
              //                                                               33.97,
              //                                                           top:
              //                                                               33.15,
              //                                                           child:
              //                                                               Container(
              //                                                             width:
              //                                                                 3.61,
              //                                                             height:
              //                                                                 10.55,
              //                                                             decoration:
              //                                                                 BoxDecoration(
              //                                                               borderRadius:
              //                                                                   BorderRadius.circular(8),
              //                                                             ),
              //                                                             child:
              //                                                                 FlutterLogo(size: 3.609229564666748),
              //                                                           ),
              //                                                         ),
              //                                                         Opacity(
              //                                                           opacity:
              //                                                               0.70,
              //                                                           child:
              //                                                               Container(
              //                                                             width:
              //                                                                 38.92,
              //                                                             height:
              //                                                                 75.05,
              //                                                             decoration:
              //                                                                 BoxDecoration(
              //                                                               borderRadius:
              //                                                                   BorderRadius.circular(8),
              //                                                               gradient:
              //                                                                   LinearGradient(
              //                                                                 begin: Alignment.topCenter,
              //                                                                 end: Alignment.bottomCenter,
              //                                                                 colors: [
              //                                                                   Color(0xffa44b5e),
              //                                                                   Color(0xffd4c7cd)
              //                                                                 ],
              //                                                               ),
              //                                                             ),
              //                                                           ),
              //                                                         ),
              //                                                       ],
              //                                                     ),
              //                                                   ),
              //                                                   Positioned(
              //                                                     left: 33.11,
              //                                                     top: 71.22,
              //                                                     child:
              //                                                         Opacity(
              //                                                       opacity:
              //                                                           0.70,
              //                                                       child:
              //                                                           Container(
              //                                                         width:
              //                                                             4.08,
              //                                                         height:
              //                                                             3.83,
              //                                                         decoration:
              //                                                             BoxDecoration(
              //                                                           borderRadius:
              //                                                               BorderRadius.circular(8),
              //                                                           gradient:
              //                                                               LinearGradient(
              //                                                             begin:
              //                                                                 Alignment.centerLeft,
              //                                                             end: Alignment
              //                                                                 .centerRight,
              //                                                             colors: [
              //                                                               Color(0xffa44b5e),
              //                                                               Color(0xffd4c7cd)
              //                                                             ],
              //                                                           ),
              //                                                         ),
              //                                                       ),
              //                                                     ),
              //                                                   ),
              //                                                 ],
              //                                               ),
              //                                             ),
              //                                           ),
              //                                         ),
              //                                         Positioned(
              //                                           left: 9.49,
              //                                           top: 9.46,
              //                                           child: Container(
              //                                             width: 19.85,
              //                                             height: 12.98,
              //                                             decoration:
              //                                                 BoxDecoration(
              //                                               borderRadius:
              //                                                   BorderRadius
              //                                                       .circular(
              //                                                           8),
              //                                               color: Color(
              //                                                   0xffe9672d),
              //                                             ),
              //                                             child: Stack(
              //                                               children: [
              //                                                 Positioned.fill(
              //                                                   child: Align(
              //                                                     alignment:
              //                                                         Alignment
              //                                                             .topLeft,
              //                                                     child:
              //                                                         Container(
              //                                                       width:
              //                                                           18.44,
              //                                                       height:
              //                                                           11.73,
              //                                                       decoration:
              //                                                           BoxDecoration(
              //                                                         borderRadius:
              //                                                             BorderRadius.circular(
              //                                                                 8),
              //                                                         gradient:
              //                                                             LinearGradient(
              //                                                           begin: Alignment
              //                                                               .bottomCenter,
              //                                                           end: Alignment
              //                                                               .topCenter,
              //                                                           colors: [
              //                                                             Color(
              //                                                                 0xff1a6361),
              //                                                             Color(
              //                                                                 0xff1b073b)
              //                                                           ],
              //                                                         ),
              //                                                       ),
              //                                                     ),
              //                                                   ),
              //                                                 ),
              //                                                 Positioned.fill(
              //                                                   child: Align(
              //                                                     alignment:
              //                                                         Alignment
              //                                                             .topLeft,
              //                                                     child:
              //                                                         Opacity(
              //                                                       opacity:
              //                                                           0.70,
              //                                                       child:
              //                                                           Container(
              //                                                         width:
              //                                                             19.85,
              //                                                         height:
              //                                                             0.86,
              //                                                         decoration:
              //                                                             BoxDecoration(
              //                                                           borderRadius:
              //                                                               BorderRadius.circular(8),
              //                                                           gradient:
              //                                                               LinearGradient(
              //                                                             begin:
              //                                                                 Alignment.centerLeft,
              //                                                             end: Alignment
              //                                                                 .centerRight,
              //                                                             colors: [
              //                                                               Color(0xffa44b5e),
              //                                                               Color(0xffd4c7cd)
              //                                                             ],
              //                                                           ),
              //                                                         ),
              //                                                       ),
              //                                                     ),
              //                                                   ),
              //                                                 ),
              //                                                 Positioned.fill(
              //                                                   child: Align(
              //                                                     alignment:
              //                                                         Alignment
              //                                                             .bottomLeft,
              //                                                     child:
              //                                                         Container(
              //                                                       width:
              //                                                           19.22,
              //                                                       height:
              //                                                           0.63,
              //                                                       decoration:
              //                                                           BoxDecoration(
              //                                                         borderRadius:
              //                                                             BorderRadius.circular(
              //                                                                 8),
              //                                                         color: Color(
              //                                                             0xffffc40c),
              //                                                       ),
              //                                                     ),
              //                                                   ),
              //                                                 ),
              //                                                 Positioned.fill(
              //                                                   child: Align(
              //                                                     alignment:
              //                                                         Alignment
              //                                                             .bottomRight,
              //                                                     child:
              //                                                         Container(
              //                                                       width:
              //                                                           17.97,
              //                                                       height:
              //                                                           8.44,
              //                                                       decoration:
              //                                                           BoxDecoration(
              //                                                         borderRadius:
              //                                                             BorderRadius.circular(
              //                                                                 8),
              //                                                       ),
              //                                                     ),
              //                                                   ),
              //                                                 ),
              //                                                 Positioned.fill(
              //                                                   child: Align(
              //                                                     alignment:
              //                                                         Alignment
              //                                                             .topCenter,
              //                                                     child:
              //                                                         Container(
              //                                                       width: 0.31,
              //                                                       height:
              //                                                           3.60,
              //                                                       decoration:
              //                                                           BoxDecoration(
              //                                                         borderRadius:
              //                                                             BorderRadius.circular(
              //                                                                 8),
              //                                                       ),
              //                                                     ),
              //                                                   ),
              //                                                 ),
              //                                                 Positioned.fill(
              //                                                   child: Align(
              //                                                     alignment:
              //                                                         Alignment
              //                                                             .topRight,
              //                                                     child:
              //                                                         Opacity(
              //                                                       opacity:
              //                                                           0.50,
              //                                                       child:
              //                                                           Container(
              //                                                         width:
              //                                                             11.53,
              //                                                         height:
              //                                                             11.73,
              //                                                         decoration:
              //                                                             BoxDecoration(
              //                                                           borderRadius:
              //                                                               BorderRadius.circular(8),
              //                                                           gradient:
              //                                                               LinearGradient(
              //                                                             begin:
              //                                                                 Alignment.topLeft,
              //                                                             end: Alignment
              //                                                                 .bottomRight,
              //                                                             colors: [
              //                                                               Colors.black,
              //                                                               Color(0xff826663)
              //                                                             ],
              //                                                           ),
              //                                                         ),
              //                                                       ),
              //                                                     ),
              //                                                   ),
              //                                                 ),
              //                                                 Positioned.fill(
              //                                                   child: Align(
              //                                                     alignment:
              //                                                         Alignment
              //                                                             .topLeft,
              //                                                     child:
              //                                                         Opacity(
              //                                                       opacity:
              //                                                           0.70,
              //                                                       child:
              //                                                           Container(
              //                                                         width:
              //                                                             18.44,
              //                                                         height:
              //                                                             11.73,
              //                                                         decoration:
              //                                                             BoxDecoration(
              //                                                           borderRadius:
              //                                                               BorderRadius.circular(8),
              //                                                           gradient:
              //                                                               LinearGradient(
              //                                                             begin:
              //                                                                 Alignment.topRight,
              //                                                             end: Alignment
              //                                                                 .bottomLeft,
              //                                                             colors: [
              //                                                               Color(0xffa44b5e),
              //                                                               Color(0xffd4c7cd)
              //                                                             ],
              //                                                           ),
              //                                                         ),
              //                                                       ),
              //                                                     ),
              //                                                   ),
              //                                                 ),
              //                                               ],
              //                                             ),
              //                                           ),
              //                                         ),
              //                                         Positioned(
              //                                           left: 32.72,
              //                                           top: 71.38,
              //                                           child: Opacity(
              //                                             opacity: 0.50,
              //                                             child: Container(
              //                                               width: 3.92,
              //                                               height: 3.67,
              //                                               decoration:
              //                                                   BoxDecoration(
              //                                                 borderRadius:
              //                                                     BorderRadius
              //                                                         .circular(
              //                                                             8),
              //                                                 gradient:
              //                                                     LinearGradient(
              //                                                   begin: Alignment
              //                                                       .topRight,
              //                                                   end: Alignment
              //                                                       .bottomLeft,
              //                                                   colors: [
              //                                                     Colors.white,
              //                                                     Colors.black
              //                                                   ],
              //                                                 ),
              //                                               ),
              //                                             ),
              //                                           ),
              //                                         ),
              //                                         Positioned.fill(
              //                                           child: Align(
              //                                             alignment: Alignment
              //                                                 .topRight,
              //                                             child: Opacity(
              //                                               opacity: 0.70,
              //                                               child: Container(
              //                                                 width: 4.71,
              //                                                 height: 3.91,
              //                                                 decoration:
              //                                                     BoxDecoration(
              //                                                   borderRadius:
              //                                                       BorderRadius
              //                                                           .circular(
              //                                                               8),
              //                                                   gradient:
              //                                                       LinearGradient(
              //                                                     begin: Alignment
              //                                                         .centerLeft,
              //                                                     end: Alignment
              //                                                         .centerRight,
              //                                                     colors: [
              //                                                       Color(
              //                                                           0xffa44b5e),
              //                                                       Color(
              //                                                           0xffd4c7cd)
              //                                                     ],
              //                                                   ),
              //                                                 ),
              //                                               ),
              //                                             ),
              //                                           ),
              //                                         ),
              //                                         Positioned(
              //                                           left: 34.29,
              //                                           top: 2.89,
              //                                           child: Container(
              //                                             width: 2.28,
              //                                             height: 16.18,
              //                                             decoration:
              //                                                 BoxDecoration(
              //                                               borderRadius:
              //                                                   BorderRadius
              //                                                       .circular(
              //                                                           8),
              //                                               color: Color(
              //                                                   0xffffc40c),
              //                                             ),
              //                                           ),
              //                                         ),
              //                                       ],
              //                                     ),
              //                                   ),
              //                                 ],
              //                               ),
              //                             ),
              //                           ],
              //                         ),
              //                       ),
              //                     ],
              //                   ),
              //                 ),
              //               ),
              //             ),
              //           ],
              //         ),
              //       ),
              //       SizedBox(width: 8),
              //       Container(
              //         width: 119,
              //         height: 179,
              //         child: Stack(
              //           children: [
              //             Positioned.fill(
              //               child: Align(
              //                 alignment: Alignment.bottomLeft,
              //                 child: Container(
              //                   width: 119,
              //                   height: 131,
              //                   decoration: BoxDecoration(
              //                     borderRadius: BorderRadius.circular(11),
              //                     color: Color(0xfff3f7f8),
              //                   ),
              //                   padding: const EdgeInsets.only(
              //                     top: 92,
              //                     bottom: 16,
              //                   ),
              //                   child: Row(
              //                     mainAxisSize: MainAxisSize.min,
              //                     mainAxisAlignment: MainAxisAlignment.center,
              //                     crossAxisAlignment: CrossAxisAlignment.end,
              //                     children: [
              //                       Row(
              //                         mainAxisSize: MainAxisSize.min,
              //                         mainAxisAlignment:
              //                             MainAxisAlignment.start,
              //                         crossAxisAlignment:
              //                             CrossAxisAlignment.start,
              //                         children: [
              //                           Container(
              //                             width: 20,
              //                             height: 20,
              //                             decoration: BoxDecoration(
              //                               borderRadius:
              //                                   BorderRadius.circular(8),
              //                             ),
              //                             child: FlutterLogo(size: 20),
              //                           ),
              //                           SizedBox(width: 10),
              //                           Text(
              //                             "أرنب",
              //                             textAlign: TextAlign.right,
              //                             style: TextStyle(
              //                               color: Color(0xff394445),
              //                               fontSize: 24,
              //                               fontFamily: "Tajawal",
              //                               fontWeight: FontWeight.w700,
              //                             ),
              //                           ),
              //                         ],
              //                       ),
              //                     ],
              //                   ),
              //                 ),
              //               ),
              //             ),
              //             Positioned.fill(
              //               child: Align(
              //                 alignment: Alignment.topCenter,
              //                 child: Container(
              //                   width: 102,
              //                   height: 118,
              //                   child: Row(
              //                     mainAxisSize: MainAxisSize.min,
              //                     mainAxisAlignment: MainAxisAlignment.center,
              //                     crossAxisAlignment: CrossAxisAlignment.center,
              //                     children: [
              //                       Container(
              //                         width: 102,
              //                         height: 118,
              //                         decoration: BoxDecoration(
              //                           borderRadius: BorderRadius.circular(18),
              //                           boxShadow: [
              //                             BoxShadow(
              //                               color: Color(0x19000000),
              //                               blurRadius: 4,
              //                               offset: Offset(4, 4),
              //                             ),
              //                           ],
              //                           color: Colors.white,
              //                         ),
              //                         padding: const EdgeInsets.only(
              //                           top: 40,
              //                           bottom: 39,
              //                         ),
              //                         child: Row(
              //                           mainAxisSize: MainAxisSize.min,
              //                           mainAxisAlignment:
              //                               MainAxisAlignment.center,
              //                           crossAxisAlignment:
              //                               CrossAxisAlignment.center,
              //                           children: [
              //                             Container(
              //                               width: 50.33,
              //                               height: 38.87,
              //                               decoration: BoxDecoration(
              //                                 borderRadius:
              //                                     BorderRadius.circular(8),
              //                               ),
              //                               child: FlutterLogo(
              //                                   size: 38.86820983886719),
              //                             ),
              //                           ],
              //                         ),
              //                       ),
              //                     ],
              //                   ),
              //                 ),
              //               ),
              //             ),
              //           ],
              //         ),
              //       ),
              //     ],
              //   ),
              // )
            ],
          ),
        ),
      )),
    );
  }
}
