import 'dart:async';
import 'dart:math';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class L_Test_Page extends StatefulWidget {
  //1
  const L_Test_Page({super.key});
  @override
  State<L_Test_Page> createState() => _L_Test_PageState();
}

class _L_Test_PageState extends State<L_Test_Page> {
  late Timer _timer;
  bool _isPartyStarted = false;
  List<BalloonState> _balloonStates = [];

  List<Color> _availableColors = [
    Color.fromARGB(255, 224, 131, 127),
    Color.fromARGB(255, 182, 207, 216),
    Color.fromARGB(255, 202, 233, 210),
    Color(0xffa8a3ec),
    Color.fromARGB(225, 245, 252, 116),
    Color.fromARGB(158, 234, 149, 80),
  ];

  void _startParty() {
    setState(() {
      _isPartyStarted = true;
      _balloonStates = List.generate(
        10,
        (_) => BalloonState(
          position: Offset(
            Random().nextDouble() * MediaQuery.of(context).size.width,
            MediaQuery.of(context).size.height,
          ),
          color: _availableColors[Random().nextInt(_availableColors.length)],
          startTime: DateTime.now().millisecondsSinceEpoch.toDouble(),
        ),
      );
    });
  }

  void _updatePositions(Timer timer) {
    if (_isPartyStarted) {
      setState(() {
        for (int i = 0; i < _balloonStates.length; i++) {
          final state = _balloonStates[i];
          final duration = DateTime.now().millisecondsSinceEpoch.toDouble() -
              state.startTime;
          final screenHeight = MediaQuery.of(context).size.height;
          final balloonHeight = 75.0;
          final distance = duration / 5000 * screenHeight;
          final newPosition = Offset(
            state.position.dx,
            screenHeight - distance - balloonHeight,
          );

          _balloonStates[i] = state.copyWith(position: newPosition);

          if (newPosition.dy < -balloonHeight) {
            _balloonStates[i] = state.copyWith(
              position: Offset(
                Random().nextDouble() * MediaQuery.of(context).size.width,
                screenHeight,
              ),
              startTime: DateTime.now().millisecondsSinceEpoch.toDouble(),
            );
          }
        }
      });
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

//-------------------------------------2
  final List<String> soundPaths = [
    "images/La.wav",
    "images/Lw.wav",
    "images/Le.wav"
  ];

  late String currentSoundPath;
  int? correctIndex;
  bool isTestFinished = false;
  bool isResultSent = false;
  bool isSoundPlayed = false;

  List<bool> soundsPlayed = [false, false, false]; //

  void playSound() {
    final AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer();
    assetsAudioPlayer.open(
      Audio(currentSoundPath),
      autoStart: true,
      showNotification: true,
    );

    // Determine the correct index based on the selected sound
    switch (currentSoundPath) {
      case "images/La.wav":
        correctIndex = 0;
        soundsPlayed[0] = true;
        break;
      case "images/Lw.wav":
        correctIndex = 1;
        soundsPlayed[1] = true;
        break;
      case "images/Le.wav":
        correctIndex = 2;
        soundsPlayed[2] = true;
        break;
      default:
        correctIndex = null;
    }
    if (soundsPlayed[0] == true &&
        soundsPlayed[1] == true &&
        soundsPlayed[2] == true)
      setState(() {
        {
          isResultSent = true;
        }
      });
  }

  void checkAnswer(int selectedSoundIndex) {
    if (!isTestFinished) {
      final bool isCorrectAnswer = selectedSoundIndex == correctIndex;

      if (isCorrectAnswer) {
        // Correct answer
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Image.asset(
                'images/True.png',
                height: 70,
              ),
              content: const Text(
                "إجابة صحيحة",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xff394445),
                  fontSize: 25,
                  fontFamily: "Cairo",
                  fontWeight: FontWeight.w600,
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    "إستمر",
                    style: TextStyle(
                      color: Color.fromARGB(255, 106, 152, 186),
                      fontSize: 15,
                      fontFamily: "Cairo",
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            );
          },
        );
      } else {
        // Incorrect answer
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: SizedBox(
                  height: 95,
                  width: 80,
                  child: Text(
                    textAlign: TextAlign.center,
                    'X',
                    style: TextStyle(
                      color: Color(0xff394445),
                      fontSize: 70,
                      fontFamily: "Cairo",
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                content: const Text(
                  "إجابة خاطئة",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xff394445),
                    fontSize: 20,
                    fontFamily: "Cairo",
                    fontWeight: FontWeight.w600,
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      "حاول مرة اخرى",
                      style: TextStyle(
                        color: Color.fromARGB(255, 106, 152, 186),
                        fontSize: 13,
                        fontFamily: "Cairo",
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              );
            });
      }

      // Determine whether the test is finished

      // Enable the "Send Result to Firebase" button if the test is finished
    }
  }

  void sendResultToFirebase(String TestID) {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final DateTime now = DateTime.now();
    final String formattedDate = "${now.day}/${now.month}/${now.year}";
    // final String result = correctIndex != null ? "pass" : "fail";
    firestore.collection("test_results").add({
      "date": formattedDate,
      // "result": result,
      'letter': 'حرف اللام',
      'ParentID': FirebaseAuth.instance.currentUser!.uid,
      'isRead': false,
      'TestID': TestID,
      'LetterName': 'ل'
    });

    // Set isResultSent to true to disable the button
    setState(() {
      isResultSent = false;
    });
  }

  void playRandomSound() {
    setState(() {
      currentSoundPath = soundPaths[Random().nextInt(soundPaths.length)];
      correctIndex = null;
      isTestFinished = false;
    });
    playSound();
  }

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 16), _updatePositions);

    // playRandomSound();
  }

