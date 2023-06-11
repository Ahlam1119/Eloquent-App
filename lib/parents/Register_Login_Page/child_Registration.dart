import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eloquentapp/parents/BottomNavBar.dart';
import 'package:eloquentapp/parents/Pages/home.dart';

import 'package:eloquentapp/screens/constants.dart';
import 'package:eloquentapp/services/firebase_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class ChildRegistration extends StatefulWidget {
  @override
  State<ChildRegistration> createState() => _ChildRegistrationState();
}

class _ChildRegistrationState extends State<ChildRegistration> {
  final _auth = FirebaseAuth.instance;
  late String _name;
  var uuid = Uuid();

  late User singedInUser;
  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        singedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  void initState() {
    super.initState();
    getCurrentUser();
    getUserData();
  }

  Map<String, dynamic> ParentInfo = {};
  bool isLoded = true;
  getUserData() async {
    await FirebaseFirestore.instance
        .collection('Parent')
        .where("uid", isEqualTo: singedInUser.uid)
        .get()
        .then((v) {
      for (var element in v.docs) {
        ParentInfo.addAll(element.data());
        setState(() {
          isLoded = false;
        });
      }
    });
  }

  late String ParenId = ParentInfo["uid"];
  late String ParentName = ParentInfo["name"];
  DateTime? _selectedDate;
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: Color(0xff385a4a),
              onPrimary: Color.fromARGB(
                  255, 255, 255, 255), // Set the color of the header in the
            ),
            textTheme: TextTheme(
              subtitle1: TextStyle(
                color: Color.fromARGB(
                    255, 255, 255, 255), // Set the color of the text in the
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  DateTime date = DateTime.now();
  /*----------------------------------*/
  //varibale
  // var _highMovment;
  // var _litleMovment;
  // var _MidMovment;
  // var _social;
  // var _introvert;
  // var _shy;
  // var _quicklythwarts = false;
  // var _angryquickly = false;
  // var _Littledistraction = false;
  // var _quicklyDispersed = false;
  // var _easliyUnderstand = false;
  // var _hardUnderstand = false;
  // var _good = false;
  // var _weak = false;
  // var _nothing = false;
  // var _AgressiveYes = false;
  // var _AgressiveNo = false;
  // var _fearYes = false;
  // var _fearNo = false;
  // var _cooperatingYes = false;
  // var _cooperatingNo = false;
  // var _visualNatural;
  // var _visualweak;
  // var _visuallight;
  // var _audioNatural;
  // var _audioweak;
  // var _audiolight;
  // var _expressionNatural;
  // var _expressionweak;
  // var _expressionveryweak;
  // var _letterexitscleary;
  // var _letterexitsweak;
  // var _letterexitsveryweak;
  // var _MotionclassificationNormal;
  // var _MotionclassificationHard;
  // var _Motionclassificationhemiplegia;
  // var _Motionclassificationquadriplegia;
  // var _Motionclassificationbrainparalysis;
  // var _physicalgrowthNormal;
  // var _physicalgrowthAbnormal;

  // var _chronicdiseasesasthma;

  // var _chronicdiseasesSugar;
  // var _chronicdiseasesEpilepsy;
  // var _chronicdiseasesHeart;
  // var _chronicdiseasesConvulsions;
  // var _chronicdiseasesOther;
  // var _CheckupsYes;
  // var _CheckupsNo;
  // var _SurgeryYes;
  // var _SurgeryNo;
  // var _IntelligencetestYes;
  // var _IntelligencetestNo;
  // var _allergyYes;
  // var _allergyNo;
  late String chronicdiseasesOtherField;
  late String CheckupsYesField;
  late String SurgeryYesField;
  late String IntelligencetestYesField;
  late String allergyYesField;
  var _previoustreatmentYes;
  late String previoustreatmentYesField;
  var _previoustreatmentNo;
  late String ChildAvatar = '';

  /*----------------------------------*/
  String? Movement;
  String? personalBehaviour;
  String? emotionalBehaviour;
  String? understanding;
  String? dispersion;
  String? visualCommunication;
  String? Agressive;
  String? fear;
  String? cooperating;
  String? visualCondition;
  String? auditoryCondition;
  String? expressionLevel;
  String? LetteringLevel;
  String? MotionClassification;
  String? physicalGrowth;
  String? chronicDiseases;
  String? previousTreatment;
  String? checkUp;
  String? Surgery;
  String? DefiningIntelligence;
  String? sensitive;

  late String _EducationalLevel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.only(
                top: 40,
                left: 24,
                right: 23,
              ),
              child: SingleChildScrollView(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "تسجيل بيانات الطفل",
                    style: TextStyle(
                      color: Color(0xff394445),
                      fontSize: 20,
                      fontFamily: "Cairo",
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Center(
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                ChildAvatar = "images/GirlAvatar.png";
                              });
                            },
                            child: Transform.scale(
                              scale: ChildAvatar == "images/GirlAvatar.png"
                                  ? 1.3
                                  : 1.0,
                              child: Image.asset(
                                "images/GirlAvatar.png",
                                width: 83,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                ChildAvatar = "images/CuteBoy.png";
                              });
                            },
                            child: Transform.scale(
                              scale: ChildAvatar == "images/CuteBoy.png"
                                  ? 1.2
                                  : 1.0,
                              child: Image.asset(
                                "images/CuteBoy.png",
                                width: 80,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "اسم الطفل",
                    style: SStyleTextOfTextFeild,
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  TextField(
                    onChanged: (value) {
                      _name = value;
                    },
                    decoration: kStylingInputDec,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "تاريخ الميلاد",
                    style: SStyleTextOfTextFeild,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    readOnly: true,
                    onTap: () => _selectDate(context),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xff9BB0A5), width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 83, 97, 90), width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      labelText: '',
                      suffixIcon: Icon(
                        Icons.calendar_today,
                        color: Color(0xff394445),
                      ),
                    ),
                    validator: (value) {
                      if (_selectedDate == null)
                        return 'Please select your birthdate';
                      return null;
                    },
                    controller: TextEditingController(
                        text: _selectedDate == null
                            ? ''
                            : DateFormat('dd/MM/yyyy').format(_selectedDate!)),
                  ),
                  SizedBox(
                    height: 17,
                  ),
                  Text(
                    "مستوى الطفل التعليمي",
                    style: SStyleTextOfTextFeild,
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  TextField(
                    onChanged: (value) {
                      _EducationalLevel = value;
                    },
                    decoration: kStylingInputDec,
                  ),
                  SizedBox(
                    height: 17,
                  ),
                  Text(
                    "الصفات الشخصية والسلوكية",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Color(0xff385a4a),
                      fontSize: 16,
                      fontFamily: "Cairo",
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment
                        .start, // Align widgets to the left edge
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Radio(
                              groupValue: Movement,
                              value: "قليل الحركة",
                              onChanged: (value) {
                                setState(() {
                                  Movement = value.toString();
                                });
                              },
                              activeColor: Color(0xff385a4a),
                            ),
                          ),
                          Text(
                            "قليل الحركة",
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: Color(0xff030d1c),
                              fontSize: 14,
                              fontFamily: "Cairo",
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Radio(
                            groupValue: Movement,
                            value: "متوسط الحركة",
                            onChanged: (value) {
                              setState(() {
                                Movement = value.toString();
                              });
                            },
                            activeColor: Color(0xff385a4a),
                          ),
                          Text(
                            "متوسط الحركة",
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: Color(0xff030d1c),
                              fontSize: 14,
                              fontFamily: "Cairo",
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Flexible(
                            child: Radio(
                              groupValue: Movement,
                              value: "كثير الحركة",
                              onChanged: (value) {
                                setState(() {
                                  Movement = value.toString();
                                });
                              },
                              activeColor: Color(0xff385a4a),
                            ),
                          ),
                          Text(
                            "كثير الحركة",
                            // textAlign: TextAlign.right,
                            style: TextStyle(
                              color: Color(0xff030d1c),
                              fontSize: 13,
                              fontFamily: "Cairo",
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  /**--------------------------------------------- */
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Radio(
                        groupValue: personalBehaviour,
                        value: 'اجتماعي',
                        onChanged: (value) {
                          setState(() {
                            personalBehaviour = value.toString();
                          });
                        },
                        activeColor: Color(0xff385a4a),
                      ),
                      checkBoxLabel(label: 'اجتماعي'),
                      Radio(
                        groupValue: personalBehaviour,
                        value: "خجول",
                        onChanged: (value) {
                          setState(() {
                            personalBehaviour = value.toString();
                          });
                        },
                        activeColor: Color(0xff385a4a),
                      ),
                      checkBoxLabel(label: 'خجول'),
                      Radio(
                        groupValue: personalBehaviour,
                        value: 'انطوائي',
                        onChanged: (value) {
                          setState(() {
                            personalBehaviour = value.toString();
                          });
                        },
                        activeColor: Color(0xff385a4a),
                      ),
                      checkBoxLabel(label: 'انطوائي'),
                    ],
                  ),
                  /**--------------------------------------------- */
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Radio(
                        groupValue: emotionalBehaviour,
                        value: 'يغضب بسرعة',
                        onChanged: (value) {
                          setState(() {
                            emotionalBehaviour = value.toString();
                          });
                        },
                        activeColor: Color(0xff385a4a),
                      ),
                      checkBoxLabel(label: 'يغضب بسرعة'),
                      Radio(
                        groupValue: emotionalBehaviour,
                        value: 'يحبط بسرعة',
                        onChanged: (value) {
                          setState(() {
                            emotionalBehaviour = value.toString();
                          });
                        },
                        activeColor: Color(0xff385a4a),
                      ),
                      checkBoxLabel(label: 'يحبط بسرعة'),
                    ],
                  ),
                  /**--------------------------------------------- */
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "الانتباه:",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Color(0xff6888a0),
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Radio(
                        groupValue: dispersion,
                        value: 'يتشتت بسهولة',
                        onChanged: (value) {
                          setState(() {
                            dispersion = value.toString();
                          });
                        },
                        activeColor: Color(0xff385a4a),
                      ),
                      checkBoxLabel(label: 'يتشتت بسهولة'),
                      Radio(
                        groupValue: dispersion,
                        value: 'قليل التشتت',
                        onChanged: (value) {
                          setState(() {
                            dispersion = value.toString();
                          });
                        },
                        activeColor: Color(0xff385a4a),
                      ),
                      checkBoxLabel(label: 'قليل التشتت'),
                    ],
                  ),
                  /**--------------------------------------------- */
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "الفهم والاستيعاب:",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Color(0xff6888a0),
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Radio(
                          groupValue: understanding,
                          value: 'يفهم التعليمات بسهولة',
                          onChanged: (value) {
                            setState(() {
                              understanding = value!;
                            });
                          },
                          activeColor: Color(0xff385a4a),
                        ),
                      ),
                      Text('يفهم التعليمات بسهولة'),
                      Flexible(
                        child: Radio(
                          groupValue: understanding,
                          value: 'يفهم التعليمات بصعوبة',
                          onChanged: (value) {
                            setState(() {
                              understanding = value!;
                            });
                          },
                          activeColor: Color(0xff385a4a),
                        ),
                      ),
                      Text('يفهم التعليمات بصعوبة'),
                    ],
                  ),
                  /**--------------------------------------------- */
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "التواصل البصري:",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Color(0xff6888a0),
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Radio(
                        groupValue: visualCommunication,
                        value: 'جيد',
                        onChanged: (value) {
                          setState(() {
                            visualCommunication = value.toString();
                          });
                        },
                        activeColor: Color(0xff385a4a),
                      ),
                      checkBoxLabel(label: 'جيد'),
                      Radio(
                        groupValue: visualCommunication,
                        value: 'ضعيف',
                        onChanged: (value) {
                          setState(() {
                            visualCommunication = value.toString();
                          });
                        },
                        activeColor: Color(0xff385a4a),
                      ),
                      checkBoxLabel(label: 'ضعيف'),
                      Radio(
                        groupValue: visualCommunication,
                        value: 'لا يوجد',
                        onChanged: (value) {
                          setState(() {
                            visualCommunication = value.toString();
                          });
                        },
                        activeColor: Color(0xff385a4a),
                      ),
                      checkBoxLabel(label: 'لا يوجد'),
                    ],
                  ),
                  /**--------------------------------------------- */
                  Row(
                    children: [
                      Text(
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Color(0xff6888a0),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                          'يظهر على الطفل سلوك عدواني؟'),
                      Radio(
                        groupValue: Agressive,
                        value: 'نعم',
                        onChanged: (value) {
                          setState(() {
                            Agressive = value!;
                          });
                        },
                        activeColor: Color(0xff385a4a),
                      ),
                      checkBoxLabel(label: 'نعم'),
                      Radio(
                        groupValue: Agressive,
                        value: 'لا',
                        onChanged: (value) {
                          setState(() {
                            Agressive = value!;
                          });
                        },
                        activeColor: Color(0xff385a4a),
                      ),
                      checkBoxLabel(label: 'لا'),
                    ],
                  ),
                  /**--------------------------------------------- */
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'يظهر على الطفل الخوف أو القلق؟',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Color(0xff6888a0),
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Radio(
                        groupValue: fear,
                        value: 'نعم',
                        onChanged: (value) {
                          setState(() {
                            fear = value!;
                          });
                        },
                        activeColor: Color(0xff385a4a),
                      ),
                      checkBoxLabel(label: 'نعم'),
                      Radio(
                        groupValue: fear,
                        value: 'لا',
                        onChanged: (value) {
                          setState(() {
                            fear = value!;
                          });
                        },
                        activeColor: Color(0xff385a4a),
                      ),
                      checkBoxLabel(label: 'لا'),
                    ],
                  ),
                  /**--------------------------------------------- */
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'هل الطفل متعاون مع الآخرين؟',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Color(0xff6888a0),
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Radio(
                        groupValue: cooperating,
                        value: "نعم",
                        onChanged: (value) {
                          setState(() {
                            cooperating = value!;
                          });
                        },
                        activeColor: Color(0xff385a4a),
                      ),
                      checkBoxLabel(label: 'نعم'),
                      Radio(
                        groupValue: cooperating,
                        value: "لا",
                        onChanged: (value) {
                          setState(() {
                            cooperating = value!;
                          });
                        },
                        activeColor: Color(0xff385a4a),
                      ),
                      checkBoxLabel(label: 'لا'),
                      SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "الحالة الصحية العامة للطفل",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Color(0xff385a4a),
                          fontSize: 17,
                          fontFamily: "Cairo",
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "الحالة البصرية",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Color(0xff6888a0),
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Radio(
                            groupValue: visualCondition,
                            value: "طبيعي",
                            onChanged: (value) {
                              setState(() {
                                visualCondition = value!;
                              });
                            },
                            activeColor: Color(0xff385a4a),
                          ),
                          checkBoxLabel(label: 'طبيعي'),
                          Radio(
                            groupValue: visualCondition,
                            value: "ضعيف",
                            onChanged: (value) {
                              setState(() {
                                visualCondition = value!;
                              });
                            },
                            activeColor: Color(0xff385a4a),
                          ),
                          checkBoxLabel(label: 'ضعيف'),
                          Radio(
                            groupValue: visualCondition,
                            value: "كفيف",
                            onChanged: (value) {
                              setState(() {
                                visualCondition = value!;
                              });
                            },
                            activeColor: Color(0xff385a4a),
                          ),
                          checkBoxLabel(label: 'كفيف'),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "الحالة السمعية",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Color(0xff6888a0),
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Radio(
                            groupValue: auditoryCondition,
                            value: "طبيعي",
                            onChanged: (value) {
                              setState(() {
                                auditoryCondition = value!;
                              });
                            },
                            activeColor: Color(0xff385a4a),
                          ),
                          checkBoxLabel(label: 'طبيعي'),
                          Radio(
                            groupValue: auditoryCondition,
                            value: "اصم",
                            onChanged: (value) {
                              setState(() {
                                auditoryCondition = value!;
                              });
                            },
                            activeColor: Color(0xff385a4a),
                          ),
                          checkBoxLabel(label: 'أصم'),
                          Radio(
                            groupValue: auditoryCondition,
                            value: "ضعيف",
                            onChanged: (value) {
                              setState(() {
                                auditoryCondition = value!;
                              });
                            },
                            activeColor: Color(0xff385a4a),
                          ),
                          checkBoxLabel(label: 'ضعيف'),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "مستوى النطق",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Color(0xff6888a0),
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      /**--------------------------------------------- */
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "قدرته على التعبير مقارنه بأقرانه في العمر:",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Color(0xff6888a0),
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Radio(
                            groupValue: expressionLevel,
                            value: "طبيعية",
                            onChanged: (value) {
                              setState(() {
                                expressionLevel = value!;
                              });
                            },
                            activeColor: Color(0xff385a4a),
                          ),
                          checkBoxLabel(label: 'طبيعة'),
                          Radio(
                            groupValue: expressionLevel,
                            value: "ضغيفة نوعا ما",
                            onChanged: (value) {
                              setState(() {
                                expressionLevel = value!;
                              });
                            },
                            activeColor: Color(0xff385a4a),
                          ),
                          checkBoxLabel(label: 'ضعيفة نوعاَ ما'),
                          Radio(
                            groupValue: expressionLevel,
                            value: "ضعيفة",
                            onChanged: (value) {
                              setState(() {
                                expressionLevel = value!;
                              });
                            },
                            activeColor: Color(0xff385a4a),
                          ),
                          checkBoxLabel(label: 'ضعيفة'),
                        ],
                      ),
                      /**--------------------------------------------- */
                      /**--------------------------------------------- */
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "وضوح مخارج الحروف:",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Color(0xff6888a0),
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Radio(
                            groupValue: LetteringLevel,
                            value: "واضحة",
                            onChanged: (value) {
                              setState(() {
                                LetteringLevel = value!;
                              });
                            },
                            activeColor: Color(0xff385a4a),
                          ),
                          checkBoxLabel(label: 'واضحة'),
                          Radio(
                            groupValue: LetteringLevel,
                            value: "واضحة نوعا ما ",
                            onChanged: (value) {
                              setState(() {
                                LetteringLevel = value!;
                              });
                            },
                            activeColor: Color(0xff385a4a),
                          ),
                          checkBoxLabel(label: 'واضحة نوعًا ما'),
                          Radio(
                            groupValue: LetteringLevel,
                            value: "ضعيفة",
                            onChanged: (value) {
                              setState(() {
                                LetteringLevel = value!;
                              });
                            },
                            activeColor: Color(0xff385a4a),
                          ),
                          checkBoxLabel(label: 'ضعيفة'),
                        ],
                      ),
                      /**--------------------------------------------- */
                      /**--------------------------------------------- */
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "تصنيف الحركة:",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Color(0xff6888a0),
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Radio(
                              groupValue: MotionClassification,
                              value: "طبيعي",
                              onChanged: (value) {
                                setState(() {
                                  MotionClassification = value!;
                                });
                              },
                              activeColor: Color(0xff385a4a),
                            ),
                          ),
                          checkBoxLabel(label: 'طبيعي'),
                          Radio(
                            groupValue: MotionClassification,
                            value: "شلل نصفي",
                            onChanged: (value) {
                              setState(() {
                                MotionClassification = value!;
                              });
                            },
                            activeColor: Color(0xff385a4a),
                          ),
                          checkBoxLabel(label: 'شلل نصفي'),
                          Radio(
                            groupValue: MotionClassification,
                            value: "صعب التحرك",
                            onChanged: (value) {
                              setState(() {
                                MotionClassification = value!;
                              });
                            },
                            activeColor: Color(0xff385a4a),
                          ),
                          checkBoxLabel(label: 'صعب التحرك'),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Radio(
                            groupValue: MotionClassification,
                            value: "شلل رباعي",
                            onChanged: (value) {
                              setState(() {
                                MotionClassification = value!;
                              });
                            },
                            activeColor: Color(0xff385a4a),
                          ),
                          checkBoxLabel(label: 'شلل رباعي'),
                          Radio(
                            groupValue: MotionClassification,
                            value: "شلل دماغي",
                            onChanged: (value) {
                              setState(() {
                                MotionClassification = value!;
                              });
                            },
                            activeColor: Color(0xff385a4a),
                          ),
                          checkBoxLabel(label: 'شلل دماغي'),
                        ],
                      ),
                      /**--------------------------------------------- */
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "النمو الجسمي:",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Color(0xff6888a0),
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Radio(
                            groupValue: physicalGrowth,
                            value: "طبيعي",
                            onChanged: (value) {
                              setState(() {
                                physicalGrowth = value!;
                              });
                            },
                            activeColor: Color(0xff385a4a),
                          ),
                          checkBoxLabel(label: 'طبيعي'),
                          Radio(
                            groupValue: physicalGrowth,
                            value: "غير طبيعي",
                            onChanged: (value) {
                              setState(() {
                                physicalGrowth = value!;
                              });
                            },
                            activeColor: Color(0xff385a4a),
                          ),
                          checkBoxLabel(label: 'غير طبيعي'),
                        ],
                      ),
                      /**--------------------------------------------- */
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "الأمراض المزمنة:",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Color(0xff6888a0),
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Radio(
                            groupValue: chronicDiseases,
                            value: "القلب",
                            onChanged: (value) {
                              setState(() {
                                chronicDiseases = value!;
                              });
                            },
                            activeColor: Color(0xff385a4a),
                          ),
                          checkBoxLabel(label: 'القلب'),
                          Radio(
                            groupValue: chronicDiseases,
                            value: "السكر",
                            onChanged: (value) {
                              setState(() {
                                chronicDiseases = value!;
                              });
                            },
                            activeColor: Color(0xff385a4a),
                          ),
                          checkBoxLabel(label: 'السكر'),
                          Radio(
                            groupValue: chronicDiseases,
                            value: "الربو",
                            onChanged: (value) {
                              setState(() {
                                chronicDiseases = value!;
                              });
                            },
                            activeColor: Color(0xff385a4a),
                          ),
                          checkBoxLabel(label: 'الربو'),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Radio(
                            groupValue: chronicDiseases,
                            value: "الصرع",
                            onChanged: (value) {
                              setState(() {
                                chronicDiseases = value!;
                              });
                            },
                            activeColor: Color(0xff385a4a),
                          ),
                          checkBoxLabel(label: 'الصرع'),
                          Radio(
                            groupValue: chronicDiseases,
                            value: "التشجنات",
                            onChanged: (value) {
                              setState(() {
                                chronicDiseases = value!;
                              });
                            },
                            activeColor: Color(0xff385a4a),
                          ),
                          checkBoxLabel(label: 'التشنجات'),
                          Radio(
                            groupValue: chronicDiseases,
                            value: "امراض اخرى",
                            onChanged: (value) {
                              setState(() {
                                chronicDiseases = value!;
                              });
                            },
                            activeColor: Color(0xff385a4a),
                          ),
                          checkBoxLabel(label: 'امراض اخرى'),
                        ],
                      ),
                      Visibility(
                        visible: chronicDiseases == "امراض اخرى",
                        child: TextField(
                          onChanged: (value) {
                            chronicdiseasesOtherField = value;
                          },
                          decoration: kStylingInputDec.copyWith(
                              hintText: 'مثال: متلازمة داون'),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'هل خضع الطفل لعلاج سابق؟',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: Color(0xff6888a0),
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Radio(
                            groupValue: previousTreatment,
                            value: "نعم",
                            onChanged: (value) {
                              setState(() {
                                previousTreatment = value!;
                              });
                            },
                            activeColor: Color(0xff385a4a),
                          ),
                          checkBoxLabel(label: 'نعم'),
                          Radio(
                            groupValue: previousTreatment,
                            value: "لا",
                            onChanged: (value) {
                              setState(() {
                                previousTreatment = value!;
                              });
                            },
                            activeColor: Color(0xff385a4a),
                          ),
                          checkBoxLabel(label: 'لا'),
                        ],
                      ),
                      Visibility(
                        visible: previousTreatment == 'نعم',
                        child: TextField(
                          onChanged: (value) {
                            previoustreatmentYesField = value;
                          },
                          decoration: kStylingInputDec.copyWith(
                              hintText: 'مثال: علاج سلوكي'),
                        ),
                      ),
                      /**--------------------------------------------- */
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "الفحوصات والعمليات",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Color(0xff385a4a),
                      fontSize: 18,
                      fontFamily: "Cairo",
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "هل أجريت له فحوصات وأشعة جمجمة ورسم مخ وتحاليل؟",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Color(0xff6888a0),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Radio(
                        groupValue: checkUp,
                        value: "نعم",
                        onChanged: (value) {
                          setState(() {
                            checkUp = value!;
                          });
                        },
                        activeColor: Color(0xff385a4a),
                      ),
                      checkBoxLabel(label: 'نعم'),
                      Radio(
                        groupValue: checkUp,
                        value: "لا",
                        onChanged: (value) {
                          setState(() {
                            checkUp = value!;
                          });
                        },
                        activeColor: Color(0xff385a4a),
                      ),
                      checkBoxLabel(label: 'لا'),
                    ],
                  ),
                  Visibility(
                    visible: checkUp == "نعم",
                    child: TextField(
                      onChanged: (value) {
                        CheckupsYesField = value;
                      },
                      decoration: kStylingInputDec.copyWith(
                          hintText: 'حدد نوع الفحوصات'),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "هل أجريت له عمليات جراحية؟",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Color(0xff6888a0),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Radio(
                        groupValue: Surgery,
                        value: "نعم",
                        onChanged: (value) {
                          setState(() {
                            Surgery = value!;
                          });
                        },
                        activeColor: Color(0xff385a4a),
                      ),
                      checkBoxLabel(label: 'نعم'),
                      Radio(
                        groupValue: Surgery,
                        value: "لا",
                        onChanged: (value) {
                          setState(() {
                            Surgery = value!;
                          });
                        },
                        activeColor: Color(0xff385a4a),
                      ),
                      checkBoxLabel(label: 'لا'),
                    ],
                  ),
                  Visibility(
                    visible: Surgery == "نعم",
                    child: TextField(
                      onChanged: (value) {
                        SurgeryYesField = value;
                      },
                      decoration: kStylingInputDec.copyWith(
                          hintText: 'حدد نوع العمليات'),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "هل خضع لاختبار لتحديد الذكاء؟",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Color(0xff6888a0),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Radio(
                        groupValue: DefiningIntelligence,
                        value: 'نعم',
                        onChanged: (value) {
                          setState(() {
                            DefiningIntelligence = value!;
                          });
                        },
                        activeColor: Color(0xff385a4a),
                      ),
                      checkBoxLabel(label: 'نعم'),
                      Radio(
                        groupValue: DefiningIntelligence,
                        value: "لا",
                        onChanged: (value) {
                          setState(() {
                            DefiningIntelligence = value!;
                          });
                        },
                        activeColor: Color(0xff385a4a),
                      ),
                      checkBoxLabel(label: 'لا'),
                    ],
                  ),
                  Visibility(
                    visible: DefiningIntelligence == 'نعم',
                    child: TextField(
                      onChanged: (value) {
                        IntelligencetestYesField = value;
                      },
                      decoration: kStylingInputDec.copyWith(
                          hintText: "نعم، أذكر النسبة "),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "هل يوجد لدى الطفل حساسية؟",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Color(0xff6888a0),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Radio(
                        groupValue: sensitive,
                        value: "نعم",
                        onChanged: (value) {
                          setState(() {
                            sensitive = value!;
                          });
                        },
                        activeColor: Color(0xff385a4a),
                      ),
                      checkBoxLabel(label: 'نعم'),
                      Radio(
                        groupValue: sensitive,
                        value: "لا",
                        onChanged: (value) {
                          setState(() {
                            sensitive = value!;
                          });
                        },
                        activeColor: Color(0xff385a4a),
                      ),
                      checkBoxLabel(label: 'لا'),
                    ],
                  ),
                  Visibility(
                    visible: sensitive == "نعم",
                    child: TextField(
                      onChanged: (value) {
                        allergyYesField = value;
                      },
                      decoration: kStylingInputDec.copyWith(
                          hintText: 'اذكر نوع الحساسية'),
                    ),
                  ),
                  SizedBox(
                    height: 37,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 25),
                    child: Align(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                minimumSize: Size(180, 45),
                                backgroundColor: Color(0xff394445),
                                elevation: 3,
                                shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                )),
                            onPressed: () async {
                              // late final childid = uuid.v4();
                              // try {
                              //   AddChildData(
                              //       ParentName: ParentNmae,
                              //       name: _name,
                              //       BirthDate: date,
                              //       ChildEducationalLevel: _EducationalLevel,
                              //       chronicdiseasesOtherField: chronicDiseases == "لا"
                              //           ? "لا يوجد"
                              //           : chronicdiseasesOtherField,
                              //       previoustreatmentYesField:
                              //           previousTreatment == "لا"
                              //               ? "لا يوجد"
                              //               : previoustreatmentYesField,
                              //       CheckupsYesField: checkUp == "لا"
                              //           ? "لا يوجد"
                              //           : CheckupsYesField,
                              //       SurgeryYesField: SurgeryYesField,
                              //       IntelligencetestYesField:
                              //           IntelligencetestYesField,
                              //       allergyYesField: allergyYesField,
                              //       uid: childid,
                              //       uidParent: ParentId,
                              //       Movement: Movement,
                              //       personalBehaviour: personalBehaviour,
                              //       emotionalBehaviour: emotionalBehaviour,
                              //       understanding: understanding,
                              //       dispersion: dispersion,
                              //       visualCommunication: visualCommunication,
                              //       Agressive: Agressive,
                              //       fear: fear,
                              //       cooperating: cooperating,
                              //       visualCondition: visualCondition,
                              //       auditoryCondition: auditoryCondition,
                              //       expressionLevel: expressionLevel,
                              //       LetteringLevel: LetteringLevel,
                              //       MotionClassification: MotionClassification,
                              //       physicalGrowth: physicalGrowth,
                              //       chronicDiseases: chronicDiseases,
                              //       previousTreatment: previousTreatment,
                              //       checkUp: checkUp,
                              //       Surgery: Surgery,
                              //       DefiningIntelligence: DefiningIntelligence,
                              //       sensitive: sensitive);
                              // setState(() {
                              //   Navigator.push(
                              //       context,
                              //       MaterialPageRoute(
                              //           builder: (context) =>
                              //               MyBottomNavigationBar()));
                              // });
                              // } catch (e) {
                              //   print(e);
                              // }

                              late final childid = uuid.v4();
                              final isSaved = await FirebaseHelperChild.saveUser(
                                  ParentName: ParentName,
                                  name: _name,
                                  BirthDate: date,
                                  ChildEducationalLevel: _EducationalLevel,
                                  chronicdiseasesOtherField:
                                      chronicDiseases == ""
                                          ? chronicdiseasesOtherField
                                          : chronicDiseases.toString(),
                                  previoustreatmentYesField:
                                      previousTreatment == "لا"
                                          ? ""
                                          : previoustreatmentYesField,
                                  CheckupsYesField:
                                      checkUp == "لا" ? "" : CheckupsYesField,
                                  SurgeryYesField:
                                      Surgery == "لا" ? "" : SurgeryYesField,
                                  IntelligencetestYesField:
                                      DefiningIntelligence == "لا"
                                          ? ""
                                          : IntelligencetestYesField,
                                  allergyYesField:
                                      sensitive == "لا" ? "" : allergyYesField,
                                  uid: childid,
                                  uidParent: ParenId,
                                  Movement: Movement,
                                  personalBehaviour: personalBehaviour,
                                  emotionalBehaviour: emotionalBehaviour,
                                  understanding: understanding,
                                  dispersion: dispersion,
                                  visualCommunication: visualCommunication,
                                  Agressive: Agressive,
                                  fear: fear,
                                  cooperating: cooperating,
                                  visualCondition: visualCondition,
                                  auditoryCondition: auditoryCondition,
                                  expressionLevel: expressionLevel,
                                  LetteringLevel: LetteringLevel,
                                  MotionClassification: MotionClassification,
                                  physicalGrowth: physicalGrowth,
                                  chronicDiseases: chronicDiseases,
                                  previousTreatment: previousTreatment,
                                  checkUp: checkUp,
                                  Surgery: Surgery,
                                  DefiningIntelligence: DefiningIntelligence,
                                  sensitive: sensitive,
                                  ChildAvatar: ChildAvatar);
                              if (isSaved) {
                                setState(() {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              MyBottomNavigationBar()));
                                });
                              }
                            },
                            child: Text(
                              'انشاء حساب الطفل',
                              style: TextStyle(
                                color: Color(0xffF8F8F8),
                                fontSize: 14,
                                fontFamily: "Cairo",
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              )))),
    );
  }
}

class checkBoxLabel extends StatelessWidget {
  late String label;
  checkBoxLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      textAlign: TextAlign.right,
      style: TextStyle(
        color: Color(0xff030d1c),
        fontSize: 14,
        fontFamily: "Cairo",
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
