import 'package:cloud_firestore/cloud_firestore.dart';

class ParentModel {
  final String uid;
  final String name;
  final String email;
  final String pass;
  final String? docId;
  final String phone;

  const ParentModel(
      {required this.name,
      required this.email,
      required this.phone,
      required this.pass,
      required this.uid,
      this.docId});
  //(fetch data from firebase ) data from the database will converted and store in this model to use in the app
  factory ParentModel.fromJson(DocumentSnapshot<Map<String, dynamic>> json) =>
      ParentModel(
        uid: json['uid'],
        name: json['name'],
        email: json['email'],
        pass: json['password'],
        phone: json['phone'],
      );

  //(send data to firebase )data  will converted and store in data base

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'name': name,
        'email': email,
        'password': pass,
        'phone': phone,
      };

  factory ParentModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return ParentModel(
      uid: data['uid'],
      name: data['name'],
      email: data['email'],
      pass: data['password'],
      phone: data['phone'],
      docId: data['document.id'],
    );
  }
}

  // Future<TherapistModel> getUserDitals(String email) async {
  //   final snapshot = await _db
  //       .collection('Therapist')
  //       .where('email', isEqualTo: email)
  //       .get();
  //   final therapistData =
  //       snapshot.docs.map((e) => TherapistModel.fromSnapshot(e)).single;
  //   return therapistData;
  // }

  // Future<List<TherapistModel>> getAllUser() async {
  //   final snapshot = await _db.collection('Therapist').get();
  //   final therapistData =
  //       snapshot.docs.map((e) => TherapistModel.fromSnapshot(e)).toList();
  //   return therapistData;
  // }
