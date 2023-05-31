import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eloquentapp/Child/Page/Eloquent_Phases/SoundPhase/A.dart';
import 'package:eloquentapp/Child/Page/Eloquent_Phases/SoundPhase/B.dart.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'SoundPhase/3.dart';
import 'SoundPhase/33.dart';
import 'SoundPhase/5.dart';
import 'SoundPhase/7.dart';
import 'SoundPhase/D.dart';
import 'SoundPhase/DDa.dart';
import 'SoundPhase/Dh.dart';
import 'SoundPhase/H.dart';
import 'SoundPhase/J.dart';
import 'SoundPhase/K.dart';
import 'SoundPhase/L.dart';
import 'SoundPhase/M.dart';
import 'SoundPhase/N.dart';
import 'SoundPhase/Q.dart';
import 'SoundPhase/R.dart';
import 'SoundPhase/S.dart';
import 'SoundPhase/SH.dart';
import 'SoundPhase/SS.dart';
import 'SoundPhase/T.dart';
import 'SoundPhase/TH.dart';
import 'SoundPhase/TT.dart';
import 'SoundPhase/Ta.dart';
import 'SoundPhase/F.dart';
import 'SoundPhase/W.dart';
import 'SoundPhase/Y.dart';
import 'SoundPhase/Z.dart';

class AlphabetChildPage extends StatefulWidget {
  late String ChildID;
  AlphabetChildPage({required this.ChildID});

  @override
  State<AlphabetChildPage> createState() => _AlphabetChildPageState();
}

class _AlphabetChildPageState extends State<AlphabetChildPage> {
  late String ChildID = widget.ChildID;

  @override
  void initState() {
    super.initState();
    GetLaeeterPassind();
    getChidlData();
  }

