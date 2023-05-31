// // import 'package:eloquentapp/screens/UserMangment/users.dart';
// // import 'package:eloquentapp/screens/constants.dart';
// // import 'package:eloquentapp/services/firebase_helper.dart';
// // import 'package:flutter/material.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:eloquentapp/therapist/home.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:uuid/uuid.dart';

// // class TherapistRegistrationScreen extends StatefulWidget {
// //   static String id = 'Therapistregistration_screen';

// //   @override
// //   State<TherapistRegistrationScreen> createState() =>
// //       _TherapistRegistrationScreenState();
// // }

// // class _TherapistRegistrationScreenState
// //     extends State<TherapistRegistrationScreen> {
// //   final _auth = FirebaseAuth.instance;
// //   //varibale
// //   late String name;
// //   late String email;
// //   late String pass;
// //   late String ConfirmPass;
// //   late String phone;

// // //Add user ditals to data base
// //   Future AddUserDitals(
// //       String Name, String Email, String Password, String Phone) async {
// //     await FirebaseFirestore.instance.collection("Therapist").add(
// //         {'Name': Name, 'Email': Email, 'Password': Password, 'Phone': Phone});
// //   }

// //   //Confirm Password
// //   bool passwordConfermd() {
// //     if (pass == ConfirmPass) {
// //       return true;
// //     } else {
// //       print('pass not match');
// //       return false;
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: SafeArea(
// //           child: Padding(
// //         padding: const EdgeInsets.only(
// //           left: 24,
// //           right: 23,
// //         ),
// //         child: SingleChildScrollView(
// //           child: Column(
// //             mainAxisAlignment: MainAxisAlignment.center,
// //             crossAxisAlignment: CrossAxisAlignment.end,
// //             children: [
// //               Text(
// //                 'إنشاء حساب  ',
// //                 style: TextStyle(
// //                   color: Color(0xff394445),
// //                   fontSize: 25,
// //                   fontFamily: "Cairo",
// //                   fontWeight: FontWeight.w700,
// //                 ),
// //               ),
// //               SizedBox(
// //                 height: 15,
// //               ),
// //               //Name Text Filed
// //               Text('الأسم'),
// //               TextField(
// //                 onChanged: (value) {
// //                   name = value;
// //                 },
// //                 decoration: kStylingInputDec,
// //               ),
// //               SizedBox(
// //                 height: 10,
// //               ),
// //               //email Text Filed
// //               Text('البريد الإلكتروني'),
// //               TextField(
// //                 onChanged: (value) {
// //                   email = value;
// //                 },
// //                 decoration: kStylingInputDec,
// //               ),
// //               SizedBox(
// //                 height: 10,
// //               ),
// //               //phonr Text Filed
// //               Text('رقم الجوال'),
// //               TextField(
// //                   onChanged: (value) {
// //                     phone = value;
// //                   },
// //                   keyboardType: TextInputType.phone,
// //                   decoration: kStylingInputDec.copyWith(
// //                     hintText: '+966 535 241 724',
// //                     hintStyle:
// //                         TextStyle(color: Color.fromARGB(170, 158, 158, 158)),
// //                   )),
// //               SizedBox(
// //                 height: 10,
// //               ),
// //               //Pass Text Filed
// //               Text('كلمة المرور'),
// //               TextField(
// //                 obscureText: true,
// //                 onChanged: (value) {
// //                   pass = value;
// //                 },
// //                 decoration: kStylingInputDec,
// //               ),
// //               SizedBox(
// //                 height: 15,
// //               ),
// //               //Confirm Pass Text Filed
// //               Text('إعادة كلمة المرور'),
// //               TextField(
// //                 obscureText: true,
// //                 onChanged: (value) {
// //                   ConfirmPass = value;
// //                 },
// //                 decoration: kStylingInputDec,
// //               ),
// //               SizedBox(
// //                 height: 15,
// //               ),
// //               ElevatedButton(
// //                   onPressed: () async {
// //                     //Naw fuction section
// //                     if (passwordConfermd()) {
// //                       try {
// //                         final isSaved = await FirebaseHelperTherapist.saveUser(
// //                             email: email,
// //                             password: pass,
// //                             name: name,
// //                             phone: phone);
// //                         if (isSaved) {
// //                           Navigator.pushNamed(context, TherapistHomeScreen.id);
// //                         }
// //                         print(isSaved);
// //                       } catch (e) {
// //                         print(e);
// //                       }
// //                     }
// //                   },
// //                   child: Text('تسجيل'))
// //             ],
// //           ),
// //         ),
// //       )),
// //     );
// //   }
// // }

// import 'package:eloquentapp/screens/constants.dart';
// import 'package:eloquentapp/services/firebase_helper.dart';
// import 'package:eloquentapp/therapist/bottomNavbar.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:eloquentapp/therapist/Pages/home.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:input_quantity/input_quantity.dart';
// import 'package:uuid/uuid.dart';

// class TherapistRegistrationScreen extends StatefulWidget {
//   static String id = 'Therapistregistration_screen';

//   @override
//   State<TherapistRegistrationScreen> createState() =>
//       _TherapistRegistrationScreenState();
// }

// class _TherapistRegistrationScreenState
//     extends State<TherapistRegistrationScreen> {
//   final _auth = FirebaseAuth.instance;
//   //varibale
//   late String name;
//   late String email;
//   late String pass;
//   late String ConfirmPass;
//   late String phone;
//   late String GeneralInfo;
//   late String YearsofExperience;
//   late String duration;
//   var arabicLanguage = false;
//   var englishLanguage = false;
//   var incenter = false;
//   var online = false;

// //Add user ditals to data base
//   // Future AddUserDitals(
//   // String Name, String Email, String Password, String Phone) async {
//   // await FirebaseFirestore.instance.collection("Therapist").add(
//   // {'Name': Name, 'Email': Email, 'Password': Password, 'Phone': Phone});
//   // }

//   //Confirm Password
//   bool passwordConfermd() {
//     if (pass == ConfirmPass) {
//       return true;
//     } else {
//       print('pass not match');
//       return false;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.end,
//               crossAxisAlignment: CrossAxisAlignment.end,
//               children: [
//                 Text(
//                   'إنشاء حساب  ',
//                   style: TextStyle(
//                     color: Color(0xff394445),
//                     fontSize: 25,
//                     fontFamily: "Cairo",
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),
//                 SizedBox(
//                   height: 15,
//                 ),
//                 //Name Text Filed
//                 Text('الأسم'),
//                 TextField(
//                   onChanged: (value) {
//                     name = value;
//                   },
//                   decoration: kStylingInputDec,
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 //email Text Filed
//                 Text('البريد الإلكتروني'),
//                 TextField(
//                   onChanged: (value) {
//                     email = value;
//                   },
//                   decoration: kStylingInputDec,
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 //phonr Text Filed
//                 Text('رقم الجوال'),
//                 TextField(
//                     onChanged: (value) {
//                       phone = value;
//                     },
//                     keyboardType: TextInputType.phone,
//                     decoration: kStylingInputDec.copyWith(
//                       hintText: '+966 535 241 724',
//                       hintStyle:
//                           TextStyle(color: Color.fromARGB(170, 158, 158, 158)),
//                     )),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 //Pass Text Filed
//                 Text('كلمة المرور'),
//                 TextField(
//                   obscureText: true,
//                   onChanged: (value) {
//                     pass = value;
//                   },
//                   decoration: kStylingInputDec,
//                 ),
//                 SizedBox(
//                   height: 15,
//                 ),
//                 //Confirm Pass Text Filed
//                 Text('إعادة كلمة المرور'),
//                 TextField(
//                   obscureText: true,
//                   onChanged: (value) {
//                     ConfirmPass = value;
//                   },
//                   decoration: kStylingInputDec,
//                 ),
//                 SizedBox(
//                   height: 15,
//                 ),
//                 Text(
//                   'معلومات أساسية   ',
//                   style: TextStyle(
//                     color: Color(0xff394445),
//                     fontSize: 25,
//                     fontFamily: "Cairo",
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),
//                 SizedBox(
//                   height: 15,
//                 ),
//                 //Name Text Filed
//                 Text('نبذة عامة'),
//                 SizedBox(
//                   height: 200,
//                   child: TextField(
//                     keyboardType: TextInputType.multiline,
//                     maxLines: null,
//                     expands: true,
//                     onChanged: (value) {
//                       GeneralInfo = value;
//                     },
//                     decoration: kStylingInputDec,
//                   ),
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Text("سنوات الخبرة"),
//                 InputQty(
//                   maxVal: 100,
//                   minVal: 0,
//                   initVal: 0,
//                   isIntrinsicWidth: false,
//                   onQtyChanged: (val) {
//                     YearsofExperience = val.toString();
//                     print(YearsofExperience);
//                   },
//                 ),
//                 SizedBox(
//                   height: 15,
//                 ),
//                 Text("مدة الجلسة "),
//                 InputQty(
//                   maxVal: 100,
//                   minVal: 0,
//                   initVal: 0,
//                   isIntrinsicWidth: false,
//                   onQtyChanged: (val) {
//                     duration = val.toString();
//                     print(duration);
//                   },
//                 ),
//                 Text("اللغات"),
//                 Row(
//                   children: [
//                     Text("اللغة الانجليزية"),
//                     Checkbox(
//                         value: englishLanguage,
//                         onChanged: (value) {
//                           setState(() {
//                             englishLanguage = value!;
//                           });
//                         }),
//                     Spacer(),
//                     Text("اللغة العربية"),
//                     Checkbox(
//                         value: arabicLanguage,
//                         onChanged: (value) {
//                           setState(() {
//                             arabicLanguage = value!;
//                           });
//                         })
//                   ],
//                 ),
//                 Text("تقديم الاستشارات"),
//                 Row(
//                   children: [
//                     Text("عن بعد"),
//                     Checkbox(
//                         value: online,
//                         onChanged: (value) {
//                           setState(() {
//                             online = value!;
//                           });
//                         }),
//                     Spacer(),
//                     Text("في المركز"),
//                     Checkbox(
//                         value: incenter,
//                         onChanged: (value) {
//                           setState(() {
//                             incenter = value!;
//                           });
//                         })
//                   ],
//                 ),
//                 ElevatedButton(
//                     onPressed: () async {
//                       //valditae
//                       if (passwordConfermd()) {
//                         try {
//                           if (passwordConfermd()) {
//                             try {
//                               final isSaved =
//                                   await FirebaseHelperTherapist.saveUser(
//                                       email: email,
//                                       password: pass,
//                                       name: name,
//                                       phone: phone,
//                                       GeneralInfo: GeneralInfo,
//                                       duration: duration,
//                                       YearsofExperience: YearsofExperience,
//                                       arabicLanguage: arabicLanguage,
//                                       englishLanguage: englishLanguage,
//                                       incenter: incenter,
//                                       online: online);
//                               print(isSaved);
//                               Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) =>
//                                           navBarForTherapist()));
//                             } catch (e) {
//                               print(e);
//                             }
//                           }
//                         } catch (e) {
//                           print(e);
//                         }
//                       }
//                     },

//                     //1- Creat user
//                     // },
//                     child: Text('التالي')),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
