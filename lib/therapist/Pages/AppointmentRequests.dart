import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class AppointmentRequests extends StatefulWidget {
  const AppointmentRequests({super.key});

  @override
  State<AppointmentRequests> createState() => _AppointmentRequestsState();
}

class _AppointmentRequestsState extends State<AppointmentRequests> {
  //instance for cloud firestore
  final _auth = FirebaseAuth.instance;

  late User singedInUser;
  @override
  void initState() {
    super.initState();
    getCurrentUser();
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

  TextEditingController SessionName = TextEditingController();
  TextEditingController SessionGoul = TextEditingController();

  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  final CollectionReference usersRef = _db.collection('requestedSessions');
  late Query query = usersRef
      .where('TherapistID', isEqualTo: singedInUser.uid)
      .where('status', isEqualTo: 'requested');
  late Stream<QuerySnapshot> usersStream = query.snapshots();

  ///Save value----------------------------------------------------------------
  late DocumentReference TherapistRequest =
      FirebaseFirestore.instance.collection('acceptedSessions').doc();

  void _saveValues({
    required String SessionName,
    required String ChildName,
    required String Date,
    required String TimeRange,
    required String ParentNote,
    required String SessionGoul,
    required String ParentUid,
    required String sessionID,
    required String therapistName,
    required Timestamp dateTime,
    required String ChildID,
    required String centerid,
  }) async {
    try {
      await TherapistRequest.set({
        'SessionName': SessionName,
        'ChildName': ChildName,
        'ChildID': ChildID,
        'TherapistName': therapistName,
        'Date': Date,
        'DateTime': dateTime,
        'TimeRange': TimeRange,
        'ParentNote': ParentNote,
        'SessionGoul': SessionGoul,
        'TherapistID': singedInUser.uid,
        'ParentId': ParentUid,
        'sessionID': sessionID,
        'therapistName': therapistName,
        'TherapistStatus': "accepted",
        'TherapistaAccepted': 'accepted',
        'Parentstatus': "accepted",
        "centerid": centerid,
      });
      _showSuccessDialog('تم حفظ البيانات بنجاح');
    } catch (e) {
      print('Error saving values: $e');
      _showErrorDialog('حدث خطأ أثناء حفظ البيانات');
    }
  }

  void _showSuccessDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Image.asset(
            'images/True.png',
            height: 70,
          ),
          content: Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xff394445),
              fontSize: 25,
              fontFamily: "Cairo",
              fontWeight: FontWeight.w600,
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'حسنا',
                style: TextStyle(
                  color: Color.fromARGB(255, 106, 152, 186),
                  fontSize: 15,
                  fontFamily: "Cairo",
                  fontWeight: FontWeight.w900,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('خطأ'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('حسنا'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

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

                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 15,
                    ),
                    child: Card(
                      elevation: 4,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(17.80)),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),

                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.medical_information_rounded,
                                      color: Color(0xff394445),
                                      size: 21,
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      documentSnapshot['ParentName'],
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
                                    Icon(
                                      Icons.date_range,
                                      color: Color(0xff394445),
                                      size: 22,
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      documentSnapshot['Date'],
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
                                    Icon(
                                      Icons.watch_later,
                                      color: Color(0xff394445),
                                      size: 22,
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      documentSnapshot['timeRange'],
                                      style: const TextStyle(
                                          color: Color(0xff385a4a)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Column(
                                children: [
                                  ElevatedButton(
                                    onPressed: () async {
                                      showModalBottomSheet<void>(
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
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.82,
                                                  child: SingleChildScrollView(
                                                      reverse: true,
                                                      child: Container(
                                                          padding:
                                                              EdgeInsets.only(
                                                            bottom: bottomInset,
                                                          ),
                                                          child: Container(
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: <
                                                                  Widget>[
                                                                Padding(
                                                                    padding:
                                                                        EdgeInsets.all(
                                                                            20.0),
                                                                    child: Text(
                                                                      "بيانات الجلسة",
                                                                      textAlign:
                                                                          TextAlign
                                                                              .right,
                                                                      style:
                                                                          TextStyle(
                                                                        color: Color(
                                                                            0xff385a4a),
                                                                        fontSize:
                                                                            20,
                                                                        fontFamily:
                                                                            "Cairo",
                                                                        fontWeight:
                                                                            FontWeight.w700,
                                                                      ),
                                                                    )),
                                                                Padding(
                                                                  padding: EdgeInsets
                                                                      .symmetric(
                                                                          horizontal:
                                                                              20),
                                                                  child:
                                                                      TextFormField(
                                                                    validator:
                                                                        (value) {
                                                                      if (value ==
                                                                              null ||
                                                                          value
                                                                              .isEmpty) {
                                                                        return 'الرجاء ادخال إسم الجلسة';
                                                                      }
                                                                      return null;
                                                                    },
                                                                    autovalidateMode:
                                                                        AutovalidateMode
                                                                            .onUserInteraction,
                                                                    controller:
                                                                        SessionName,
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
                                                                      fillColor:
                                                                          Color(
                                                                              0x0c9bb0a5),
                                                                      prefixIcon:
                                                                          Column(
                                                                        mainAxisSize:
                                                                            MainAxisSize.min,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: <
                                                                            Widget>[
                                                                          Padding(
                                                                            padding:
                                                                                EdgeInsets.only(right: 8.0),
                                                                            child:
                                                                                Text(
                                                                              "اسم الجلسة: ",
                                                                              textAlign: TextAlign.right,
                                                                              style: TextStyle(
                                                                                color: Color(0xff385a4a),
                                                                                fontSize: 15,
                                                                                fontFamily: "Rubik",
                                                                                fontWeight: FontWeight.w500,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),

                                                                ///---------------------------------------
                                                                SizedBox(
                                                                  height: 20,
                                                                ),
                                                                Center(
                                                                  child:
                                                                      Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Color(
                                                                          0x0c9bb0a5),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8),
                                                                    ),
                                                                    width: 350,
                                                                    height: 65,
                                                                    padding: EdgeInsets.symmetric(
                                                                        horizontal:
                                                                            10),
                                                                    child:
                                                                        Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .centerRight,
                                                                      child:
                                                                          Text(
                                                                        'اسم الطفل:  ' +
                                                                            documentSnapshot['ChildName'],
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
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 20,
                                                                ),
                                                                Center(
                                                                  child:
                                                                      Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Color(
                                                                          0x0c9bb0a5),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8),
                                                                    ),
                                                                    width: 350,
                                                                    height: 65,
                                                                    padding: EdgeInsets.symmetric(
                                                                        horizontal:
                                                                            10),
                                                                    child:
                                                                        Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .centerRight,
                                                                      child:
                                                                          Text(
                                                                        'موعد الجلسة :  ' +
                                                                            documentSnapshot['Date'],
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
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 20,
                                                                ),
                                                                Center(
                                                                  child:
                                                                      Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Color(
                                                                          0x0c9bb0a5),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8),
                                                                    ),
                                                                    width: 350,
                                                                    height: 65,
                                                                    padding: EdgeInsets.symmetric(
                                                                        horizontal:
                                                                            10),
                                                                    child:
                                                                        Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .centerRight,
                                                                      child:
                                                                          Text(
                                                                        ' وقت الجلسة:  ' +
                                                                            documentSnapshot['timeRange'],
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
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 20,
                                                                ),
                                                                Center(
                                                                  child:
                                                                      Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Color(
                                                                          0x0c9bb0a5),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8),
                                                                    ),
                                                                    width: 350,
                                                                    height: 65,
                                                                    padding: EdgeInsets.symmetric(
                                                                        horizontal:
                                                                            10),
                                                                    child:
                                                                        Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .centerRight,
                                                                      child:
                                                                          Text(
                                                                        'ملاحطات الام  :  ' +
                                                                            documentSnapshot['ParentNote'],
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
                                                                  ),
                                                                ),

                                                                //------------------------------------------
                                                                SizedBox(
                                                                    height:
                                                                        16.0),
                                                                Padding(
                                                                  padding: EdgeInsets
                                                                      .symmetric(
                                                                          horizontal:
                                                                              20),
                                                                  child:
                                                                      SizedBox(
                                                                    height: 100,
                                                                    child:
                                                                        TextFormField(
                                                                      validator:
                                                                          (value) {
                                                                        if (value ==
                                                                                null ||
                                                                            value.isEmpty) {
                                                                          return 'الرجاء ادخال الهدف من الجلسة';
                                                                        }
                                                                        return null;
                                                                      },
                                                                      autovalidateMode:
                                                                          AutovalidateMode
                                                                              .onUserInteraction,
                                                                      keyboardType:
                                                                          TextInputType
                                                                              .multiline,
                                                                      controller:
                                                                          SessionGoul,
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
                                                                        fillColor:
                                                                            Color(0x0c9bb0a5),
                                                                        prefixIcon:
                                                                            Column(
                                                                          mainAxisSize:
                                                                              MainAxisSize.min,
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          children: <
                                                                              Widget>[
                                                                            Padding(
                                                                              padding: EdgeInsets.only(right: 8.0),
                                                                              child: Text(
                                                                                "الهدف من الجلسة:",
                                                                                textAlign: TextAlign.right,
                                                                                style: TextStyle(
                                                                                  color: Color(0xff385a4a),
                                                                                  fontSize: 15,
                                                                                  fontFamily: "Rubik",
                                                                                  fontWeight: FontWeight.w500,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),

                                                                SizedBox(
                                                                    height:
                                                                        2.0),
                                                                Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  child:
                                                                      ElevatedButton(
                                                                    style: ElevatedButton.styleFrom(
                                                                        minimumSize: Size(200, 40),
                                                                        backgroundColor: Color(0xff394445),
                                                                        shape: const RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.all(Radius.circular(12)),
                                                                        )),
                                                                    onPressed:
                                                                        () async {
                                                                      final String
                                                                          SessionId =
                                                                          const Uuid()
                                                                              .v4();
                                                                      _saveValues(
                                                                        SessionName:
                                                                            SessionName.text,
                                                                        ChildName:
                                                                            documentSnapshot['ChildName'],
                                                                        Date: documentSnapshot[
                                                                            'Date'],
                                                                        TimeRange:
                                                                            documentSnapshot['timeRange'],
                                                                        ParentNote:
                                                                            documentSnapshot['ParentNote'],
                                                                        SessionGoul:
                                                                            SessionGoul.text,
                                                                        ParentUid:
                                                                            documentSnapshot['ParentId'],
                                                                        sessionID:
                                                                            SessionId,
                                                                        therapistName:
                                                                            documentSnapshot['TherapistName'],
                                                                        dateTime:
                                                                            documentSnapshot['DateTime'],
                                                                        ChildID:
                                                                            documentSnapshot['ChildID'],
                                                                        centerid:
                                                                            documentSnapshot['centerid'],
                                                                      );

                                                                      SessionName
                                                                          .clear();
                                                                      SessionGoul
                                                                          .clear();

                                                                      if (documentSnapshot[
                                                                              'status'] !=
                                                                          null) {
                                                                        String
                                                                            requestId =
                                                                            documentSnapshot['RequestId'];
                                                                        QuerySnapshot querySnapshot = await FirebaseFirestore
                                                                            .instance
                                                                            .collection(
                                                                                'requestedSessions')
                                                                            .where('RequestId',
                                                                                isEqualTo: requestId)
                                                                            .get();

                                                                        querySnapshot
                                                                            .docs
                                                                            .forEach((document) {
                                                                          document
                                                                              .reference
                                                                              .update({
                                                                            "status":
                                                                                "accepted"
                                                                          });
                                                                        });

                                                                        final therapySessionRef = FirebaseFirestore
                                                                            .instance
                                                                            .collection('Child')
                                                                            .doc(
                                                                              documentSnapshot['ChildID'],
                                                                            )
                                                                            .collection('therapy_sessions')
                                                                            .doc();

                                                                        await therapySessionRef
                                                                            .set({
                                                                          'therapist_id': FirebaseAuth
                                                                              .instance
                                                                              .currentUser!
                                                                              .uid,
                                                                          'status':
                                                                              'accepted',
                                                                        });
                                                                      }
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                    },
                                                                    child: Text(
                                                                      "اضافة الجلسة",
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            15,
                                                                        fontFamily:
                                                                            "Cairo",
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                    height:
                                                                        16.0),
                                                              ],
                                                            ),
                                                          ))));
                                            });
                                          });
                                    },
                                    child: Text(
                                      "قبول الجلسة",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontFamily: "Rubik",
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                        minimumSize: Size(40, 30),
                                        backgroundColor: Color(0xff406553),
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                        )),
                                  ),
                                  ElevatedButton(
                                    onPressed: () async {
                                      String requestId =
                                          documentSnapshot['RequestId'];
                                      String reason = '';
                                      showDialog(
                                        context: context,
                                        builder: (context) => Theme(
                                          data: ThemeData(
                                              useMaterial3: true,
                                              colorScheme: ColorScheme.fromSeed(
                                                  seedColor:
                                                      const Color(0xff385a4a))),
                                          child: Directionality(
                                            textDirection: TextDirection.rtl,
                                            child: AlertDialog(
                                              title: const Text(
                                                'رفض الجلسة',
                                                textAlign: TextAlign.right,
                                                style: TextStyle(
                                                  color: Color(0xff385a4a),
                                                  fontSize: 16,
                                                  fontFamily: "Cairo",
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                              content: Container(
                                                width: double.maxFinite,
                                                child: TextField(
                                                  onChanged: (value) {
                                                    reason = value;
                                                  },
                                                  keyboardType:
                                                      TextInputType.multiline,
                                                  maxLines: 3,
                                                  textDirection:
                                                      TextDirection.rtl,
                                                  decoration: InputDecoration(
                                                    border: OutlineInputBorder(
                                                      borderSide:
                                                          BorderSide.none,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                    ),
                                                    filled: true,
                                                    fillColor: Color.fromARGB(
                                                        28, 155, 176, 165),
                                                    hintText:
                                                        "السبب من رفض الجلسة",
                                                  ),
                                                ),
                                              ),
                                              actions: [
                                                Align(
                                                  alignment: Alignment.center,
                                                  child: Container(
                                                    width: 150,
                                                    child: TextButton(
                                                      style:
                                                          TextButton.styleFrom(
                                                        backgroundColor:
                                                            Color(0xff394445),
                                                        // set text color here
                                                      ),
                                                      onPressed: () async {
                                                        QuerySnapshot
                                                            querySnapshot =
                                                            await FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    'requestedSessions')
                                                                .where(
                                                                    'RequestId',
                                                                    isEqualTo:
                                                                        requestId)
                                                                .get();
                                                        querySnapshot.docs
                                                            .forEach(
                                                                (document) {
                                                          document.reference
                                                              .delete();
                                                        });
                                                        // Send reason to Parent page

                                                        FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                'Parent')
                                                            .doc(
                                                                documentSnapshot[
                                                                    'ParentId'])
                                                            .collection(
                                                                'RejuctAndCanceld')
                                                            .add({
                                                          'RequestId':
                                                              requestId,
                                                          'Reason': reason,
                                                          'status': "rejected",
                                                          'Range':
                                                              documentSnapshot[
                                                                  'timeRange'],
                                                          'Date':
                                                              documentSnapshot[
                                                                  'Date'],
                                                          'isRead': false,
                                                          'TherapisName':
                                                              documentSnapshot[
                                                                  'TherapistName'],
                                                        });
                                                        Navigator.pop(context);
                                                      },
                                                      child: const Text(
                                                        'إرسال',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 15,
                                                          fontFamily: "Cairo",
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      "رفض الجلسة",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontFamily: "Rubik",
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                        minimumSize: Size(40, 30),
                                        backgroundColor: Color(0xffd21414),
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
