import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eloquentapp/screens/callPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TodaySession extends StatefulWidget {
  const TodaySession({super.key});

  @override
  State<TodaySession> createState() => _TodaySessionState();
}

class _TodaySessionState extends State<TodaySession> {
  //instance for cloud firestore
  final _auth = FirebaseAuth.instance;

  late User singedInUser;
  @override
  void initState() {
    super.initState();
    getCurrentUser();
    getUserData();
  }

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        singedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  // get the current date

  // late Timestamp timestamp = SessionInfo['DateTime'];
  // late DateTime dateTime = timestamp.toDate();

// format the current date as a string without the time component
  // late String formattedCurrentDate =
  //     "${currentDate.year}/${currentDate.month.toString().padLeft(2, '0')}/${currentDate.day.toString().padLeft(2, '0')}";
  //-----------------------------------------------------------------------------------------------------------------

  DateTime currentDate = DateTime.now();
  late String formattedCurrentDate =
      DateFormat('dd/M/yyyy').format(currentDate);

  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  final CollectionReference usersRef = _db.collection('acceptedSessions');
  late Query query = usersRef
      .where('TherapistID', isEqualTo: singedInUser.uid)
      .where('TherapistStatus', isEqualTo: 'accepted')
      .where('Date', isEqualTo: formattedCurrentDate);

  late Stream<QuerySnapshot> usersStream = query.snapshots();

  //الجلسات المجدولة

  Map<String, dynamic> SessionInfo = {};
  // late DateTime currentDate = DateTime.now();
  //get all user data and store to Map
  getUserData() async {
    await FirebaseFirestore.instance
        .collection('acceptedSessions')
        .where("TherapistID", isEqualTo: singedInUser.uid)
        .get()
        .then((v) {
      for (var element in v.docs) {
        SessionInfo.addAll(element.data());
      }
    });
  }

