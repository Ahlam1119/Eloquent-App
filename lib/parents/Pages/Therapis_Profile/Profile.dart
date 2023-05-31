// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:eloquentapp/screens/constants.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:table_calendar/table_calendar.dart';
// import 'package:uuid/uuid.dart';

// class Profile extends StatefulWidget {
//   static String id = 'avilableTime';

//   late String therapisid;
//   Profile({required this.therapisid});

//   @override
//   State<Profile> createState() => _ProfileState();
// }

// class _ProfileState extends State<Profile> {
//   late var therapistID = widget.therapisid;
//   DateTime date = DateTime.now();

//   late bool _arabicLanguage;
//   late bool _englishLanguage;
//   late String _arabic;
//   late String _english;
//   late bool onlineconsultation;
//   late bool inCenterconsultation;
//   late String online;
//   late String inCenter;

//   TimeOfDay timeOfDay = TimeOfDay.now();
//   DateTime today = DateTime.now();
//   void _onDaySelected(DateTime day, DateTime focusedDay) {
//     setState(() {
//       today = day;
//     });
//   }

//   late String _uid;
//   //instance for auth
//   final _auth = FirebaseAuth.instance;
//   //instance for cloud firestore
//   final _firestore = FirebaseFirestore.instance;
//   late User singedInUser;
//   void initState() {
//     super.initState();
//     getCurrentUser();
//     getUserData();

//     getParentData();
//   }

//   late String Note;
//   //get current user
//   void getCurrentUser() {
//     try {
//       final user = _auth.currentUser;
//       if (user != null) {
//         singedInUser = user;
//       }
//     } catch (e) {
//       print(e);
//     }
//   }

//   Map<String, dynamic> TherapistInfo = {};
//   bool isLoded = true;
//   getUserData() async {
//     await FirebaseFirestore.instance
//         .collection('Therapist')
//         .where("uid", isEqualTo: therapistID)
//         .get()
//         .then((v) {
//       for (var element in v.docs) {
//         TherapistInfo.addAll(element.data());
//         print(TherapistInfo);
//         getBoolData();
//         setState(() {
//           isLoded = false;
//         });
//       }
//     });
//   }

//   late String TherapistName = TherapistInfo['name'];
//   late String Level = TherapistInfo['name'];

//   //-----------------------------------------------

//   Map<String, dynamic> ParentData = {};

//   //get all user data and store to Map
//   getParentData() async {
//     await FirebaseFirestore.instance
//         .collection('Parent')
//         .where("uid", isEqualTo: singedInUser.uid)
//         .get()
//         .then((v) {
//       for (var element in v.docs) {
//         ParentData.addAll(element.data());
//         print(ParentData['name']);
//       }
//     });
//   }

//   late String ParentName = ParentData['name'];

//   //------------------------------------------------

//   String formatDate(var timestamp) {
//     var format = DateTime.fromMillisecondsSinceEpoch(timestamp.seconds * 1000);
//     return DateFormat('dd-MM-yyyy').format(format);
//   }

//   // late Timestamp reDate = RequstInfoData['DateTime'];
//   //----------------------------------------------------------------

//   getBoolData() {
//     _arabicLanguage = TherapistInfo['arabicLanguage'];
//     _englishLanguage = TherapistInfo['englishLanguage'];
//     onlineconsultation = TherapistInfo['online'];
//     inCenterconsultation = TherapistInfo['incenter'];

//     if (_arabicLanguage == true) {
//       _arabic = "العربية";
//     } else {
//       _arabic = "";
//     }

//     if (_englishLanguage = true) {
//       _english = "الأنجيليزية";
//     } else {
//       _english = "";
//     }
//     if (inCenterconsultation == true) {
//       inCenter = "بالمركز";
//     } else {
//       inCenter = "";
//     }

//     if (onlineconsultation == true) {
//       online = ",عن بعد";
//     } else {
//       online = "";
//     }
//   }

//   //--------------------------------------
//   getrequst(
//       {required String ParentName,
//       required String TherapistName,
//       required String RequestId,
//       required String TherapistID,
//       required String Note,
//       required DateTime today}) async {
//     final QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
//         .instance
//         .collection('requests')
//         .where('userId', isEqualTo: singedInUser.uid)
//         .where('status', isEqualTo: 'InPrograss')
//         .get();

