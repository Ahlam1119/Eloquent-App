import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eloquentapp/parents/BottomNavBar.dart';
import 'package:eloquentapp/parents/Register_Login_Page/child_Registration.dart';
import 'package:eloquentapp/screens/constants.dart';
import 'package:eloquentapp/services/firebase_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class stepperView extends StatefulWidget {
  const stepperView({super.key});

  @override
  State<stepperView> createState() => _stepperViewState();
}

class _stepperViewState extends State<stepperView> {
  var uuid = Uuid();
  DateTime date = DateTime.now();
  bool _isPasswordVisible = false;
  bool _isPasswordConfirmVisible = false;
  String? _errorMessage;
  late String _name;
  late String ParentAvatar = '';
  late final String chronicdiseasesOtherField;
  late final String CheckupsYesField;
  late final String SurgeryYesField;
  late final String IntelligencetestYesField;
  late final String allergyYesField;
  var _previoustreatmentYes;
  late final String previoustreatmentYesField;
  var _previoustreatmentNo;
/*----------------------------------*/
  late String ChildAvatar = '';
  Color _iconColor = Colors.grey; // default color
  Color _iconColor2 = Colors.grey;
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
  late String name;
  late String email;
  late String pass;
  late String ConfirmPass;
  late String phone;
  final _formKey = GlobalKey<FormState>();

  bool passwordConfermd() {
    if (pass == ConfirmPass) {
      return true;
    } else {
      print('pass not match');
      return false;
    }
  }

  void initState() {
    super.initState();
    getCurrentUser();
  }

  final _auth = FirebaseAuth.instance;

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

