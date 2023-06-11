import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eloquentapp/Child/Page/Eloquent_Phases/Buildevents.dart';
import 'package:eloquentapp/Child/Page/Eloquent_Phases/Buildevents/firsStory/secondEvent.dart';
import 'package:eloquentapp/Child/Page/Eloquent_Phases/Buildevents/fourthStory/fifthEvent.dart';
import 'package:eloquentapp/Child/Page/Eloquent_Phases/Buildevents/fourthStory/thirdEvent.dart';
import 'package:eloquentapp/Child/Page/Eloquent_Phases/Buildevents/secStory/fifthEventSec.dart';
import 'package:eloquentapp/Child/Page/Eloquent_Phases/Buildevents/secStory/thirdEventSec.dart';
import 'package:eloquentapp/Child/Page/Eloquent_Phases/Buildingconcepts.dart';
import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audioplayers/audioplayers.dart';

class fouthEventFourth extends StatefulWidget {
  final String childId;
  final String page;
  const fouthEventFourth({required this.childId, required this.page});

  @override
  State<fouthEventFourth> createState() => _fouthEventFourthState();
}

class _fouthEventFourthState extends State<fouthEventFourth> {
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 5),
                      child: Column(children: [
                        Container(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "الحدث الرابع",
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        color: Color(0xff385a4a),
                                        fontSize: 20,
                                        fontFamily: "Cairo",
                                        fontWeight: FontWeight.w700,
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
                                              builder: (context) => Buildevents(
                                                  childId: ChildID,
                                                  page: 'Buildevents'),
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
                                    "أوصف الحدث الذي تراه في الصورة",
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      color: Color(0xff687c71),
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 340,
                              height: 760,
                              child: Stack(children: [
                                Positioned.fill(
                                  top: 490,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Container(
                                        width: 353,
                                        height: 138,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(11),
                                          color: Color.fromARGB(
                                              255, 235, 243, 245),
                                        ),
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 35),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Align(
                                                alignment:
                                                    Alignment.bottomCenter,
                                                child: Text(
                                                  "حازم يسأل !",
                                                  style: TextStyle(
                                                    color: Color(0xff394445),
                                                    fontSize: 21,
                                                    fontFamily: "Tajawal",
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                              Align(
                                                  alignment:
                                                      Alignment.bottomCenter,
                                                  child: GestureDetector(
                                                    onTap: () async {
                                                      AssetsAudioPlayer
                                                              .newPlayer()
                                                          .open(
                                                        Audio(
                                                            "images/StoryVoice.wav"),
                                                        autoStart: true,
                                                        showNotification: true,
                                                      );
                                                    },
                                                    child: Image.asset(
                                                        "images/VolumUp.png"),
                                                  )),
                                            ],
                                          ),
                                        )),
                                  ),
                                ),
                                Positioned(
                                  left: 20,
                                  top: 20,
                                  child: Container(
                                    width: 300,
                                    height: 572,
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
                                    padding: const EdgeInsets.only(
                                      left: 8,
                                      right: 3,
                                      top: 93,
                                      bottom: 69,
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                            width: 289,
                                            height: 410,
                                            child:
                                                Image.asset("images/3-4.jpg")),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 10, top: 710),
                                  child: Row(children: [
                                    Row(
                                      children: [
                                        IconButton(
                                          icon: Icon(
                                              Icons.arrow_back_ios_outlined),
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      fifthEventFourth(
                                                          childId: ChildID,
                                                          page:
                                                              'fifthEventFourth'),
                                                ));
                                          },
                                        ),
                                        Text(
                                          " التالي",
                                          style: TextStyle(fontSize: 19),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 140,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          " السابق",
                                          style: TextStyle(fontSize: 19),
                                        ),
                                        IconButton(
                                          icon: Icon(
                                            Icons.arrow_forward_ios_outlined,
                                          ),
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      thirdEventFourth(
                                                          childId: ChildID,
                                                          page:
                                                              'thirdEventFourth'),
                                                ));
                                          },
                                        ),
                                      ],
                                    ),
                                  ]),
                                ),
                              ]),
                            ),
                          ],
                        ),
                      ]),
                    )))));
  }
}
