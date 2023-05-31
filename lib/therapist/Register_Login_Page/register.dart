import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:eloquentapp/screens/constants.dart';
import 'package:eloquentapp/screens/welcome.dart';
import 'package:eloquentapp/services/firebase_helper.dart';
import 'package:eloquentapp/widget/drop_down_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:input_quantity/input_quantity.dart';
import 'package:drop_down_list/model/selected_list_item.dart';

class ThtRegistration extends StatefulWidget {
  static String id = 'Therapistregistration_screen';

  const ThtRegistration({super.key});

  @override
  State<ThtRegistration> createState() => _ThtRegistrationState();
}

class _ThtRegistrationState extends State<ThtRegistration> {
  //varibale
  late String name;
  late String email;
  late String pass;
  late String ConfirmPass;
  late String phone;
  late String GeneralInfo;
  late String YearsofExperience;
  late String duration;
  late String JobTitle;
  late String TherapistAvatar = '';
  var active = false;
  var arabicLanguage = false;
  var englishLanguage = false;
  var incenter = false;
  var online = false;
  bool _isPasswordConfirmVisible = false;
  bool _isPasswordVisible = false;
  String? _errorMessage;
  Color _iconColor = Colors.grey; // default color
  Color _iconColor2 = Colors.grey; // default color

  //Confirm Password
  bool passwordConfermd() {
    if (pass == ConfirmPass) {
      return true;
    } else {
      print('pass not match');
      return false;
    }
  }

  final _formKey = GlobalKey<FormState>();

  // الدروب داون ليست
  TextEditingController dropname = TextEditingController();
  TextEditingController dropid = TextEditingController();

  List<SelectedListItem> data = [];

  getCenterNames() async {
    QuerySnapshot<Map<String, dynamic>> center =
        await FirebaseFirestore.instance.collection("center").get();
    for (var element in center.docs) {
      data.add(SelectedListItem(name: element['name'], value: element.id));
    }
  }

  @override
  void initState() {
    getCenterNames();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'إنشاء حساب  ',
                      style: TextStyle(
                        color: Color(0xff394445),
                        fontSize: 25,
                        fontFamily: "Cairo",
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(
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
                                TherapistAvatar = "images/TherpistWomen.png";
                              });

                              setState(() {
                                print(TherapistAvatar);
                              });
                            },
                            child: Transform.scale(
                              scale:
                                  TherapistAvatar == "images/TherpistWomen.png"
                                      ? 1.2
                                      : 1.0,
                              child: Image.asset(
                                "images/TherpistWomen.png",
                                width: 80,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                TherapistAvatar = "images/TherpisMan.png";
                              });

