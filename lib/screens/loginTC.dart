import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eloquentapp/Admin/home_Screen.dart';
import 'package:eloquentapp/center/center_information.dart';
import 'package:eloquentapp/center/vavBarCenter.dart';
import 'package:eloquentapp/screens/constants.dart';
import 'package:eloquentapp/therapist/Register_Login_Page/register.dart';
import 'package:eloquentapp/therapist/bottomNavbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class loginTC extends StatefulWidget {
  static String id = 'loginTC_screen';
  @override
  State<loginTC> createState() => _loginTCState();
}

class _loginTCState extends State<loginTC> {
  final auth = FirebaseAuth.instance;
  late String email;
  late String pass;
  bool _isPasswordVisible = false;
  String? _errorMessage;
  final _formKey = GlobalKey<FormState>();
  Color _iconColor = Colors.grey; // default color

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
          body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(
                height: 100,
              ),
              const Text(
                'تسجيل الدخول',
                style: TextStyle(
                  color: Color(0xff385a4a),
                  fontSize: 28,
                  fontFamily: "Cairo",
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Expanded(
                child: DefaultTabController(
                  length: 1,
                  child: Column(children: [
                    Expanded(
                      child: TabBarView(
                        children: [
                          TabControler(
                            tab1: Text('المركز'),
                            tab2: Text('الأخصائي'),
                            widget1: ListView(
                              children: [
                                //المركز
                                GestureDetector(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      const SizedBox(height: 55),
                                      /**------------------Email Text Filed---------------------------**/
                                      const Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          'البريد الإلكتروني',
                                          textAlign: TextAlign.end,
                                          style: TextStyle(
                                            color: Color(0xff385a4a),
                                            fontSize: 14,
                                            fontFamily: "Cairo",
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      TextFormField(
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return " الرجاء ادخال البريد الالكتروني";
                                            }
                                          },
                                          onChanged: (value) {
                                            email = value;
                                          },
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          decoration: kStylingInputDec.copyWith(
                                            hintText: 'example@gmail.com',
                                          )),
                                      const SizedBox(
                                        height: 17.17,
                                      ),
                                      /**--------------------pass Text Filed-------------------------**/
                                      const Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          'كلمة المرور',
                                          textAlign: TextAlign.end,
                                          style: TextStyle(
                                            color: Color(0xff385a4a),
                                            fontSize: 14,
                                            fontFamily: "Cairo",
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      TextFormField(
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "الرجاء ادخال كلمة المرور";
                                          }
                                        },
                                        obscureText: !_isPasswordVisible,
                                        onChanged: (value) {
                                          pass = value;
                                        },
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 10.0, horizontal: 20.0),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10.0)),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color(0xff385a4a),
                                                width: 1.0),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10.0)),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color(0xff385a4a),
                                                width: 2.0),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10.0)),
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
                                                _isPasswordVisible =
                                                    !_isPasswordVisible;
                                                _iconColor = _isPasswordVisible
                                                    ? Color(0xff385a4a)
                                                    : Colors
                                                        .grey; // change color based on state
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        const ForgotPassword(),
                                                  ));
                                            },
                                            child: const Text(
                                                'نسيت كلمة المرور؟ اضغط هنا',
                                                style: TextStyle(
                                                  color: Color(0xff385a4a),
                                                )),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      /**---------------------------------------------**/
                                      if (_errorMessage != null)
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: Text(
                                            _errorMessage!,
                                            style: TextStyle(
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  minimumSize:
                                                      const Size(247, 37),
                                                  backgroundColor:
                                                      const Color(0xff394445),
                                                  elevation: 3,
                                                  shape:
                                                      const RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(6)),
                                                  )),
                                              onPressed: () async {
                                                if (_formKey.currentState!
                                                    .validate()) {
                                                  if (email != 'gg@gmail.com') {
                                                    try {
                                                      UserCredential user =
                                                          await FirebaseAuth
                                                              .instance
                                                              .signInWithEmailAndPassword(
                                                                  email: email,
                                                                  password:
                                                                      pass);

                                                      // نجيب البيانات من الفايربيس ونخزنها في متغير ستاتيك عشان نقدر نستخدمها بعدين
                                                      QuerySnapshot temp =
                                                          await FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  'center')
                                                              .where('uid',
                                                                  isEqualTo:
                                                                      user.user!
                                                                          .uid)
                                                              .get();

                                                      CenterInformation.uid =
                                                          user.user!.uid;
                                                      CenterInformation.email =
                                                          temp.docs[0]['email'];
                                                      CenterInformation.name =
                                                          temp.docs[0]['name'];
                                                      // ignore: use_build_context_synchronously
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  MyBottomNavigationBar()));
                                                      setState(() {
                                                        _errorMessage = '';
                                                      });
                                                    } on FirebaseAuthException catch (e) {
                                                      if (e.code ==
                                                              'user-not-found' ||
                                                          e.code ==
                                                              'wrong-password') {
                                                        setState(() {
                                                          _errorMessage =
                                                              'الايميل او كلمة السر غير صحيحة';
                                                        });
                                                      }
                                                    }
                                                  } else {
                                                    FirebaseAuth.instance
                                                        .signInWithEmailAndPassword(
                                                            email: email,
                                                            password: pass)
                                                        .then((value) => Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        HomeScreen())))
                                                        .catchError((e) {
                                                      print(e);
                                                    });
                                                  }
                                                }
                                              },
                                              child:
                                                  const Text('تسجيل الدخول')),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            /////////////////////////////////////////////

                            //الاخصائي
                            widget2: ListView(
                              children: [
                                GestureDetector(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      const SizedBox(height: 55),
                                      /**---------------------------------------------**/
                                      const Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          'البريد الإلكتروني',
                                          textAlign: TextAlign.end,
                                          style: TextStyle(
                                            color: Color(0xff385a4a),
                                            fontSize: 14,
                                            fontFamily: "Cairo",
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      TextFormField(
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'الرجاء ادخال البريد الالكتروني ';
                                            }
                                          },
                                          onChanged: (value) {
                                            email = value;
                                          },
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          decoration: kStylingInputDec.copyWith(
                                            hintText: 'example@gmail.com',
                                          )),
                                      const SizedBox(
                                        height: 17.17,
                                      ),
                                      /**---------------------------------------------**/
                                      const Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          'كلمة المرور',
                                          textAlign: TextAlign.end,
                                          style: TextStyle(
                                            color: Color(0xff385a4a),
                                            fontSize: 14,
                                            fontFamily: "Cairo",
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      TextFormField(
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'الرجاء ادخال كلمة المرور ';
                                          }
                                        },
                                        obscureText: !_isPasswordVisible,
                                        onChanged: (value) {
                                          pass = value;
                                        },
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 10.0, horizontal: 20.0),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10.0)),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color(0xff385a4a),
                                                width: 1.0),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10.0)),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color(0xff385a4a),
                                                width: 2.0),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10.0)),
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
                                                _isPasswordVisible =
                                                    !_isPasswordVisible;
                                                _iconColor = _isPasswordVisible
                                                    ? Color(0xff385a4a)
                                                    : Colors
                                                        .grey; // change color based on state
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        const ForgotPassword(),
                                                  ));
                                            },
                                            child: const Text(
                                                'نسيت كلمة المرور؟اضغط هنا',
                                                style: TextStyle(
                                                  color: Color(0xff385a4a),
                                                )),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      /**---------------------------------------------**/
                                      if (_errorMessage != null)
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: Text(
                                            _errorMessage!,
                                            style: TextStyle(
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  minimumSize:
                                                      const Size(247, 37),
                                                  backgroundColor:
                                                      const Color(0xff394445),
                                                  elevation: 3,
                                                  shape:
                                                      const RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(6)),
                                                  )),
                                              onPressed: () async {
                                                if (_formKey.currentState!
                                                    .validate()) {
                                                  if (email != 'gg@gmail.com') {
                                                    FirebaseAuth.instance
                                                        .signInWithEmailAndPassword(
                                                            email: email,
                                                            password: pass)
                                                        .then((value) async {
                                                      QuerySnapshot temp =
                                                          await FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  "Therapist")
                                                              .where("email",
                                                                  isEqualTo:
                                                                      email)
                                                              .get();

                                                      if (temp.docs[0]
                                                          ['active']) {
                                                        return Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        navBarForTherapist()));
                                                      } else {
                                                        AwesomeDialog(
                                                            dialogType:
                                                                DialogType
                                                                    .noHeader,
                                                            context: context,
                                                            title: "فشل",
                                                            body:
                                                                const SizedBox(
                                                              height: 50,
                                                              child: Text(
                                                                  "الحساب غير مفعل"),
                                                            )).show();
                                                      }
                                                    }).catchError((e) {
                                                      if (e.code ==
                                                              'user-not-found' ||
                                                          e.code ==
                                                              'wrong-password') {
                                                        setState(() {
                                                          _errorMessage =
                                                              'الايميل او كلمة السر غير صحيحة';
                                                        });
                                                      }
                                                    });
                                                  } else {
                                                    FirebaseAuth.instance
                                                        .signInWithEmailAndPassword(
                                                            email: email,
                                                            password: pass)
                                                        .then((value) => Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        HomeScreen())))
                                                        .catchError((e) {
                                                      print(e);
                                                    });
                                                  }
                                                }
                                              },
                                              child:
                                                  const Text('تسجيل الدخول')),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  minimumSize:
                                                      const Size(247, 37),
                                                  backgroundColor:
                                                      const Color(0xff394445),
                                                  elevation: 3,
                                                  shape:
                                                      const RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(6)),
                                                  )),
                                              onPressed: () {
                                                Navigator.pushNamed(context,
                                                    ThtRegistration.id);
                                              },
                                              child: const Text(
                                                  'انشاء حساب جديد')),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ]),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}

