import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HelpSupport extends StatefulWidget {
  const HelpSupport({super.key});

  @override
  State<HelpSupport> createState() => _HelpSupportState();
}

class _HelpSupportState extends State<HelpSupport> {
  late Stream<QuerySnapshot> usersStream;

  @override
  void initState() {
    super.initState();
    final CollectionReference canceld =
        FirebaseFirestore.instance.collection('Respond');
    Query query = canceld.where('UserID',
        isEqualTo: FirebaseAuth.instance.currentUser!.uid);
    usersStream = query.snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                            'المساعدة والدعم',
                            style: TextStyle(
                              color: Color(0xff385a4a),
                              fontSize: 20,
                              fontFamily: "Cairo",
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: IconButton(
                            icon: const Icon(Icons.chevron_right, size: 32.0),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: StreamBuilder<QuerySnapshot>(
                          stream: usersStream,
                          builder: (context,
                              AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                            if (streamSnapshot.hasData) {
                              return ListView.builder(
                                  itemCount: streamSnapshot.data!.docs.length,
                                  itemBuilder: (context, index) {
                                    final DocumentSnapshot documentSnapshot =
                                        streamSnapshot.data!.docs[index];
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      child: Card(
                                        elevation: 4,
                                        shadowColor:
                                            Color.fromARGB(127, 0, 0, 0),

                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(17.80)),

                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  SizedBox(
                                                    width: 18,
                                                    height: 20,
                                                    child: Image.asset(
                                                      "images/support.png",
                                                    ),
                                                  ),
                                                  const SizedBox(width: 15),
                                                  Text(
                                                    'للاطلاع على تفاصيل الرد ',
                                                    style: TextStyle(
                                                      color: Color(0xff385a4a),
                                                      fontSize: 12,
                                                      fontFamily: "Cairo",
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                              elevation: 0,
                                                              minimumSize:
                                                                  Size(100, 35),
                                                              backgroundColor:
                                                                  Color(
                                                                      0xff394445),
                                                              shape:
                                                                  const RoundedRectangleBorder(
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            10)),
                                                              )),
                                                      onPressed: () {
                                                        showDialog(
                                                            context: context,
                                                            builder:
                                                                (context) =>
                                                                    AlertDialog(
                                                                      insetPadding:
                                                                          EdgeInsets.all(
                                                                              15),
                                                                      shape: RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(19)),
                                                                      title:
                                                                          const Text(
                                                                        "تسعدنا حل  مشكلتك في أي وقت",
                                                                        textAlign:
                                                                            TextAlign.right,
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Color(0xff385a4a),
                                                                          fontSize:
                                                                              16,
                                                                          fontFamily:
                                                                              "Cairo",
                                                                          fontWeight:
                                                                              FontWeight.w700,
                                                                        ),
                                                                      ),
                                                                      content:
                                                                          Container(
                                                                        width:
                                                                            300,
                                                                        child:
                                                                            TextField(
                                                                          controller:
                                                                              TextEditingController(
                                                                            text:
                                                                                documentSnapshot['Respond'],
                                                                          ),
                                                                          readOnly:
                                                                              true,
                                                                          keyboardType:
                                                                              TextInputType.multiline,
                                                                          maxLines:
                                                                              5,
                                                                          textDirection:
                                                                              TextDirection.rtl,
                                                                          decoration:
                                                                              InputDecoration(
                                                                            border:
                                                                                OutlineInputBorder(
                                                                              borderSide: BorderSide.none,
                                                                              borderRadius: BorderRadius.circular(8.0),
                                                                            ),
                                                                            filled:
                                                                                true,
                                                                            fillColor: Color.fromARGB(
                                                                                28,
                                                                                155,
                                                                                176,
                                                                                165),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ));
                                                      },
                                                      child: Text(
                                                        'اضغط هنا',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 12,
                                                          fontFamily: "Cairo",
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      )),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),

                                        // subtitle: Text(rejectSessions[index]['description']),
                                      ),
                                    );
                                  });
                            }
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }),
                    ),
                  ])),
        ),
      ),
    );
  }
}
