import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TherapistReport extends StatefulWidget {
  late String ChildID;
  TherapistReport({required this.ChildID});

  @override
  State<TherapistReport> createState() => _TherapistReportState();
}

class _TherapistReportState extends State<TherapistReport> {
  //instance for cloud firestore
  final _auth = FirebaseAuth.instance;
  late String TherapistNote;
  late String childID;

  @override
  void initState() {
    super.initState();
  }

  late DocumentReference ReportRef =
      FirebaseFirestore.instance.collection('Report').doc();

// the riport will be get if both parent and therapist have a session
  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  final CollectionReference usersRef = _db.collection('acceptedSessions');
  late Query query = usersRef
      .where('ChildID', isEqualTo: widget.ChildID)
      .where('Parentstatus', isEqualTo: 'attandend')
      .where('TherapistStatus', isEqualTo: 'attandend');

  late Stream<QuerySnapshot> usersStream = query.snapshots();

  Map<String, dynamic> ReportInfo = {};
  late String TherapistNotes;
  @override
  Widget build(BuildContext context) {
    var textStyle = TextStyle(
      color: Color(0xff6888a0),
      fontSize: 15,
      fontFamily: "Rubik",
      fontWeight: FontWeight.w600,
    );
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: StreamBuilder<QuerySnapshot>(
          stream: usersStream,
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.hasData) {
              return ListView.builder(
                  itemCount: streamSnapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final DocumentSnapshot documentSnapshot =
                        streamSnapshot.data!.docs[index];

                    late String Sid = documentSnapshot['sessionID'];

                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5,
                      ),
                      child: Card(
                        elevation: 0,
                        color: Color(0x0c9bb0a5),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(17.80)),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const SizedBox(width: 5),
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
                                  // Row(
                                  //   children: [
                                  //     Image.asset(
                                  //       "images/NameCard.png",
                                  //     ),
                                  //     const SizedBox(width: 10),
                                  //     Text(
                                  //       documentSnapshot['SessionGoul'],
                                  //       style: TextStyle(
                                  //         color: Color(0xff6888a0),
                                  //         fontSize: 14,
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      Image.asset(
                                        "images/Calnder.png",
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        "موعد الجلسة :" +
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
                              Padding(
                                padding: const EdgeInsets.only(left: 2),
                                child: Column(
                                  children: [
                                    ElevatedButton(
                                      onPressed: () async {
                                        await FirebaseFirestore.instance
                                            .collection('Report')
                                            .where("ReportID", isEqualTo: Sid)
                                            .get()
                                            .then((v) {
                                          for (var element in v.docs) {
                                            ReportInfo.addAll(element.data());
                                          }
                                        });
                                        final TherapistNotes =
                                            TextEditingController();
                                        if (ReportInfo['TherapistNote'] !=
                                            null) {
                                          TherapistNotes.text =
                                              ReportInfo['TherapistNote'];
                                        }
                                        showModalBottomSheet(
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(35.0),
                                                topRight: Radius.circular(35.0),
                                              ),
                                            ),
                                            isScrollControlled: true,
                                            context: context,
                                            builder: (BuildContext context) {
                                              return StatefulBuilder(builder:
                                                  (BuildContext context,
                                                      StateSetter setState) {
                                                final bottomInset =
                                                    MediaQuery.of(context)
                                                        .viewInsets
                                                        .bottom;
                                                return SizedBox(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.71,
                                                    child:
                                                        SingleChildScrollView(
                                                      reverse: true,
                                                      child: Container(
                                                        padding:
                                                            EdgeInsets.only(
                                                          bottom: bottomInset,
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      20,
                                                                  vertical: 10),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Image.asset(
                                                                    "images/Report.png",
                                                                  ),
                                                                  SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  Text(
                                                                    'تقرير | ',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .right,
                                                                    style:
                                                                        TextStyle(
                                                                      color: Color(
                                                                          0xff385a4a),
                                                                      fontSize:
                                                                          25,
                                                                      fontFamily:
                                                                          "Cairo",
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700,
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        top:
                                                                            14),
                                                                    child: Text(
                                                                      documentSnapshot[
                                                                          'SessionName'],
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              17,
                                                                          fontFamily:
                                                                              "Cairo",
                                                                          fontWeight: FontWeight
                                                                              .w600,
                                                                          color:
                                                                              Colors.grey),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 20,
                                                              ),
                                                              Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Row(
                                                                    children: [
                                                                      Image
                                                                          .asset(
                                                                        "images/ReportTherapist.png",
                                                                      ),
                                                                      const SizedBox(
                                                                          width:
                                                                              15),
                                                                      Text(
                                                                        documentSnapshot[
                                                                            'ChildName'],
                                                                        style:
                                                                            textStyle,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  SizedBox(
                                                                    height: 10,
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      Image
                                                                          .asset(
                                                                        "images/ReportDate.png",
                                                                      ),
                                                                      const SizedBox(
                                                                          width:
                                                                              15),
                                                                      Text(
                                                                        documentSnapshot[
                                                                            'Date'],
                                                                        style:
                                                                            textStyle,
                                                                      )
                                                                    ],
                                                                  ),
                                                                  SizedBox(
                                                                    height: 10,
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      Image
                                                                          .asset(
                                                                        "images/Clock.png",
                                                                      ),
                                                                      const SizedBox(
                                                                          width:
                                                                              15),
                                                                      Text(
                                                                        documentSnapshot[
                                                                            'TimeRange'],
                                                                        style:
                                                                            textStyle,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  SizedBox(
                                                                    height: 15,
                                                                  ),
                                                                  TextField(
                                                                    controller:
                                                                        TextEditingController(
                                                                      text: documentSnapshot[
                                                                          'SessionGoul'],
                                                                    ),
                                                                    style:
                                                                        TextStyle(
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          50,
                                                                          81,
                                                                          66),
                                                                      fontSize:
                                                                          16,
                                                                      fontFamily:
                                                                          "Rubik",
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                    ),
                                                                    readOnly:
                                                                        true,
                                                                    keyboardType:
                                                                        TextInputType
                                                                            .multiline,
                                                                    textDirection:
                                                                        TextDirection
                                                                            .rtl,
                                                                    maxLines: 2,
                                                                    decoration:
                                                                        InputDecoration(
                                                                      border:
                                                                          OutlineInputBorder(
                                                                        borderSide:
                                                                            BorderSide.none,
                                                                        borderRadius:
                                                                            BorderRadius.circular(8.0),
                                                                      ),
                                                                      filled:
                                                                          true,
                                                                      fillColor: Color.fromARGB(
                                                                          251,
                                                                          242,
                                                                          242,
                                                                          242),
                                                                      prefixIcon:
                                                                          Column(
                                                                        mainAxisSize:
                                                                            MainAxisSize.min,
                                                                        children: <
                                                                            Widget>[
                                                                          Padding(
                                                                            padding:
                                                                                EdgeInsets.only(right: 8.0, top: 2),
                                                                            child:
                                                                                Text(
                                                                              " هدف الجلسة: ",
                                                                              textAlign: TextAlign.right,
                                                                              style: TextStyle(
                                                                                color: Color(0xff385a4a),
                                                                                fontSize: 16,
                                                                                fontFamily: "Rubik",
                                                                                fontWeight: FontWeight.w500,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 15,
                                                                  ),
                                                                  TextField(
                                                                    controller:
                                                                        TextEditingController(
                                                                      text: documentSnapshot[
                                                                          'ParentNote'],
                                                                    ),
                                                                    style:
                                                                        TextStyle(
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          50,
                                                                          81,
                                                                          66),
                                                                      fontSize:
                                                                          16,
                                                                      fontFamily:
                                                                          "Rubik",
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                    ),
                                                                    readOnly:
                                                                        true,
                                                                    keyboardType:
                                                                        TextInputType
                                                                            .multiline,
                                                                    textDirection:
                                                                        TextDirection
                                                                            .rtl,
                                                                    maxLines: 2,
                                                                    decoration:
                                                                        InputDecoration(
                                                                      border:
                                                                          OutlineInputBorder(
                                                                        borderSide:
                                                                            BorderSide.none,
                                                                        borderRadius:
                                                                            BorderRadius.circular(8.0),
                                                                      ),
                                                                      filled:
                                                                          true,
                                                                      fillColor: Color.fromARGB(
                                                                          251,
                                                                          242,
                                                                          242,
                                                                          242),
                                                                      prefixIcon:
                                                                          Column(
                                                                        mainAxisSize:
                                                                            MainAxisSize.min,
                                                                        children: <
                                                                            Widget>[
                                                                          Padding(
                                                                            padding:
                                                                                EdgeInsets.only(right: 8.0, top: 2),
                                                                            child:
                                                                                Text(
                                                                              "  ملاحظات الأهل: ",
                                                                              textAlign: TextAlign.right,
                                                                              style: TextStyle(
                                                                                color: Color(0xff385a4a),
                                                                                fontSize: 16,
                                                                                fontFamily: "Rubik",
                                                                                fontWeight: FontWeight.w500,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 15,
                                                                  ),
                                                                  TextField(
                                                                    controller:
                                                                        TherapistNotes,
                                                                    keyboardType:
                                                                        TextInputType
                                                                            .multiline,
                                                                    maxLines: 3,
                                                                    textDirection:
                                                                        TextDirection
                                                                            .rtl,
                                                                    decoration:
                                                                        InputDecoration(
                                                                      border:
                                                                          OutlineInputBorder(
                                                                        borderSide:
                                                                            BorderSide.none,
                                                                        borderRadius:
                                                                            BorderRadius.circular(8.0),
                                                                      ),
                                                                      filled:
                                                                          true,
                                                                      fillColor: Color.fromARGB(
                                                                          251,
                                                                          242,
                                                                          242,
                                                                          242),
                                                                      prefixIcon:
                                                                          Column(
                                                                        mainAxisSize:
                                                                            MainAxisSize.min,
                                                                        children: <
                                                                            Widget>[
                                                                          Padding(
                                                                            padding:
                                                                                EdgeInsets.only(right: 8.0, bottom: 40),
                                                                            child:
                                                                                Text(
                                                                              "  ملاحظات الأخصائي: ",
                                                                              textAlign: TextAlign.right,
                                                                              style: TextStyle(
                                                                                color: Color(0xff385a4a),
                                                                                fontSize: 16,
                                                                                fontFamily: "Rubik",
                                                                                fontWeight: FontWeight.w500,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 20,
                                                                  ),
                                                                  Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child:
                                                                        ElevatedButton(
                                                                      onPressed:
                                                                          () async {
                                                                        FirebaseFirestore
                                                                            .instance
                                                                            .collection('Report')
                                                                            .add({
                                                                          'ReportID':
                                                                              Sid,
                                                                          'TherapistNote':
                                                                              TherapistNotes.text,
                                                                        });

                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                      child: Text(
                                                                          "حفظ التقرير"),
                                                                      style: ElevatedButton.styleFrom(
                                                                          minimumSize: Size(170, 40),
                                                                          backgroundColor: Color(0xff394445),
                                                                          shape: const RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                BorderRadius.all(Radius.circular(12)),
                                                                          )),
                                                                    ),
                                                                  )
                                                                ],
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ));
                                              });
                                            });
                                      },
                                      child: Text(
                                        "تقرير الجلسة ",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 13,
                                          fontFamily: "Rubik",
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                          elevation: 1,
                                          minimumSize: Size(40, 30),
                                          backgroundColor: Color(0xff394445),
                                          shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
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
      ),
    );
  }
}