  late String SessionID = SessionInfo['sessionID'];
  late String TherapistName = SessionInfo['TherapistName'];
  late String Sessionname = SessionInfo['SessionName'];
  late String SessionGoal = SessionInfo['SessionGoul'];
  final TextEditingController SessionNameController = TextEditingController();
  final TextEditingController SessionGoalController = TextEditingController();
  updateRequestedSessiom(docId) async {
    var sessionRef = _db.collection('acceptedSessions');
    await sessionRef
        .doc(docId)
        .update({"SessionName": Sessionname, "SessionGoul": SessionGoal});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
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

                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    child: Card(
                      elevation: 0,
                      color: Color(0x0c9bb0a5),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(11)),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),

                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Column(
                                children: [
                                  Text(timeRange.split(
                                      ' - ')[0]), // Display the start time
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 8.0),
                                    height: 28.0,
                                    child: VerticalDivider(
                                        color: Color.fromARGB(255, 59, 52, 52)),
                                  ), // Display the vertical line
                                  Text(timeRange
                                      .split(' - ')[1]), // Display the end time
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'جلسة ' + documentSnapshot['ChildName'],
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
                                    Text(
                                      documentSnapshot['SessionName'],
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
                                    Text(
                                      "موعد الجلسة " + documentSnapshot['Date'],
                                      style: const TextStyle(
                                        color: Color(0xff6888a0),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                ElevatedButton(
                                  onPressed: () async {
                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (context) {
                                        return CallPage(
                                          callID: SessionID,
                                          UserId: singedInUser.uid,
                                          Name: TherapistName,
                                        );
                                      },
                                    ));
                                    if (documentSnapshot['TherapistStatus'] !=
                                        null) {
                                      QuerySnapshot querySnapshot =
                                          await FirebaseFirestore.instance
                                              .collection('acceptedSessions')
                                              .where('TherapistStatus',
                                                  isEqualTo: 'accepted')
                                              .get();

                                      querySnapshot.docs.forEach((document) {
                                        document.reference.update(
                                            {"TherapistStatus": "attandend"});
                                      });
                                    }
                                  },
                                  child: Text(
                                    "حضور الجلسة ",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontFamily: "Cairo",
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                      minimumSize: Size(20, 30),
                                      backgroundColor: Color(0xff394445),
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                      )),
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    showModalBottomSheet(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(35.0),
                                            topRight: Radius.circular(35.0),
                                          ),
                                        ),
                                        context: context,
                                        builder: (context) => Center(
                                              child: ListView(children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                right: 30,
                                                                top: 30,
                                                                bottom: 23),
                                                        child: Text(
                                                          'تفاصيل الجلسة',
                                                          textAlign:
                                                              TextAlign.right,
                                                          style: TextStyle(
                                                            color: Color(
                                                                0xff385a4a),
                                                            fontSize: 23,
                                                            fontFamily: "Cairo",
                                                            fontWeight:
                                                                FontWeight.w700,
                                                          ),
                                                        )),
                                                    Center(
                                                      child: Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 20),
                                                        child: Container(
                                                          width: 335,
                                                          height: 50,
                                                          child: TextField(
                                                            controller:
                                                                TextEditingController(
                                                                    text:
                                                                        Sessionname),
                                                            onChanged:
                                                                ((value) {
                                                              Sessionname =
                                                                  value;
                                                            }),
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
                                                                            8.0),
                                                              ),
                                                              filled: true,
                                                              fillColor: Colors
                                                                  .grey[200],
                                                              prefixIcon:
                                                                  Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: <
                                                                    Widget>[
                                                                  Padding(
                                                                    padding: EdgeInsets.only(
                                                                        right:
                                                                            8.0),
                                                                    child: Text(
                                                                      "اسم الجلسة: ",
                                                                      textAlign:
                                                                          TextAlign
                                                                              .right,
                                                                      style:
                                                                          TextStyle(
                                                                        color: Color(
                                                                            0xff385a4a),
                                                                        fontSize:
                                                                            15,
                                                                        fontFamily:
                                                                            "Rubik",
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),

                                                    ///---------------------------------------
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    Center(
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Colors.grey[200],
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                        width: 335,
                                                        height: 50,
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 10),
                                                        child: Align(
                                                          alignment: Alignment
                                                              .centerRight,
                                                          child: Text(
                                                            'اسم الطفل:  ' +
                                                                documentSnapshot[
                                                                    'ChildName'],
                                                            textAlign:
                                                                TextAlign.right,
                                                            style: TextStyle(
                                                              color: Color(
                                                                  0xff385a4a),
                                                              fontSize: 15,
                                                              fontFamily:
                                                                  "Rubik",
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    Center(
                                                      child: Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 20),
                                                        child: Container(
                                                          width: 335,
                                                          child: TextField(
                                                            textAlign:
                                                                TextAlign.right,

                                                            keyboardType:
                                                                TextInputType
                                                                    .multiline,
                                                            maxLines: 3,

                                                            // minLines: 10,
                                                            // maxLength: 12,
                                                            controller:
                                                                TextEditingController(
                                                                    text:
                                                                        SessionGoal),
                                                            onChanged:
                                                                ((value) {
                                                              SessionGoal =
                                                                  value;
                                                            }),
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
                                                                            8.0),
                                                              ),
                                                              filled: true,
                                                              fillColor: Colors
                                                                  .grey[200],
                                                              prefixIcon:
                                                                  Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: <
                                                                    Widget>[
                                                                  Padding(
                                                                    padding: EdgeInsets.only(
                                                                        right:
                                                                            8.0),
                                                                    child: Text(
                                                                      "وصف الجلسة: ",
                                                                      style:
                                                                          TextStyle(
                                                                        color: Color(
                                                                            0xff385a4a),
                                                                        fontSize:
                                                                            15,
                                                                        fontFamily:
                                                                            "Rubik",
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    Center(
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Colors.grey[200],
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                        width: 335,
                                                        height: 50,
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 10),
                                                        child: Align(
                                                          alignment: Alignment
                                                              .centerRight,
                                                          child: Text(
                                                            'موعد الجلسة :  ' +
                                                                documentSnapshot[
                                                                    'Date'],
                                                            textAlign:
                                                                TextAlign.right,
                                                            style: TextStyle(
                                                              color: Color(
                                                                  0xff385a4a),
                                                              fontSize: 15,
                                                              fontFamily:
                                                                  "Rubik",
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    Center(
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Colors.grey[200],
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                        width: 335,
                                                        height: 50,
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 10),
                                                        child: Align(
                                                          alignment: Alignment
                                                              .centerRight,
                                                          child: Text(
                                                            'وقت الجلسة :  ' +
                                                                documentSnapshot[
                                                                    'TimeRange'],
                                                            textAlign:
                                                                TextAlign.right,
                                                            style: TextStyle(
                                                              color: Color(
                                                                  0xff385a4a),
                                                              fontSize: 15,
                                                              fontFamily:
                                                                  "Rubik",
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          ElevatedButton(
                                                              style:
                                                                  ElevatedButton
                                                                      .styleFrom(
                                                                minimumSize:
                                                                    Size(100,
                                                                        45),
                                                                backgroundColor:
                                                                    Color(
                                                                        0xff406553),
                                                                shape:
                                                                    const RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              10)),
                                                                ),
                                                              ),
                                                              onPressed: () {
                                                                String docId =
                                                                    documentSnapshot
                                                                        .id;
                                                                updateRequestedSessiom(
                                                                    docId);
                                                                Navigator.pop(
                                                                    context);
                                                                showDialog(
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (context) =>
                                                                            AlertDialog(
                                                                              title: Text("!تم ارسال التعديلات بنجاح"),
                                                                            ));
                                                              },
                                                              child: Text(
                                                                  'حفظ التغيرات')),
                                                          SizedBox(
                                                            width: 20,
                                                          ),
                                                          ElevatedButton(
                                                              style: ElevatedButton
                                                                  .styleFrom(
                                                                      minimumSize:
                                                                          Size(100,
                                                                              45),
                                                                      backgroundColor:
                                                                          Colors
                                                                              .red,
                                                                      shape:
                                                                          const RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.all(Radius.circular(10)),
                                                                      )),
                                                              onPressed:
                                                                  () async {
                                                                String
                                                                    sessionID =
                                                                    documentSnapshot[
                                                                        'sessionID'];
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                                QuerySnapshot
                                                                    querySnapshot =
                                                                    await FirebaseFirestore
                                                                        .instance
                                                                        .collection(
                                                                            'acceptedSessions')
                                                                        .where(
                                                                            'sessionID',
                                                                            isEqualTo:
                                                                                sessionID)
                                                                        .get();
                                                                querySnapshot
                                                                    .docs
                                                                    .forEach(
                                                                        (document) {
                                                                  document
                                                                      .reference
                                                                      .delete();
                                                                });
                                                                // Send reason to Parent page
                                                                FirebaseFirestore
                                                                    .instance
                                                                    .collection(
                                                                        'Parent')
                                                                    .doc(documentSnapshot[
                                                                        'ParentId'])
                                                                    .collection(
                                                                        'canceld')
                                                                    .add({
                                                                  'sessionID':
                                                                      sessionID,
                                                                  'status':
                                                                      "canceld",
                                                                });
                                                              },
                                                              child: Text(
                                                                  'حذف الجلسة '))
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                )
                                              ]),
                                            ));
                                  },
                                  child: Text(
                                    "تفاصيل الجلسة ",
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 12,
                                      fontFamily: "Cairo",
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      minimumSize: Size(40, 30),
                                      backgroundColor:
                                          Color.fromARGB(0, 155, 176, 165),
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                      )),
                                ),
                              ],
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
