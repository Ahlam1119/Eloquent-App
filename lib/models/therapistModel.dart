// import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:flutter/cupertino.dart';

// // class TherapistModel {
// //   final String uid;
// //   final String name;
// //   final String email;
// //   final String pass;
// //   final String? docId;
// //   final String phone;

// //   const TherapistModel(
// //       {this.docId,
// //       required this.name,
// //       required this.email,
// //       required this.phone,
// //       required this.pass,
// //       required this.uid});
// //   //(fetch data from firebase ) data from the database will converted and store in this model to use in the app
// //   //convert the Json data to TherapistModel object.
// //   factory TherapistModel.fromJson(
// //           DocumentSnapshot<Map<String, dynamic>> json) =>
// //       TherapistModel(
// //         uid: json['uid'],
// //         name: json['name'],
// //         email: json['email'],
// //         pass: json['password'],
// //         phone: json['phone'],
// //       );

// //   //(send data to firebase )data  will converted and store in data base
// // //Map type function to convert the character TherapistModel to json format.
// //   Map<String, dynamic> toJson() => {
// //         'uid': uid,
// //         'name': name,
// //         'email': email,
// //         'password': pass,
// //         'phone': phone,
// //       };

// //   //
// //   factory TherapistModel.fromSnapshot(
// //       DocumentSnapshot<Map<String, dynamic>> document) {
// //     final data = document.data()!;
// //     return TherapistModel(
// //       uid: data['uid'],
// //       name: data['name'],
// //       email: data['email'],
// //       pass: data['password'],
// //       phone: data['phone'],
// //       docId: data['document.id'],
// //     );
// //   }
// // }

// import 'package:flutter/cupertino.dart';

// class TherapistModel {
//   final String uid;
//   final String name;
//   final String email;
//   final String pass;
//   final String phone;
//   final String GeneralInfo;

//   final String YearsofExperience;
//   final String duration;
//   final bool arabicLanguage;
//   final bool englishLanguage;
//   final bool incenter;
//   final bool online;

//   const TherapistModel(
//       {required this.name,
//       required this.email,
//       required this.phone,
//       required this.pass,
//       required this.uid,
//       required this.GeneralInfo,
//       required this.YearsofExperience,
//       required this.duration,
//       required this.arabicLanguage,
//       required this.englishLanguage,
//       required this.incenter,
//       required this.online});
//   //(fetch data from firebase ) data from the database will converted and store in this model to use in the app
//   factory TherapistModel.fromJson(
//           DocumentSnapshot<Map<String, dynamic>> json) =>
//       TherapistModel(
//         uid: json['uid'],
//         name: json['name'],
//         email: json['email'],
//         pass: json['password'],
//         phone: json['phone'],
//         GeneralInfo: json['GeneralInfo'],
//         YearsofExperience: json["YearsofExperience"],
//         duration: json["duration"],
//         arabicLanguage: json["arabicLanguage"],
//         englishLanguage: json["englishLanguage"],
//         incenter: json["incenter"],
//         online: json["online"],
//       );

//   //(send data to firebase )data  will converted and store in data base

//   Map<String, dynamic> toJson() => {
//         'uid': uid,
//         'name': name,
//         'email': email,
//         'password': pass,
//         'phone': phone,
//         'GeneralInfo': GeneralInfo,
//         'YearsofExperience': YearsofExperience,
//         'duration': duration,
//         'arabicLanguage': arabicLanguage,
//         'englishLanguage': englishLanguage,
//         'incenter': incenter,
//         'online': online
//       };
// }

//   // static TherapistModel fromJson(Map<String, dynamic> json) => TherapistModel(
//   // uid: json['uid'],
//   // name: json['name'],
//   // email: json['email'],
//   // pass: json['password'],
//   // phone: json['phone'],
//   // );

//--------------------------------------------------------------------

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class TherapistModel {
  final String uid;
  final String name;
  final String email;
  final String pass;
  final String phone;
  final String GeneralInfo;
  final String YearsofExperience;
  final String duration;
  final String JobTitle;
  final bool arabicLanguage;
  final bool englishLanguage;
  final bool incenter;
  final bool online;
  final bool active;
  final FieldValue time;
  final String centerid;
  final String centerName;
  final String TherapistAvatar;

  const TherapistModel(
      {required this.name,
      required this.email,
      required this.phone,
      required this.pass,
      required this.uid,
      required this.GeneralInfo,
      required this.YearsofExperience,
      required this.duration,
      required this.arabicLanguage,
      required this.englishLanguage,
      required this.incenter,
      required this.online,
      required this.JobTitle,
      required this.time,
      required this.active,
      required this.centerid,
      required this.centerName,
      required this.TherapistAvatar});
  //(fetch data from firebase ) data from the database will converted and store in this model to use in the app
  factory TherapistModel.fromJson(Map<String, dynamic> json) => TherapistModel(
      uid: json['uid'],
      name: json['name'],
      email: json['email'],
      pass: json['password'],
      phone: json['phone'],
      GeneralInfo: json['GeneralInfo'],
      YearsofExperience: json["YearsofExperience"],
      duration: json["duration"],
      arabicLanguage: json["arabicLanguage"],
      englishLanguage: json["englishLanguage"],
      incenter: json["incenter"],
      online: json["online"],
      JobTitle: json["JobTitle"],
      time: json["time"],
      active: json["active"],
      centerid: json["centerid"],
      centerName: json["centerName"],
      TherapistAvatar: json["TherapistAvatar"]);

  //(send data to firebase )data  will converted and store in data base

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'name': name,
        'email': email,
        'password': pass,
        'phone': phone,
        'GeneralInfo': GeneralInfo,
        'YearsofExperience': YearsofExperience,
        'duration': duration,
        'arabicLanguage': arabicLanguage,
        'englishLanguage': englishLanguage,
        'incenter': incenter,
        'online': online,
        'JobTitle': JobTitle,
        'time': FieldValue.serverTimestamp(),
        'active': active,
        "centerid": centerid,
        'centerName': centerName,
        'TherapistAvatar': TherapistAvatar,
      };
}