//     if (snapshot.docs.isNotEmpty) {
//       showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//           title: Text("يوجد لديك طلب سابق جاري العمل عليه"),
//           content: Text(
//               "عند قبول الأخصائي للجسلة، سوف تضاف جلستك الى قائمة الجلسات القادمة"),
//         ),
//       );
//     } else {
//       final DocumentReference<Map<String, dynamic>> requestRef =
//           FirebaseFirestore.instance.collection('requests').doc();

//       final Map<String, dynamic> requestData = {
//         'userId': singedInUser.uid,
//         'status': 'InPrograss',
//         'ParentName': ParentName,

//         'TherapistName': TherapistName,
//         'RequestId': RequestId,
//         'TherapistID': TherapistID,
//         'ParentNote': Note,
//         'DateTime': today,
//         // Add any other fields you need for the request
//       };

//       await requestRef.set(requestData);

//       showDialog(
//         // RoundedRectangleBorder(
//         //     borderRadius: BorderRadius.vertical(
//         //         top: Radius.circular(30))),
//         context: context,
//         builder: (context) => AlertDialog(
//           title: Text("تم ارسال طلبك بنجاح"),
//           content: Text(
//               "عند قبول الأخصائي للجسلة، سوف تضاف جلستك الى قائمة الجلسات القادمة"),
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: isLoded == true
//             ? Center(child: CircularProgressIndicator())
//             : SafeArea(
//                 child: Column(
//                   children: [
//                     ProfileContainer(
//                       TherapistName: TherapistName,
//                       EducationLevel: Level,
//                     ),
//                     SizedBox(
//                       height: 12,
//                     ),
//                     Expanded(
//                       child: DefaultTabController(
//                         length: 3,
//                         child: Container(
//                           width: 365,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(18.31),
//                             color: Color(0x0c9bb0a5),
//                           ),
//                           child: Column(children: [
//                             Container(
//                               child: TabBar(
//                                 indicator: BoxDecoration(
//                                   border: Border(
//                                       bottom: BorderSide(
//                                           color: Color.fromARGB(0, 66, 65, 65),
//                                           width: 2)),
//                                 ),
//                                 labelColor: Color.fromARGB(255, 21, 11, 11),
//                                 tabs: [
//                                   Tab(
//                                     child: Text("المراجعات"),
//                                   ),
//                                   Tab(
//                                     child: Text("الجلسات المتاحة"),
//                                   ),
//                                   Tab(
//                                     child: Text("معلومات عامة"),
//                                   )
//                                 ],
//                               ),
//                             ),
//                             Container(
//                               child: Expanded(
//                                 child: TabBarView(
//                                   children: [
//                                     Text("Comment section"),
//                                     ListView(
//                                       children: [
//                                         Column(children: [
//                                           Padding(
//                                             padding: const EdgeInsets.symmetric(
//                                                 vertical: 10, horizontal: 20),
//                                             child: Column(
//                                               children: [
//                                                 TableCalendar(
//                                                   selectedDayPredicate: (day) =>
//                                                       isSameDay(day, today),
//                                                   focusedDay: today,
//                                                   firstDay: DateTime.utc(
//                                                       2018, 10, 16),
//                                                   lastDay: DateTime.utc(
//                                                       2030, 10, 16),
//                                                   onDaySelected: _onDaySelected,
//                                                 ),
//                                                 SizedBox(
//                                                   height: 15,
//                                                 ),
//                                                 Align(
//                                                   alignment: Alignment.topRight,
//                                                   child: Text("وقت الجلسة"),
//                                                 ),
//                                                 SizedBox(
//                                                   height: 15,
//                                                 ),
//                                                 Align(
//                                                   alignment: Alignment.topRight,
//                                                   child: Text("الملاحظات"),
//                                                 ),
//                                                 SizedBox(
//                                                   height: 15,
//                                                 ),
//                                                 SizedBox(
//                                                   height: 200,
//                                                   child: TextField(
//                                                     keyboardType:
//                                                         TextInputType.multiline,
//                                                     maxLines: null,
//                                                     expands: true,
//                                                     onChanged: (value) {
//                                                       Note = value;
//                                                     },
//                                                     decoration:
//                                                         kStylingInputDec,
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                           SizedBox(
//                                             height: 15,
//                                           ),
//                                           ElevatedButton(
//                                               onPressed: () {
//                                                 showModalBottomSheet(
//                                                   shape: RoundedRectangleBorder(
//                                                       borderRadius:
//                                                           BorderRadius.vertical(
//                                                               top: Radius
//                                                                   .circular(
//                                                                       30))),
//                                                   context: context,
//                                                   builder: (context) => Center(
//                                                     child: Padding(
//                                                       padding:
//                                                           const EdgeInsets.all(
//                                                               15),
//                                                       child: Column(children: [
//                                                         Align(
//                                                           alignment: Alignment
//                                                               .centerRight,
//                                                           child: Text(
//                                                             'ملخص حجز الجلسة',
//                                                             style: TextStyle(
//                                                               color: Color(
//                                                                   0xff385a4a),
//                                                               fontSize: 18,
//                                                               fontFamily:
//                                                                   "Cairo",
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .w700,
//                                                             ),
//                                                           ),
//                                                         ),
//                                                         SizedBox(
//                                                           height: 15,
//                                                         ),
//                                                         Align(
//                                                           alignment: Alignment
//                                                               .centerRight,
//                                                           child: Table(
//                                                             columnWidths: {
//                                                               0: FractionColumnWidth(
//                                                                   0.3),
//                                                               1: FractionColumnWidth(
//                                                                   0.2),
//                                                             },
//                                                             children: [
//                                                               TableRow(
//                                                                   children: [
//                                                                     TableCell(
//                                                                       child:
//                                                                           Text(
//                                                                         TherapistName +
//                                                                             " /د",
//                                                                         textAlign:
//                                                                             TextAlign.end,
//                                                                       ),
//                                                                     ),
//                                                                     Icon(Icons
//                                                                         .timer_sharp),
//                                                                   ]),
//                                                             ],
//                                                           ),
//                                                         ),
//                                                         SizedBox(
//                                                           height: 10,
//                                                         ),
//                                                         Align(
//                                                           alignment: Alignment
//                                                               .centerRight,
//                                                           child: Table(
//                                                             columnWidths: {
//                                                               0: FractionColumnWidth(
//                                                                   0.3),
//                                                               1: FractionColumnWidth(
//                                                                   0.2),
//                                                             },
//                                                             children: [
//                                                               TableRow(
//                                                                   children: [
//                                                                     TableCell(
//                                                                       child:
//                                                                           Text(
//                                                                         ParentName,
//                                                                         textAlign:
//                                                                             TextAlign.end,
//                                                                       ),
//                                                                     ),
//                                                                     Icon(Icons
//                                                                         .timer_sharp),
//                                                                   ]),
//                                                             ],
//                                                           ),
//                                                         ),
//                                                         SizedBox(
//                                                           height: 10,
//                                                         ),
//                                                         Align(
//                                                           alignment: Alignment
//                                                               .centerRight,
//                                                           child: Table(
//                                                             columnWidths: {
//                                                               0: FractionColumnWidth(
//                                                                   0.3),
//                                                               1: FractionColumnWidth(
//                                                                   0.2),
//                                                             },
//                                                             children: [
//                                                               TableRow(
//                                                                   children: [
//                                                                     TableCell(
//                                                                       child:
//                                                                           Text(
//                                                                         ""
//                                                                         // formatDate(
//                                                                         //     today),
//                                                                         ,
//                                                                         textAlign:
//                                                                             TextAlign.end,
//                                                                       ),
//                                                                     ),
//                                                                     Icon(Icons
//                                                                         .timer_sharp),
//                                                                   ]),
//                                                             ],
//                                                           ),
//                                                         ),
//                                                         SizedBox(
//                                                           height: 100,
//                                                           child: TextField(
//                                                             keyboardType:
//                                                                 TextInputType
//                                                                     .multiline,
//                                                             maxLines: null,
//                                                             expands: true,
//                                                             onChanged:
//                                                                 (value) {},
//                                                             decoration:
//                                                                 kStylingInputDec
//                                                                     .copyWith(
//                                                                         hintText:
//                                                                             "ملاحظات الأهل"),
//                                                           ),
//                                                         ),
//                                                         ElevatedButton(
//                                                             style:
//                                                                 ElevatedButton
//                                                                     .styleFrom(
//                                                               backgroundColor:
//                                                                   Color(
//                                                                       0xff385a4a),
//                                                             ),
//                                                             onPressed: () {
//                                                               final RequestId =
//                                                                   Uuid().v4();
//                                                               getrequst(
//                                                                   ParentName:
//                                                                       ParentName,
//                                                                   TherapistID:
//                                                                       therapistID,
//                                                                   RequestId:
//                                                                       RequestId,
//                                                                   TherapistName:
//                                                                       TherapistName,
//                                                                   Note: Note,
//                                                                   today: today);
//                                                               Navigator.pop(
//                                                                   context);

//                                                               // Navigator.push(
//                                                               //     context,
//                                                               //     MaterialPageRoute(
//                                                               //       builder: (context) => Request(
//                                                               //         TherapistId: uid,
//                                                               //       ),
//                                                               //     ));
//                                                             },
//                                                             child: Text(
//                                                                 'ارسال الطلب'))
//                                                       ]),
//                                                     ),
//                                                   ),
//                                                 );
//                                               },
//                                               child: Text('التالي')),
//                                         ]),
//                                       ],
//                                     ),
//                                     Padding(
//                                       padding: const EdgeInsets.symmetric(
//                                           horizontal: 5),
//                                       child: ListView(
//                                         children: [
//                                           Column(children: [
//                                             SizedBox(
//                                               height: 13,
//                                             ),
//                                             Table(
//                                               columnWidths: {
//                                                 0: FractionColumnWidth(0.4),
//                                                 1: FractionColumnWidth(0.1),
//                                                 2: FractionColumnWidth(0.4),
//                                                 3: FractionColumnWidth(0.1),
//                                               },
//                                               children: [
//                                                 TableRow(children: [
//                                                   TableCell(
//                                                     child: Text(
//                                                       "اللغات: " +
//                                                           _arabic +
//                                                           "," +
//                                                           _english,
//                                                       textAlign: TextAlign.end,
//                                                       style: TextStyle(
//                                                         color:
//                                                             Color(0xff687c71),
//                                                         fontSize: 14,
//                                                         fontFamily: "Cairo",
//                                                         fontWeight:
//                                                             FontWeight.w500,
//                                                       ),
//                                                     ),
//                                                   ),
//                                                   Padding(
//                                                     padding:
//                                                         const EdgeInsets.only(
//                                                             right: 15),
//                                                     child: Icon(Icons.book),
//                                                   ),
//                                                   TableCell(
//                                                     child: Text(
//                                                       "سنوات الخبرة: ${TherapistInfo['YearsofExperience']} سنة",
//                                                       textAlign: TextAlign.end,
//                                                       style: TextStyle(
//                                                         color:
//                                                             Color(0xff687c71),
//                                                         fontSize: 14,
//                                                         fontFamily: "Cairo",
//                                                         fontWeight:
//                                                             FontWeight.w500,
//                                                       ),
//                                                     ),
//                                                   ),
//                                                   Icon(Icons.book),
//                                                 ]),
//                                               ],
//                                             ),
//                                             SizedBox(
//                                               height: 15,
//                                             ),
//                                             Table(
//                                               columnWidths: {
//                                                 0: FractionColumnWidth(0.4),
//                                                 1: FractionColumnWidth(0.1),
//                                                 2: FractionColumnWidth(0.4),
//                                                 3: FractionColumnWidth(0.1),
//                                               },
//                                               children: [
//                                                 TableRow(children: [
//                                                   TableCell(
//                                                     child: Text(
//                                                       "مدة الجلسة :" +
//                                                           TherapistInfo[
//                                                               'duration'] +
//                                                           " دقيقة",
//                                                       textAlign: TextAlign.end,
//                                                       style: TextStyle(
//                                                         color:
//                                                             Color(0xff687c71),
//                                                         fontSize: 14,
//                                                         fontFamily: "Cairo",
//                                                         fontWeight:
//                                                             FontWeight.w500,
//                                                       ),
//                                                     ),
//                                                   ),
//                                                   Padding(
//                                                     padding:
//                                                         const EdgeInsets.only(
//                                                             right: 15),
//                                                     child: Icon(Icons.book),
//                                                   ),
//                                                   TableCell(
//                                                     child: Text(
//                                                       "يقدم استشارات: " +
//                                                           inCenter +
//                                                           online,
//                                                       textAlign: TextAlign.end,
//                                                       style: TextStyle(
//                                                         color:
//                                                             Color(0xff687c71),
//                                                         fontSize: 14,
//                                                         fontFamily: "Cairo",
//                                                         fontWeight:
//                                                             FontWeight.w500,
//                                                       ),
//                                                     ),
//                                                   ),
//                                                   Icon(Icons.book),
//                                                 ]),
//                                               ],
//                                             ),
//                                             SizedBox(
//                                               height: 25,
//                                             ),
//                                             Column(
//                                               children: [
//                                                 Align(
//                                                   alignment:
//                                                       Alignment.centerRight,
//                                                   child: Text(
//                                                     "نبذة عن المختص",
//                                                     style: TextStyle(
//                                                       color: Colors.black,
//                                                       fontSize: 16,
//                                                       fontFamily: "Cairo",
//                                                       fontWeight:
//                                                           FontWeight.w700,
//                                                     ),
//                                                   ),
//                                                 ),
//                                                 Padding(
//                                                   padding:
//                                                       const EdgeInsets.all(8.0),
//                                                   child: Text(
//                                                     TherapistInfo[
//                                                         'GeneralInfo'],
//                                                     textAlign: TextAlign.end,
//                                                     style: TextStyle(
//                                                       color: Color(0xff6888a0),
//                                                       fontSize: 14,
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ],
//                                             )
//                                           ]),
//                                         ],
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             )
//                           ]),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ));
//   }
// }

