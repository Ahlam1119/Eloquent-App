import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get_connect/http/src/_http/interface/request_base.dart';

class preivouseSession extends StatefulWidget {
  const preivouseSession({super.key});

  @override
  State<preivouseSession> createState() => _preivouseSessionState();
}

class _preivouseSessionState extends State<preivouseSession> {
  //instance for cloud firestore
  final _auth = FirebaseAuth.instance;
  late String TherapistNote;

  @override
  void initState() {
    super.initState();

    getUserData();
  }

  Map<String, dynamic> ParentData = {};
  getUserData() async {
    await FirebaseFirestore.instance
        .collection('Parent')
        .where(
          "uid",
          isEqualTo: FirebaseAuth.instance.currentUser!.uid,
        )
        .get()
        .then((v) {
      for (var element in v.docs) {
        ParentData.addAll(element.data());
      }
    });
  }

  TextEditingController SessionName = TextEditingController();
  TextEditingController SessionGoul = TextEditingController();

  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  final CollectionReference usersRef = _db.collection('acceptedSessions');
  late Query query = usersRef
      .where('ParentId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .where('Parentstatus', isEqualTo: 'attandend');

  late Stream<QuerySnapshot> usersStream = query.snapshots();
  late String ParentAvatar = ParentData['ParentAvatar'];
  Map<String, dynamic> ReportInfo = {};

//تقييم الأخصائي
  double _rating = 0.0;
  String _comment = '';

  void sendRating(
      {required String ParentAvatar,
      required String TherapistID,
      required double rating,
      required String comment,
      required String parentName}) {
    FirebaseFirestore.instance.collection('ratings').add({
      "ParentAvatar": ParentAvatar,
      'TherapistID': TherapistID,
      'rating': rating,
      'comment': comment,
      'parentId': FirebaseAuth.instance.currentUser!.uid,
      'timestamp': FieldValue.serverTimestamp(),
      'ParentName': parentName
    });
  }

//   void addRating(String therapistId, double rating) {
//   FirebaseFirestore.instance.runTransaction((transaction) async {
//     DocumentReference therapistRef =
//         FirebaseFirestore.instance.collection('Therapist').doc(therapistId);

//     DocumentSnapshot therapistSnapshot = await transaction.get(therapistRef);
//     Map<String, dynamic> therapistData = therapistSnapshot.data()!;

//     // Update the total rating and rating count in the therapist document
//     double totalRating = (therapistData['totalRating'] ?? 0) + rating;
//     int ratingCount = (therapistData['ratingCount'] ?? 0) + 1;
//     transaction.update(therapistRef, {
//       'totalRating': totalRating,
//       'ratingCount': ratingCount,
//     });

//     // Add the new rating to the ratings map in the therapist document
//     String ratingId = DateTime.now().millisecondsSinceEpoch.toString();
//     transaction.set(
//       therapistRef.collection('ratings').doc(ratingId),
//       {'rating': rating},
//     );
//   });
// }

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
                  String timeRange = documentSnapshot['TimeRange'];
                  late String Sid = documentSnapshot['sessionID'];
                  // getUserData(Sid);
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    child: Card(
                      elevation: 0,
                      color: Color(0xfffbfbfb),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(17.80)),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),

                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Column(
                                    children: [
                                      Text(timeRange.split(
                                          ' - ')[0]), // Display the start time
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        height: 28.0,
                                        child: VerticalDivider(
                                            color: Color.fromARGB(
                                                255, 59, 52, 52)),
                                      ), // Display the vertical line
                                      Text(timeRange.split(
                                          ' - ')[1]), // Display the end time
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          documentSnapshot['SessionName'],
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            color: Color(0xff385a4a),
                                            fontSize: 17,
                                            fontFamily: "Cairo",
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        Image.asset(
                                          "images/NameCard.png",
                                        ),
                                        const SizedBox(width: 5),
                                        Text(
                                          "د/ " +
                                              documentSnapshot['TherapistName'],
                                          style: TextStyle(
                                            color: Color(0xff6888a0),
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        Image.asset(
                                          "images/Calnder.png",
                                        ),
                                        const SizedBox(width: 5),
                                        Text(
                                          documentSnapshot['Date'],
                                          style: TextStyle(
                                            color: Color(0xff6888a0),
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 2),
                              child: Column(
                                children: [
                                  ElevatedButton(
                                    onPressed: () async {
                                      showDialog(
                                          context: context,
                                          builder: (context) => Theme(
                                              data:
                                                  ThemeData(useMaterial3: true),
                                              child: Directionality(
                                                textDirection:
                                                    TextDirection.rtl,
                                                child: AlertDialog(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16),
                                                  ),
                                                  insetPadding:
                                                      EdgeInsets.all(15),
                                                  content:
                                                      SingleChildScrollView(
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          "تقييم الجلسة",
                                                          style: TextStyle(
                                                            color: Color(
                                                                0xff385a4a),
                                                            fontSize: 21,
                                                            fontFamily: "Cairo",
                                                            fontWeight:
                                                                FontWeight.w700,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Text(
                                                          documentSnapshot[
                                                              'Date'],
                                                          textAlign:
                                                              TextAlign.right,
                                                          style: TextStyle(
                                                            color: Color(
                                                                0xff9bb0a5),
                                                            fontSize: 15,
                                                            fontFamily:
                                                                "Montserrat",
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                        SizedBox(height: 10),
                                                        Center(
                                                          child:
                                                              //تقيم الجلسة
                                                              RatingBar.builder(
                                                            unratedColor:
                                                                Color.fromARGB(
                                                                    255,
                                                                    241,
                                                                    240,
                                                                    240),
                                                            initialRating:
                                                                _rating,
                                                            minRating: 1,
                                                            direction:
                                                                Axis.horizontal,
                                                            allowHalfRating:
                                                                true,
                                                            itemCount: 5,
                                                            itemPadding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        4.0),
                                                            itemBuilder:
                                                                (context, _) =>
                                                                    Icon(
                                                              Icons.star,
                                                              color:
                                                                  Colors.amber,
                                                            ),
                                                            onRatingUpdate:
                                                                (rating) {
                                                              setState(() {
                                                                _rating =
                                                                    rating;
                                                              });
                                                            },
                                                          ),
                                                        ),
                                                        SizedBox(height: 20),
                                                        SizedBox(
                                                          width: 350,
                                                          child: TextField(
                                                            maxLines: 3,
                                                            textDirection:
                                                                TextDirection
                                                                    .rtl,
                                                            decoration:
                                                                InputDecoration(
                                                              border:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide
                                                                        .none,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            7.0),
                                                              ),
                                                              hintText:
                                                                  "اكتب تعليقك هنا",
                                                              filled:
                                                                  true, // set filled to true
                                                              fillColor: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      249,
                                                                      248,
                                                                      248), // set fillColor to the desired color
                                                            ),
                                                            onChanged: (value) {
                                                              setState(() {
                                                                _comment =
                                                                    value;
                                                              });
                                                            },
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  actions: [
                                                    Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                                minimumSize:
                                                                    Size(160,
                                                                        39),
                                                                backgroundColor:
                                                                    Color(
                                                                        0xff394445),
                                                                shape:
                                                                    const RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              10)),
                                                                )),
                                                        child: Text(
                                                          "ارسل التقييم",
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 15,
                                                            fontFamily: "Cairo",
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                        onPressed: () {
                                                          sendRating(
                                                              ParentAvatar:
                                                                  ParentAvatar,
                                                              parentName:
                                                                  ParentData[
                                                                      'name'],
                                                              TherapistID:
                                                                  documentSnapshot[
                                                                      'TherapistID'],
                                                              rating: _rating,
                                                              comment:
                                                                  _comment);
                                                          //TODO: implement sending rating and comment to Firebase

                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )));
                                    },
                                    child: Text(
                                      "قيم الجلسة",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontFamily: "Rubik",
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                        elevation: 1,
                                        minimumSize: Size(20, 26),
                                        backgroundColor: Color(0xff394445),
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                        )),
                                  ),
                                  // ElevatedButton(
                                  //   onPressed: () {},
                                  //   child: Text(
                                  //     "تفاصيل الجلسة ",
                                  //     style: TextStyle(
                                  //       color: Color.fromARGB(255, 0, 0, 0),
                                  //       fontSize: 12,
                                  //       fontFamily: "Cairo",
                                  //       fontWeight: FontWeight.w500,
                                  //     ),
                                  //   ),
                                  //   style: ElevatedButton.styleFrom(
                                  //       elevation: 0,
                                  //       minimumSize: const Size(20, 30),
                                  //       backgroundColor:
                                  //           const Color(0xfffbfbfb),
                                  //       shape: const RoundedRectangleBorder(
                                  //         borderRadius: BorderRadius.all(
                                  //             Radius.circular(15)),
                                  //       )),
                                  // )
                                ],
                              ),
                            ),
                          ],
                        ),

                        // title: Text(
                        //   documentSnapshot['name'],
                        //   textAlign: TextAlign.right,
                        //   style: TextStyle(
                        //     color: Color(0xff385a4a),
                        //     fontSize: 15,
                        //     fontFamily: "Cairo",
                        //     fontWeight: FontWeight.w700,
                        //   ),
                        // ),
                        // subtitle: Text(
                        //   documentSnapshot['ParentName'],
                        //   textAlign: TextAlign.right,
                        //   style: TextStyle(
                        //     color: Color(0xff6888a0),
                        //     fontSize: 12,
                        //   ),
                        // ),
                      ),
                    ),
                  );
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