class TabControler extends StatelessWidget {
  late Widget tab1;
  late Widget tab2;
  late Widget widget1;
  late Widget widget2;
  TabControler({
    required this.tab1,
    required this.tab2,
    required this.widget1,
    required this.widget2,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          Container(
            height: 45,
            decoration: const BoxDecoration(
              border: Border(
                  bottom:
                      BorderSide(color: Color.fromARGB(131, 158, 158, 158))),
            ),
            child: TabBar(
              indicator: const BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        color: Color.fromARGB(111, 66, 65, 65), width: 2)),
              ),
              labelColor: const Color.fromARGB(255, 21, 11, 11),
              tabs: [
                Tab(
                  child: tab1,
                ),
                Tab(
                  child: tab2,
                )
              ],
            ),
          ),
          Expanded(
              child: TabBarView(
            children: [
              widget1,
              widget2,
            ],
          ))
        ],
      ),
    );
  }
}

class ForgotPassword extends StatefulWidget {
  static String id = 'login_screen';

  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final auth = FirebaseAuth.instance;
  late String email;
  late String Pass;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  const Align(
                    alignment: Alignment.center,
                    child: Text(
                      'إعادة تعيين كلمة المرور',
                      style: TextStyle(
                        color: Color(0xff385a4a),
                        fontSize: 28,
                        fontFamily: "Cairo",
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 55),
                  /**------------------Email Text Filed---------------------------**/
                  const Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'البريد الإلكتروني',
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        color: Color(0xff385a4a),
                        fontSize: 14,
                        fontFamily: "Cairo",
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  TextField(
                      onChanged: (value) {
                        email = value;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: kStylingInputDec.copyWith(
                        hintText: 'example@gmail.com',
                      )),
                  const SizedBox(
                    height: 17.17,
                  ),
                  /**---------------------------------------------**/
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              minimumSize: const Size(247, 37),
                              backgroundColor: const Color(0xff394445),
                              elevation: 3,
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6)),
                              )),
                          onPressed: () {
                            auth.sendPasswordResetEmail(email: email);

                            //Navigator.of(context).pop();

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => loginTC(),
                                ));

                            AwesomeDialog(
                                dialogType: DialogType.noHeader,
                                context: context,
                                title: "نجاح",
                                body: Container(
                                  height: 50,
                                  child: const Text(
                                      "تم إرسال رابط اعادة تعيين كلمة المرور على الايميل"),
                                )).show();
                          },
                          child: const Text(' إرسال')),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
