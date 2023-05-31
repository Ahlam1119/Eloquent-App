import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CanceldSessionsScreen extends StatefulWidget {
  const CanceldSessionsScreen({super.key});

  @override
  State<CanceldSessionsScreen> createState() => _CanceldSessionsScreenState();
}

class _CanceldSessionsScreenState extends State<CanceldSessionsScreen> {
  late Stream<QuerySnapshot> usersStream;

  @override
  void initState() {
    super.initState();
    final CollectionReference rejected = FirebaseFirestore.instance
        .collection('Parent')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('RejuctAndCanceld');
    Query query = rejected.where('status', isEqualTo: 'rejected');
    usersStream = query.snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                    return Card(
                      elevation: 4,
                      shadowColor: Color.fromARGB(127, 0, 0, 0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(17.80)),

                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Row(
                                //   children: [
                                //     Text(
                                //       "جلسة  " + documentSnapshot['SessionName'],
                                //       style: TextStyle(
                                //         color: Color(0xff385a4a),
                                //         fontSize: 17,
                                //         fontFamily: "Cairo",
                                //         fontWeight: FontWeight.w700,
                                //       ),
                                //     ),
                                //   ],
                                // ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 18,
                                      height: 20,
                                      child: Image.asset(
                                        "images/ReportTherapist.png",
                                      ),
                                    ),
                                    const SizedBox(width: 15),
                                    Text(
                                      "د/ " + documentSnapshot['TherapisName'],
                                      style: TextStyle(
                                        color: Color(0xff6888a0),
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 18,
                                      height: 20,
                                      child: Image.asset(
                                        "images/ReportDate.png",
                                      ),
                                    ),
                                    const SizedBox(width: 15),
                                    Text(
                                      documentSnapshot['Date'],
                                      style: TextStyle(
                                        color: Color(0xff6888a0),
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 18,
                                      height: 20,
                                      child: Image.asset(
                                        "images/Clock.png",
                                      ),
                                    ),
                                    const SizedBox(width: 15),
                                    Text(
                                      documentSnapshot['Range'],
                                      style: TextStyle(
                                        color: Color(0xff6888a0),
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        elevation: 0,
                                        minimumSize: Size(100, 35),
                                        backgroundColor: Color(0xff394445),
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                        )),
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                                insetPadding:
                                                    EdgeInsets.all(15),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            19)),
                                                title: const Text(
                                                  "السبب من رفض الجلسة",
                                                  textAlign: TextAlign.right,
                                                  style: TextStyle(
                                                    color: Color(0xff385a4a),
                                                    fontSize: 16,
                                                    fontFamily: "Cairo",
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                                content: Container(
                                                  width: 300,
                                                  child: TextField(
                                                    controller:
                                                        TextEditingController(
                                                      text: documentSnapshot[
                                                          'Reason'],
                                                    ),
                                                    readOnly: true,
                                                    keyboardType:
                                                        TextInputType.multiline,
                                                    maxLines: 5,
                                                    textDirection:
                                                        TextDirection.rtl,
                                                    decoration: InputDecoration(
                                                      border:
                                                          OutlineInputBorder(
                                                        borderSide:
                                                            BorderSide.none,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                      ),
                                                      filled: true,
                                                      fillColor: Color.fromARGB(
                                                          28, 155, 176, 165),
                                                    ),
                                                  ),
                                                ),
                                              ));
                                    },
                                    child: Text(
                                      'سبب الرفض',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontFamily: "Cairo",
                                        fontWeight: FontWeight.w500,
                                      ),
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // subtitle: Text(rejectSessions[index]['description']),
                    );
                  });
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
