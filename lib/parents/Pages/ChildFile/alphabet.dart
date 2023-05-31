import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class alphabet extends StatefulWidget {
  late String ChildID;
  alphabet({required this.ChildID});

  @override
  State<alphabet> createState() => _alphabetState();
}

class _alphabetState extends State<alphabet> {
  late String ChildID = widget.ChildID;

  @override
  void initState() {
    super.initState();
    getChidlData();
    GetLaeeterPassind();
  }

  Map<String, dynamic> ChildInfo = {};
  bool isLoded = true;
  getChidlData() async {
    await FirebaseFirestore.instance
        .collection('Child')
        .where("uid", isEqualTo: ChildID)
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

  late String name = ChildInfo['name'];

  var passedBoxDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(11),
    color: Color(0xffeef1f4),
  );

  var defaultBoxDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(11),
    color: Color.fromARGB(255, 233, 239, 236),
  );
  TextStyle textStyle = TextStyle(
      color: Color(0xff385a4a),
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
                  padding: const EdgeInsets.only(right: 50),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      "$name \nاتقن كل هذه الحروف !",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: "cairo",
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    right: 40,
                    left: 40,
                    top: 60,
                  ),
                  child: GridView.count(
                    crossAxisSpacing: 2,
                    mainAxisSpacing: 20,
                    crossAxisCount: 4,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          decoration: LetterPasiing['حرف الألف'] == true
                              ? passedBoxDecoration
                              : defaultBoxDecoration,
                          padding: EdgeInsets.all(1),
                          child: Text(
                            "أ",
                            textAlign: TextAlign.center,
                            style: LetterPasiing['حرف الألف'] == true
                                ? PassedtextStyle
                                : textStyle,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          decoration: LetterPasiing['حرف الباء'] == true
                              ? passedBoxDecoration
                              : defaultBoxDecoration,
                          padding: EdgeInsets.all(1),
                          child: Text(
                            "ب",
                            textAlign: TextAlign.center,
                            style: LetterPasiing['حرف الباء'] == true
                                ? PassedtextStyle
                                : textStyle,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          decoration: LetterPasiing['حرف التاء'] == true
                              ? passedBoxDecoration
                              : defaultBoxDecoration,
                          padding: EdgeInsets.all(1),
                          child: Text(
                            "ت",
                            textAlign: TextAlign.center,
                            style: LetterPasiing['حرف التاء'] == true
                                ? PassedtextStyle
                                : textStyle,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          decoration: LetterPasiing['حرف الثاء'] == true
                              ? passedBoxDecoration
                              : defaultBoxDecoration,
                          padding: EdgeInsets.all(1),
                          child: Text(
                            "ث",
                            textAlign: TextAlign.center,
                            style: LetterPasiing['حرف الثاء'] == true
                                ? PassedtextStyle
                                : textStyle,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          decoration: LetterPasiing['حرف الجيم'] == true
                              ? passedBoxDecoration
                              : defaultBoxDecoration,
                          child: Text(
                            "ج",
                            textAlign: TextAlign.center,
                            style: LetterPasiing['حرف الجيم'] == true
                                ? PassedtextStyle
                                : textStyle,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          decoration: LetterPasiing['حرف الحاء'] == true
                              ? passedBoxDecoration
                              : defaultBoxDecoration,
                          padding: EdgeInsets.all(1),
                          child: Text(
                            "ح",
                            textAlign: TextAlign.center,
                            style: LetterPasiing['حرف الحاء'] == true
                                ? PassedtextStyle
                                : textStyle,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          decoration: LetterPasiing['حرف الخاء'] == true
                              ? passedBoxDecoration
                              : defaultBoxDecoration,
                          padding: EdgeInsets.all(1),
                          child: Text(
                            "خ",
                            textAlign: TextAlign.center,
                            style: LetterPasiing['حرف الخاء'] == true
                                ? PassedtextStyle
                                : textStyle,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          decoration: LetterPasiing['حرف الدال'] == true
                              ? passedBoxDecoration
                              : defaultBoxDecoration,
                          padding: EdgeInsets.all(1),
                          child: Text(
                            "د",
                            textAlign: TextAlign.center,
                            style: LetterPasiing['حرف الدال'] == true
                                ? PassedtextStyle
                                : textStyle,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          decoration: LetterPasiing['حرف الذال'] == true
                              ? passedBoxDecoration
                              : defaultBoxDecoration,
                          padding: EdgeInsets.all(1),
                          child: Text(
                            "ذ",
                            textAlign: TextAlign.center,
                            style: LetterPasiing['حرف الذال'] == true
                                ? PassedtextStyle
                                : textStyle,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          decoration: LetterPasiing['حرف الراء'] == true
                              ? passedBoxDecoration
                              : defaultBoxDecoration,
                          padding: EdgeInsets.all(1),
                          child: Text(
                            "ر",
                            textAlign: TextAlign.center,
                            style: LetterPasiing['حرف الراء'] == true
                                ? PassedtextStyle
                                : textStyle,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          decoration: LetterPasiing['حرف الزاي'] == true
                              ? passedBoxDecoration
                              : defaultBoxDecoration,
                          padding: EdgeInsets.all(1),
                          child: Text(
                            "ز",
                            textAlign: TextAlign.center,
                            style: LetterPasiing['حرف الزاي'] == true
                                ? PassedtextStyle
                                : textStyle,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          decoration: LetterPasiing['حرف السين'] == true
                              ? passedBoxDecoration
                              : defaultBoxDecoration,
                          padding: EdgeInsets.all(1),
                          child: Text(
                            "س",
                            textAlign: TextAlign.center,
                            style: LetterPasiing['حرف السين'] == true
                                ? PassedtextStyle
                                : textStyle,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          decoration: LetterPasiing['حرف الشين'] == true
                              ? passedBoxDecoration
                              : defaultBoxDecoration,
                          padding: EdgeInsets.all(1),
                          child: Text(
                            "ش",
                            textAlign: TextAlign.center,
                            style: LetterPasiing['حرف الشين'] == true
                                ? PassedtextStyle
                                : textStyle,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          decoration: LetterPasiing['حرف الصاد'] == true
                              ? passedBoxDecoration
                              : defaultBoxDecoration,
                          padding: EdgeInsets.all(1),
                          child: Text(
                            "ص",
                            textAlign: TextAlign.center,
                            style: LetterPasiing['حرف الصاد'] == true
                                ? PassedtextStyle
                                : textStyle,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          decoration: LetterPasiing['حرف الضاد'] == true
                              ? passedBoxDecoration
                              : defaultBoxDecoration,
                          padding: EdgeInsets.all(1),
                          child: Text(
                            "ض",
                            textAlign: TextAlign.center,
                            style: LetterPasiing['حرف الضاد'] == true
                                ? PassedtextStyle
                                : textStyle,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          decoration: LetterPasiing['حرف الطاء'] == true
                              ? passedBoxDecoration
                              : defaultBoxDecoration,
                          padding: EdgeInsets.all(1),
                          child: Text(
                            "ط",
                            textAlign: TextAlign.center,
                            style: LetterPasiing['حرف الطاء'] == true
                                ? PassedtextStyle
                                : textStyle,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          decoration: LetterPasiing['حرف الظاء'] == true
                              ? passedBoxDecoration
                              : defaultBoxDecoration,
                          padding: EdgeInsets.all(1),
                          child: Text(
                            "ظ",
                            textAlign: TextAlign.center,
                            style: LetterPasiing['حرف الظاء'] == true
                                ? PassedtextStyle
                                : textStyle,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          decoration: LetterPasiing['حرف العين'] == true
                              ? passedBoxDecoration
                              : defaultBoxDecoration,
                          child: Text(
                            "ع",
                            textAlign: TextAlign.center,
                            style: LetterPasiing['حرف العين'] == true
                                ? PassedtextStyle
                                : textStyle,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          decoration: LetterPasiing['حرف الغين'] == true
                              ? passedBoxDecoration
                              : defaultBoxDecoration,
                          child: Text(
                            "غ",
                            textAlign: TextAlign.center,
                            style: LetterPasiing['حرف الغين'] == true
                                ? PassedtextStyle
                                : textStyle,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          decoration: LetterPasiing['حرف الفاء'] == true
                              ? passedBoxDecoration
                              : defaultBoxDecoration,
                          padding: EdgeInsets.all(1),
                          child: Text(
                            "ف",
                            textAlign: TextAlign.center,
                            style: LetterPasiing['حرف الفاء'] == true
                                ? PassedtextStyle
                                : textStyle,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          decoration: LetterPasiing['حرف القاف'] == true
                              ? passedBoxDecoration
                              : defaultBoxDecoration,
                          padding: EdgeInsets.all(1),
                          child: Text(
                            "ق",
                            textAlign: TextAlign.center,
                            style: LetterPasiing['حرف القاف'] == true
                                ? PassedtextStyle
                                : textStyle,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          decoration: LetterPasiing['حرف الكاف'] == true
                              ? passedBoxDecoration
                              : defaultBoxDecoration,
                          padding: EdgeInsets.all(1),
                          child: Text(
                            "ك",
                            textAlign: TextAlign.center,
                            style: LetterPasiing['حرف الكاف'] == true
                                ? PassedtextStyle
                                : textStyle,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          decoration: LetterPasiing['حرف اللام'] == true
                              ? passedBoxDecoration
                              : defaultBoxDecoration,
                          child: Text(
                            "ل",
                            textAlign: TextAlign.center,
                            style: LetterPasiing['حرف اللام'] == true
                                ? PassedtextStyle
                                : textStyle,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          decoration: LetterPasiing['حرف الميم'] == true
                              ? passedBoxDecoration
                              : defaultBoxDecoration,
                          child: Text(
                            "م",
                            textAlign: TextAlign.center,
                            style: LetterPasiing['حرف الميم'] == true
                                ? PassedtextStyle
                                : textStyle,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          decoration: LetterPasiing['حرف النون'] == true
                              ? passedBoxDecoration
                              : defaultBoxDecoration,
                          child: Text(
                            "ن",
                            textAlign: TextAlign.center,
                            style: LetterPasiing['حرف النون'] == true
                                ? PassedtextStyle
                                : textStyle,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          decoration: LetterPasiing['حرف الهاء'] == true
                              ? passedBoxDecoration
                              : defaultBoxDecoration,
                          padding: EdgeInsets.all(1),
                          child: Text(
                            "هـ",
                            textAlign: TextAlign.center,
                            style: LetterPasiing['حرف الهاء'] == true
                                ? PassedtextStyle
                                : textStyle,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          decoration: LetterPasiing['حرف الواو'] == true
                              ? passedBoxDecoration
                              : defaultBoxDecoration,
                          child: Text(
                            "و",
                            textAlign: TextAlign.center,
                            style: LetterPasiing['حرف الواو'] == true
                                ? PassedtextStyle
                                : textStyle,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          decoration: LetterPasiing['حرف الياء'] == true
                              ? passedBoxDecoration
                              : defaultBoxDecoration,
                          child: Text(
                            "ي",
                            textAlign: TextAlign.center,
                            style: LetterPasiing['حرف الياء'] == true
                                ? PassedtextStyle
                                : textStyle,
                          ),
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
