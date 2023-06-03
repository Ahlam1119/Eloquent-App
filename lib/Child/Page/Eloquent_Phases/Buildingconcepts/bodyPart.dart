import 'dart:ui';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
// import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/services.dart';
import 'dart:typed_data';

class bodyPart extends StatefulWidget {
  final String childId;
  final String page;
  bodyPart({required this.childId, required this.page});

  @override
  State<bodyPart> createState() => _bodyPartState();
}

class _bodyPartState extends State<bodyPart> {
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
                          "اجزاء الجسم ",
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
                height: 40,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 400,
                    height: 160,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Align(
                            alignment: Alignment.center,
                            child: Container(
                              width: 330,
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
                                        color:
                                            Color.fromARGB(255, 253, 245, 230)),
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
                                          "يد",
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
                                                Audio(
                                                    "images/WordSounds/Yaa.wav"),
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
                                    child: SizedBox(
                                        child: Image.asset(
                                      "images/handBig.png",
                                    ))),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
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
                              height: 140,
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
                                          "عين",
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
                                                Audio(
                                                    "images/WordSounds/aaN.wav"),
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
                                                  "images/eyesBig.png")))
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
                              height: 140,
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
                                          "قَدَم",
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
                                                Audio("images/foott.wav"),
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
                                            Image.asset("images/footbig2.png"),
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
                              height: 140,
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
                                          "شَعْر",
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
                                                Audio("images/hair1.wav"),
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
                                          child:
                                              Image.asset("images/hairBig.png"))
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
                              height: 140,
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
                                        color: Color(0xfff3f7f8)),
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
                                          "أُذُن",
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
                                                Audio("images/ear1.wav"),
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
                                          child:
                                              Image.asset("images/earsBig.png"))
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
            ],
          ),
        ),
      )),
    );
  }
}
