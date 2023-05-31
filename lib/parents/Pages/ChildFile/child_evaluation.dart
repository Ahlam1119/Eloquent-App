import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class childEvaluationPage extends StatefulWidget {
  const childEvaluationPage({super.key});

  @override
  State<childEvaluationPage> createState() => _childEvaluationPageState();
}

class _childEvaluationPageState extends State<childEvaluationPage> {
  final CollectionReference _Child =
      FirebaseFirestore.instance.collection('test_results');
  late Query query = _Child.where('ParentID',
      isEqualTo: FirebaseAuth.instance.currentUser!.uid);

  late Stream<QuerySnapshot> usersStream = query.snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "اتقان الحروف",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Color(0xff385a4a),
                          fontSize: 22,
                          fontFamily: "Cairo",
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 20,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "شجع، حفز، وساعد طفلك",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Color(0xff687c71),
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ]),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: Container(
                //هنا اعرض القائمة
                child: StreamBuilder<QuerySnapshot>(
                  stream: usersStream,
                  builder:
                      (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                    if (streamSnapshot.hasData) {
                      return ListView.builder(
                          itemCount: streamSnapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            final DocumentSnapshot documentSnapshot =
                                streamSnapshot.data!.docs[index];
                            return Container(
                              width: 343,
                              height: 130,
                              child: Card(
                                  color: Color(0x0c9bb0a5),
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(17.80)),
                                  child: GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 10),
                                        alignment: Alignment.center,
                                        width: 275,
                                        height: 80,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 10, top: 20),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    documentSnapshot['letter'],
                                                    textAlign: TextAlign.right,
                                                    style: TextStyle(
                                                      color: Color(0xff385a4a),
                                                      fontSize: 16,
                                                      fontFamily: "Cairo",
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Image.asset(
                                                        "images/Calnder.png",
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text(
                                                        documentSnapshot[
                                                            'date'],
                                                        textAlign:
                                                            TextAlign.right,
                                                        style: TextStyle(
                                                          fontFamily: "Cairo",
                                                          color:
                                                              Color(0xff6888a0),
                                                          fontSize: 15,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Column(
                                              children: [
                                                ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            minimumSize:
                                                                Size(70, 30),
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
                                                    onPressed: () async {
                                                      _delete(
                                                          documentSnapshot.id);
                                                      String letter =
                                                          documentSnapshot[
                                                              'letter'];
                                                      FirebaseFirestore.instance
                                                          .collection(
                                                              'ChildEvaluation')
                                                          .add({
                                                        'ParentID': FirebaseAuth
                                                            .instance
                                                            .currentUser!
                                                            .uid,
                                                        '$letter': true,
                                                        'letterName':
                                                            documentSnapshot[
                                                                'LetterName'],
                                                        "pass": true
                                                      });

                                                      QuerySnapshot
                                                          querySnapshot =
                                                          await FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  'test_results')
                                                              .where('ParentID',
                                                                  isEqualTo: FirebaseAuth
                                                                      .instance
                                                                      .currentUser!
                                                                      .uid)
                                                              .get();
                                                      //   querySnapshot.docs
                                                      // .forEach(

                                                      //       (document) {
                                                      //  document.reference
                                                      //   .delete();
                                                      //  }
                                                      //   );
                                                    },
                                                    child: Text(
                                                      'اتقن',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 15,
                                                        fontFamily: "Rubik",
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    )),
                                                ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            minimumSize:
                                                                Size(60, 30),
                                                            backgroundColor:
                                                                Color(
                                                                    0xffd21414),
                                                            shape:
                                                                const RoundedRectangleBorder(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          10)),
                                                            )),
                                                    onPressed: () async {
                                                      _delete(
                                                          documentSnapshot.id);
                                                      String letter =
                                                          documentSnapshot[
                                                              'letter'];
                                                      FirebaseFirestore.instance
                                                          .collection(
                                                              'ChildEvaluation')
                                                          .add({
                                                        'ParentID': FirebaseAuth
                                                            .instance
                                                            .currentUser!
                                                            .uid,
                                                        'letterName':
                                                            documentSnapshot[
                                                                'LetterName'],
                                                        "pass": false
                                                      });

                                                      QuerySnapshot
                                                          querySnapshot =
                                                          await FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  'test_results')
                                                              .where('ParentID',
                                                                  isEqualTo: FirebaseAuth
                                                                      .instance
                                                                      .currentUser!
                                                                      .uid)
                                                              .get();
                                                      //   querySnapshot.docs
                                                      // .forEach(

                                                      //       (document) {
                                                      //  document.reference
                                                      //   .delete();
                                                      //  }
                                                      //   );
                                                    },
                                                    child: Text(
                                                      'لم يتقن',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 15,
                                                        fontFamily: "Rubik",
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    )),
                                              ],
                                            ),
                                          ],
                                        )),
                                  )),
                            );
                          });
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Future<void> _delete(String Child) async {
    await _Child.doc(Child).delete();
  }
}
