// import 'package:eloquentapp/screens/constants.dart';
// import 'package:eloquentapp/therapist/Pages/home.dart';
// import 'package:eloquentapp/therapist/Register_Login_Page/registration.dart';
// import 'package:eloquentapp/therapist/bottomNavbar.dart';
// import 'package:eloquentapp/therapist/test.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class TherapistLoginScreen extends StatefulWidget {
//   static String id = 'Therpiatslogin_screen';

//   @override
//   State<TherapistLoginScreen> createState() => _TherapistLoginScreenState();
// }

// class _TherapistLoginScreenState extends State<TherapistLoginScreen> {
//   final _auth = FirebaseAuth.instance;
//   bool showspinner = false;
//   late String email;
//   late String Pass;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 24),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               Text(
//                 'تسجيل الدخول',
//                 style: TextStyle(
//                   color: Color(0xff385a4a),
//                   fontSize: 28,
//                   fontFamily: "Cairo",
//                   fontWeight: FontWeight.w700,
//                 ),
//               ),
//               SizedBox(height: 55),
//               /**---------------------------------------------**/
//               Text(
//                 'البريد الإلكتروني',
//                 textAlign: TextAlign.end,
//                 style: TextStyle(
//                   color: Color(0xff385a4a),
//                   fontSize: 14,
//                   fontFamily: "Cairo",
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//               TextField(
//                   onChanged: (value) {
//                     email = value;
//                   },
//                   keyboardType: TextInputType.emailAddress,
//                   decoration: kStylingInputDec.copyWith(
//                     hintText: 'example@gmail.com',
//                   )),
//               SizedBox(
//                 height: 17.17,
//               ),
//               /**---------------------------------------------**/
//               Text(
//                 'كلمة المرور',
//                 textAlign: TextAlign.end,
//                 style: TextStyle(
//                   color: Color(0xff385a4a),
//                   fontSize: 14,
//                   fontFamily: "Cairo",
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//               TextFormField(
//                 onChanged: (value) {
//                   Pass = value;
//                 },
//                 decoration: kStylingInputDec,
//               ),
//               Text('نسيت كلمة المرور؟اضغط هنا'),
//               SizedBox(
//                 height: 20,
//               ),

//               /**---------------------------------------------**/
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                           minimumSize: Size(247, 37),
//                           backgroundColor: Color(0xff394445),
//                           elevation: 3,
//                           shape: const RoundedRectangleBorder(
//                             borderRadius: BorderRadius.all(Radius.circular(6)),
//                           )),
//                       onPressed: () async {
//                         FirebaseAuth.instance
//                             .signInWithEmailAndPassword(
//                                 email: email, password: Pass)
//                             .then((value) => Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) =>
//                                         navBarForTherapist())))
//                             .catchError((e) {
//                           print(e);
//                         });
//                       },
//                       child: Text('تسجيل الدخول')),
//                 ],
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                           minimumSize: Size(247, 37),
//                           backgroundColor: Color(0xff394445),
//                           elevation: 3,
//                           shape: const RoundedRectangleBorder(
//                             borderRadius: BorderRadius.all(Radius.circular(6)),
//                           )),
//                       onPressed: () {
//                         Navigator.pushNamed(
//                             context, TherapistRegistrationScreen.id);
//                       },
//                       child: Text('انشاء حساب جديد')),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
