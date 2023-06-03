import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';

class CommentPage extends StatefulWidget {
  late String therpaistId;
  CommentPage({required this.therpaistId});

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  //instance for cloud firestore
  final _auth = FirebaseAuth.instance;
  late String TherapistNote;

  @override
  void initState() {
    super.initState();
  }

  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  final CollectionReference usersRef = _db.collection('ratings');
  late Query query =
      usersRef.where('TherapistID', isEqualTo: widget.therpaistId);

  late Stream<QuerySnapshot> usersStream = query.snapshots();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<QuerySnapshot>(
        stream: usersStream,
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
                itemCount: streamSnapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final DocumentSnapshot documentSnapshot =
                      streamSnapshot.data!.docs[index];
                  final Timestamp timestamp = documentSnapshot['timestamp'];
                  final DateTime dateTime = timestamp.toDate();
                  late String formattedCurrentDate =
                      DateFormat('dd/M/yyyy').format(dateTime);

                  return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 5),
                      child: Card(
                          shadowColor: Color.fromARGB(105, 0, 0, 0),
                          elevation: 4,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(17.80)),
                          child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: CircleAvatar(
                                          radius: 23,
                                          backgroundColor: Color(0xffEFF5F2),
                                          foregroundColor: Color(0xffEFF5F2),
                                          backgroundImage: AssetImage(
                                              documentSnapshot['ParentAvatar']),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                documentSnapshot['ParentName'],
                                                textAlign: TextAlign.right,
                                                style: TextStyle(
                                                  color: Color(0xff385a4a),
                                                  fontSize: 15,
                                                  fontFamily: "Cairo",
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 90,
                                              ),
                                              RatingBar.builder(
                                                itemSize: 16,
                                                initialRating:
                                                    documentSnapshot['rating'],
                                                minRating: 1,
                                                maxRating: 5,
                                                direction: Axis.horizontal,
                                                allowHalfRating: true,
                                                itemCount: 5,
                                                itemPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 4.0),
                                                itemBuilder: (context, _) =>
                                                    Icon(
                                                  Icons.star,
                                                  color: Colors.amber,
                                                ),
                                                onRatingUpdate: (rating) {
                                                  // Handle rating updates here.
                                                },
                                              ),
                                            ],
                                          ),
                                          Text(
                                            formattedCurrentDate,
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                              color: Color(0xff394445),
                                              fontSize: 13.24,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          SizedBox(
                                            width: 254,
                                            child: Text(
                                              documentSnapshot['comment'],
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                                  color: Color(0xff6888a0),
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ))));
                });
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