//-----------------------------------
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
                          "حرف اللام",
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
                        "بمفرده و في مواضع الكلمة",
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
                height: 35,
              ),
              Container(
                height: 640,
                child: Stack(
                  children: [
                    GestureDetector(
                      onTap: () {
                        playRandomSound();
                      },
                      child: Container(
                        width: 353,
                        height: 383,
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: Align(
                                alignment: Alignment.bottomLeft,
                                child: Container(
                                  width: 353,
                                  height: 138,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 330,
                                        height: 138,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(11),
                                          color: Color(0xfff3f7f8),
                                        ),
                                        padding: const EdgeInsets.only(
                                          top: 92,
                                          bottom: 21,
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Row(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  child: Text(
                                                    "أختر الصوت الصحيح الذي تسمعه",
                                                    textAlign: TextAlign.right,
                                                    style: TextStyle(
                                                      color: Color(0xff394445),
                                                      fontSize: 15,
                                                      fontFamily: "Cairo",
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(width: 5),
                                                Container(
                                                  width: 30.81,
                                                  height: 20.86,
                                                  child: Image.asset(
                                                      "images/VolumUp.png"),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Positioned.fill(
                              child: Align(
                                alignment: Alignment.topCenter,
                                child: Container(
                                  width: 300,
                                  height: 314,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 300,
                                        height: 314,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(18),
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
                                          left: 116,
                                          right: 115,
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: 69,
                                              height: 126,
                                              child: Image.asset(
                                                  "images/qustionMark.png"),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Positioned(
                      bottom: 87,
                      child: Container(
                        width: 353,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                checkAnswer(0);
                              },
                              child: Container(
                                width: 93,
                                height: 118,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 93,
                                      height: 118,
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
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            "لا",
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                              color: Color(0xff6888a0),
                                              fontSize: 52,
                                              fontFamily: "Cairo",
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: 8),
                            GestureDetector(
                              onTap: () {
                                checkAnswer(1);
                              },
                              child: Container(
                                width: 102,
                                height: 118,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 102,
                                      height: 118,
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
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            "لو",
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                              color: Color(0xff6888a0),
                                              fontSize: 52,
                                              fontFamily: "Cairo",
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: 8),
                            GestureDetector(
                              onTap: () {
                                checkAnswer(2);
                              },
                              child: Container(
                                width: 125,
                                height: 115,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 125,
                                      height: 115,
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
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            "لي",
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                              color: Color(0xff6888a0),
                                              fontSize: 50,
                                              fontFamily: "Cairo",
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
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
                    ),
                    SizedBox(
                      height: 23,
                    ),
                    for (int i = 0; i < _balloonStates.length; i++)
                      Positioned(
                        left: _balloonStates[i].position.dx,
                        top: _balloonStates[i].position.dy,
                        child: Image.asset(
                          'images/gbaloon.png',
                          width: 70,
                          height: 100,
                          color: _balloonStates[i].color,
                        ),
                      ),
                    Positioned(
                      bottom: 20,
                      left: 120,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size(119, 37),
                            backgroundColor: Color(0xff394445),
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            )),
                        onPressed: isResultSent
                            ? () {
                                final String requestId = const Uuid().v4();
                                sendResultToFirebase(requestId);
                                _startParty();
                                // Disable the button again after sending the result to Firebase
                              }
                            : null,
                        child: Text('تم'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}

class BalloonState {
  final Offset position;
  final Color color;
  final double startTime;

  BalloonState({
    required this.position,
    required this.color,
    required this.startTime,
  });

  BalloonState copyWith({Offset? position, Color? color, double? startTime}) {
    return BalloonState(
      position: position ?? this.position,
      color: color ?? this.color,
      startTime: startTime ?? this.startTime,
    );
  }
}
