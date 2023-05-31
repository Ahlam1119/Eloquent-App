import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:eloquentapp/Child/Page/Eloquent_Phases/SoundPhase/balon.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';
import 'dart:typed_data';
import 'TT_Test.dart';

class TT_sound extends StatefulWidget {
  //2
  const TT_sound({super.key});
  @override
  State<TT_sound> createState() => _TT_soundState();
}

class _TT_soundState extends State<TT_sound> {
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
                          "حرف الثاء",
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 353,
                    height: 124,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Align(
                            alignment: Alignment.center,
                            child: Container(
                              width: 353,
                              height: 92,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 330,
                                    height: 92,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(11),
                                        color: Color(0xffF3F7F8)),
                                    padding: const EdgeInsets.only(
                                      left: 20,
                                      right: 152,
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "أسمع نطق الحرف",
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            color: Color(0xff7688a2),
                                            fontSize: 14,
                                            fontFamily: "Cairo",
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        SizedBox(width: 27.95),
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
                                                    "images/LetterSounds/tta.wav"),
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
                          left: 210,
                          top: 0,
                          child: Container(
                            width: 126,
                            height: 120,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 126,
                                  height: 124,
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
                                  child: Text(
                                    "ثا",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color(0xff394445),
                                      fontSize: 60,
                                      fontFamily: "Cairo",
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 25),
                  //----------------------------------
                  Container(
                    width: 353,
                    height: 124,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Align(
                            alignment: Alignment.center,
                            child: Container(
                              width: 353,
                              height: 92,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 330,
                                    height: 92,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(11),
                                        color: Color(0xffF3F7F8)),
                                    padding: const EdgeInsets.only(
                                      left: 20,
                                      right: 152,
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "أسمع نطق الحرف",
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            color: Color(0xff7688a2),
                                            fontSize: 14,
                                            fontFamily: "Cairo",
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        SizedBox(width: 27.95),
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
                                                    "images/LetterSounds/ttw.wav"),
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
                          left: 210,
                          top: 0,
                          child: Container(
                            width: 126,
                            height: 120,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 126,
                                  height: 124,
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
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        "ثو",
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                          color: Color(0xff394445),
                                          fontSize: 60,
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

                  SizedBox(height: 25),
                  //----------------------------------
                  Container(
                    width: 353,
                    height: 124,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Align(
                            alignment: Alignment.center,
                            child: Container(
                              width: 353,
                              height: 92,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 330,
                                    height: 92,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(11),
                                        color: Color(0xffF3F7F8)),
                                    padding: const EdgeInsets.only(
                                      left: 20,
                                      right: 152,
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "أسمع نطق الحرف",
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            color: Color(0xff7688a2),
                                            fontSize: 14,
                                            fontFamily: "Cairo",
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        SizedBox(width: 27.95),
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
                                                    "images/LetterSounds/tte.wav"),
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
                          left: 210,
                          top: 0,
                          child: Container(
                            width: 126,
                            height: 124,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 126,
                                  height: 124,
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
                                      horizontal: 10, vertical: 10),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "ثي",
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                          color: Color(0xff394445),
                                          fontSize: 60,
                                          fontFamily: "Cairo",
                                          fontWeight: FontWeight.w800,
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
                ],
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                child: Row(children: [
                  Container(
                    width: 105,
                    height: 179,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(11),
                      color: Color(0xfff3f7f8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 93,
                                      height: 93,
                                      child: Image.asset("images/TTaa.png"),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "ثعلب",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: Color(0xff394445),
                                fontSize: 26,
                                fontFamily: "Cairo",
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: GestureDetector(
                                onTap: () async {
                                  AssetsAudioPlayer.newPlayer().open(
                                    Audio("images/WordSounds/TTaa.wav"),
                                    autoStart: true,
                                    showNotification: true,
                                  );
                                },
                                child: Image.asset("images/VolumUp.png"),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 3,
                  ),
                  //-----------------
                  Container(
                    width: 110,
                    height: 179,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(11),
                      color: Color(0xfff3f7f8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                        width: 93,
                                        height: 93,
                                        child: Image.asset("images/aTTa.png")),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "مثلث",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: Color(0xff394445),
                                fontSize: 26,
                                fontFamily: "Cairo",
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: GestureDetector(
                                onTap: () async {
                                  AssetsAudioPlayer.newPlayer().open(
                                    Audio("images/WordSounds/aTTa.wav"),
                                    autoStart: true,
                                    showNotification: true,
                                  );
                                },
                                child: Image.asset("images/VolumUp.png"),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 2,
                  ),
                  //-----------------
                  Container(
                    width: 110,
                    height: 179,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(11),
                      color: Color(0xfff3f7f8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                        width: 93,
                                        height: 93,
                                        child: Image.asset(
                                          "images/aaTT.png",
                                        )),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "محراث",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: Color(0xff394445),
                                fontSize: 26,
                                fontFamily: "Cairo",
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: GestureDetector(
                                onTap: () async {
                                  AssetsAudioPlayer.newPlayer().open(
                                    Audio("images/WordSounds/aaTT.wav"),
                                    autoStart: true,
                                    showNotification: true,
                                  );
                                },
                                child: Image.asset("images/VolumUp.png"),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ]),
              ),
              SizedBox(
                height: 15,
              ),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(119, 37),
                      backgroundColor: Color(0xff394445),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      )),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TT_Test_Page(),
                        ));
                  },
                  child: Text('التالي'),
                ),
              ),
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
