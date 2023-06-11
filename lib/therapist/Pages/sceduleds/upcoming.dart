import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eloquentapp/screens/callPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class upcoming extends StatefulWidget {
  const upcoming({super.key});

  @override
  State<upcoming> createState() => _upcomingState();
}

class _upcomingState extends State<upcoming> {
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

  // TextEditingController SessionName = TextEditingController();
  // TextEditingController SessionGoul = TextEditingController();

  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  final CollectionReference usersRef = _db.collection('acceptedSessions');
  late Query query = usersRef
      .where('TherapistID', isEqualTo: singedInUser.uid)
      .where('TherapistStatus', isEqualTo: 'accepted');

  late Stream<QuerySnapshot> usersStream = query.snapshots();

  ///get session  id----------------------------------------------------------------
  Map<String, dynamic> SessionInfo = {};

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
        .set({"SessionName": Sessionname, "SessionGoul": SessionGoal});
  }

  // late DocumentReference CanceldSession =
  // FirebaseFirestore.instance.collection('canceldSession').doc();
  // void _saveValues({
  // required String Sessionname,
  // required String ParentUid,
  // required String sessionID,
  // required String therapistName,
  // }) async {
  // try {
  // await CanceldSession.set({
  // 'SessionName': Sessionname,
  // 'TherapistName': therapistName,
  // 'TherapistID': singedInUser.uid,
  // 'ParentId': ParentUid,
  // 'sessionID': sessionID,
  // 'status': "canceld",
  // });
  //  _showSuccessDialog('تم حفظ البيانات بنجاح');
  // } catch (e) {
  // print('Error saving values: $e');
  //  _showErrorDialog('حدث خطأ أثناء حفظ البيانات');
  // }
  // }
//  void _showSuccessDialog(String message) {
  //  showDialog(
  //  context: context,
  //  builder: (BuildContext context) {
  //  return AlertDialog(
  //  title: Text('نجاح'),
  //  content: Text(message),
  //  actions: <Widget>[
  //  TextButton(
  //  child: Text('حسنا'),
  //  onPressed: () {
  //  Navigator.of(context).pop();
  //  },
  //  ),
  //  ],
  //  );
  //  },
  //  );
