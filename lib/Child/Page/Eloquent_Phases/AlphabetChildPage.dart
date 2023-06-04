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
                                builder: (context) =>
                                    A_sound(childId: ChildID, page: 'A_sound'),
                              ));
                        },
                        child: Stack(
                          children: [
                            Container(
                              width: 80,
                              decoration: boxDecoration,
                              padding: const EdgeInsets.all(1),
                              child: Text(
                                "أ",
                                textAlign: TextAlign.center,
                                style: LetterPasiing['حرف الألف'] == true
                                    ? PassedtextStyle
                                    : textStyle,
                              ),
                            ),
                            LetterPasiing['حرف الألف'] == true
                                ? Positioned(
                                    top: -2,
                                    left: 0,
                                    child: Image.asset("images/passtest.png"),
                                  )
                                : Text(""),
                          ],
                        ),
                      ),
                      LetterPasiing['حرف الألف'] == true
                          ? GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => B_sound(
                                          childId: ChildID, page: 'B_sound'),
                                    ));
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    width: 80,
                                    decoration: boxDecoration,
                                    padding: const EdgeInsets.all(1),
                                    child: Text(
                                      "ب",
                                      textAlign: TextAlign.center,
                                      style: LetterPasiing['حرف الباء'] == true
                                          ? PassedtextStyle
                                          : textStyle,
                                    ),
                                  ),
                                  LetterPasiing['حرف الباء'] == true
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
                                      "ب",
                                      textAlign: TextAlign.center,
                                      style: LetterPasiing['حرف الباء'] == true
                                          ? PassedtextStyle
                                          : textStyle,
                                    ),
                                  ),
                                  LetterPasiing['حرف الباء'] == true
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

                      LetterPasiing['حرف الباء'] == true
                          ? GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => T_sound(
                                          childId: ChildID, page: 'T_sound'),
                                    ));
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    width: 80,
                                    decoration: boxDecoration,
                                    padding: const EdgeInsets.all(1),
                                    child: Text(
                                      "ت",
                                      textAlign: TextAlign.center,
                                      style: LetterPasiing['حرف التاء'] == true
                                          ? PassedtextStyle
                                          : textStyle,
                                    ),
                                  ),
                                  LetterPasiing['حرف التاء'] == true
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
                                      "ت",
                                      textAlign: TextAlign.center,
                                      style: LetterPasiing['حرف التاء'] == true
                                          ? PassedtextStyle
                                          : textStyle,
                                    ),
                                  ),
                                  LetterPasiing['حرف التاء'] == true
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
                      LetterPasiing['حرف التاء'] == true
                          ? GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => TT_sound(
                                          childId: ChildID, page: 'TT_sound'),
                                    ));
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    width: 80,
                                    decoration: boxDecoration,
                                    padding: const EdgeInsets.all(1),
                                    child: Text(
                                      "ث",
                                      textAlign: TextAlign.center,
                                      style: LetterPasiing['حرف الثاء'] == true
                                          ? PassedtextStyle
                                          : textStyle,
                                    ),
                                  ),
                                  LetterPasiing['حرف الثاء'] == true
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
                                      "ث",
                                      textAlign: TextAlign.center,
                                      style: LetterPasiing['حرف الثاء'] == true
                                          ? PassedtextStyle
                                          : textStyle,
                                    ),
                                  ),
                                  LetterPasiing['حرف الثاء'] == true
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
                      LetterPasiing['حرف الثاء'] == true
                          ? GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => J_sound(
                                          childId: ChildID, page: 'J_sound'),
                                    ));
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    width: 80,
                                    decoration: boxDecoration,
                                    padding: const EdgeInsets.all(1),
                                    child: Text(
                                      "ج",
                                      textAlign: TextAlign.center,
                                      style: LetterPasiing['حرف الجيم'] == true
                                          ? PassedtextStyle
                                          : textStyle,
                                    ),
                                  ),
                                  LetterPasiing['حرف الجيم'] == true
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
                                      "ج",
                                      textAlign: TextAlign.center,
                                      style: LetterPasiing['حرف الجيم'] == true
                                          ? PassedtextStyle
                                          : textStyle,
                                    ),
                                  ),
                                  LetterPasiing['حرف الجيم'] == true
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
                      LetterPasiing['حرف الجيم'] == true
                          ? GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => HH_sound(
                                          childId: ChildID, page: 'HH_sound'),
                                    ));
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    width: 80,
                                    decoration: boxDecoration,
                                    padding: const EdgeInsets.all(1),
                                    child: Text(
                                      "ح",
                                      textAlign: TextAlign.center,
                                      style: LetterPasiing['حرف الحاء'] == true
                                          ? PassedtextStyle
                                          : textStyle,
                                    ),
                                  ),
                                  LetterPasiing['حرف الحاء'] == true
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
                                      "ح",
                                      textAlign: TextAlign.center,
                                      style: LetterPasiing['حرف الحاء'] == true
                                          ? PassedtextStyle
                                          : textStyle,
                                    ),
                                  ),
                                  LetterPasiing['حرف الحاء'] == true
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
                      LetterPasiing['حرف الحاء'] == true
                          ? GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => kh_sound(
                                          childId: ChildID, page: 'kh_sound'),
                                    ));
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    width: 80,
                                    decoration: boxDecoration,
                                    padding: const EdgeInsets.all(1),
                                    child: Text(
                                      "خ",
                                      textAlign: TextAlign.center,
                                      style: LetterPasiing['حرف الخاء'] == true
                                          ? PassedtextStyle
                                          : textStyle,
                                    ),
                                  ),
                                  LetterPasiing['حرف الخاء'] == true
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
                                      "خ",
                                      textAlign: TextAlign.center,
                                      style: LetterPasiing['حرف الخاء'] == true
                                          ? PassedtextStyle
                                          : textStyle,
                                    ),
                                  ),
                                  LetterPasiing['حرف الخاء'] == true
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
                      LetterPasiing['حرف الخاء'] == true
                          ? GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => D_sound(
                                          childId: ChildID, page: 'D_sound'),
                                    ));
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    width: 80,
                                    decoration: boxDecoration,
                                    padding: const EdgeInsets.all(1),
                                    child: Text(
                                      "د",
                                      textAlign: TextAlign.center,
                                      style: LetterPasiing['حرف الدال'] == true
                                          ? PassedtextStyle
                                          : textStyle,
                                    ),
                                  ),
                                  LetterPasiing['حرف الدال'] == true
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
                                      "د",
                                      textAlign: TextAlign.center,
                                      style: LetterPasiing['حرف الدال'] == true
                                          ? PassedtextStyle
                                          : textStyle,
                                    ),
                                  ),
                                  LetterPasiing['حرف الدال'] == true
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
                      LetterPasiing['حرف الدال'] == true
                          ? GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => TH_sound(
                                          childId: ChildID, page: 'TH_sound'),
                                    ));
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    width: 80,
                                    decoration: boxDecoration,
                                    padding: const EdgeInsets.all(1),
                                    child: Text(
                                      "ذ",
                                      textAlign: TextAlign.center,
                                      style: LetterPasiing['حرف الذال'] == true
                                          ? PassedtextStyle
                                          : textStyle,
                                    ),
                                  ),
                                  LetterPasiing['حرف الذال'] == true
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
                                      "ذ",
                                      textAlign: TextAlign.center,
                                      style: LetterPasiing['حرف الذال'] == true
                                          ? PassedtextStyle
                                          : textStyle,
                                    ),
                                  ),
                                  LetterPasiing['حرف الذال'] == true
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
                      LetterPasiing['حرف الذال'] == true
                          ? GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => R_sound(
                                          childId: ChildID, page: 'R_sound'),
                                    ));
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    width: 80,
                                    decoration: boxDecoration,
                                    padding: const EdgeInsets.all(1),
                                    child: Text(
                                      "ر",
                                      textAlign: TextAlign.center,
                                      style: LetterPasiing['حرف الراء'] == true
                                          ? PassedtextStyle
                                          : textStyle,
                                    ),
                                  ),
                                  LetterPasiing['حرف الراء'] == true
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
                                      "ر",
                                      textAlign: TextAlign.center,
                                      style: LetterPasiing['حرف الراء'] == true
                                          ? PassedtextStyle
                                          : textStyle,
                                    ),
                                  ),
                                  LetterPasiing['حرف الراء'] == true
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
                      LetterPasiing['حرف الراء'] == true
                          ? GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Z_sound(
                                          childId: ChildID, page: 'Z_sound'),
                                    ));
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    width: 80,
                                    decoration: boxDecoration,
                                    padding: const EdgeInsets.all(1),
                                    child: Text(
                                      "ز",
                                      textAlign: TextAlign.center,
                                      style: LetterPasiing['حرف الزاي'] == true
                                          ? PassedtextStyle
                                          : textStyle,
                                    ),
                                  ),
                                  LetterPasiing['حرف الزاي'] == true
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
                                      "ز",
                                      textAlign: TextAlign.center,
                                      style: LetterPasiing['حرف الزاي'] == true
                                          ? PassedtextStyle
                                          : textStyle,
                                    ),
                                  ),
                                  LetterPasiing['حرف الزاي'] == true
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
                      LetterPasiing['حرف الزاي'] == true
                          ? GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => S_sound(
                                          childId: ChildID, page: 'S_sound'),
                                    ));
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    width: 80,
                                    decoration: boxDecoration,
                                    padding: const EdgeInsets.all(1),
                                    child: Text(
                                      "س",
                                      textAlign: TextAlign.center,
                                      style: LetterPasiing['حرف السين'] == true
                                          ? PassedtextStyle
                                          : textStyle,
                                    ),
                                  ),
                                  LetterPasiing['حرف السين'] == true
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
                                      "س",
                                      textAlign: TextAlign.center,
                                      style: LetterPasiing['حرف السين'] == true
                                          ? PassedtextStyle
                                          : textStyle,
                                    ),
                                  ),
                                  LetterPasiing['حرف السين'] == true
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
                      LetterPasiing['حرف السين'] == true
                          ? GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SH_sound(
                                          childId: ChildID, page: 'SH_sound'),
                                    ));
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    width: 80,
                                    decoration: boxDecoration,
                                    padding: const EdgeInsets.all(1),
                                    child: Text(
                                      "ش",
                                      textAlign: TextAlign.center,
                                      style: LetterPasiing['حرف الشين'] == true
                                          ? PassedtextStyle
                                          : textStyle,
                                    ),
                                  ),
                                  LetterPasiing['حرف الشين'] == true
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
                                      "ش",
                                      textAlign: TextAlign.center,
                                      style: LetterPasiing['حرف الشين'] == true
                                          ? PassedtextStyle
                                          : textStyle,
                                    ),
                                  ),
                                  LetterPasiing['حرف الشين'] == true
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
                      LetterPasiing['حرف الشين'] == true
                          ? GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SS_sound(
                                          childId: ChildID, page: 'SS_sound'),
                                    ));
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    width: 80,
                                    decoration: boxDecoration,
                                    padding: const EdgeInsets.all(1),
                                    child: Text(
                                      "ص",
                                      textAlign: TextAlign.center,
                                      style: LetterPasiing['حرف الصاد'] == true
                                          ? PassedtextStyle
                                          : textStyle,
                                    ),
                                  ),
                                  LetterPasiing['حرف الصاد'] == true
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
                                      "ص",
                                      textAlign: TextAlign.center,
                                      style: LetterPasiing['حرف الصاد'] == true
                                          ? PassedtextStyle
                                          : textStyle,
                                    ),
                                  ),
                                  LetterPasiing['حرف الصاد'] == true
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

                      LetterPasiing['حرف الصاد'] == true
                          ? GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Dha_sound(
                                          childId: ChildID, page: 'Dha_sound'),
                                    ));
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    width: 80,
                                    decoration: boxDecoration,
                                    padding: const EdgeInsets.all(1),
                                    child: Text(
                                      "ض",
                                      textAlign: TextAlign.center,
                                      style: LetterPasiing['حرف الضاد'] == true
                                          ? PassedtextStyle
                                          : textStyle,
                                    ),
                                  ),
                                  LetterPasiing['حرف الضاد'] == true
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
                                      "ض",
                                      textAlign: TextAlign.center,
                                      style: LetterPasiing['حرف الضاد'] == true
                                          ? PassedtextStyle
                                          : textStyle,
                                    ),
                                  ),
                                  LetterPasiing['حرف الضاد'] == true
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
                      LetterPasiing['حرف الضاد'] == true
                          ? GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Ta_sound(
                                          childId: ChildID, page: 'Ta_sound'),
                                    ));
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    width: 80,
                                    decoration: boxDecoration,
                                    padding: const EdgeInsets.all(1),
                                    child: Text(
                                      "ط",
                                      textAlign: TextAlign.center,
                                      style: LetterPasiing['حرف الطاء'] == true
                                          ? PassedtextStyle
                                          : textStyle,
                                    ),
                                  ),
                                  LetterPasiing['حرف الطاء'] == true
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
                                      "ط",
                                      textAlign: TextAlign.center,
                                      style: LetterPasiing['حرف الطاء'] == true
                                          ? PassedtextStyle
                                          : textStyle,
                                    ),
                                  ),
                                  LetterPasiing['حرف الطاء'] == true
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
                      LetterPasiing['حرف الطاء'] == true
                          ? GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DDa_sound(
                                          childId: ChildID, page: 'DDa_sound'),
                                    ));
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    width: 80,
                                    decoration: boxDecoration,
                                    padding: const EdgeInsets.all(1),
                                    child: Text(
                                      "ظ",
                                      textAlign: TextAlign.center,
                                      style: LetterPasiing['حرف الظاء'] == true
                                          ? PassedtextStyle
                                          : textStyle,
                                    ),
                                  ),
                                  LetterPasiing['حرف الظاء'] == true
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
                                      "ظ",
                                      textAlign: TextAlign.center,
                                      style: LetterPasiing['حرف الظاء'] == true
                                          ? PassedtextStyle
                                          : textStyle,
                                    ),
                                  ),
                                  LetterPasiing['حرف الظاء'] == true
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
                      LetterPasiing['حرف الظاء'] == true
                          ? GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => E_sound(
                                          childId: ChildID, page: 'E_sound'),
                                    ));
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    width: 80,
                                    decoration: boxDecoration,
                                    padding: const EdgeInsets.all(1),
                                    child: Text(
                                      "ع",
                                      textAlign: TextAlign.center,
                                      style: LetterPasiing['حرف العين'] == true
                                          ? PassedtextStyle
                                          : textStyle,
                                    ),
                                  ),
                                  LetterPasiing['حرف العين'] == true
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
                                      "ع",
                                      textAlign: TextAlign.center,
                                      style: LetterPasiing['حرف العين'] == true
                                          ? PassedtextStyle
                                          : textStyle,
                                    ),
                                  ),
                                  LetterPasiing['حرف العين'] == true
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
                      LetterPasiing['حرف العين'] == true
                          ? GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EE_sound(
                                          childId: ChildID, page: 'EE_sound'),
                                    ));
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    width: 80,
                                    decoration: boxDecoration,
                                    padding: const EdgeInsets.all(1),
                                    child: Text(
                                      "غ",
                                      textAlign: TextAlign.center,
                                      style: LetterPasiing['حرف الغين'] == true
                                          ? PassedtextStyle
                                          : textStyle,
                                    ),
                                  ),
                                  LetterPasiing['حرف الغين'] == true
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
                                      "غ",
                                      textAlign: TextAlign.center,
                                      style: LetterPasiing['حرف الغين'] == true
                                          ? PassedtextStyle
                                          : textStyle,
                                    ),
                                  ),
                                  LetterPasiing['حرف الغين'] == true
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
                      LetterPasiing['حرف الغين'] == true
                          ? GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => F_sound(
                                          childId: ChildID, page: 'F_sound'),
                                    ));
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    width: 80,
                                    decoration: boxDecoration,
                                    padding: const EdgeInsets.all(1),
                                    child: Text(
                                      "ف",
                                      textAlign: TextAlign.center,
                                      style: LetterPasiing['حرف الفاء'] == true
                                          ? PassedtextStyle
                                          : textStyle,
                                    ),
                                  ),
                                  LetterPasiing['حرف الفاء'] == true
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
                                      "ف",
                                      textAlign: TextAlign.center,
                                      style: LetterPasiing['حرف الفاء'] == true
                                          ? PassedtextStyle
                                          : textStyle,
                                    ),
                                  ),
                                  LetterPasiing['حرف الفاء'] == true
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
                      LetterPasiing['حرف الفاء'] == true
                          ? GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Q_sound(
                                          childId: ChildID, page: 'Q_sound'),
                                    ));
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    width: 80,
                                    decoration: boxDecoration,
                                    padding: const EdgeInsets.all(1),
                                    child: Text(
                                      "ق",
                                      textAlign: TextAlign.center,
                                      style: LetterPasiing['حرف القاف'] == true
                                          ? PassedtextStyle
                                          : textStyle,
                                    ),
                                  ),
                                  LetterPasiing['حرف القاف'] == true
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
                                      "ق",
                                      textAlign: TextAlign.center,
                                      style: LetterPasiing['حرف القاف'] == true
                                          ? PassedtextStyle
                                          : textStyle,
                                    ),
                                  ),
                                  LetterPasiing['حرف القاف'] == true
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
                      LetterPasiing['حرف القاف'] == true
                          ? GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => K_sound(
                                          childId: ChildID, page: 'K_sound'),
                                    ));
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    width: 80,
                                    decoration: boxDecoration,
                                    padding: const EdgeInsets.all(1),
                                    child: Text(
                                      "ك",
                                      textAlign: TextAlign.center,
                                      style: LetterPasiing['حرف الكاف'] == true
                                          ? PassedtextStyle
                                          : textStyle,
                                    ),
                                  ),
                                  LetterPasiing['حرف الكاف'] == true
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
                                      "ك",
                                      textAlign: TextAlign.center,
                                      style: LetterPasiing['حرف الكاف'] == true
                                          ? PassedtextStyle
                                          : textStyle,
                                    ),
                                  ),
                                  LetterPasiing['حرف الكاف'] == true
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
                      LetterPasiing['حرف الكاف'] == true
                          ? GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => L_sound(
                                          childId: ChildID, page: 'L_sound'),
                                    ));
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    width: 80,
                                    decoration: boxDecoration,
                                    padding: const EdgeInsets.all(1),
                                    child: Text(
                                      "ل",
                                      textAlign: TextAlign.center,
                                      style: LetterPasiing['حرف اللام'] == true
                                          ? PassedtextStyle
                                          : textStyle,
                                    ),
                                  ),
                                  LetterPasiing['حرف اللام'] == true
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
                                      "ل",
                                      textAlign: TextAlign.center,
                                      style: LetterPasiing['حرف اللام'] == true
                                          ? PassedtextStyle
                                          : textStyle,
                                    ),
                                  ),
                                  LetterPasiing['حرف اللام'] == true
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
                      LetterPasiing['حرف اللام'] == true
                          ? GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => M_sound(
                                          childId: ChildID, page: 'M_sound'),
                                    ));
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    width: 80,
                                    decoration: boxDecoration,
                                    padding: const EdgeInsets.all(1),
                                    child: Text(
                                      "م",
                                      textAlign: TextAlign.center,
                                      style: LetterPasiing['حرف الميم'] == true
                                          ? PassedtextStyle
                                          : textStyle,
                                    ),
                                  ),
                                  LetterPasiing['حرف الميم'] == true
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
                                      "م",
                                      textAlign: TextAlign.center,
                                      style: LetterPasiing['حرف الميم'] == true
                                          ? PassedtextStyle
                                          : textStyle,
                                    ),
                                  ),
                                  LetterPasiing['حرف الميم'] == true
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
                      LetterPasiing['حرف الميم'] == true
                          ? GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => N_sound(
                                          childId: ChildID, page: 'N_sound'),
                                    ));
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    width: 80,
                                    decoration: boxDecoration,
                                    padding: const EdgeInsets.all(1),
                                    child: Text(
                                      "ن",
                                      textAlign: TextAlign.center,
                                      style: LetterPasiing['حرف النون'] == true
                                          ? PassedtextStyle
                                          : textStyle,
                                    ),
                                  ),
                                  LetterPasiing['حرف النون'] == true
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
                                      "ن",
                                      textAlign: TextAlign.center,
                                      style: LetterPasiing['حرف النون'] == true
                                          ? PassedtextStyle
                                          : textStyle,
                                    ),
                                  ),
                                  LetterPasiing['حرف النون'] == true
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
                      LetterPasiing['حرف النون'] == true
                          ? GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => H_sound(
                                          childId: ChildID, page: 'H_sound'),
                                    ));
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    width: 80,
                                    decoration: boxDecoration,
                                    padding: const EdgeInsets.all(1),
                                    child: Text(
                                      "هـ",
                                      textAlign: TextAlign.center,
                                      style: LetterPasiing['حرف الهاء'] == true
                                          ? PassedtextStyle
                                          : textStyle,
                                    ),
                                  ),
                                  LetterPasiing['حرف الهاء'] == true
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
                                      "هـ",
                                      textAlign: TextAlign.center,
                                      style: LetterPasiing['حرف الهاء'] == true
                                          ? PassedtextStyle
                                          : textStyle,
                                    ),
                                  ),
                                  LetterPasiing['حرف الهاء'] == true
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
                      LetterPasiing['حرف الهاء'] == true
                          ? GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => W_sound(
                                          childId: ChildID, page: 'W_sound'),
                                    ));
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    width: 80,
                                    decoration: boxDecoration,
                                    padding: const EdgeInsets.all(1),
                                    child: Text(
                                      "و",
                                      textAlign: TextAlign.center,
                                      style: LetterPasiing['حرف الواو'] == true
                                          ? PassedtextStyle
                                          : textStyle,
                                    ),
                                  ),
                                  LetterPasiing['حرف الواو'] == true
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
                                      "و",
                                      textAlign: TextAlign.center,
                                      style: LetterPasiing['حرف الواو'] == true
                                          ? PassedtextStyle
                                          : textStyle,
                                    ),
                                  ),
                                  LetterPasiing['حرف الواو'] == true
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
                      LetterPasiing['حرف الواو'] == true
                          ? GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Y_sound(
                                          childId: ChildID, page: 'Y_sound'),
                                    ));
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    width: 80,
                                    decoration: boxDecoration,
                                    child: Text(
                                      "ي",
                                      textAlign: TextAlign.center,
                                      style: LetterPasiing['حرف الياء'] == true
                                          ? PassedtextStyle
                                          : textStyle,
                                    ),
                                  ),
                                  LetterPasiing['حرف الياء'] == true
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
                                      "ي",
                                      textAlign: TextAlign.center,
                                      style: LetterPasiing['حرف الياء'] == true
                                          ? PassedtextStyle
                                          : textStyle,
                                    ),
                                  ),
                                  LetterPasiing['حرف الياء'] == true
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
