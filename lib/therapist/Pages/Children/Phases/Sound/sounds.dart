import 'package:eloquentapp/therapist/Pages/Children/Phases/Sound/TwoSyllableWords.dart';
import 'package:eloquentapp/therapist/Pages/Children/Phases/Sound/letter/%D8%AC.dart';
import 'package:eloquentapp/therapist/Pages/Children/Phases/Sound/letter/%D8%AD.dart';
import 'package:eloquentapp/therapist/Pages/Children/Phases/Sound/letter/%D8%AE.dart';
import 'package:eloquentapp/therapist/Pages/Children/Phases/Sound/letter/%D8%AF.dart';
import 'package:eloquentapp/therapist/Pages/Children/Phases/Sound/letter/%D8%B0.dart';
import 'package:eloquentapp/therapist/Pages/Children/Phases/Sound/letter/%D8%B1.dart';
import 'package:eloquentapp/therapist/Pages/Children/Phases/Sound/letter/%D8%B2.dart';
import 'package:eloquentapp/therapist/Pages/Children/Phases/Sound/letter/%D8%B3.dart';
import 'package:eloquentapp/therapist/Pages/Children/Phases/Sound/letter/%D8%B4.dart';
import 'package:eloquentapp/therapist/Pages/Children/Phases/Sound/letter/%D8%B6.dart';
import 'package:eloquentapp/therapist/Pages/Children/Phases/Sound/letter/%D8%B7.dart';
import 'package:eloquentapp/therapist/Pages/Children/Phases/Sound/letter/%D8%B8.dart';
import 'package:eloquentapp/therapist/Pages/Children/Phases/Sound/letter/%D8%B9.dart';
import 'package:eloquentapp/therapist/Pages/Children/Phases/Sound/letter/%D8%BA.dart';
import 'package:eloquentapp/therapist/Pages/Children/Phases/Sound/letter/%D9%81.dart';
import 'package:eloquentapp/therapist/Pages/Children/Phases/Sound/letter/%D9%82.dart';
import 'package:eloquentapp/therapist/Pages/Children/Phases/Sound/letter/%D9%83.dart';
import 'package:eloquentapp/therapist/Pages/Children/Phases/Sound/letter/%D9%84.dart';
import 'package:eloquentapp/therapist/Pages/Children/Phases/Sound/letter/%D9%85.dart';
import 'package:eloquentapp/therapist/Pages/Children/Phases/Sound/letter/%D9%86.dart';
import 'package:eloquentapp/therapist/Pages/Children/Phases/Sound/letter/%D9%87.dart';
import 'package:eloquentapp/therapist/Pages/Children/Phases/Sound/letter/%D9%88.dart';
import 'package:eloquentapp/therapist/Pages/Children/Phases/Sound/letter/%D9%8A.dart';
import 'package:eloquentapp/therapist/Pages/Children/Phases/Sound/letter/%D8%A3.dart';
import 'package:eloquentapp/therapist/Pages/Children/Phases/Sound/letter/%D8%A8.dart';
import 'package:eloquentapp/therapist/Pages/Children/Phases/Sound/letter/%D8%B5.dart';
import 'package:eloquentapp/therapist/Pages/Children/Phases/Sound/letter/%D8%AA.dart';
import 'package:eloquentapp/therapist/Pages/Children/Phases/Sound/letter/%D8%AB.dart';
import 'package:flutter/material.dart';

class Sounds extends StatefulWidget {
  late String childId;
  Sounds({required this.childId});

  @override
  State<Sounds> createState() => _SoundsState();
}