  Map<String, dynamic> ChildInfo = {};
  bool isLoded = true;
  getChidlData() async {
    await FirebaseFirestore.instance
        .collection('Child')
        .where("uidParent", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((v) {
      for (var element in v.docs) {
        ChildInfo.addAll(element.data());
        setState(() {
          isLoded = false;
        });
      }
    });
  }

  // late String name = ChildInfo['name'];

  Map<String, dynamic> LetterPasiing = {};

  GetLaeeterPassind() async {
    await FirebaseFirestore.instance
        .collection('ChildEvaluation')
        .where('ParentID', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((v) {
      for (var element in v.docs) {
        LetterPasiing.addAll(element.data());
      }
    });
  }

  var boxDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(11),
    color: Color(0xffeef1f4),
  );
  static const textStyle = TextStyle(
      color: Color(0xff6888a0),
      fontSize: 38,
      fontFamily: "Cairo",
      fontWeight: FontWeight.w800);
  TextStyle PassedtextStyle = TextStyle(
      color: Color(0xffc4c4c4),
      fontSize: 38,
      fontFamily: "Cairo",
      fontWeight: FontWeight.w800);

  @override
  Widget build(BuildContext context) {
    return isLoded == true
        ? Center(child: CircularProgressIndicator())
        : Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: GridView.count(
                    crossAxisSpacing: 3,
                    mainAxisSpacing: 20,
                    crossAxisCount: 4,
                    padding: const EdgeInsets.all(3),
                    children: [
                      //start
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => A_sound(),
                              ));
                        },
                        child: Stack(
                          children: [
                            Container(
                              width: 80,
                              decoration: boxDecoration,
                              padding: const EdgeInsets.all(1),
                              child: Text(
                                "ط£",
                                textAlign: TextAlign.center,
                                style:
                                    LetterPasiing['ط­ط±ظپ ط§ظ„ط£ظ„ظپ'] == true
                                        ? PassedtextStyle
                                        : textStyle,
                              ),
                            ),
                            LetterPasiing['ط­ط±ظپ ط§ظ„ط£ظ„ظپ'] == true
                                ? Positioned(
                                    top: -2,
                                    left: 0,
                                    child: Image.asset("images/passtest.png"),
                                  )
                                : Text(""),
                          ],
                        ),
                      ),
                      LetterPasiing['ط­ط±ظپ ط§ظ„ط£ظ„ظپ'] == true
                          ? GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => B_sound(),
                                    ));
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    width: 80,
                                    decoration: boxDecoration,
                                    padding: const EdgeInsets.all(1),
                                    child: Text(
                                      "ط¨",
                                      textAlign: TextAlign.center,
                                      style:
                                          LetterPasiing['ط­ط±ظپ ط§ظ„ط¨ط§ط،'] ==
                                                  true
                                              ? PassedtextStyle
                                              : textStyle,
                                    ),
                                  ),
                                  LetterPasiing['ط­ط±ظپ ط§ظ„ط¨ط§ط،'] == true
                                      ? Positioned(
                                          top: -2,
                                          left: 0,
                                          child: Image.asset(
                                              "images/passtest.png"),
                                        )
                                      : Text(""),
                                ],
                              ),
                            )
                          : GestureDetector(
                              onTap: () {},
                              child: Stack(
                                children: [
                                  Container(
                                    width: 80,
                                    decoration: boxDecoration,
                                    padding: const EdgeInsets.all(1),
                                    child: Text(
                                      "ط¨",
                                      textAlign: TextAlign.center,
                                      style:
                                          LetterPasiing['ط­ط±ظپ ط§ظ„ط¨ط§ط،'] ==
                                                  true
                                              ? PassedtextStyle
                                              : textStyle,
                                    ),
                                  ),
                                  LetterPasiing['ط­ط±ظپ ط§ظ„ط¨ط§ط،'] == true
                                      ? Positioned(
                                          top: -2,
                                          left: 0,
                                          child: Image.asset(
                                              "images/passtest.png"),
                                        )
                                      : Text(""),
                                ],
                              ),
                            ),

                      LetterPasiing['ط­ط±ظپ ط§ظ„ط¨ط§ط،'] == true
                          ? GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => T_sound(),
                                    ));
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    width: 80,
                                    decoration: boxDecoration,
                                    padding: const EdgeInsets.all(1),
                                    child: Text(
                                      "طھ",
                                      textAlign: TextAlign.center,
                                      style:
                                          LetterPasiing['ط­ط±ظپ ط§ظ„طھط§ط،'] ==
                                                  true
                                              ? PassedtextStyle
                                              : textStyle,
                                    ),
                                  ),
                                  LetterPasiing['ط­ط±ظپ ط§ظ„طھط§ط،'] == true
                                      ? Positioned(
                                          top: -2,
                                          left: 0,
                                          child: Image.asset(
                                              "images/passtest.png"),
                                        )
                                      : Text(""),
                                ],
                              ),
                            )
                          : GestureDetector(
                              onTap: () {},
                              child: Stack(
                                children: [
                                  Container(
                                    width: 80,
                                    decoration: boxDecoration,
                                    padding: const EdgeInsets.all(1),
                                    child: Text(
                                      "طھ",
                                      textAlign: TextAlign.center,
                                      style:
                                          LetterPasiing['ط­ط±ظپ ط§ظ„طھط§ط،'] ==
                                                  true
                                              ? PassedtextStyle
                                              : textStyle,
                                    ),
                                  ),
                                  LetterPasiing['ط­ط±ظپ ط§ظ„طھط§ط،'] == true
                                      ? Positioned(
                                          top: -2,
                                          left: 0,
                                          child: Image.asset(
                                              "images/passtest.png"),
                                        )
                                      : Text(""),
                                ],
                              ),
                            ),
                      LetterPasiing['ط­ط±ظپ ط§ظ„طھط§ط،'] == true
                          ? GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => TT_sound(),
                                    ));
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    width: 80,
                                    decoration: boxDecoration,
                                    padding: const EdgeInsets.all(1),
                                    child: Text(
                                      "ط«",
                                      textAlign: TextAlign.center,
                                      style:
                                          LetterPasiing['ط­ط±ظپ ط§ظ„ط«ط§ط،'] ==
                                                  true
                                              ? PassedtextStyle
                                              : textStyle,
                                    ),
                                  ),
                                  LetterPasiing['ط­ط±ظپ ط§ظ„ط«ط§ط،'] == true
                                      ? Positioned(
                                          top: -2,
                                          left: 0,
                                          child: Image.asset(
                                              "images/passtest.png"),
                                        )
                                      : Text(""),
                                ],
                              ),
                            )
                          : GestureDetector(
                              onTap: () {},
                              child: Stack(
                                children: [
                                  Container(
                                    width: 80,
                                    decoration: boxDecoration,
                                    padding: const EdgeInsets.all(1),
                                    child: Text(
                                      "ط«",
                                      textAlign: TextAlign.center,
                                      style:
                                          LetterPasiing['ط­ط±ظپ ط§ظ„ط«ط§ط،'] ==
                                                  true
                                              ? PassedtextStyle
                                              : textStyle,
                                    ),
                                  ),
                                  LetterPasiing['ط­ط±ظپ ط§ظ„ط«ط§ط،'] == true
                                      ? Positioned(
                                          top: -2,
                                          left: 0,
                                          child: Image.asset(
                                              "images/passtest.png"),
                                        )
                                      : Text(""),
                                ],
                              ),
                            ),
                      LetterPasiing['ط­ط±ظپ ط§ظ„ط«ط§ط،'] == true
                          ? GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => J_sound(),
                                    ));
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    width: 80,
                                    decoration: boxDecoration,
                                    padding: const EdgeInsets.all(1),
                                    child: Text(
                                      "ط¬",
                                      textAlign: TextAlign.center,
                                      style:
                                          LetterPasiing['ط­ط±ظپ ط§ظ„ط¬ظٹظ…'] ==
                                                  true
                                              ? PassedtextStyle
                                              : textStyle,
                                    ),
                                  ),
                                  LetterPasiing['ط­ط±ظپ ط§ظ„ط¬ظٹظ…'] == true
                                      ? Positioned(
                                          top: -2,
                                          left: 0,
                                          child: Image.asset(
                                              "images/passtest.png"),
                                        )
                                      : Text(""),
                                ],
                              ),
                            )
                          : GestureDetector(
                              onTap: () {},
                              child: Stack(
                                children: [
                                  Container(
                                    width: 80,
                                    decoration: boxDecoration,
                                    padding: const EdgeInsets.all(1),
                                    child: Text(
                                      "ط¬",
                                      textAlign: TextAlign.center,
                                      style:
                                          LetterPasiing['ط­ط±ظپ ط§ظ„ط¬ظٹظ…'] ==
                                                  true
                                              ? PassedtextStyle
                                              : textStyle,
                                    ),
                                  ),
                                  LetterPasiing['ط­ط±ظپ ط§ظ„ط¬ظٹظ…'] == true
                                      ? Positioned(
                                          top: -2,
                                          left: 0,
                                          child: Image.asset(
                                              "images/passtest.png"),
                                        )
                                      : Text(""),
                                ],
                              ),
                            ),
                      LetterPasiing['ط­ط±ظپ ط§ظ„ط¬ظٹظ…'] == true
                          ? GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => HH_sound(),
                                    ));
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    width: 80,
                                    decoration: boxDecoration,
                                    padding: const EdgeInsets.all(1),
                                    child: Text(
                                      "ط­",
                                      textAlign: TextAlign.center,
                                      style:
                                          LetterPasiing['ط­ط±ظپ ط§ظ„ط­ط§ط،'] ==
                                                  true
                                              ? PassedtextStyle
                                              : textStyle,
                                    ),
                                  ),
                                  LetterPasiing['ط­ط±ظپ ط§ظ„ط­ط§ط،'] == true
                                      ? Positioned(
                                          top: -2,
                                          left: 0,
                                          child: Image.asset(
                                              "images/passtest.png"),
                                        )
                                      : Text(""),
                                ],
                              ),
                            )
                          : GestureDetector(
                              onTap: () {},
                              child: Stack(
                                children: [
                                  Container(
                                    width: 80,
                                    decoration: boxDecoration,
                                    padding: const EdgeInsets.all(1),
                                    child: Text(
                                      "ط­",
                                      textAlign: TextAlign.center,
                                      style:
                                          LetterPasiing['ط­ط±ظپ ط§ظ„ط­ط§ط،'] ==
                                                  true
                                              ? PassedtextStyle
                                              : textStyle,
                                    ),
                                  ),
                                  LetterPasiing['ط­ط±ظپ ط§ظ„ط­ط§ط،'] == true
                                      ? Positioned(
                                          top: -2,
                                          left: 0,
                                          child: Image.asset(
                                              "images/passtest.png"),
                                        )
                                      : Text(""),
                                ],
                              ),
                            ),
                      LetterPasiing['ط­ط±ظپ ط§ظ„ط­ط§ط،'] == true
                          ? GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => kh_sound(),
                                    ));
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    width: 80,
                                    decoration: boxDecoration,
                                    padding: const EdgeInsets.all(1),
                                    child: Text(
                                      "ط®",
                                      textAlign: TextAlign.center,
                                      style:
                                          LetterPasiing['ط­ط±ظپ ط§ظ„ط®ط§ط،'] ==
                                                  true
                                              ? PassedtextStyle
                                              : textStyle,
                                    ),
                                  ),
                                  LetterPasiing['ط­ط±ظپ ط§ظ„ط®ط§ط،'] == true
                                      ? Positioned(
                                          top: -2,
                                          left: 0,
                                          child: Image.asset(
                                              "images/passtest.png"),
                                        )
                                      : Text(""),
                                ],
                              ),
                            )
                          : GestureDetector(
                              onTap: () {},
                              child: Stack(
                                children: [
                                  Container(
                                    width: 80,
                                    decoration: boxDecoration,
                                    padding: const EdgeInsets.all(1),
                                    child: Text(
                                      "ط®",
                                      textAlign: TextAlign.center,
                                      style:
                                          LetterPasiing['ط­ط±ظپ ط§ظ„ط®ط§ط،'] ==
                                                  true
                                              ? PassedtextStyle
                                              : textStyle,
                                    ),
                                  ),
                                  LetterPasiing['ط­ط±ظپ ط§ظ„ط®ط§ط،'] == true
                                      ? Positioned(
                                          top: -2,
                                          left: 0,
                                          child: Image.asset(
                                              "images/passtest.png"),
                                        )
                                      : Text(""),
                                ],
                              ),
                            ),
                      LetterPasiing['ط­ط±ظپ ط§ظ„ط®ط§ط،'] == true
                          ? GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => D_sound(),
                                    ));
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    width: 80,
                                    decoration: boxDecoration,
                                    padding: const EdgeInsets.all(1),
                                    child: Text(
                                      "ط¯",
                                      textAlign: TextAlign.center,
                                      style:
                                          LetterPasiing['ط­ط±ظپ ط§ظ„ط¯ط§ظ„'] ==
                                                  true
                                              ? PassedtextStyle
                                              : textStyle,
                                    ),
                                  ),
                                  LetterPasiing['ط­ط±ظپ ط§ظ„ط¯ط§ظ„'] == true
                                      ? Positioned(
                                          top: -2,
                                          left: 0,
                                          child: Image.asset(
                                              "images/passtest.png"),
                                        )
                                      : Text(""),
                                ],
                              ),
                            )
                          : GestureDetector(
                              onTap: () {},
                              child: Stack(
                                children: [
                                  Container(
                                    width: 80,
                                    decoration: boxDecoration,
                                    padding: const EdgeInsets.all(1),
                                    child: Text(
                                      "ط¯",
                                      textAlign: TextAlign.center,
                                      style:
                                          LetterPasiing['ط­ط±ظپ ط§ظ„ط¯ط§ظ„'] ==
                                                  true
                                              ? PassedtextStyle
                                              : textStyle,
                                    ),
                                  ),
                                  LetterPasiing['ط­ط±ظپ ط§ظ„ط¯ط§ظ„'] == true
                                      ? Positioned(
                                          top: -2,
                                          left: 0,
                                          child: Image.asset(
                                              "images/passtest.png"),
                                        )
                                      : Text(""),
                                ],
                              ),
                            ),
                      LetterPasiing['ط­ط±ظپ ط§ظ„ط¯ط§ظ„'] == true
                          ? GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => TH_sound(),
                                    ));
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    width: 80,
                                    decoration: boxDecoration,
                                    padding: const EdgeInsets.all(1),
                                    child: Text(
                                      "ط°",
                                      textAlign: TextAlign.center,
                                      style:
                                          LetterPasiing['ط­ط±ظپ ط§ظ„ط°ط§ظ„'] ==
                                                  true
                                              ? PassedtextStyle
                                              : textStyle,
                                    ),
                                  ),
                                  LetterPasiing['ط­ط±ظپ ط§ظ„ط°ط§ظ„'] == true
                                      ? Positioned(
                                          top: -2,
                                          left: 0,
                                          child: Image.asset(
                                              "images/passtest.png"),
                                        )
                                      : Text(""),
                                ],
                              ),
                            )
                          : GestureDetector(
                              onTap: () {},
                              child: Stack(
                                children: [
                                  Container(
                                    width: 80,
                                    decoration: boxDecoration,
                                    padding: const EdgeInsets.all(1),
                                    child: Text(
                                      "ط°",
                                      textAlign: TextAlign.center,
                                      style:
                                          LetterPasiing['ط­ط±ظپ ط§ظ„ط°ط§ظ„'] ==
                                                  true
                                              ? PassedtextStyle
                                              : textStyle,
                                    ),
                                  ),
                                  LetterPasiing['ط­ط±ظپ ط§ظ„ط°ط§ظ„'] == true
                                      ? Positioned(
                                          top: -2,
                                          left: 0,
                                          child: Image.asset(
                                              "images/passtest.png"),
                                        )
                                      : Text(""),
                                ],
                              ),
                            ),
                      LetterPasiing['ط­ط±ظپ ط§ظ„ط°ط§ظ„'] == true
                          ? GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => R_sound(),
                                    ));
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    width: 80,
                                    decoration: boxDecoration,
                                    padding: const EdgeInsets.all(1),
                                    child: Text(
                                      "ط±",
                                      textAlign: TextAlign.center,
                                      style:
                                          LetterPasiing['ط­ط±ظپ ط§ظ„ط±ط§ط،'] ==
                                                  true
                                              ? PassedtextStyle
                                              : textStyle,
                                    ),
                                  ),
                                  LetterPasiing['ط­ط±ظپ ط§ظ„ط±ط§ط،'] == true
                                      ? Positioned(
                                          top: -2,
                                          left: 0,
                                          child: Image.asset(
                                              "images/passtest.png"),
                                        )
                                      : Text(""),
                                ],
                              ),
                            )
                          : GestureDetector(
                              onTap: () {},
                              child: Stack(
                                children: [
                                  Container(
                                    width: 80,
                                    decoration: boxDecoration,
                                    padding: const EdgeInsets.all(1),
                                    child: Text(
                                      "ط±",
                                      textAlign: TextAlign.center,
                                      style:
                                          LetterPasiing['ط­ط±ظپ ط§ظ„ط±ط§ط،'] ==
                                                  true
                                              ? PassedtextStyle
                                              : textStyle,
                                    ),
                                  ),
                                  LetterPasiing['ط­ط±ظپ ط§ظ„ط±ط§ط،'] == true
                                      ? Positioned(
                                          top: -2,
                                          left: 0,
                                          child: Image.asset(
                                              "images/passtest.png"),
                                        )
                                      : Text(""),
                                ],
                              ),
                            ),
                      LetterPasiing['ط­ط±ظپ ط§ظ„ط±ط§ط،'] == true
                          ? GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Z_sound(),
                                    ));
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    width: 80,
                                    decoration: boxDecoration,
                                    padding: const EdgeInsets.all(1),
                                    child: Text(
                                      "ط²",
                                      textAlign: TextAlign.center,
                                      style:
                                          LetterPasiing['ط­ط±ظپ ط§ظ„ط²ط§ظٹ'] ==
                                                  true
                                              ? PassedtextStyle
                                              : textStyle,
                                    ),
                                  ),
                                  LetterPasiing['ط­ط±ظپ ط§ظ„ط²ط§ظٹ'] == true
                                      ? Positioned(
                                          top: -2,
                                          left: 0,
                                          child: Image.asset(
                                              "images/passtest.png"),
                                        )
                                      : Text(""),
                                ],
                              ),
                            )
                          : GestureDetector(
                              onTap: () {},
                              child: Stack(
                                children: [
                                  Container(
                                    width: 80,
                                    decoration: boxDecoration,
                                    padding: const EdgeInsets.all(1),
                                    child: Text(
                                      "ط²",
                                      textAlign: TextAlign.center,
                                      style:
                                          LetterPasiing['ط­ط±ظپ ط§ظ„ط²ط§ظٹ'] ==
                                                  true
                                              ? PassedtextStyle
                                              : textStyle,
                                    ),
                                  ),
                                  LetterPasiing['ط­ط±ظپ ط§ظ„ط²ط§ظٹ'] == true
                                      ? Positioned(
                                          top: -2,
                                          left: 0,
                                          child: Image.asset(
                                              "images/passtest.png"),
                                        )
                                      : Text(""),
                                ],
                              ),
                            ),
                      LetterPasiing['ط­ط±ظپ ط§ظ„ط²ط§ظٹ'] == true
                          ? GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => S_sound(),
                                    ));
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    width: 80,
                                    decoration: boxDecoration,
                                    padding: const EdgeInsets.all(1),
                                    child: Text(
                                      "ط³",
                                      textAlign: TextAlign.center,
                                      style:
                                          LetterPasiing['ط­ط±ظپ ط§ظ„ط³ظٹظ†'] ==
                                                  true
                                              ? PassedtextStyle
                                              : textStyle,
                                    ),
                                  ),
                                  LetterPasiing['ط­ط±ظپ ط§ظ„ط³ظٹظ†'] == true
                                      ? Positioned(
                                          top: -2,
                                          left: 0,
                                          child: Image.asset(
                                              "images/passtest.png"),
                                        )
                                      : Text(""),
                                ],
                              ),
                            )
                          : GestureDetector(
                              onTap: () {},
                              child: Stack(
                                children: [
                                  Container(
                                    width: 80,
                                    decoration: boxDecoration,
                                    padding: const EdgeInsets.all(1),
                                    child: Text(
                                      "ط³",
                                      textAlign: TextAlign.center,
                                      style:
                                          LetterPasiing['ط­ط±ظپ ط§ظ„ط³ظٹظ†'] ==
                                                  true
                                              ? PassedtextStyle
                                              : textStyle,
                                    ),
                                  ),
                                  LetterPasiing['ط­ط±ظپ ط§ظ„ط³ظٹظ†'] == true
                                      ? Positioned(
                                          top: -2,
                                          left: 0,
                                          child: Image.asset(
                                              "images/passtest.png"),
                                        )
                                      : Text(""),
                                ],
                              ),
                            ),
                      LetterPasiing['ط­ط±ظپ ط§ظ„ط³ظٹظ†'] == true
                          ? GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SH_sound(),
                                    ));
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    width: 80,
                                    decoration: boxDecoration,
                                    padding: const EdgeInsets.all(1),
                                    child: Text(
                                      "ط´",
                                      textAlign: TextAlign.center,
                                      style:
                                          LetterPasiing['ط­ط±ظپ ط§ظ„ط´ظٹظ†'] ==
                                                  true
                                              ? PassedtextStyle
                                              : textStyle,
                                    ),
                                  ),
                                  LetterPasiing['ط­ط±ظپ ط§ظ„ط´ظٹظ†'] == true
                                      ? Positioned(
                                          top: -2,
                                          left: 0,
                                          child: Image.asset(
                                              "images/passtest.png"),
                                        )
                                      : Text(""),
                                ],
                              ),
                            )
                          : GestureDetector(
                              onTap: () {},
                              child: Stack(
                                children: [
                                  Container(
                                    width: 80,
                                    decoration: boxDecoration,
                                    padding: const EdgeInsets.all(1),
                                    child: Text(
                                      "ط´",
                                      textAlign: TextAlign.center,
                                      style:
                                          LetterPasiing['ط­ط±ظپ ط§ظ„ط´ظٹظ†'] ==
                                                  true
                                              ? PassedtextStyle
                                              : textStyle,
                                    ),
                                  ),
                                  LetterPasiing['ط­ط±ظپ ط§ظ„ط´ظٹظ†'] == true
                                      ? Positioned(
                                          top: -2,
                                          left: 0,
                                          child: Image.asset(
                                              "images/passtest.png"),
                                        )
                                      : Text(""),
                                ],
                              ),
                            ),
                      LetterPasiing['ط­ط±ظپ ط§ظ„ط´ظٹظ†'] == true
                          ? GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SS_sound(),
                                    ));
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    width: 80,
                                    decoration: boxDecoration,
                                    padding: const EdgeInsets.all(1),
                                    child: Text(
                                      "طµ",
                                      textAlign: TextAlign.center,
                                      style:
                                          LetterPasiing['ط­ط±ظپ ط§ظ„طµط§ط¯'] ==
                                                  true
                                              ? PassedtextStyle
                                              : textStyle,
                                    ),
                                  ),
                                  LetterPasiing['ط­ط±ظپ ط§ظ„طµط§ط¯'] == true
                                      ? Positioned(
                                          top: -2,
                                          left: 0,
                                          child: Image.asset(
                                              "images/passtest.png"),
                                        )
                                      : Text(""),
                                ],
                              ),
                            )
                          : GestureDetector(
                              onTap: () {},
                              child: Stack(
                                children: [
                                  Container(
                                    width: 80,
                                    decoration: boxDecoration,
                                    padding: const EdgeInsets.all(1),
                                    child: Text(
                                      "طµ",
                                      textAlign: TextAlign.center,
                                      style:
                                          LetterPasiing['ط­ط±ظپ ط§ظ„طµط§ط¯'] ==
                                                  true
                                              ? PassedtextStyle
                                              : textStyle,
                                    ),
                                  ),
                                  LetterPasiing['ط­ط±ظپ ط§ظ„طµط§ط¯'] == true
                                      ? Positioned(
                                          top: -2,
                                          left: 0,
                                          child: Image.asset(
                                              "images/passtest.png"),
                                        )
                                      : Text(""),
                                ],
                              ),
                            ),

                      LetterPasiing['ط­ط±ظپ ط§ظ„طµط§ط¯'] == true
                          ? GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Dha_sound(),
                                    ));
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    width: 80,
                                    decoration: boxDecoration,
                                    padding: const EdgeInsets.all(1),
                                    child: Text(
                                      "ط¶",
                                      textAlign: TextAlign.center,
                                      style:
                                          LetterPasiing['ط­ط±ظپ ط§ظ„ط¶ط§ط¯'] ==
                                                  true
                                              ? PassedtextStyle
                                              : textStyle,
                                    ),
                                  ),
                                  LetterPasiing['ط­ط±ظپ ط§ظ„ط¶ط§ط¯'] == true
                                      ? Positioned(
                                          top: -2,
                                          left: 0,
                                          child: Image.asset(
                                              "images/passtest.png"),
                                        )
                                      : Text(""),
                                ],
                              ),
                            )
                          : GestureDetector(
                              onTap: () {},
                              child: Stack(
                                children: [
                                  Container(
                                    width: 80,
                                    decoration: boxDecoration,
                                    padding: const EdgeInsets.all(1),
                                    child: Text(
                                      "ط¶",
                                      textAlign: TextAlign.center,
                                      style:
                                          LetterPasiing['ط­ط±ظپ ط§ظ„ط¶ط§ط¯'] ==
                                                  true
                                              ? PassedtextStyle
                                              : textStyle,
                                    ),
                                  ),
                                  LetterPasiing['ط­ط±ظپ ط§ظ„ط¶ط§ط¯'] == true
                                      ? Positioned(
                                          top: -2,
                                          left: 0,
                                          child: Image.asset(
                                              "images/passtest.png"),
                                        )
                                      : Text(""),
                                ],
                              ),
                            ),
                      LetterPasiing['ط­ط±ظپ ط§ظ„ط¶ط§ط¯'] == true
                          ? GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Ta_sound(),
                                    ));
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    width: 80,
                                    decoration: boxDecoration,
                                    padding: const EdgeInsets.all(1),
                                    child: Text(
                                      "ط·",
                                      textAlign: TextAlign.center,
                                      style:
                                          LetterPasiing['ط­ط±ظپ ط§ظ„ط·ط§ط،'] ==
                                                  true
                                              ? PassedtextStyle
                                              : textStyle,
                                    ),
                                  ),
                                  LetterPasiing['ط­ط±ظپ ط§ظ„ط·ط§ط،'] == true
                                      ? Positioned(
                                          top: -2,
                                          left: 0,
                                          child: Image.asset(
                                              "images/passtest.png"),
                                        )
                                      : Text(""),
                                ],
                              ),
                            )
                          : GestureDetector(
                              onTap: () {},
                              child: Stack(
                                children: [
                                  Container(
                                    width: 80,
                                    decoration: boxDecoration,
                                    padding: const EdgeInsets.all(1),
                                    child: Text(
                                      "ط·",
                                      textAlign: TextAlign.center,
                                      style:
                                          LetterPasiing['ط­ط±ظپ ط§ظ„ط·ط§ط،'] ==
                                                  true
                                              ? PassedtextStyle
                                              : textStyle,
                                    ),
                                  ),
                                  LetterPasiing['ط­ط±ظپ ط§ظ„ط·ط§ط،'] == true
                                      ? Positioned(
                                          top: -2,
                                          left: 0,
                                          child: Image.asset(
                                              "images/passtest.png"),
                                        )
                                      : Text(""),
                                ],
                              ),
                            ),
                      LetterPasiing['ط­ط±ظپ ط§ظ„ط·ط§ط،'] == true
                          ? GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DDa_sound(),
                                    ));
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    width: 80,
                                    decoration: boxDecoration,
                                    padding: const EdgeInsets.all(1),
                                    child: Text(
                                      "ط¸",
                                      textAlign: TextAlign.center,
                                      style:
                                          LetterPasiing['ط­ط±ظپ ط§ظ„ط¸ط§ط،'] ==
                                                  true
                                              ? PassedtextStyle
                                              : textStyle,
                                    ),
                                  ),
                                  LetterPasiing['ط­ط±ظپ ط§ظ„ط¸ط§ط،'] == true
                                      ? Positioned(
                                          top: -2,
                                          left: 0,
                                          child: Image.asset(
                                              "images/passtest.png"),
                                        )
                                      : Text(""),
                                ],
                              ),
                            )
                          : GestureDetector(
                              onTap: () {},
                              child: Stack(
                                children: [
                                  Container(
                                    width: 80,
                                    decoration: boxDecoration,
                                    padding: const EdgeInsets.all(1),
                                    child: Text(
                                      "ط¸",
                                      textAlign: TextAlign.center,
                                      style:
                                          LetterPasiing['ط­ط±ظپ ط§ظ„ط¸ط§ط،'] ==
                                                  true
                                              ? PassedtextStyle
                                              : textStyle,
                                    ),
                                  ),
                                  LetterPasiing['ط­ط±ظپ ط§ظ„ط¸ط§ط،'] == true
                                      ? Positioned(
                                          top: -2,
                                          left: 0,
                                          child: Image.asset(
                                              "images/passtest.png"),
                                        )
                                      : Text(""),
                                ],
                              ),
                            ),
                      LetterPasiing['ط­ط±ظپ ط§ظ„ط¸ط§ط،'] == true
                          ? GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => E_sound(),
                                    ));
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    width: 80,
                                    decoration: boxDecoration,
                                    padding: const EdgeInsets.all(1),
                                    child: Text(
                                      "ط¹",
                                      textAlign: TextAlign.center,
                                      style:
                                          LetterPasiing['ط­ط±ظپ ط§ظ„ط¹ظٹظ†'] ==
                                                  true
                                              ? PassedtextStyle
                                              : textStyle,
                                    ),
                                  ),
                                  LetterPasiing['ط­ط±ظپ ط§ظ„ط¹ظٹظ†'] == true
                                      ? Positioned(
                                          top: -2,
                                          left: 0,
                                          child: Image.asset(
                                              "images/passtest.png"),
                                        )
                                      : Text(""),
                                ],
                              ),
                            )
                          : GestureDetector(
                              onTap: () {},
                              child: Stack(
                                children: [
                                  Container(
                                    width: 80,
                                    decoration: boxDecoration,
                                    padding: const EdgeInsets.all(1),
                                    child: Text(
                                      "ط¹",
                                      textAlign: TextAlign.center,
                                      style:
                                          LetterPasiing['ط­ط±ظپ ط§ظ„ط¹ظٹظ†'] ==
                                                  true
                                              ? PassedtextStyle
                                              : textStyle,
                                    ),
                                  ),
                                  LetterPasiing['ط­ط±ظپ ط§ظ„ط¹ظٹظ†'] == true
                                      ? Positioned(
                                          top: -2,
                                          left: 0,
                                          child: Image.asset(
                                              "images/passtest.png"),
                                        )
                                      : Text(""),
                                ],
                              ),
                            ),
                      LetterPasiing['ط­ط±ظپ ط§ظ„ط¹ظٹظ†'] == true
                          ? GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EE_sound(),
                                    ));
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    width: 80,
                                    decoration: boxDecoration,
                                    padding: const EdgeInsets.all(1),
                                    child: Text(
                                      "ط؛",
                                      textAlign: TextAlign.center,
                                      style:
                                          LetterPasiing['ط­ط±ظپ ط§ظ„ط؛ظٹظ†'] ==
                                                  true
                                              ? PassedtextStyle
                                              : textStyle,
                                    ),
                                  ),
                                  LetterPasiing['ط­ط±ظپ ط§ظ„ط؛ظٹظ†'] == true
                                      ? Positioned(
                                          top: -2,
                                          left: 0,
                                          child: Image.asset(
                                              "images/passtest.png"),
                                        )
                                      : Text(""),
                                ],
                              ),
                            )
                          : GestureDetector(
                              onTap: () {},
                              child: Stack(
                                children: [
                                  Container(
                                    width: 80,
                                    decoration: boxDecoration,
                                    padding: const EdgeInsets.all(1),
                                    child: Text(
                                      "ط؛",
                                      textAlign: TextAlign.center,
                                      style:
                                          LetterPasiing['ط­ط±ظپ ط§ظ„ط؛ظٹظ†'] ==
                                                  true
                                              ? PassedtextStyle
                                              : textStyle,
                                    ),
                                  ),
                                  LetterPasiing['ط­ط±ظپ ط§ظ„ط؛ظٹظ†'] == true
                                      ? Positioned(
                                          top: -2,
                                          left: 0,
                                          child: Image.asset(
                                              "images/passtest.png"),
                                        )
                                      : Text(""),
                                ],
                              ),
                            ),
                      LetterPasiing['ط­ط±ظپ ط§ظ„ط؛ظٹظ†'] == true
                          ? GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => F_sound(),
                                    ));
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    width: 80,
                                    decoration: boxDecoration,
                                    padding: const EdgeInsets.all(1),
                                    child: Text(
                                      "ظپ",
                                      textAlign: TextAlign.center,
                                      style:
                                          LetterPasiing['ط­ط±ظپ ط§ظ„ظپط§ط،'] ==
                                                  true
                                              ? PassedtextStyle
                                              : textStyle,
                                    ),
                                  ),
                                  LetterPasiing['ط­ط±ظپ ط§ظ„ظپط§ط،'] == true
                                      ? Positioned(
                                          top: -2,
                                          left: 0,
                                          child: Image.asset(
                                              "images/passtest.png"),
                                        )
                                      : Text(""),
                                ],
                              ),
                            )
                          : GestureDetector(
                              onTap: () {},
                              child: Stack(
                                children: [
                                  Container(
                                    width: 80,
                                    decoration: boxDecoration,
                                    padding: const EdgeInsets.all(1),
                                    child: Text(
                                      "ظپ",
                                      textAlign: TextAlign.center,
                                      style:
                                          LetterPasiing['ط­ط±ظپ ط§ظ„ظپط§ط،'] ==
                                                  true
                                              ? PassedtextStyle
                                              : textStyle,
                                    ),
                                  ),
                                  LetterPasiing['ط­ط±ظپ ط§ظ„ظپط§ط،'] == true
                                      ? Positioned(
                                          top: -2,
                                          left: 0,
                                          child: Image.asset(
                                              "images/passtest.png"),
                                        )
                                      : Text(""),
                                ],
                              ),
                            ),
                      LetterPasiing['ط­ط±ظپ ط§ظ„ظپط§ط،'] == true
                          ? GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Q_sound(),
                                    ));
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    width: 80,
                                    decoration: boxDecoration,
                                    padding: const EdgeInsets.all(1),
                                    child: Text(
                                      "ظ‚",
                                      textAlign: TextAlign.center,
                                      style:
                                          LetterPasiing['ط­ط±ظپ ط§ظ„ظ‚ط§ظپ'] ==
                                                  true
                                              ? PassedtextStyle
                                              : textStyle,
                                    ),
                                  ),
                                  LetterPasiing['ط­ط±ظپ ط§ظ„ظ‚ط§ظپ'] == true
                                      ? Positioned(
                                          top: -2,
                                          left: 0,
                                          child: Image.asset(
                                              "images/passtest.png"),
                                        )
                                      : Text(""),
                                ],
                              ),
                            )
                          : GestureDetector(
                              onTap: () {},
                              child: Stack(
                                children: [
                                  Container(
                                    width: 80,
                                    decoration: boxDecoration,
                                    padding: const EdgeInsets.all(1),
                                    child: Text(
                                      "ظ‚",
                                      textAlign: TextAlign.center,
                                      style:
                                          LetterPasiing['ط­ط±ظپ ط§ظ„ظ‚ط§ظپ'] ==
                                                  true
                                              ? PassedtextStyle
                                              : textStyle,
                                    ),
                                  ),
                                  LetterPasiing['ط­ط±ظپ ط§ظ„ظ‚ط§ظپ'] == true
                                      ? Positioned(
                                          top: -2,
                                          left: 0,
                                          child: Image.asset(
                                              "images/passtest.png"),
                                        )
                                      : Text(""),
                                ],
                              ),
                            ),
                      LetterPasiing['ط­ط±ظپ ط§ظ„ظ‚ط§ظپ'] == true
                          ? GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => K_sound(),
                                    ));
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    width: 80,
                                    decoration: boxDecoration,
                                    padding: const EdgeInsets.all(1),
                                    child: Text(
                                      "ظƒ",
                                      textAlign: TextAlign.center,
                                      style:
                                          LetterPasiing['ط­ط±ظپ ط§ظ„ظƒط§ظپ'] ==
                                                  true
                                              ? PassedtextStyle
                                              : textStyle,
                                    ),
                                  ),
                                  LetterPasiing['ط­ط±ظپ ط§ظ„ظƒط§ظپ'] == true
                                      ? Positioned(
                                          top: -2,
                                          left: 0,
                                          child: Image.asset(
                                              "images/passtest.png"),
                                        )
                                      : Text(""),
                                ],
                              ),
                            )
                          : GestureDetector(
                              onTap: () {},
                              child: Stack(
                                children: [
                                  Container(
                                    width: 80,
                                    decoration: boxDecoration,
                                    padding: const EdgeInsets.all(1),
                                    child: Text(
                                      "ظƒ",
                                      textAlign: TextAlign.center,
                                      style:
                                          LetterPasiing['ط­ط±ظپ ط§ظ„ظƒط§ظپ'] ==
                                                  true
                                              ? PassedtextStyle
                                              : textStyle,
                                    ),
                                  ),
                                  LetterPasiing['ط­ط±ظپ ط§ظ„ظƒط§ظپ'] == true
                                      ? Positioned(
                                          top: -2,
                                          left: 0,
                                          child: Image.asset(
                                              "images/passtest.png"),
                                        )
                                      : Text(""),
                                ],
                              ),
                            ),
                      LetterPasiing['ط­ط±ظپ ط§ظ„ظƒط§ظپ'] == true
                          ? GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => L_sound(),
                                    ));
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    width: 80,
                                    decoration: boxDecoration,
                                    padding: const EdgeInsets.all(1),
                                    child: Text(
                                      "ظ„",
                                      textAlign: TextAlign.center,
                                      style:
                                          LetterPasiing['ط­ط±ظپ ط§ظ„ظ„ط§ظ…'] ==
                                                  true
                                              ? PassedtextStyle
                                              : textStyle,
                                    ),
                                  ),
                                  LetterPasiing['ط­ط±ظپ ط§ظ„ظ„ط§ظ…'] == true
                                      ? Positioned(
                                          top: -2,
                                          left: 0,
                                          child: Image.asset(
                                              "images/passtest.png"),
                                        )
                                      : Text(""),
                                ],
                              ),
                            )
                          : GestureDetector(
                              onTap: () {},
                              child: Stack(
                                children: [
                                  Container(
                                    width: 80,
                                    decoration: boxDecoration,
                                    padding: const EdgeInsets.all(1),
                                    child: Text(
                                      "ظ„",
                                      textAlign: TextAlign.center,
                                      style:
                                          LetterPasiing['ط­ط±ظپ ط§ظ„ظ„ط§ظ…'] ==
                                                  true
                                              ? PassedtextStyle
                                              : textStyle,
                                    ),
                                  ),
                                  LetterPasiing['ط­ط±ظپ ط§ظ„ظ„ط§ظ…'] == true
                                      ? Positioned(
                                          top: -2,
                                          left: 0,
                                          child: Image.asset(
                                              "images/passtest.png"),
                                        )
                                      : Text(""),
                                ],
                              ),
                            ),
                      LetterPasiing['ط­ط±ظپ ط§ظ„ظ„ط§ظ…'] == true
                          ? GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => M_sound(),
                                    ));
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    width: 80,
                                    decoration: boxDecoration,
                                    padding: const EdgeInsets.all(1),
                                    child: Text(
                                      "ظ…",
                                      textAlign: TextAlign.center,
                                      style:
                                          LetterPasiing['ط­ط±ظپ ط§ظ„ظ…ظٹظ…'] ==
                                                  true
                                              ? PassedtextStyle
                                              : textStyle,
                                    ),
                                  ),
                                  LetterPasiing['ط­ط±ظپ ط§ظ„ظ…ظٹظ…'] == true
                                      ? Positioned(
                                          top: -2,
                                          left: 0,
                                          child: Image.asset(
                                              "images/passtest.png"),
                                        )
                                      : Text(""),
                                ],
                              ),
                            )
                          : GestureDetector(
                              onTap: () {},
                              child: Stack(
                                children: [
                                  Container(
                                    width: 80,
                                    decoration: boxDecoration,
                                    padding: const EdgeInsets.all(1),
                                    child: Text(
                                      "ظ…",
                                      textAlign: TextAlign.center,
                                      style:
                                          LetterPasiing['ط­ط±ظپ ط§ظ„ظ…ظٹظ…'] ==
                                                  true
                                              ? PassedtextStyle
                                              : textStyle,
                                    ),
                                  ),
                                  LetterPasiing['ط­ط±ظپ ط§ظ„ظ…ظٹظ…'] == true
                                      ? Positioned(
                                          top: -2,
                                          left: 0,
                                          child: Image.asset(
                                              "images/passtest.png"),
                                        )
                                      : Text(""),
                                ],
                              ),
                            ),
                      LetterPasiing['ط­ط±ظپ ط§ظ„ظ…ظٹظ…'] == true
                          ? GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => N_sound(),
                                    ));
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    width: 80,
                                    decoration: boxDecoration,
                                    padding: const EdgeInsets.all(1),
                                    child: Text(
                                      "ظ†",
                                      textAlign: TextAlign.center,
                                      style:
                                          LetterPasiing['ط­ط±ظپ ط§ظ„ظ†ظˆظ†'] ==
                                                  true
                                              ? PassedtextStyle
                                              : textStyle,
                                    ),
                                  ),
                                  LetterPasiing['ط­ط±ظپ ط§ظ„ظ†ظˆظ†'] == true
                                      ? Positioned(
                                          top: -2,
                                          left: 0,
                                          child: Image.asset(
                                              "images/passtest.png"),
                                        )
                                      : Text(""),
                                ],
                              ),
                            )
                          : GestureDetector(
                              onTap: () {},
                              child: Stack(
                                children: [
                                  Container(
                                    width: 80,
                                    decoration: boxDecoration,
                                    padding: const EdgeInsets.all(1),
                                    child: Text(
                                      "ظ†",
                                      textAlign: TextAlign.center,
                                      style:
                                          LetterPasiing['ط­ط±ظپ ط§ظ„ظ†ظˆظ†'] ==
                                                  true
                                              ? PassedtextStyle
                                              : textStyle,
                                    ),
                                  ),
                                  LetterPasiing['ط­ط±ظپ ط§ظ„ظ†ظˆظ†'] == true
                                      ? Positioned(
                                          top: -2,
                                          left: 0,
                                          child: Image.asset(
                                              "images/passtest.png"),
                                        )
                                      : Text(""),
                                ],
                              ),
                            ),
                      LetterPasiing['ط­ط±ظپ ط§ظ„ظ†ظˆظ†'] == true
                          ? GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => H_sound(),
                                    ));
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    width: 80,
                                    decoration: boxDecoration,
                                    padding: const EdgeInsets.all(1),
                                    child: Text(
                                      "ظ‡ظ€",
                                      textAlign: TextAlign.center,
                                      style:
                                          LetterPasiing['ط­ط±ظپ ط§ظ„ظ‡ط§ط،'] ==
                                                  true
                                              ? PassedtextStyle
                                              : textStyle,
                                    ),
                                  ),
                                  LetterPasiing['ط­ط±ظپ ط§ظ„ظ‡ط§ط،'] == true
                                      ? Positioned(
                                          top: -2,
                                          left: 0,
                                          child: Image.asset(
                                              "images/passtest.png"),
                                        )
                                      : Text(""),
                                ],
                              ),
                            )
                          : GestureDetector(
                              onTap: () {},
                              child: Stack(
                                children: [
                                  Container(
                                    width: 80,
                                    decoration: boxDecoration,
                                    padding: const EdgeInsets.all(1),
                                    child: Text(
                                      "ظ‡ظ€",
                                      textAlign: TextAlign.center,
                                      style:
                                          LetterPasiing['ط­ط±ظپ ط§ظ„ظ‡ط§ط،'] ==
                                                  true
                                              ? PassedtextStyle
                                              : textStyle,
                                    ),
                                  ),
                                  LetterPasiing['ط­ط±ظپ ط§ظ„ظ‡ط§ط،'] == true
                                      ? Positioned(
                                          top: -2,
                                          left: 0,
                                          child: Image.asset(
                                              "images/passtest.png"),
                                        )
                                      : Text(""),
                                ],
                              ),
                            ),
                      LetterPasiing['ط­ط±ظپ ط§ظ„ظ‡ط§ط،'] == true
                          ? GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => W_sound(),
                                    ));
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    width: 80,
                                    decoration: boxDecoration,
                                    padding: const EdgeInsets.all(1),
                                    child: Text(
                                      "ظˆ",
                                      textAlign: TextAlign.center,
                                      style:
                                          LetterPasiing['ط­ط±ظپ ط§ظ„ظˆط§ظˆ'] ==
                                                  true
                                              ? PassedtextStyle
                                              : textStyle,
                                    ),
                                  ),
                                  LetterPasiing['ط­ط±ظپ ط§ظ„ظˆط§ظˆ'] == true
                                      ? Positioned(
                                          top: -2,
                                          left: 0,
                                          child: Image.asset(
                                              "images/passtest.png"),
                                        )
                                      : Text(""),
                                ],
                              ),
                            )
                          : GestureDetector(
                              onTap: () {},
                              child: Stack(
                                children: [
                                  Container(
                                    width: 80,
                                    decoration: boxDecoration,
                                    padding: const EdgeInsets.all(1),
                                    child: Text(
                                      "ظˆ",
                                      textAlign: TextAlign.center,
                                      style:
                                          LetterPasiing['ط­ط±ظپ ط§ظ„ظˆط§ظˆ'] ==
                                                  true
                                              ? PassedtextStyle
                                              : textStyle,
                                    ),
                                  ),
                                  LetterPasiing['ط­ط±ظپ ط§ظ„ظˆط§ظˆ'] == true
                                      ? Positioned(
                                          top: -2,
                                          left: 0,
                                          child: Image.asset(
                                              "images/passtest.png"),
                                        )
                                      : Text(""),
                                ],
                              ),
                            ),
                      LetterPasiing['ط­ط±ظپ ط§ظ„ظˆط§ظˆ'] == true
                          ? GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Y_sound(),
                                    ));
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    width: 80,
                                    decoration: boxDecoration,
                                    child: Text(
                                      "ظٹ",
                                      textAlign: TextAlign.center,
                                      style:
                                          LetterPasiing['ط­ط±ظپ ط§ظ„ظٹط§ط،'] ==
                                                  true
                                              ? PassedtextStyle
                                              : textStyle,
                                    ),
                                  ),
                                  LetterPasiing['ط­ط±ظپ ط§ظ„ظٹط§ط،'] == true
                                      ? Positioned(
                                          top: -2,
                                          left: 0,
                                          child: Image.asset(
                                              "images/passtest.png"),
                                        )
                                      : Text(""),
                                ],
                              ),
                            )
                          : GestureDetector(
                              onTap: () {},
                              child: Stack(
                                children: [
                                  Container(
                                    width: 80,
                                    decoration: boxDecoration,
                                    padding: const EdgeInsets.all(1),
                                    child: Text(
                                      "ظٹ",
                                      textAlign: TextAlign.center,
                                      style:
                                          LetterPasiing['ط­ط±ظپ ط§ظ„ظٹط§ط،'] ==
                                                  true
                                              ? PassedtextStyle
                                              : textStyle,
                                    ),
                                  ),
                                  LetterPasiing['ط­ط±ظپ ط§ظ„ظٹط§ط،'] == true
                                      ? Positioned(
                                          top: -2,
                                          left: 0,
                                          child: Image.asset(
                                              "images/passtest.png"),
                                        )
                                      : Text(""),
                                ],
                              ),
                            ),
                    ],
                  ),
                ),
              ],
            ),
          );
  }
}