  late String ParentId;
  late String ParentNmae;
  AddData({
    required String name,
    required String email,
    required String pass,
    required String phone,
    required String uid,
    required String ParentAvatar,
  }) async {
    final DocumentReference<Map<String, dynamic>> userRef =
        FirebaseFirestore.instance.collection('Parent').doc(uid);

    await userRef.set({
      "ParentAvatar": ParentAvatar,
      "name": name,
      'uid': uid,
      'email': email,
      'password': pass,
      "phone": phone
    });
    setState(() {
      ParentId = uid;
      ParentNmae = name;
    });
  }

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
              onPrimary: Color.fromARGB(255, 255, 255,
                  255), // Set the color of the header in the date picker dialog
            ),
            textTheme: TextTheme(
              subtitle1: TextStyle(
                color: Color.fromARGB(255, 255, 255,
                    255), // Set the color of the text in the date picker dialog
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

  int currenStep = 0;
  List<Step> getSteps() => [
        Step(
            state: currenStep > 0 ? StepState.complete : StepState.disabled,
            isActive: currenStep >= 0,
            title: Text(
              " بيانات الوالدين",
              textAlign: TextAlign.start,
            ),
            // subtitle: Text(
            // " بيانات الوالدين",

            content: Padding(
              padding: const EdgeInsets.all(4),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "تسجيل بيانات الوالدين",
                        style: TextStyle(
                          color: Color(0xff394445),
                          fontSize: 20,
                          fontFamily: "Cairo",
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: 15,
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
                                    ParentAvatar = "images/Mother.png";
                                  });
                                  setState(() {
                                    print(ParentAvatar);
                                  });
                                },
                                child: Transform.scale(
                                  scale: ParentAvatar == "images/Mother.png"
                                      ? 1.3
                                      : 1.0,
                                  child: Image.asset(
                                    "images/Mother.png",
                                    width: 80,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 25,
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    ParentAvatar = "images/Father.png";
                                  });
                                  setState(() {
                                    print(ParentAvatar);
                                  });
                                },
                                child: Transform.scale(
                                  scale: ParentAvatar == "images/Father.png"
                                      ? 1.3
                                      : 1.0,
                                  child: Image.asset(
                                    "images/Father.png",
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
                      //Name Text Filed
                      Text('الأسم',
                          textAlign: TextAlign.center,
                          style: SStyleTextOfTextFeild),
                      SizedBox(
                        height: 14,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'الرجاء ادخال الاسم';
                          }
                          return null;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        onChanged: (value) {
                          name = value;
                        },
                        decoration: kStylingInputDec,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      //Email Text Filed
                      Text('البريد الإلكتروني',
                          textAlign: TextAlign.center,
                          style: SStyleTextOfTextFeild),
                      SizedBox(
                        height: 14,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'الرجاء ادخال البريد الالكتروني';
                          }
                          return null;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        onChanged: (value) {
                          email = value;
                        },
                        decoration: kStylingInputDec,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      //phone Text Filed
                      Text('رقم الجوال',
                          textAlign: TextAlign.center,
                          style: SStyleTextOfTextFeild),
                      SizedBox(
                        height: 14,
                      ),
                      TextFormField(
                          maxLength: 10,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'الرجاء ادخال رقم الجوال ';
                            }
                            return null;
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          onChanged: (value) {
                            phone = value;
                          },
                          keyboardType: TextInputType.phone,
                          decoration: kStylingInputDec.copyWith(
                            hintText: '+966 535 241 724',
                            hintStyle: TextStyle(
                                color: Color.fromARGB(170, 158, 158, 158)),
                          )),
                      //pass Text Filed
                      SizedBox(
                        height: 15,
                      ),
                      Text('كلمة المرور',
                          textAlign: TextAlign.center,
                          style: SStyleTextOfTextFeild),
                      SizedBox(
                        height: 14,
                      ),
                      TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'الرجاء ادخال كلمة المرور';
                            }
                            return null;
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          obscureText: !_isPasswordVisible,
                          onChanged: (value) {
                            pass = value;
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 20.0),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xff385a4a), width: 1.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xff385a4a), width: 2.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: _iconColor,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible;
                                  _iconColor = _isPasswordVisible
                                      ? Color(0xff385a4a)
                                      : Colors
                                          .grey; // change color based on state
                                });
                              },
                            ),
                          )),
                      SizedBox(
                        height: 15,
                      ),
                      //Confirm Pass Text Filed
                      Text('إعادة كلمة المرور',
                          textAlign: TextAlign.center,
                          style: SStyleTextOfTextFeild),
                      SizedBox(
                        height: 14,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'الرجاء اعادة كلمة المرور ';
                          }
                          return null;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        obscureText: !_isPasswordConfirmVisible,
                        onChanged: (value) {
                          ConfirmPass = value;
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xff385a4a), width: 1.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xff385a4a), width: 2.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordConfirmVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: _iconColor2,
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordConfirmVisible =
                                    !_isPasswordConfirmVisible;
                                _iconColor2 = _isPasswordConfirmVisible
                                    ? Color(0xff385a4a)
                                    : Colors
                                        .grey; // change color based on state
                              });
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 17.63,
                      ),
                      if (_errorMessage != null)
                        Text(
                          _errorMessage!,
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                      Center(
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                minimumSize: Size(110, 38),
                                backgroundColor: Color(0xff394445),
                                elevation: 3,
                                shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                )),
                            onPressed: () async {
                              print('Button pressed');
                              if (_formKey.currentState!.validate()) {
                                if (passwordConfermd()) {
                                  try {
                                    final UserCredential newUser =
                                        await FirebaseAuth.instance
                                            .createUserWithEmailAndPassword(
                                                email: email, password: pass);
                                    if (newUser.user == null) {
                                      print("User not found");
                                      return;
                                    } else {
                                      AddData(
                                        ParentAvatar: ParentAvatar,
                                        name: name,
                                        email: email,
                                        pass: pass,
                                        phone: phone,
                                        uid: newUser.user!.uid,
                                      );
                                      setState(() {
                                        currenStep += 1;
                                      });
                                    }
                                  } on FirebaseAuthException catch (e) {
                                    print('FirebaseAuthException: ${e.code}');
                                    if (e.code == 'user-not-found' ||
                                        e.code == 'wrong-password') {
                                      setState(() {
                                        _errorMessage =
                                            'الايميل او كلمة السر غير صحيحة';
                                      });
                                    } else {
                                      print('Unhandled FirebaseAuthException');
                                    }
                                  } catch (e) {
                                    print('Error: $e');
                                  }
                                } else {
                                  setState(() {
                                    _errorMessage =
                                        ' كلمة المرور غير متطابقة، الرجاء المحاولة مرا اخرى';
                                  });
                                }
                              } else {
                                print('Form validation failed');
                              }
                            },
                            child: Text('التالي')),
                      ),
                    ],
                  ),
                ),
              ),
            )),
        Step(
          state: currenStep > 0 ? StepState.complete : StepState.disabled,
          isActive: currenStep == 1,
          title: Text("بيانات الطفل "),
          content: SingleChildScrollView(
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
                          scale:
                              ChildAvatar == "images/CuteBoy.png" ? 1.2 : 1.0,
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
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
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
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Align widgets to the left edge

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
                  decoration:
                      kStylingInputDec.copyWith(hintText: 'حدد نوع الفحوصات'),
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
                  decoration:
                      kStylingInputDec.copyWith(hintText: 'حدد نوع العمليات'),
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
                  decoration:
                      kStylingInputDec.copyWith(hintText: "نعم، أذكر النسبة "),
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
                  decoration:
                      kStylingInputDec.copyWith(hintText: 'اذكر نوع الحساسية'),
                ),
              ),
              SizedBox(
                height: 37,
              ),
              Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size(180, 45),
                          backgroundColor: Color(0xff394445),
                          elevation: 3,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
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
                            ParentName: ParentNmae,
                            name: _name,
                            BirthDate: date,
                            ChildEducationalLevel: _EducationalLevel,
                            chronicdiseasesOtherField: chronicDiseases == ""
                                ? chronicdiseasesOtherField
                                : chronicDiseases.toString(),
                            previoustreatmentYesField: previousTreatment == "لا"
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
                            uidParent: ParentId,
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
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(247, 38),
                        backgroundColor: Color.fromARGB(255, 252, 250, 250),
                        elevation: 0,
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyBottomNavigationBar()));
                      },
                      child: Text(
                        'تخطي',
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: "Cairo",
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                    ),
                  ],
                ),
              )
            ],
          )),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        body: SafeArea(
            child: Theme(
          data: Theme.of(context).copyWith(
              // colorScheme: ColorScheme.fromSwatch(
              // primarySwatch: Color.fromARGB(56, 90, 64, 47),
              // accentColor: Colors.green,
              // backgroundColor: Color.fromARGB(255, 179, 47, 47),
              // errorColor: Colors.red,
              // )),
              colorScheme: ColorScheme.light(
            primary: Color(0xff385a4a),
            background: Colors.red,
          )),
          child: Stepper(
            onStepTapped: (step) => setState(() {
              currenStep = step;
              // direction:
              // AxisDirection.right;
            }),
            type: StepperType.horizontal,
            steps: getSteps(),
            currentStep: currenStep,
            controlsBuilder: (context, details) {
              return Column(
                children: [
                  TextButton(onPressed: () {}, child: Text("")),
                  TextButton(onPressed: () {}, child: Text("")),
                ],
              );
            },
            // onStepContinue: () {
            // setState(() {
            // if (currenStep < 2) {
            // currenStep += 1;
            // }
            // });
            // },
            // onStepCancel: () {
            // setState(() {
            // if (currenStep > 0) {
            // currenStep -= 1;
            // }
            // });
            // },
            // onStepContinue: () {
            // final isLastStep = currenStep == getSteps().length - 1;
            // if (isLastStep) {
            // Navigator.push(
            // context,
            // MaterialPageRoute(
            // builder: (context) => LoginScreen(),
            // ));
            // } else {
            // setState(() {
            // currenStep += 1;
            // });
            // }
            // },
            // onStepCancel:
            // currenStep == 0 ? null : () => setState(() => currenStep -= 1),
            // controlsBuilder: (context, {onStepContinue, onStepCancel}) {
            // return Container();
            // },
          ),
        )),
      ),
    );
  }
}