class _SoundsState extends State<Sounds> {
  late String childId = widget.childId;
  @override
  Widget build(BuildContext context) {
    var boxDecoration = BoxDecoration(
      borderRadius: BorderRadius.circular(11),
      color: Color.fromARGB(255, 233, 239, 236),
    );
    const textStyle = TextStyle(
        color: Color(0xff385a4a),
        fontSize: 38,
        fontFamily: "Cairo",
        fontWeight: FontWeight.w800);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_right, size: 32),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          )
        ],
        foregroundColor: Color(0xff385a4a),
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 244, 245, 245),
        title: Align(
          alignment: Alignment.centerRight,
          child: Text(
            "مرحلة الاصوات",
            style: TextStyle(
              color: Color(0xff385a4a),
              fontSize: 25,
              fontFamily: "Cairo",
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        bottom: PreferredSize(
          child: Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 17, left: 10),
              child: Text(
                " تشمل هذه المرحلة جميع الاصوات\nمفردة وبمقاطع , وكلمات ذات مقطعين,\nوكلمات لجميع الاصوات بمواضع الكلمة المختلفة ",
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xff385a4a),
                ),
                textAlign: TextAlign.start,
              ),
            ),
          ),
          preferredSize: Size.fromHeight(70.0),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Color.fromARGB(255, 244, 245, 245),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        right: 55, left: 55, top: 30, bottom: 40),
                    child: Text(
                      "اختر الحرف وقيم!",
                      style: TextStyle(
                          color: Color(0xff385a4a),
                          fontSize: 20,
                          fontFamily: "Cairo",
                          fontWeight: FontWeight.w800),
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
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 20,
                    crossAxisCount: 4,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LetterA(childId: childId),
                              ));
                        },
                        child: Container(
                          decoration: boxDecoration,
                          padding: const EdgeInsets.all(1),
                          child: const Text(
                            "أ",
                            textAlign: TextAlign.center,
                            style: textStyle,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LetterB(childId: childId),
                              ));
                        },
                        child: Container(
                          decoration: boxDecoration,
                          padding: const EdgeInsets.all(1),
                          child: const Text(
                            "ب",
                            textAlign: TextAlign.center,
                            style: textStyle,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LetterT(childId: childId),
                              ));
                        },
                        child: Container(
                          decoration: boxDecoration,
                          padding: const EdgeInsets.all(1),
                          child: const Text(
                            'ت',
                            textAlign: TextAlign.center,
                            style: textStyle,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    LetterTh(childId: childId),
                              ));
                        },
                        child: Container(
                          decoration: boxDecoration,
                          padding: const EdgeInsets.all(1),
                          child: const Text(
                            'ث',
                            textAlign: TextAlign.center,
                            style: textStyle,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LetterG(childId: childId),
                              ));
                        },
                        child: Container(
                          decoration: boxDecoration,
                          padding: const EdgeInsets.all(1),
                          child: const Text(
                            "ج",
                            textAlign: TextAlign.center,
                            style: textStyle,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LetterH(childId: childId),
                              ));
                        },
                        child: Container(
                          decoration: boxDecoration,
                          padding: const EdgeInsets.all(1),
                          child: const Text(
                            'ح',
                            textAlign: TextAlign.center,
                            style: textStyle,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      LetterKh(childId: childId)));
                        },
                        child: Container(
                          decoration: boxDecoration,
                          padding: const EdgeInsets.all(1),
                          child: const Text(
                            "خ",
                            textAlign: TextAlign.center,
                            style: textStyle,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      LetterD(childId: childId)));
                        },
                        child: Container(
                          decoration: boxDecoration,
                          padding: const EdgeInsets.all(1),
                          child: const Text(
                            'د',
                            textAlign: TextAlign.center,
                            style: textStyle,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    LetterTha(childId: childId),
                              ));
                        },
                        child: Container(
                          decoration: boxDecoration,
                          padding: const EdgeInsets.all(1),
                          child: const Text(
                            "ذ",
                            textAlign: TextAlign.center,
                            style: textStyle,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LetterR(childId: childId),
                              ));
                        },
                        child: Container(
                          decoration: boxDecoration,
                          padding: const EdgeInsets.all(1),
                          child: const Text(
                            'ر',
                            textAlign: TextAlign.center,
                            style: textStyle,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LetterZ(childId: childId),
                              ));
                        },
                        child: Container(
                          decoration: boxDecoration,
                          padding: const EdgeInsets.all(1),
                          child: const Text(
                            "ز",
                            textAlign: TextAlign.center,
                            style: textStyle,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LetterS(childId: childId),
                              ));
                        },
                        child: Container(
                          decoration: boxDecoration,
                          padding: const EdgeInsets.all(1),
                          child: const Text(
                            'س',
                            textAlign: TextAlign.center,
                            style: textStyle,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    LetterSh(childId: childId),
                              ));
                        },
                        child: Container(
                          decoration: boxDecoration,
                          padding: const EdgeInsets.all(1),
                          child: const Text(
                            "ش",
                            textAlign: TextAlign.center,
                            style: textStyle,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    LetterSaD(childId: childId),
                              ));
                        },
                        child: Container(
                          decoration: boxDecoration,
                          padding: const EdgeInsets.all(1),
                          child: const Text(
                            'ص',
                            textAlign: TextAlign.center,
                            style: textStyle,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    LetterDaD(childId: childId),
                              ));
                        },
                        child: Container(
                          decoration: boxDecoration,
                          padding: const EdgeInsets.all(1),
                          child: const Text(
                            "ض",
                            textAlign: TextAlign.center,
                            style: textStyle,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      LetterTA(childId: childId)));
                        },
                        child: Container(
                          decoration: boxDecoration,
                          padding: const EdgeInsets.all(1),
                          child: const Text(
                            'ط',
                            textAlign: TextAlign.center,
                            style: textStyle,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      LetterThad(childId: childId)));
                        },
                        child: Container(
                          decoration: boxDecoration,
                          padding: const EdgeInsets.all(1),
                          child: const Text(
                            "ظ",
                            textAlign: TextAlign.center,
                            style: textStyle,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      LetterE(childId: childId)));
                        },
                        child: Container(
                          decoration: boxDecoration,
                          padding: const EdgeInsets.all(1),
                          child: const Text(
                            'ع',
                            textAlign: TextAlign.center,
                            style: textStyle,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      LetterGain(childId: childId)));
                        },
                        child: Container(
                          decoration: boxDecoration,
                          padding: const EdgeInsets.all(1),
                          child: const Text(
                            "غ",
                            textAlign: TextAlign.center,
                            style: textStyle,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      LetterF(childId: childId)));
                        }),
                        child: Container(
                          decoration: boxDecoration,
                          padding: const EdgeInsets.all(1),
                          child: const Text(
                            'ف',
                            textAlign: TextAlign.center,
                            style: textStyle,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      LetterQ(childId: childId)));
                        }),
                        child: Container(
                          decoration: boxDecoration,
                          padding: const EdgeInsets.all(1),
                          child: const Text(
                            "ق",
                            textAlign: TextAlign.center,
                            style: textStyle,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      LetterK(childId: childId)));
                        }),
                        child: Container(
                          decoration: boxDecoration,
                          padding: const EdgeInsets.all(1),
                          child: const Text(
                            'ك',
                            textAlign: TextAlign.center,
                            style: textStyle,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      LetterL(childId: childId)));
                        }),
                        child: Container(
                          decoration: boxDecoration,
                          padding: const EdgeInsets.all(1),
                          child: const Text(
                            "ل",
                            textAlign: TextAlign.center,
                            style: textStyle,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      LetterM(childId: childId)));
                        }),
                        child: Container(
                          decoration: boxDecoration,
                          child: const Text(
                            'م',
                            textAlign: TextAlign.center,
                            style: textStyle,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      LetterN(childId: childId)));
                        },
                        child: Container(
                          decoration: boxDecoration,
                          child: const Text(
                            "ن",
                            textAlign: TextAlign.center,
                            style: textStyle,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      LetterHA(childId: childId)));
                        },
                        child: Container(
                          decoration: boxDecoration,
                          padding: const EdgeInsets.all(1),
                          child: const Text(
                            'هـ',
                            textAlign: TextAlign.center,
                            style: textStyle,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      LetterWow(childId: childId)));
                        },
                        child: Container(
                          decoration: boxDecoration,
                          padding: const EdgeInsets.all(1),
                          child: const Text(
                            "و",
                            textAlign: TextAlign.center,
                            style: textStyle,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      LetterYA(childId: childId)));
                        },
                        child: Container(
                          decoration: boxDecoration,
                          child: const Text(
                            'ي',
                            textAlign: TextAlign.center,
                            style: textStyle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 670, right: 49, left: 112),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size(230, 50),
                          backgroundColor: Color.fromARGB(255, 233, 239, 236),
                          elevation: 3,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(6)),
                          )),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TwoSyllableWords(
                                childId: childId,
                              ),
                            ));
                      },
                      child: Text("كلمات ذات مقطعين",
                          style: TextStyle(
                              color: Color(0xff385a4a),
                              fontSize: 15,
                              fontFamily: "Cairo",
                              fontWeight: FontWeight.w800))),
                )
              ],
            ),
          ),
        ),
      ),
      // Align(
      // alignment: Alignment.topRight,
      // child: Padding(
      // padding: const EdgeInsets.all(8.0),
      // child: Text(
      // "تشمل هذه المرحلة جميع الاصوات\n مفردة وبمقاطع,وكلمات ذات مقطعين",
      // style: TextStyle(
      // color: Color(0xff385a4a),
      // fontSize: 15,
      // fontFamily: "Cairo",
      // fontWeight: FontWeight.w800,
      // ),
      // ),
      // ),
      // ),
      // Positioned(
      // top: 60,
      // left: 185,
      // right: 0,
      // child: Container(
      // child: Text("!اختر الحرف وقيم",
      // style: TextStyle(
      // fontWeight: FontWeight.bold,
      // fontSize: 24,
      // ))))
    );
  }
}