                              setState(() {
                                print(TherapistAvatar);
                              });
                            },
                            child: Transform.scale(
                              scale: TherapistAvatar == "images/TherpisMan.png"
                                  ? 1.2
                                  : 1.0,
                              child: Image.asset(
                                "images/TherpisMan.png",
                                width: 80,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'الأسم',
                        style: SStyleTextOfTextFeild,
                      )),
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
                    onChanged: (value) {
                      name = value;

                      // name = value;
                    },
                    decoration: kStylingInputDec,
                  ),

                  const SizedBox(
                    height: 15,
                  ),
                  //email Text Filed
                  const Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'البريد الإلكتروني',
                        style: SStyleTextOfTextFeild,
                      )),
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
                    onChanged: (value) {
                      email = value;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: kStylingInputDec.copyWith(
                      hintText: 'example@gmail.com',
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  //Pass Text Filed
                  const Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'كلمة المرور',
                        style: SStyleTextOfTextFeild,
                      )),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'الرجاء ادخال كلمة المرور';
                      }
                      return null;
                    },
                    obscureText: !_isPasswordVisible,
                    onChanged: (value) {
                      pass = value;
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xff385a4a), width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xff385a4a), width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
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
                                : Colors.grey; // change color based on state
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  //Confirm Pass Text Filed
                  const Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'إعادة كلمة المرور',
                        style: SStyleTextOfTextFeild,
                      )),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'الرجاء تاكيد كلمة المرور ';
                      }
                      return null;
                    },
                    obscureText: !_isPasswordConfirmVisible,
                    onChanged: (value) {
                      ConfirmPass = value;
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xff385a4a), width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xff385a4a), width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
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
                                : Colors.grey; // change color based on state
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'رقم الجوال',
                        style: SStyleTextOfTextFeild,
                      )),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                      maxLength: 10,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'الرجاء ادخال رفم الجوال';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        phone = value;
                      },
                      keyboardType: TextInputType.phone,
                      decoration: kStylingInputDec.copyWith(
                        //hintText: '+966 535 241 724',
                        hintStyle: const TextStyle(
                            color: Color.fromARGB(170, 158, 158, 158)),
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  const Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'معلومات أساسية   ',
                      style: TextStyle(
                        color: Color(0xff394445),
                        fontSize: 25,
                        fontFamily: "Cairo",
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'اختر المركز الخاص بالأخصائي',
                        style: SStyleTextOfTextFeild,
                      )),
                  SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                      height: 45,
                      child: DropDownList(
                        title: "المراكز",
                        data: data,
                        id: dropid,
                        name: dropname,
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  // JobTitle
                  const Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'المسمى الوظيفي',
                        style: SStyleTextOfTextFeild,
                      )),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'الرجاء اكمال الحقل ';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      JobTitle = value;
                    },
                    decoration: kStylingInputDec,
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  const Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      'نبذة عامة عن الاخصائي ',
                      style: SStyleTextOfTextFeild,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    height: 200,
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'الرجاء اكمال الحقل ';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      expands: true,
                      onChanged: (value) {
                        GeneralInfo = value;
                      },
                      decoration: kStylingInputDec,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "سنوات الخبرة",
                        style: SStyleTextOfTextFeild,
                      )),
                  SizedBox(
                    height: 15,
                  ),
                  InputQty(
                    maxVal: 100,
                    minVal: 0,
                    initVal: 0,
                    isIntrinsicWidth: false,
                    onQtyChanged: (val) {
                      YearsofExperience = val.toString();
                      print(YearsofExperience);
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "مدة الجلسة ",
                        style: SStyleTextOfTextFeild,
                      )),
                  SizedBox(
                    height: 15,
                  ),
                  InputQty(
                    maxVal: 100,
                    minVal: 0,
                    initVal: 0,
                    isIntrinsicWidth: false,
                    onQtyChanged: (val) {
                      duration = val.toString();
                      print(duration);
                    },
                  ),
                  const Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "اللغات",
                        style: SStyleTextOfTextFeild,
                      )),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Checkbox(
                          activeColor: Color(0xff385a4a),
                          value: englishLanguage,
                          onChanged: (value) {
                            setState(() {
                              englishLanguage = value!;
                            });
                          }),
                      const Text("اللغة العربية"),
                      SizedBox(
                        width: 12,
                      ),
                      Checkbox(
                          activeColor: Color(0xff385a4a),
                          value: arabicLanguage,
                          onChanged: (value) {
                            setState(() {
                              arabicLanguage = value!;
                            });
                          }),
                      const Text("اللغة الانجليزية"),
                    ],
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  const Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "تقديم الاستشارات",
                        style: SStyleTextOfTextFeild,
                      )),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Checkbox(
                          activeColor: Color(0xff385a4a),
                          value: online,
                          onChanged: (value) {
                            setState(() {
                              online = value!;
                            });
                          }),
                      const Text("في المركز"),
                      SizedBox(
                        width: 20,
                      ),
                      Checkbox(
                          activeColor: Color(0xff385a4a),
                          value: incenter,
                          onChanged: (value) {
                            setState(() {
                              incenter = value!;
                            });
                          }),
                      const Text("عن بعد"),
                    ],
                  ),
                  if (_errorMessage != null)
                    Text(
                      _errorMessage!,
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                  SizedBox(
                    height: 17.63,
                  ),
                  Center(
                    child: SizedBox(
                      width: 110,
                      height: 38,
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
                          //valditae
                          if (_formKey.currentState!.validate()) {
                            if (passwordConfermd()) {
                              try {
                                QuerySnapshot<Map<String, dynamic>> temp =
                                    await FirebaseFirestore.instance
                                        .collection("center")
                                        .where("name", isEqualTo: dropname.text)
                                        .get();

                                final String centerUID = temp.docs[0]["uid"];

                                final isSaved =
                                    await FirebaseHelperTherapist.saveUser(
                                        email: email,
                                        password: pass,
                                        name: name,
                                        phone: phone,
                                        GeneralInfo: GeneralInfo,
                                        duration: duration,
                                        YearsofExperience: YearsofExperience,
                                        arabicLanguage: arabicLanguage,
                                        englishLanguage: englishLanguage,
                                        incenter: incenter,
                                        online: online,
                                        JobTitle: JobTitle,
                                        active: active,
                                        centerid: centerUID,
                                        centerName: dropname.text,
                                        TherapistAvatar: TherapistAvatar);
                                setState(() {
                                  _errorMessage = '';
                                });

                                if (isSaved) {
                                  Navigator.pushNamed(
                                      context, WelcomeScreen.id);

                                  AwesomeDialog(
                                      dialogType: DialogType.noHeader,
                                      context: context,
                                      title: "نجاح",
                                      body: Container(
                                        //تعديل الشكل
                                        child: Column(
                                          children: [
                                            Image.asset(
                                              'images/True.png',
                                              height: 70,
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            const Text(
                                              " تمت إرسال الطلب للمركز بنجاح, ستصلك رسالة القبول/الرفض على الايميل ",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontFamily: 'Cairo',
                                                  fontSize: 16),
                                            ),
                                            SizedBox(
                                              height: 30,
                                            )
                                          ],
                                        ),
                                      )).show();
                                }

                                // AwesomeDialog(
                                // dialogType: DialogType.noHeader,
                                // context: context,
                                // title: "فشل",
                                // body: const SizedBox(
                                // height: 50,
                                // child: Text("الايميل مستخدم"),
                                // )).show();

                              } on FirebaseAuthException catch (e) {
                                if (e.code == 'user-not-found' ||
                                    e.code == 'wrong-password') {
                                  setState(() {
                                    _errorMessage =
                                        'الايميل او كلمة السر غير صحيحة';
                                  });
                                }
                                /*
                                  AwesomeDialog(
                                      dialogType: DialogType.noHeader,
                                      context: context,
                                      title: "فشل",
                                      body: const SizedBox(
                                        height: 50,
                                        child: Text("فشل انشاء الحاسب"),
                                      )).show();
                                      */
                              }
                            } else {
                              setState(() {
                                _errorMessage =
                                    ' كلمة المرور غير متطابقة، الرجاء المحاولة مرا اخرى';
                              });
                            }
                          }
                        },

                        // }

                        child: Align(
                            alignment: Alignment.center, child: Text('أرسال')),
                      ),
                    ),
                  ),
                  /*
                  ElevatedButton(
                      onPressed: () async {
                        //valditae
                        if (passwordConfermd()) {
                          if (passwordConfermd()) {
                            try {
                              QuerySnapshot<Map<String, dynamic>> temp =
                                  await FirebaseFirestore.instance
                                      .collection("center")
                                      .where("name", isEqualTo: dropname.text)
                                      .get();
    
                              final String centerUID = temp.docs[0]["uid"];
    
                              final isSaved =
                                  await FirebaseHelperTherapist.saveUser(
                                      email: email,
                                      password: pass,
                                      name: name,
                                      phone: phone,
                                      GeneralInfo: GeneralInfo,
                                      duration: duration,
                                      YearsofExperience: YearsofExperience,
                                      arabicLanguage: arabicLanguage,
                                      englishLanguage: englishLanguage,
                                      incenter: incenter,
                                      online: online,
                                      JobTitle: JobTitle,
                                      active: active,
                                      centerid: centerUID);
    
                              print(isSaved);
                              Navigator.pushNamed(
                                  //تتعدل بعدين
                                  context,
                                  WelcomeScreen.id);
                              AwesomeDialog(
                                  dialogType: DialogType.noHeader,
                                  context: context,
                                  title: "نجاح",
                                  body: Container(
                                    height: 50,
                                    child: const Text("تمت اضافة الاخصائي بنجاح"),
                                  )).show();
                            } catch (e) {
                              AwesomeDialog(
                                  dialogType: DialogType.noHeader,
                                  context: context,
                                  title: "فشل",
                                  body: const SizedBox(
                                    height: 50,
                                    child: Text("حدث خطأ ما"),
                                  )).show();
                              print(e);
                            }
                          }
                        } //
                      },
                      child: Align(
                          alignment: Alignment.center, child: Text('أرسال')),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff385a4a),
                      )),
                      */
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