//  }

  final NameOfSession = TextEditingController();
  final GoulOfSession = TextEditingController();

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

                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 15,
                    ),
                    child: Card(
                      elevation: 4,
                      shadowColor: Color.fromARGB(105, 59, 55, 55),
                      color: Color(0xfffbfbfb),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(17.80)),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding:
                            EdgeInsets.symmetric(horizontal: 1, vertical: 3),

                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 5,
                                  ),
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
                                  width: 7,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          'جلسة ' +
                                              documentSnapshot['ChildName'],
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            color: Color(0xff385a4a),
                                            fontSize: 15,
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
                                          style: const TextStyle(
                                              color: Color(0xff6888a0),
                                              fontSize: 14),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "موعد الجلسة " +
                                              documentSnapshot['Date'],
                                          style: const TextStyle(
                                              color: Color(0xff6888a0),
                                              fontSize: 14),
                                        ),
                                      ],
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
                                              .where('sessionID',
                                                  isEqualTo: documentSnapshot[
                                                      'sessionID'])
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
                                      minimumSize: Size(39, 30),
                                      backgroundColor: Color(0xff394445),
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                      )),
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    Map<String, dynamic> SessionDocument = {};
                                    await FirebaseFirestore.instance
                                        .collection('acceptedSessions')
                                        .where("TherapistID",
                                            isEqualTo: singedInUser.uid)
                                        .where('sessionID',
                                            isEqualTo:
                                                documentSnapshot['sessionID'])
                                        .get()
                                        .then((v) {
                                      for (var element in v.docs) {
                                        SessionDocument.addAll(element.data());
                                      }
                                    });

                                    NameOfSession.text =
                                        SessionDocument['SessionName'];
                                    GoulOfSession.text =
                                        SessionDocument['SessionGoul'];

                                    showModalBottomSheet(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(35.0),
                                            topRight: Radius.circular(35.0),
                                          ),
                                        ),
                                        context: context,
                                        isScrollControlled: true,
                                        builder: (BuildContext context) {
                                          return SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.71,
                                            child: ListView(
                                                shrinkWrap: true,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
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
                                                              fontSize: 20,
                                                              fontFamily:
                                                                  "Cairo",
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                            ),
                                                          )),
                                                      Center(
                                                        child: Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      9),
                                                          child: Container(
                                                            width: 335,
                                                            height: 50,
                                                            child: TextField(
                                                              controller:
                                                                  NameOfSession,
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
                                                                fillColor: Color(
                                                                    0x0c9bb0a5),
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
                                                                              8.0,
                                                                          top:
                                                                              10),
                                                                      child:
                                                                          Text(
                                                                        "اسم الجلسة: ",
                                                                        textAlign:
                                                                            TextAlign.right,
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Color(0xff385a4a),
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
                                                            color: Color(
                                                                0x0c9bb0a5),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                          ),
                                                          width: 335,
                                                          height: 50,
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      10),
                                                          child: Align(
                                                            alignment: Alignment
                                                                .centerRight,
                                                            child: Text(
                                                              'اسم الطفل:  ' +
                                                                  documentSnapshot[
                                                                      'ChildName'],
                                                              textAlign:
                                                                  TextAlign
                                                                      .right,
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
                                                                  horizontal:
                                                                      20),
                                                          child: Container(
                                                            width: 335,
                                                            child: TextField(
                                                              textAlign:
                                                                  TextAlign
                                                                      .right,

                                                              keyboardType:
                                                                  TextInputType
                                                                      .multiline,
                                                              maxLines: 3,

                                                              // minLines: 10,
                                                              // maxLength: 12,
                                                              controller:
                                                                  GoulOfSession,
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
                                                                fillColor: Color(
                                                                    0x0c9bb0a5),
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
                                                                              8.0,
                                                                          bottom:
                                                                              35),
                                                                      child:
                                                                          Text(
                                                                        "وصف الجلسة: ",
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Color(0xff385a4a),
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
                                                            color: Color(
                                                                0x0c9bb0a5),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                          ),
                                                          width: 335,
                                                          height: 50,
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      10),
                                                          child: Align(
                                                            alignment: Alignment
                                                                .centerRight,
                                                            child: Text(
                                                              'موعد الجلسة :  ' +
                                                                  documentSnapshot[
                                                                      'Date'],
                                                              textAlign:
                                                                  TextAlign
                                                                      .right,
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
                                                            color: Color(
                                                                0x0c9bb0a5),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                          ),
                                                          width: 335,
                                                          height: 50,
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      10),
                                                          child: Align(
                                                            alignment: Alignment
                                                                .centerRight,
                                                            child: Text(
                                                              'وقت الجلسة :  ' +
                                                                  documentSnapshot[
                                                                      'TimeRange'],
                                                              textAlign:
                                                                  TextAlign
                                                                      .right,
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
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            ElevatedButton(
                                                                style: ElevatedButton
                                                                    .styleFrom(
                                                                  minimumSize:
                                                                      Size(100,
                                                                          40),
                                                                  backgroundColor:
                                                                      Color(
                                                                          0xff394445),
                                                                  shape:
                                                                      const RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.all(
                                                                            Radius.circular(10)),
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
                                                                                40),
                                                                        backgroundColor: Color.fromARGB(
                                                                            255,
                                                                            206,
                                                                            49,
                                                                            38),
                                                                        shape:
                                                                            const RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.all(Radius.circular(10)),
                                                                        )),
                                                                onPressed:
                                                                    () async {
                                                                  String
                                                                      reason =
                                                                      '';
                                                                  showDialog(
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (context) =>
                                                                            Theme(
                                                                      data: ThemeData(
                                                                          useMaterial3:
                                                                              true,
                                                                          colorScheme:
                                                                              ColorScheme.fromSeed(seedColor: const Color(0xff385a4a))),
                                                                      child:
                                                                          Directionality(
                                                                        textDirection:
                                                                            TextDirection.rtl,
                                                                        child:
                                                                            AlertDialog(
                                                                          title:
                                                                              const Text(
                                                                            "هل انت متأكد من رغبتك في حذف الجلسة",
                                                                            textAlign:
                                                                                TextAlign.right,
                                                                            style:
                                                                                TextStyle(
                                                                              color: Color(0xff385a4a),
                                                                              fontSize: 16,
                                                                              fontFamily: "Cairo",
                                                                              fontWeight: FontWeight.w700,
                                                                            ),
                                                                          ),
                                                                          content:
                                                                              Container(
                                                                            width:
                                                                                double.maxFinite,
                                                                            child:
                                                                                TextField(
                                                                              onChanged: (value) {
                                                                                reason = value;
                                                                              },
                                                                              keyboardType: TextInputType.multiline,
                                                                              maxLines: 3,
                                                                              textDirection: TextDirection.rtl,
                                                                              decoration: InputDecoration(
                                                                                border: OutlineInputBorder(
                                                                                  borderSide: BorderSide.none,
                                                                                  borderRadius: BorderRadius.circular(8.0),
                                                                                ),
                                                                                filled: true,
                                                                                fillColor: Color.fromARGB(28, 155, 176, 165),
                                                                                hintText: "ادخل سبب الحذف",
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          actions: [
                                                                            Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: [
                                                                                Container(
                                                                                  width: 100,
                                                                                  child: TextButton(
                                                                                    style: TextButton.styleFrom(
                                                                                        backgroundColor: Color(0xff394445),
                                                                                        shape: const RoundedRectangleBorder(
                                                                                          borderRadius: BorderRadius.all(Radius.circular(10)),
                                                                                        )
                                                                                        // set text color here
                                                                                        ),
                                                                                    onPressed: () async {
                                                                                      String sessionID = documentSnapshot['sessionID'];

                                                                                      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('acceptedSessions').where('sessionID', isEqualTo: sessionID).get();
                                                                                      querySnapshot.docs.forEach((document) {
                                                                                        document.reference.delete();
                                                                                      });
                                                                                      // Send reason to Parent page
                                                                                      FirebaseFirestore.instance.collection('Parent').doc(documentSnapshot['ParentId']).collection('RejuctAndCanceld').add({
                                                                                        'sessionID': sessionID,
                                                                                        'status': "canceld",
                                                                                        'reason': reason,
                                                                                        'Range': documentSnapshot['TimeRange'],
                                                                                        'Date': documentSnapshot['Date'],
                                                                                        'SessionName': documentSnapshot['SessionName'],
                                                                                        //تأكدي
                                                                                        'isRead': false,
                                                                                        'TherapisName': TherapistName
                                                                                      });
                                                                                      Navigator.pop(context);
                                                                                      Navigator.pop(context);
                                                                                    },
                                                                                    child: const Text(
                                                                                      'حذف',
                                                                                      style: TextStyle(
                                                                                        color: Colors.white,
                                                                                        fontSize: 15,
                                                                                        fontFamily: "Cairo",
                                                                                        fontWeight: FontWeight.w500,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                Container(
                                                                                  width: 120,
                                                                                  child: TextButton(
                                                                                      style: TextButton.styleFrom(
                                                                                          backgroundColor: Colors.white,
                                                                                          shape: const RoundedRectangleBorder(
                                                                                            borderRadius: BorderRadius.all(Radius.circular(10)),
                                                                                          )),
                                                                                      onPressed: () {
                                                                                        Navigator.pop(context);
                                                                                        Navigator.pop(context);
                                                                                      },
                                                                                      child: Text(
                                                                                        'الغاء',
                                                                                        style: TextStyle(
                                                                                          color: Color(0xff394445),
                                                                                          fontSize: 15,
                                                                                          fontFamily: "Cairo",
                                                                                          fontWeight: FontWeight.w500,
                                                                                        ),
                                                                                      )),
                                                                                )
                                                                              ],
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  );
                                                                },
                                                                child: Text(
                                                                  'حذف الجلسة ',
                                                                ))
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  )
                                                ]),
                                          );
                                        });
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
                                          Color.fromARGB(255, 255, 252, 252),
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
