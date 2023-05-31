import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Request extends StatefulWidget {
  final TherapistId;
  const Request({this.TherapistId});

  @override
  State<Request> createState() => _RequestState();
}

class _RequestState extends State<Request> {
  final CollectionReference _Request =
      FirebaseFirestore.instance.collection('Request');

  late String therapistName;
  late String therapistId = widget.TherapistId;

  @override
  void initState() {
    super.initState();
    // print(therapistId);
  }

  // final _auth = FirebaseAuth.instance;
  // final _firestore = FirebaseFirestore.instance;
  // late User singedInUser;
  // void getCurrentUser() {
  //   try {
  //     final user = _auth.currentUser;
  //     if (user != null) {
  //       singedInUser = user;
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  // _fetch() async {
  //   if (singedInUser != null)
  //     await FirebaseFirestore.instance
  //         .collection("Therapist")
  //         .doc(singedInUser.uid)
  //         .get()
  //         .then((ds) {
  //       therapistId = ds.get("Uuid");
  //       print(therapistId);
  //     }).catchError((e) {
  //       print(e);
  //     });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
          stream: _Request.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            List<Text> info = [];
            if (streamSnapshot.hasData) {
              return ListView.builder(
                  itemCount: streamSnapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final DocumentSnapshot documentSnapshot =
                        streamSnapshot.data!.docs[index];
                    // if (documentSnapshot['TherapistID'] == therapistId) {
                    return Card(
                      child: ListTile(
                        title: Text('Parent Name :' +
                            documentSnapshot['ParentName'] +
                            'therapistName :' +
                            documentSnapshot['TherapistName']),
                        trailing: SizedBox(
                          width: 150,
                          child: Row(
                            children: [
                              ElevatedButton(
                                onPressed: () async {
                                  if (documentSnapshot['Statu'] != null) {
                                    await _Request.doc(documentSnapshot!.id)
                                        .update({"Statu": "susseful"});
                                  }
                                },
                                child: Text('قبول'),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  if (documentSnapshot['Statu'] != null) {
                                    await _Request.doc(documentSnapshot!.id)
                                        .update({"Statu": "rejact"});
                                  }
                                },
                                child: Text('رفض'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                    // }
                    // return Center(
                    //   child: CircularProgressIndicator(),
                    // );
                  });
            }

            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
