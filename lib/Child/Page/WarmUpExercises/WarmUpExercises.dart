// import 'dart:async';

// import 'package:eloquentapp/Child/Page/WarmUpExercises/testpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eloquentapp/Child/Page/WarmUpExercises/warmupvedio.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:video_player/video_player.dart';
// import 'dart:math' as math;

class WarmUpExercisesPage extends StatefulWidget {
  final String childId;
  final String page;
  WarmUpExercisesPage({required this.childId, required this.page});

  @override
  State<WarmUpExercisesPage> createState() => _WarmUpExercisesPageState();
}

class _WarmUpExercisesPageState extends State<WarmUpExercisesPage> {
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
            children: [
              Container(
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "تمارين التحمية",
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
                  Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "تساعد هذه التمارين\nبتقوية عضلات الفم واللسان لدى الطفل",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Color(0xff687c71),
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: 343,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 288,
                      height: 30,
                      child: Text(
                        "مجموعة الأدوات",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Color(0xff385a4a),
                          fontSize: 18,
                          fontFamily: "Cairo",
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    SizedBox(height: 3),
                    SizedBox(
                      width: 280,
                      child: Text(
                        "هذه مجموعة من الأدوات اللازمة  \nعند البدء في تمارين التحمية",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Color(0xff6888a0),
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: 365,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 77,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(11),
                        color: Color(0x0c9bb0a5),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Image.asset("images/glavs.png"),
                          ),
                          SizedBox(height: 15),
                          SizedBox(
                            width: 80,
                            height: 45,
                            child: Text(
                              "قفازات",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xff687c71),
                                fontSize: 15,
                                fontFamily: "Cairo",
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 6),
                    Container(
                      width: 77,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(11),
                        color: Color(0x0c9bb0a5),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 55,
                            height: 55,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Image.asset("images/lesan.png"),
                          ),
                          SizedBox(height: 15),
                          SizedBox(
                            child: Text(
                              "خافضات\n اللسان",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xff687c71),
                                fontSize: 14,
                                fontFamily: "Cairo",
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 6),
                    Container(
                      width: 77,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(11),
                        color: Color(0x0c9bb0a5),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Image.asset("images/balon.png"),
                          ),
                          SizedBox(height: 15),
                          SizedBox(
                            width: 80,
                            height: 46,
                            child: Text(
                              "بالون",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xff687c71),
                                fontSize: 15,
                                fontFamily: "Cairo",
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 6),
                    Container(
                      width: 77,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(11),
                        color: Color(0x0c9bb0a5),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Image.asset("images/candel.png"),
                          ),
                          SizedBox(height: 15),
                          SizedBox(
                            width: 80,
                            height: 45,
                            child: Text(
                              "شمعة",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xff687c71),
                                fontSize: 14,
                                fontFamily: "Cairo",
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "هيا لنبدأ",
                  style: TextStyle(
                    color: Color(0xff385a4a),
                    fontSize: 18,
                    fontFamily: "Cairo",
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              VideoCard(
                asset: "assets/video.mp4",
                phaseName: 'التنفس',
                image: 'images/Koala.png',
                CardColor: Color.fromARGB(226, 255, 245, 245),
                CircalColor: Color(0x7fffb7a1),
                TextColor: Color(0xff7c6063),
                width: 111,
                hight: 124,
              ),
              SizedBox(
                height: 10,
              ),
              VideoCard(
                asset: 'assets/lesanEx.mp4',
                phaseName: 'اللسان',
                image: 'images/Elephant.png',
                CardColor: Color.fromARGB(195, 238, 251, 255),
                CircalColor: Color(0xffbfdae4),
                TextColor: Color(0xff7688a2),
                width: 120,
                hight: 131,
              ),

              SizedBox(
                height: 10,
              ),
              VideoCard(
                asset: 'assets/vedio2.mp4',
                phaseName: 'النفخ',
                image: 'images/Rabbit.png',
                CardColor: Color(0xffeff4f0),
                CircalColor: Color(0xffd3e7d8),
                TextColor: Color.fromARGB(164, 56, 90, 74),
                width: 150,
                hight: 150,
              ),
              SizedBox(
                height: 10,
              ),
              VideoCard(
                asset: 'assets/SoundEx.mp4',
                phaseName: 'الاصوات',
                image: 'images/lavander.png',
                CardColor: Color.fromARGB(220, 244, 242, 255),
                CircalColor: Color.fromARGB(235, 190, 185, 250),
                TextColor: Color.fromARGB(160, 86, 42, 117),
                width: 132.67,
                hight: 189,
              ),
              //----------------

              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      )),
    );
  }

  // void _showVideoPlayer(BuildContext context) {
  //   showModalBottomSheet(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return SingleChildScrollView(
  //           child: FutureBuilder(
  //         future: _initializeVideoPlayerFuture,
  //         builder: (context, snapshot) {
  //           if (snapshot.connectionState == ConnectionState.done) {
  //             return Center(
  //               child: AspectRatio(
  //                 aspectRatio: _controller.value.aspectRatio,
  //                 child: VideoPlayer(_controller),
  //               ),
  //             );
  //           } else {
  //             return Center(
  //               child: CircularProgressIndicator(),
  //             );
  //           }
  //         },
  //       ));
  //     },
  //   );
  // }
  // void _showVideoPlayer(BuildContext context) {
  //   showModalBottomSheet(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return SingleChildScrollView(
  //         child: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: <Widget>[
  //             AspectRatio(
  //               aspectRatio: _controller.value.aspectRatio,
  //               child: VideoPlayer(_controller),
  //             ),
  //             Padding(
  //               padding: const EdgeInsets.all(8.0),
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 children: <Widget>[
  //                   IconButton(
  //                     onPressed: () {
  //                       setState(() {
  //                         if (_controller.value.isPlaying) {
  //                           _controller.pause();
  //                           print('Video is paused.');
  //                         } else {
  //                           _controller.play();
  //                           print('Video is playing.');
  //                         }
  //                       });
  //                     },
  //                     icon: Icon(
  //                       _controller.value.isPlaying
  //                           ? Icons.pause
  //                           : Icons.play_arrow,
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }

  // void _showVideoPlayer(BuildContext context) {
  //   showModalBottomSheet(
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.only(
  //         topLeft: Radius.circular(35.0),
  //         topRight: Radius.circular(35.0),
  //       ),
  //     ),
  //     context: context,
  //     isScrollControlled: true,
  //     builder: (BuildContext context) {
  //       return StatefulBuilder(
  //           builder: (BuildContext context, StateSetter setState) {
  //         final bottomInset = MediaQuery.of(context).viewInsets.bottom;
  //         return SizedBox(
  //           height: MediaQuery.of(context).size.height * 0.5,
  //           child: SingleChildScrollView(
  //             child: Column(
  //               mainAxisSize: MainAxisSize.min,
  //               children: <Widget>[
  //                 AspectRatio(
  //                   aspectRatio: _controller.value.aspectRatio,
  //                   child: VideoPlayer(_controller),
  //                 ),
  //                 Padding(
  //                   padding: const EdgeInsets.all(8.0),
  //                   child: Row(
  //                     mainAxisAlignment: MainAxisAlignment.center,
  //                     children: <Widget>[
  //                       IconButton(
  //                         onPressed: () {
  //                           setState(() {
  //                             if (_controller.value.isPlaying) {
  //                               _controller.pause();
  //                               print('Video is paused.');
  //                             } else {
  //                               _controller.play();
  //                               print('Video is playing.');
  //                             }
  //                           });
  //                         },
  //                         icon: Icon(
  //                           _controller.value.isPlaying
  //                               ? Icons.pause
  //                               : Icons.play_arrow,
  //                         ),
  //                       )
  //                     ],
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         );
  //       });
  //     },
  //   ).whenComplete(() {
  //     _controller.pause();
  //   });
  // }

  // void _showVideoPlayer(BuildContext context) {
  //   showModalBottomSheet(
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.only(
  //         topLeft: Radius.circular(35.0),
  //         topRight: Radius.circular(35.0),
  //       ),
  //     ),
  //     context: context,
  //     isScrollControlled: true,
  //     builder: (BuildContext context) {
  //       return StatefulBuilder(
  //         builder: (BuildContext context, StateSetter setState) {
  //           final bottomInset = MediaQuery.of(context).viewInsets.bottom;
  //           return SizedBox(
  //             height: MediaQuery.of(context).size.height *
  //                 0.5, // Adjust the height of the SizedBox to make the video player larger
  //             child: SingleChildScrollView(
  //               child: Column(
  //                 mainAxisSize: MainAxisSize.min,
  //                 children: <Widget>[
  //                   Container(
  //                     height: MediaQuery.of(context).size.height *
  //                         0.5, // Set the height of the Container to the height of the SizedBox
  //                     child: AspectRatio(
  //                       aspectRatio: _controller.value.aspectRatio,
  //                       child: VideoPlayer(_controller),
  //                     ),
  //                   ),
  //                   Padding(
  //                     padding: const EdgeInsets.all(8.0),
  //                     child: Align(
  //                       alignment: Alignment.center,
  //                       child: IconButton(
  //                         onPressed: () {
  //                           setState(() {
  //                             if (_controller.value.isPlaying) {
  //                               _controller.pause();
  //                               print('Video is paused.');
  //                             } else {
  //                               _controller.play();
  //                               print('Video is playing.');
  //                             }
  //                           });
  //                         },
  //                         icon: Icon(
  //                           _controller.value.isPlaying
  //                               ? Icons.pause
  //                               : Icons.play_arrow,
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           );
  //         },
  //       );
  //     },
  //   ).whenComplete(() {
  //     _controller.pause();
  //   });
  // }

  // void _showVideoPlayer(BuildContext context) {
  //   showModalBottomSheet(
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.only(
  //         topLeft: Radius.circular(35.0),
  //         topRight: Radius.circular(35.0),
  //       ),
  //     ),
  //     context: context,
  //     isScrollControlled: true,
  //     builder: (BuildContext context) {
  //       final bottomInset = MediaQuery.of(context).viewInsets.bottom;
  //       return Container(
  //         margin: EdgeInsets.only(bottom: bottomInset),
  //         child: SizedBox(
  //           height: MediaQuery.of(context).size.height * 0.8,
  //           child: Stack(
  //             children: [
  //               GestureDetector(
  //                 onTap: () {
  //                   setState(() {
  //                     if (_controller.value.isPlaying) {
  //                       _controller.pause();
  //                     } else {
  //                       _controller.play();
  //                     }
  //                   });
  //                 },
  //                 child: Container(
  //                   decoration: BoxDecoration(
  //                     borderRadius: BorderRadius.only(
  //                       topLeft: Radius.circular(35.0),
  //                       topRight: Radius.circular(35.0),
  //                     ),
  //                     boxShadow: [
  //                       BoxShadow(
  //                         color: Colors.black.withOpacity(0.2),
  //                         blurRadius: 10.0,
  //                         spreadRadius: 5.0,
  //                         offset: Offset(0, -5),
  //                       ),
  //                     ],
  //                   ),
  //                   child: AspectRatio(
  //                     aspectRatio: _controller.value.aspectRatio,
  //                     child: VideoPlayer(_controller),
  //                   ),
  //                 ),
  //               ),
  //               AnimatedOpacity(
  //                 duration: Duration(milliseconds: 500),
  //                 opacity: _controller.value.isPlaying ? 0.0 : 1.0,
  //                 child: Positioned(
  //                   left: 0,
  //                   top: 0,
  //                   right: 0,
  //                   bottom: 0,
  //                   child: IconButton(
  //                     onPressed: () {
  //                       setState(() {
  //                         if (_controller.value.isPlaying) {
  //                           _controller.pause();
  //                         } else {
  //                           _controller.play();
  //                         }
  //                       });
  //                     },
  //                     icon: Icon(
  //                       Icons.play_arrow,
  //                       color: Colors.white,
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  // void _showVideoPlayer(BuildContext context) {
  //   showModalBottomSheet(
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.only(
  //         topLeft: Radius.circular(35.0),
  //         topRight: Radius.circular(35.0),
  //       ),
  //     ),
  //     context: context,
  //     isScrollControlled: true,
  //     builder: (BuildContext context) {
  //       return StatefulBuilder(
  //         builder: (BuildContext context, StateSetter setState) {
  //           final bottomInset = MediaQuery.of(context).viewInsets.bottom;
  //           return SizedBox(
  //             height: MediaQuery.of(context).size.height *
  //                 0.5, // Adjust the height of the SizedBox to make the video player larger
  //             child: SingleChildScrollView(
  //               child: Stack(
  //                 children: <Widget>[
  //                   Container(
  //                     height: MediaQuery.of(context).size.height *
  //                         0.5, // Set the height of the Container to the height of the SizedBox
  //                     child: AspectRatio(
  //                       aspectRatio: _controller.value.aspectRatio,
  //                       child: VideoPlayer(_controller),
  //                     ),
  //                   ),
  //                   Positioned(
  //                     // Center the IconButton inside the video player
  //                     left: 0,

  //                     right: 0,
  //                     bottom: 0,
  //                     child: IconButton(
  //                       color: Colors.white,
  //                       iconSize: 30,
  //                       onPressed: () {
  //                         setState(() {
  //                           if (_controller.value.isPlaying) {
  //                             _controller.pause();
  //                             print('Video is paused.');
  //                           } else {
  //                             _controller.play();
  //                             print('Video is playing.');
  //                           }
  //                         });
  //                       },
  //                       icon: Icon(
  //                         _controller.value.isPlaying
  //                             ? Icons.pause
  //                             : Icons.play_arrow_sharp,
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           );
  //         },
  //       );
  //     },
  //   ).whenComplete(() {
  //     _controller.pause();
  //   });
  // }

  // void _showVideoPlayer(BuildContext context) {
  //   showModalBottomSheet(
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.only(
  //         topLeft: Radius.circular(35.0),
  //         topRight: Radius.circular(35.0),
  //       ),
  //     ),
  //     context: context,
  //     isScrollControlled: true,
  //     builder: (BuildContext context) {
  //       return StatefulBuilder(
  //         builder: (BuildContext context, StateSetter setState) {
  //           final bottomInset = MediaQuery.of(context).viewInsets.bottom;
  //           return SizedBox(
  //             height: MediaQuery.of(context).size.height *
  //                 0.5, // Adjust the height of the SizedBox to make the video player larger
  //             child: SingleChildScrollView(
  //               child: Stack(
  //                 children: <Widget>[
  //                   Container(
  //                     height: MediaQuery.of(context).size.height *
  //                         0.5, // Set the height of the Container to the height of the SizedBox
  //                     child: AspectRatio(
  //                       aspectRatio: _controller.value.aspectRatio,
  //                       child: VideoPlayer(_controller),
  //                     ),
  //                   ),
  //                   Positioned(
  //                     // Center the IconButton inside the video player
  //                     left: 0,
  //                     right: 0,
  //                     bottom: 0,
  //                     child: Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                       children: [
  //                         IconButton(
  //                           color: Colors.white,
  //                           iconSize: 30,
  //                           onPressed: () {
  //                             setState(() {
  //                               if (_controller.value.isPlaying) {
  //                                 _controller.pause();
  //                                 print('Video is paused.');
  //                               } else {
  //                                 _controller.play();
  //                                 print('Video is playing.');
  //                               }
  //                             });
  //                           },
  //                           icon: Icon(
  //                             _controller.value.isPlaying
  //                                 ? Icons.pause
  //                                 : Icons.play_arrow_sharp,
  //                           ),
  //                         ),
  //                         IconButton(
  //                           color: Colors.white,
  //                           iconSize: 30,
  //                           onPressed: () {
  //                             setState(() {
  //                               if (_controller.value.isPlaying) {
  //                                 _controller.pause();
  //                               }
  //                               Navigator.of(context).push(
  //                                 MaterialPageRoute(
  //                                   builder: (BuildContext context) {
  //                                     return Scaffold(
  //                                       body: Center(
  //                                         child: AspectRatio(
  //                                           aspectRatio:
  //                                               _controller.value.aspectRatio,
  //                                           child: VideoPlayer(_controller),
  //                                         ),
  //                                       ),
  //                                     );
  //                                   },
  //                                 ),
  //                               );
  //                             });
  //                           },
  //                           icon: Icon(
  //                             Icons.fullscreen,
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           );
  //         },
  //       );
  //     },
  //   ).whenComplete(() {
  //     _controller.pause();
  //   });
  // }

  // void _showVideoPlayer(BuildContext context) {
  //   showModalBottomSheet(
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.only(
  //         topLeft: Radius.circular(35.0),
  //         topRight: Radius.circular(35.0),
  //       ),
  //     ),
  //     context: context,
  //     isScrollControlled: true,
  //     builder: (BuildContext context) {
  //       return StatefulBuilder(
  //         builder: (BuildContext context, StateSetter setState) {
  //           final bottomInset = MediaQuery.of(context).viewInsets.bottom;
  //           return SizedBox(
  //             height: MediaQuery.of(context).size.height *
  //                 0.5, // Adjust the height of the SizedBox to make the video player larger
  //             child: SingleChildScrollView(
  //               child: Stack(
  //                 children: <Widget>[
  //                   Container(
  //                     height: MediaQuery.of(context).size.height *
  //                         0.5, // Set the height of the Container to the height of the SizedBox
  //                     child: AspectRatio(
  //                       aspectRatio: _controller.value.aspectRatio,
  //                       child: VideoPlayer(_controller),
  //                     ),
  //                   ),
  //                   Positioned(
  //                     // Center the IconButton inside the video player
  //                     left: 0,
  //                     right: 0,
  //                     bottom: 0,
  //                     child: Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                       children: [
  //                         IconButton(
  //                           color: Colors.white,
  //                           iconSize: 30,
  //                           onPressed: () {
  //                             setState(() {
  //                               if (_controller.value.isPlaying) {
  //                                 _controller.pause();
  //                                 print('Video is paused.');
  //                               } else {
  //                                 _controller.play();
  //                                 print('Video is playing.');
  //                               }
  //                             });
  //                           },
  //                           icon: Icon(
  //                             _controller.value.isPlaying
  //                                 ? Icons.pause
  //                                 : Icons.play_arrow_sharp,
  //                           ),
  //                         ),
  //                         IconButton(
  //                           color: Colors.white,
  //                           iconSize: 30,
  //                           onPressed: () {
  //                             setState(() {
  //                               if (_controller.value.isPlaying) {
  //                                 _controller.pause();
  //                               }
  //                               Navigator.of(context).push(
  //                                 MaterialPageRoute(
  //                                   fullscreenDialog: true,
  //                                   builder: (BuildContext context) {
  //                                     return Scaffold(
  //                                       body: GestureDetector(
  //                                         onTap: () {
  //                                           Navigator.pop(context);
  //                                         },
  //                                         child: Center(
  //                                           child: AspectRatio(
  //                                             aspectRatio:
  //                                                 _controller.value.aspectRatio,
  //                                             child: Stack(
  //                                               children: [
  //                                                 VideoPlayer(_controller),
  //                                                 Positioned(
  //                                                   left: 0,
  //                                                   right: 0,
  //                                                   bottom: 0,
  //                                                   child: Row(
  //                                                     mainAxisAlignment:
  //                                                         MainAxisAlignment
  //                                                             .spaceBetween,
  //                                                     children: [
  //                                                       IconButton(
  //                                                         color: Colors.white,
  //                                                         iconSize: 30,
  //                                                         onPressed: () {
  //                                                           setState(() {
  //                                                             if (_controller
  //                                                                 .value
  //                                                                 .isPlaying) {
  //                                                               _controller
  //                                                                   .pause();
  //                                                               print(
  //                                                                   'Video is paused.');
  //                                                             } else {
  //                                                               _controller
  //                                                                   .play();
  //                                                               print(
  //                                                                   'Video is playing.');
  //                                                             }
  //                                                           });
  //                                                         },
  //                                                         icon: Icon(
  //                                                           _controller.value
  //                                                                   .isPlaying
  //                                                               ? Icons.pause
  //                                                               : Icons
  //                                                                   .play_arrow,
  //                                                         ),
  //                                                       ),
  //                                                       IconButton(
  //                                                         color: Colors.white,
  //                                                         iconSize: 30,
  //                                                         onPressed: () {
  //                                                           setState(() {});
  //                                                           if (MediaQuery.of(
  //                                                                       context)
  //                                                                   .orientation ==
  //                                                               Orientation
  //                                                                   .portrait) {
  //                                                             SystemChrome
  //                                                                 .setPreferredOrientations([
  //                                                               DeviceOrientation
  //                                                                   .landscapeLeft,
  //                                                               DeviceOrientation
  //                                                                   .landscapeRight,
  //                                                             ]);
  //                                                           } else {
  //                                                             SystemChrome
  //                                                                 .setPreferredOrientations([
  //                                                               DeviceOrientation
  //                                                                   .portraitUp,
  //                                                               DeviceOrientation
  //                                                                   .portraitDown,
  //                                                             ]);
  //                                                           }
  //                                                         },
  //                                                         icon: Icon(
  //                                                           Icons
  //                                                               .screen_rotation,
  //                                                         ),
  //                                                       ),
  //                                                     ],
  //                                                   ),
  //                                                 ),
  //                                               ],
  //                                             ),
  //                                           ),
  //                                         ),
  //                                       ),
  //                                     );
  //                                   },
  //                                 ),
  //                               );
  //                             });
  //                           },
  //                           icon: Icon(
  //                             Icons.fullscreen,
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           );
  //         },
  //       );
  //     },
  //   ).whenComplete(() {
  //     _controller.pause();
  //   });
  // }

  // void _showVideoPlayer(BuildContext context) {
  //   SystemChrome.setPreferredOrientations([
  //     DeviceOrientation.landscapeLeft,
  //     DeviceOrientation.landscapeRight,
  //   ]);

  //   Navigator.of(context).push(
  //     MaterialPageRoute(
  //       fullscreenDialog: true,
  //       builder: (BuildContext context) {
  //         return WillPopScope(
  //           onWillPop: () async {
  //             SystemChrome.setPreferredOrientations([
  //               DeviceOrientation.portraitUp,
  //               DeviceOrientation.portraitDown,
  //             ]);
  //             return true;
  //           },
  //           child: Scaffold(
  //             body: Center(
  //               child: OrientationBuilder(
  //                 builder: (BuildContext context, Orientation orientation) {
  //                   return Transform.rotate(
  //                     angle: orientation == Orientation.landscape
  //                         ? math.pi / 2
  //                         : 0,
  //                     child: Container(
  //                       constraints: BoxConstraints.expand(
  //                         height: orientation == Orientation.landscape
  //                             ? MediaQuery.of(context).size.width
  //                             : MediaQuery.of(context).size.height,
  //                       ),
  //                       child: AspectRatio(
  //                         aspectRatio: _controller.value.aspectRatio,
  //                         child: VideoPlayer(_controller),
  //                       ),
  //                     ),
  //                   );
  //                 },
  //               ),
  //             ),
  //           ),
  //         );
  //       },
  //     ),
  //   );
  // }
}