// class ProfileContainer extends StatelessWidget {
//   late String TherapistName;
//   late String EducationLevel;
//   ProfileContainer({required this.TherapistName, required this.EducationLevel});

//   @override
//   Widget build(BuildContext context) {
//     var textStyle = TextStyle(
//       color: Color(0xff394445),
//       fontSize: 16,
//       fontFamily: "Cairo",
//       fontWeight: FontWeight.w700,
//     );
//     var textStyle2 = TextStyle(
//       color: Color(0xff797979),
//       fontSize: 12,
//     );
//     return Container(
//       width: MediaQuery.of(context).size.width,
//       height: 330,
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           begin: Alignment.topRight,
//           end: Alignment.bottomLeft,
//           colors: [Color(0xff9bb0a5), Color(0xff6888a0)],
//         ),
//         color: Color(0xff6888a0),
//         borderRadius: BorderRadius.only(
//             bottomLeft: Radius.circular(50), bottomRight: Radius.circular(50)),
//       ),
//       child: Column(
//         children: [
//           Align(
//             alignment: Alignment.centerLeft,
//             child: Container(
//               margin: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
//               child: GestureDetector(
//                 onTap: () {
//                   Navigator.pop(context);
//                 },
//                 child: Icon(
//                   Icons.arrow_back_ios_new_outlined,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(
//             height: 50,
//           ),
//           Container(
//             margin: EdgeInsets.symmetric(horizontal: 20),
//             height: 180,
//             child: Center(
//                 child: Column(
//               children: [
//                 CircleAvatar(
//                   radius: 60,
//                   backgroundColor: Color(0xffEFF5F2),
//                   foregroundColor: Color(0xffEFF5F2),
//                   // backgroundImage: AssetImage(""),
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Text(
//                   "$TherapistName",
//                   style: textStyle,
//                 ),
//                 Text(
//                   "$EducationLevel",
//                   style: textStyle2,
//                 ),
//               ],
//             )),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(50),
//               boxShadow: [
//                 BoxShadow(
//                   color: Color(0x16000000),
//                   blurRadius: 4,
//                   offset: Offset(4, 4),
//                 ),
//               ],
//               color: Colors.white,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
