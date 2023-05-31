import 'package:eloquentapp/Admin/home_Screen.dart';
import 'package:eloquentapp/parents/BottomNavBar.dart';
import 'package:eloquentapp/parents/Register_Login_Page/child_Registration.dart';
import 'package:eloquentapp/parents/Register_Login_Page/stepperView.dart';
import 'package:eloquentapp/screens/constants.dart';
import 'package:eloquentapp/screens/loginTC.dart';
import 'package:flutter/material.dart';
import 'package:eloquentapp/parents/Register_Login_Page/registration.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'login_screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  Color _iconColor = Colors.grey; // default color

  late String email;
  late String Pass;
  bool _isPasswordVisible = false;
  String? _errorMessage;

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(
                      child: Text(
                        'تسجيل الدخول',
                        style: TextStyle(
                          color: Color(0xff385a4a),
                          fontSize: 28,
                          fontFamily: "Cairo",
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    SizedBox(height: 55),
                    /**------------------Email Text Filed---------------------------**/
                    Text(
                      'البريد الإلكتروني',
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        color: Color(0xff385a4a),
                        fontSize: 14,
                        fontFamily: "Cairo",
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 16.03),
                    TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'الرجاء ادخال البريد الالكتروني ';
                          }
                        },
                        onChanged: (value) {
                          email = value;
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: kStylingInputDec.copyWith(
                          hintText: 'example@gmail.com',
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    /**--------------------pass Text Filed-------------------------**/
                    Text(
                      'كلمة المرور',
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        color: Color(0xff385a4a),
                        fontSize: 14,
                        fontFamily: "Cairo",
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 16.03),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'الرجاء ادخال كلمة المرور ';
                        }
                      },
                      obscureText: !_isPasswordVisible,
                      onChanged: (value) {
                        Pass = value;
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
                    Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ForgotPassword(),
                                ));
                          },
                          child: const Text('نسيت كلمة المرور؟اضغط هنا',
                              style: TextStyle(
                                color: Color(0xff385a4a),
                              )),
                        )
                      ],
                    ),

                    /**---------------------------------------------**/
                    if (_errorMessage != null)
                      Text(
                        _errorMessage!,
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                minimumSize: Size(247, 37),
                                backgroundColor: Color(0xff394445),
                                elevation: 3,
                                shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(6)),
                                )),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                if (email != 'gg@gmail.com') {
                                  try {
                                    await FirebaseAuth.instance
                                        .signInWithEmailAndPassword(
                                            email: email, password: Pass)
                                        .then((value) => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    MyBottomNavigationBar())));
                                    setState(() {
                                      _errorMessage = '';
                                    });
                                    // .catchError((e) {
                                    // print(e);
                                    // });
                                  } on FirebaseAuthException catch (e) {
                                    if (e.code == 'user-not-found' ||
                                        e.code == 'wrong-password') {
                                      setState(() {
                                        _errorMessage =
                                            'الايميل او كلمة السر غير صحيحة';
                                      });
                                    }
                                  }
                                  //     .catchError((e) {
                                  //   print(e);
                                  // });
                                } else {
                                  FirebaseAuth.instance
                                      .signInWithEmailAndPassword(
                                          email: email, password: Pass)
                                      .then((value) => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  HomeScreen())))
                                      .catchError((e) {
                                    print(e);
                                  });
                                }
                              }
                            },
                            child: Text('تسجيل الدخول')),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                minimumSize: Size(247, 37),
                                backgroundColor: Color(0xff394445),
                                elevation: 3,
                                shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(6)),
                                )),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => stepperView()));
                            },
                            child: Text('انشاء حساب جديد')),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
// onPressed: () async {
// try {
// final userCredential = await FirebaseAuth.instance
// .signInWithEmailAndPassword(
// email: email, password: Pass);
// Get the user's role from Firestore
// final userDoc = await FirebaseFirestore.instance
// .collection(role == 'Parent' ? 'Parent' : 'Admin') // Or 'Admin'
// .doc(userCredential.user!.uid)
// .get();
// final role = userDoc.get('role');
// Navigate the user to the appropriate home screen based on their role
// if (role == 'Parent') {
// Navigator.push(
// context,
// MaterialPageRoute(
// builder: (context) =>
// MyBottomNavigationBar()),
// );
// } else if (role == 'admin') {
// Navigator.push(
// context,
// MaterialPageRoute(
// builder: (context) =>
// MyBottomNavigationBar()),
// );
// }
// } catch (e) {
// print(e);
// }
// },
//
