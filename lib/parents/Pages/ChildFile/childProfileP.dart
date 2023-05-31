import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eloquentapp/parents/Pages/ChildFile/Report_Page.dart';
import 'package:eloquentapp/parents/Pages/ChildFile/alphabet.dart';
import 'package:eloquentapp/parents/Pages/ChildFile/child_evaluation.dart';
import 'package:eloquentapp/screens/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChildProfile extends StatefulWidget {
  late String Childid;
  ChildProfile({required this.Childid});

  @override
  State<ChildProfile> createState() => _ChildProfileState();
}

class _ChildProfileState extends State<ChildProfile> {
  final _auth = FirebaseAuth.instance;
  late User singedInUser;
  late double _totalWeeklyUsage;

  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseFirestore firestorex = FirebaseFirestore.instance;

  //get current user
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

  Map<String, dynamic> ChildInfo = {};
  bool isLoded = true;
  getUserData() async {
    await FirebaseFirestore.instance
        .collection('Child')
        .where("uidParent", isEqualTo: singedInUser.uid)
        .get()
        .then((v) {
      for (var element in v.docs) {
        ChildInfo.addAll(element.data());
        setState(() {
          isLoded = false;
        });
      }
    });
  }

  late String uid = ChildInfo['uidParent'];
  late String name = ChildInfo['name'];
  late String ChildAvatar = ChildInfo['ChildAvatar'];

  late String ChildEducationalLevel = ChildInfo['ChildEducationalLevel'];

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    getUserData();
    _totalWeeklyUsage = 0;
    print(widget.Childid);
    _calculateTotalWeeklyUsage();
  }

  late String uidParent = ChildInfo['uidParent'];
  late String childId = ChildInfo['uid'];

  late String ParentName = ChildInfo['ParentName'];
  late Timestamp BirthDate = ChildInfo['BirthDate'];
  late String? Movement = ChildInfo['Movement'];
  late String? personalBehaviour = ChildInfo['personalBehaviour'];
  late String? emotionalBehaviour = ChildInfo['emotionalBehaviour'];
  late String? understanding = ChildInfo['understanding'];
  late String? dispersion = ChildInfo['dispersion'];
  late String? visualCommunication = ChildInfo['visualCommunication'];
  late String? Agressive = ChildInfo['Agressive'];
  late String? fear = ChildInfo['fear'];
  late String? cooperating = ChildInfo['cooperating'];
  late String? visualCondition = ChildInfo['visualCondition'];
  late String? auditoryCondition = ChildInfo['auditoryCondition'];
  late String? expressionLevel = ChildInfo['expressionLevel'];
  late String? LetteringLevel = ChildInfo['LetteringLevel'];
  late String? MotionClassification = ChildInfo['MotionClassification'];
  late String? physicalGrowth = ChildInfo['physicalGrowth'];
  late String? chronicDiseases = ChildInfo['chronicDiseases'];
  late String? previousTreatment = ChildInfo['previousTreatment'];
  late String? checkUp = ChildInfo['checkUp'];
  late String? Surgery = ChildInfo['Surgery'];
  late String? DefiningIntelligence = ChildInfo['DefiningIntelligence'];
  late String? sensitive = ChildInfo['sensitive'];

  late String CheckupsYesField = ChildInfo['CheckupsYesField'];
  // late bool CheckupsNo = ChildInfo['CheckupsNo'];
  // late bool SurgeryYes = ChildInfo['SurgeryYes'];
  late String SurgeryYesField = ChildInfo['SurgeryYesField'];
  // late bool SurgeryNo = ChildInfo['SurgeryNo'];
  // late bool IntelligencetestYes = ChildInfo['IntelligencetestYes'];
  late String IntelligencetestYesField = ChildInfo['IntelligencetestYesField'];
  // late bool IntelligencetestNo = ChildInfo['IntelligencetestNo'];
  // late bool allergyYes = ChildInfo['allergyYes'];
  late String allergyYesField = ChildInfo['allergyYesField'];
  // late bool allergyNo = ChildInfo['allergyNo'];
//تعديل للتيكست فيلد
  final CheckupsYesFieldController = TextEditingController();
  final SurgeryYesFieldController = TextEditingController();
  final IntelligencetestYesFieldController = TextEditingController();
  final allergyYesFieldController = TextEditingController();

  final CollectionReference usersRef = _db.collection('Child');
  late Query query = usersRef.where('uidParent', isEqualTo: singedInUser.uid);
  late Stream<QuerySnapshot> usersStream = query.snapshots();

  late String chronicdiseasesOtherField =
      ChildInfo['chronicdiseasesOtherField'];
  late bool previoustreatmentYes = ChildInfo['previoustreatmentYes'];
  late String previoustreatmentYesField =
      ChildInfo['previoustreatmentYesField'];
  // late bool previoustreatmentNo = ChildInfo['previoustreatmentNo'];

  // late var highMovmentchange;

  updte(docId) async {
    var childRef = _db.collection('Child');
    await childRef.doc(docId).update({
      // 'highMovment': highMovment,
      // 'MidMovment': MidMovment,
      // 'litleMovment': litleMovment,
    });
  }

  updtepersonalBehaviour(docId) async {
    var childRef = _db.collection('Child');
    await childRef.doc(docId).update({
      'Movement': Movement,
      'personalBehaviour': personalBehaviour,
      'emotionalBehaviour': emotionalBehaviour,
      'understanding': understanding,
      'dispersion': dispersion,
      'visualCommunication': visualCommunication,
      'Agressive': Agressive,
      'fear': fear,
      'cooperating': cooperating,
    });
  }

  updateGeneralHealthCondition(docId) async {
    var childRef = _db.collection('Child');
    await childRef.doc(docId).update({
      'visualCondition': visualCondition,
      'auditoryCondition': auditoryCondition,
      'expressionLevel': expressionLevel,
      'LetteringLevel': LetteringLevel,
      'MotionClassification': MotionClassification,
      'physicalGrowth': physicalGrowth,
      'chronicDiseases': chronicDiseases,
      'previousTreatment': previousTreatment,
      'checkUp': checkUp,
      'Surgery': Surgery,
      'DefiningIntelligence': DefiningIntelligence,
      'sensitive': sensitive,
      'CheckupsYesField': CheckupsYesField,
      'SurgeryYesField': SurgeryYesField,
      'IntelligencetestYesField': IntelligencetestYesField,
      'allergyYesField': allergyYesField,
    });
  }

  String formatDate(Timestamp timestamp) {
    var format = DateTime.fromMillisecondsSinceEpoch(timestamp.seconds * 1000);
    return DateFormat('dd-MM-yyyy').format(format);
  }

// get the Total Weekly Usage
  Future<void> _calculateTotalWeeklyUsage() async {
    final QuerySnapshot<Map<String, dynamic>> pagesSnapshot =
        await FirebaseFirestore.instance
            .collection('Child')
            .doc(widget.Childid)
            .collection('pages')
            .get();
    double totalWeeklyDuration = 0.0;
    for (final docSnapshot in pagesSnapshot.docs) {
      final double? weeklyDuration =
          docSnapshot.data()['average_weekly_duration'];
      if (weeklyDuration != null) {
        totalWeeklyDuration += weeklyDuration;
      }
    }
    setState(() {
      _totalWeeklyUsage = totalWeeklyDuration * 60.0; // convert to minutes
      print(_totalWeeklyUsage);
    });
  }

//الحرف الأكثر تكراراَ
  Future<String?> getMostFrequentLetter() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('ChildEvaluation')
        .where('ParentID', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .where('pass', isEqualTo: false)
        .get();

    final documents = snapshot.docs;
    final letterMap = Map<String, int>();

    for (final doc in documents) {
      final letterName = doc.get('letterName');
      letterMap[letterName] = (letterMap[letterName] ?? 0) + 1;
    }

    final letterList = letterMap.entries.toList();

    letterList.sort((a, b) => b.value - a.value);

    if (letterList.isEmpty) {
      return null;
    }

    final mostFrequentLetter = letterList.first.key;

    print('Most frequent letter: $mostFrequentLetter');

    return mostFrequentLetter;
  }

  var textStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    fontFamily: 'Cairo',
    color: Color(0xff6888a0),
  );

  var textStyle2 =
      TextStyle(fontSize: 14, fontWeight: FontWeight.w400, fontFamily: 'Cairo');
  @override
  Widget build(BuildContext context) {
    var boxDecoration = BoxDecoration(
      borderRadius: BorderRadius.circular(11),
      color: Color.fromARGB(255, 233, 239, 236),
    );
    const textStyle = TextStyle(
        color: Color(0xff385a4a),
        fontSize: 38,
        fontFamily: "Cairo",
        fontWeight: FontWeight.w800);
    return Scaffold(
        body: isLoded == true
            ? Center(child: CircularProgressIndicator())
            : SafeArea(
                child: Column(
                  children: [
                    ProfileContainer(
                      Berthday: formatDate(BirthDate),
                      ChildName: name,
                      EducationLevel: ChildEducationalLevel,
                      ChildAvatar: ChildAvatar,
                    ),
                    Expanded(
                      child: DefaultTabController(
                        length: 2,
                        child: Column(children: [
                          Container(
                            height: 55,
                            child: TabBar(
                              labelPadding:
                                  EdgeInsets.symmetric(horizontal: 20),
                              isScrollable: true,
                              indicator: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Color.fromARGB(0, 66, 65, 65),
                                        width: 2)),
                              ),
                              labelColor: Color.fromARGB(255, 21, 11, 11),
                              tabs: [
                                Tab(
                                  child: Text(
                                    "ملف الطفل",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: "Cairo",
                                    ),
                                  ),
                                ),
                                Tab(
                                  child: Text(
                                    " تقرير الجلسات",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: "Cairo",
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Expanded(
                              child: TabBarView(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color:
                                            Color.fromARGB(21, 166, 181, 173),
                                      ),
                                      child: TabControler(
                                        tab1: Text(
                                          'معلومات عامة',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: "Cairo",
                                          ),
                                        ),
                                        tab2: Text(
                                          'تتبع تقدم الطفل',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: "Cairo",
                                          ),
                                        ),
                                        widget1: ListView(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 20),
                                              child: Column(
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      showBottomSheet(context);
                                                    },
                                                    child: Card(
                                                      elevation: 4,
                                                      color: Colors.white,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          17.80)),
                                                      child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        width: 343,
                                                        height: 110,
                                                        child: ListTile(
                                                          title: Text(
                                                            'الصفات الشخصية والسلوكية ',
                                                            style: TextStyle(
                                                              color: Color(
                                                                  0xff687c71),
                                                              fontSize: 16,
                                                              fontFamily:
                                                                  "Cairo",
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          ),
                                                          leading: Image.asset(
                                                              "images/Behaviour.png"),
                                                          trailing: Icon(Icons
                                                              .arrow_back_ios_new_outlined),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      showBottomSheet1(context);
                                                    },
                                                    child: Card(
                                                      elevation: 4,
                                                      color: Colors.white,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          17.80)),
                                                      child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        width: 343,
                                                        height: 110,
                                                        child: ListTile(
                                                          title: Text(
                                                            'الحالة الصحية العامة ',
                                                            style: TextStyle(
                                                              color: Color(
                                                                  0xff687c71),
                                                              fontSize: 16,
                                                              fontFamily:
                                                                  "Cairo",
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          ),
                                                          leading: Image.asset(
                                                              "images/GenralHelth.png"),
                                                          trailing: Icon(Icons
                                                              .arrow_back_ios_new_outlined),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      showBottomSheet2(context);
                                                    },
                                                    child: Card(
                                                      elevation: 4,
                                                      color: Colors.white,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          17.80)),
                                                      child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        width: 343,
                                                        height: 110,
                                                        child: ListTile(
                                                          title: Text(
                                                            'الفحوصات والعمليات',
                                                            style: TextStyle(
                                                              color: Color(
                                                                  0xff687c71),
                                                              fontSize: 16,
                                                              fontFamily:
                                                                  "Cairo",
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          ),
                                                          leading: Image.asset(
                                                              "images/checkup.png"),
                                                          trailing: Icon(Icons
                                                              .arrow_back_ios_new_outlined),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        widget2: ListView(
                                          children: [
                                            SizedBox(
                                              height: 8,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                //--------------------------------متوسط الإستخدام الأسبوعي

                                                GestureDetector(
                                                  onTap: () {},
                                                  child: Card(
                                                      shadowColor:
                                                          Color.fromARGB(
                                                              94, 0, 0, 0),
                                                      elevation: 5,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          18.31)),
                                                      color: Colors.white,
                                                      child: Container(
                                                        width: 140,
                                                        height: 170,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      18.31),
                                                        ),
                                                        child: Center(
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text(
                                                                "متوسط الاستخدام\nالأسبوعي",
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style:
                                                                    TextStyle(
                                                                  color: Color(
                                                                      0xff394445),
                                                                  fontSize: 14,
                                                                  fontFamily:
                                                                      "Montserrat",
                                                                ),
                                                              ),
                                                              Text(
                                                                '${_totalWeeklyUsage.toStringAsFixed(0)} ',
                                                                style:
                                                                    TextStyle(
                                                                  color: Color(
                                                                      0xff385a4a),
                                                                  fontSize: 43,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                              ),
                                                              Text(
                                                                "دقيقة",
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style:
                                                                    TextStyle(
                                                                  color: Color(
                                                                      0xff394445),
                                                                  fontSize: 16,
                                                                  fontFamily:
                                                                      "Montserrat",
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      )),
                                                ),
                                                //----------------------ماقبل اللغة
                                                SizedBox(width: 15),

                                                GestureDetector(
                                                  onTap: () {},
                                                  child: Card(
                                                      shadowColor:
                                                          Color.fromARGB(
                                                              94, 0, 0, 0),
                                                      elevation: 5,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          18.31)),
                                                      color: Colors.white,
                                                      child: Container(
                                                        width: 140,
                                                        height: 170,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      18.31),
                                                        ),
                                                        child: Center(
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text(
                                                                "الحرف الأكثر\nتكرارًا",
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style:
                                                                    TextStyle(
                                                                  color: Color(
                                                                      0xff394445),
                                                                  fontSize: 14,
                                                                  fontFamily:
                                                                      "Montserrat",
                                                                ),
                                                              ),
                                                              FutureBuilder<
                                                                  String?>(
                                                                future:
                                                                    getMostFrequentLetter(),
                                                                builder: (BuildContext
                                                                        context,
                                                                    AsyncSnapshot<
                                                                            String?>
                                                                        snapshot) {
                                                                  if (snapshot
                                                                          .connectionState ==
                                                                      ConnectionState
                                                                          .waiting) {
                                                                    return Center(
                                                                        child:
                                                                            CircularProgressIndicator());
                                                                  }

                                                                  if (snapshot
                                                                      .hasError) {
                                                                    return Text(
                                                                        'Error: ${snapshot.error}');
                                                                  }

                                                                  final mostFrequentLetter =
                                                                      snapshot
                                                                          .data;

                                                                  if (mostFrequentLetter ==
                                                                      null) {
                                                                    return Padding(
                                                                      padding: const EdgeInsets
                                                                              .symmetric(
                                                                          vertical:
                                                                              10),
                                                                      child: Center(
                                                                          child: Text('لا يوجد',
                                                                              textAlign: TextAlign.center,
                                                                              style: TextStyle(
                                                                                color: Color(0xff385a4a),
                                                                                fontSize: 22,
                                                                                fontWeight: FontWeight.w600,
                                                                              ))),
                                                                    );
                                                                  }

                                                                  return Center(
                                                                      child: Text(
                                                                          mostFrequentLetter,
                                                                          textAlign: TextAlign
                                                                              .center,
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                Color(0xff385a4a),
                                                                            fontSize:
                                                                                43,
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                          )));
                                                                },
                                                              ),
                                                              // Text(
                                                              //   "في الاسبوع",
                                                              //   textAlign:
                                                              //       TextAlign
                                                              //           .center,
                                                              //   style:
                                                              //       TextStyle(
                                                              //     color: Color(
                                                              //         0xff394445),
                                                              //     fontSize: 16,
                                                              //     fontFamily:
                                                              //         "Montserrat",
                                                              //     fontWeight:
                                                              //         FontWeight
                                                              //             .w600,
                                                              //   ),
                                                              // ),
                                                              SizedBox(
                                                                height: 10,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      )),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            SingleChildScrollView(
                                              child: alphabet(ChildID: childId),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12),
                                    child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(18.31),
                                          color:
                                              Color.fromARGB(21, 166, 181, 173),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 6, vertical: 5),
                                          child: ChildReport(),
                                        )),
                                  )
                                ],
                              ),
                            ),
                          )
                        ]),
                      ),
                    ),
                  ],
                ),
              ));
  }

  showBottomSheet(context) {
    return showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(35.0),
            topRight: Radius.circular(35.0),
          ),
        ),
        isScrollControlled: true,
        context: context,
        builder: (builder) {
          return StatefulBuilder(
            builder: (context, setState) {
              final bottomInset = MediaQuery.of(context).viewInsets.bottom;
              return Container(
                height: MediaQuery.of(context).size.height * 0.82,
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
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 25, left: 30, right: 25),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Image.asset("images/Behaviour.png"),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 14),
                                            child: Text(
                                              "الصفات الشخصية والسلوكية",
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: 'Cairo'),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          // crossAxisAlignment:
                                          // CrossAxisAlignment.start,
                                          children: [
                                            Flexible(
                                              child: Radio(
                                                groupValue: Movement,
                                                value: "قليل الحركة",
                                                onChanged: (value) {
                                                  setState(() {
                                                    Movement = value.toString();
                                                  });
                                                },
                                                activeColor: Color(0xff385a4a),
                                              ),
                                            ),
                                            TableCell(
                                              verticalAlignment:
                                                  TableCellVerticalAlignment
                                                      .middle,
                                              child: Text(
                                                "قليل الحركة",
                                                textAlign: TextAlign.start,
                                              ),
                                            ),
                                            Flexible(
                                              child: Radio(
                                                groupValue: Movement,
                                                value: "متوسط الحركة",
                                                onChanged: (value) {
                                                  setState(() {
                                                    Movement = value.toString();
                                                  });
                                                },
                                                activeColor: Color(0xff385a4a),
                                              ),
                                            ),
                                            TableCell(
                                              verticalAlignment:
                                                  TableCellVerticalAlignment
                                                      .middle,
                                              child: Text(
                                                "متوسط الحركة",
                                                textAlign: TextAlign.end,
                                              ),
                                            ),
                                            Flexible(
                                              child: Radio(
                                                groupValue: Movement,
                                                value: "كثير الحركة",
                                                onChanged: (value) {
                                                  setState(() {
                                                    Movement = value.toString();
                                                  });
                                                },
                                                activeColor: Color(0xff385a4a),
                                              ),
                                            ),
                                            TableCell(
                                              verticalAlignment:
                                                  TableCellVerticalAlignment
                                                      .middle,
                                              child: Text(
                                                "سريع الحركة",
                                                textAlign: TextAlign.end,
                                              ),
                                            ),
                                          ]),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Flexible(
                                            child: Radio(
                                              groupValue: personalBehaviour,
                                              value: 'اجتماعي',
                                              onChanged: (value) {
                                                setState(() {
                                                  personalBehaviour =
                                                      value.toString();
                                                });
                                              },
                                              activeColor: Color(0xff385a4a),
                                            ),
                                          ),
                                          TableCell(
                                            child: Text(
                                              "اجتماعي",
                                              textAlign: TextAlign.end,
                                            ),
                                          ),
                                          Flexible(
                                            child: Radio(
                                              groupValue: personalBehaviour,
                                              value: 'انطوائي',
                                              onChanged: (value) {
                                                setState(() {
                                                  personalBehaviour =
                                                      value.toString();
                                                });
                                              },
                                              activeColor: Color(0xff385a4a),
                                            ),
                                          ),
                                          TableCell(
                                            verticalAlignment:
                                                TableCellVerticalAlignment
                                                    .middle,
                                            child: Text(
                                              "انطوائي ",
                                              textAlign: TextAlign.start,
                                            ),
                                          ),
                                          Flexible(
                                            child: Radio(
                                              groupValue: personalBehaviour,
                                              value: "خجول",
                                              onChanged: (value) {
                                                setState(() {
                                                  personalBehaviour =
                                                      value.toString();
                                                });
                                              },
                                              activeColor: Color(0xff385a4a),
                                            ),
                                          ),
                                          TableCell(
                                            // verticalAlignment:
                                            // TableCellVerticalAlignment
                                            // .middle,
                                            child: Text(
                                              "خجول ",
                                              textAlign: TextAlign.start,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Flexible(
                                            child: Radio(
                                              groupValue: emotionalBehaviour,
                                              value: 'يغضب بسرعة',
                                              onChanged: (value) {
                                                setState(() {
                                                  emotionalBehaviour =
                                                      value.toString();
                                                });
                                              },
                                              activeColor: Color(0xff385a4a),
                                            ),
                                          ),
                                          TableCell(
                                            verticalAlignment:
                                                TableCellVerticalAlignment
                                                    .middle,
                                            child: Text(
                                              "يغضب بسرعة ",
                                              textAlign: TextAlign.start,
                                            ),
                                          ),
                                          Flexible(
                                            child: Radio(
                                              groupValue: emotionalBehaviour,
                                              value: 'يحبط بسرعة',
                                              onChanged: (value) {
                                                setState(() {
                                                  emotionalBehaviour =
                                                      value.toString();
                                                });
                                              },
                                              activeColor: Color(0xff385a4a),
                                            ),
                                          ),
                                          TableCell(
                                            verticalAlignment:
                                                TableCellVerticalAlignment
                                                    .middle,
                                            child: Text(
                                              "يحبط بسرعة ",
                                              textAlign: TextAlign.start,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 5),
                                        child: Align(
                                          alignment: Alignment.topRight,
                                          child: Text(
                                            "الانتباه:",
                                            style: textStyle,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 80),
                                        child: Row(
                                          children: [
                                            Flexible(
                                              child: Radio(
                                                groupValue: dispersion,
                                                value: 'يتشتت بسهولة',
                                                onChanged: (value) {
                                                  setState(() {
                                                    dispersion =
                                                        value.toString();
                                                  });
                                                },
                                                activeColor: Color(0xff385a4a),
                                              ),
                                            ),
                                            TableCell(
                                              verticalAlignment:
                                                  TableCellVerticalAlignment
                                                      .middle,
                                              child: Text(
                                                "يتشتت بسهولة ",
                                                textAlign: TextAlign.end,
                                              ),
                                            ),
                                            Flexible(
                                              child: Radio(
                                                groupValue: dispersion,
                                                value: 'قليل التشتت',
                                                onChanged: (value) {
                                                  setState(() {
                                                    dispersion =
                                                        value.toString();
                                                  });
                                                },
                                                activeColor: Color(0xff385a4a),
                                              ),
                                            ),
                                            TableCell(
                                              verticalAlignment:
                                                  TableCellVerticalAlignment
                                                      .middle,
                                              child: Text(
                                                "قليل التشتت  ",
                                                textAlign: TextAlign.end,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      // الفهم
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 5),
                                        child: Align(
                                          alignment: Alignment.topRight,
                                          child: Text(
                                            "الفهم والاستيعاب:",
                                            style: textStyle,
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: Row(
                                          children: [
                                            Flexible(
                                              child: Radio(
                                                groupValue: understanding,
                                                value: 'يفهم التعليمات بسهولة',
                                                onChanged: (value) {
                                                  setState(() {
                                                    understanding = value!;
                                                  });
                                                },
                                                activeColor: Color(0xff385a4a),
                                              ),
                                            ),
                                            TableCell(
                                              verticalAlignment:
                                                  TableCellVerticalAlignment
                                                      .middle,
                                              child: Text(
                                                "يفهم التعليمات بصعوية",
                                                textAlign: TextAlign.start,
                                              ),
                                            ),
                                            Flexible(
                                              child: Radio(
                                                groupValue: understanding,
                                                value: 'يفهم التعليمات بصعوبة',
                                                onChanged: (value) {
                                                  setState(() {
                                                    understanding = value!;
                                                  });
                                                },
                                                activeColor: Color(0xff385a4a),
                                              ),
                                            ),
                                            TableCell(
                                              verticalAlignment:
                                                  TableCellVerticalAlignment
                                                      .middle,
                                              child: Text(
                                                "يفهم التعليمات بسهولة",
                                                textAlign: TextAlign.end,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      // التواصل البصري
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 5),
                                        child: Align(
                                          alignment: Alignment.topRight,
                                          child: Text(
                                            "التواصل البصري:",
                                            style: textStyle,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 90.0),
                                        child: Row(
                                          children: [
                                            Flexible(
                                              child: Radio(
                                                groupValue: visualCommunication,
                                                value: 'لا يوجد',
                                                onChanged: (value) {
                                                  setState(() {
                                                    visualCommunication =
                                                        value.toString();
                                                  });
                                                },
                                                activeColor: Color(0xff385a4a),
                                              ),
                                            ),
                                            TableCell(
                                              verticalAlignment:
                                                  TableCellVerticalAlignment
                                                      .middle,
                                              child: Text(
                                                "لايوجد ",
                                                textAlign: TextAlign.end,
                                              ),
                                            ),
                                            Flexible(
                                              child: Radio(
                                                groupValue: visualCommunication,
                                                value: 'ضعيف',
                                                onChanged: (value) {
                                                  setState(() {
                                                    visualCommunication =
                                                        value.toString();
                                                  });
                                                },
                                                activeColor: Color(0xff385a4a),
                                              ),
                                            ),
                                            TableCell(
                                              verticalAlignment:
                                                  TableCellVerticalAlignment
                                                      .middle,
                                              child: Text(
                                                "ضعيف  ",
                                                textAlign: TextAlign.end,
                                              ),
                                            ),
                                            Flexible(
                                              child: Radio(
                                                groupValue: visualCommunication,
                                                value: 'جيد',
                                                onChanged: (value) {
                                                  setState(() {
                                                    visualCommunication =
                                                        value.toString();
                                                  });
                                                },
                                                activeColor: Color(0xff385a4a),
                                              ),
                                            ),
                                            TableCell(
                                              verticalAlignment:
                                                  TableCellVerticalAlignment
                                                      .middle,
                                              child: Text(
                                                "جيد   ",
                                                textAlign: TextAlign.end,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Row(children: [
                                        TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: Text(
                                            "يظهر على الطفل سلوك عدواني؟",
                                            style: TextStyle(
                                                color: Color(0xff6888a0),
                                                fontWeight: FontWeight.w700,
                                                fontFamily: 'Cairo',
                                                fontSize: 13),
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                        Flexible(
                                          child: Radio(
                                            groupValue: Agressive,
                                            value: 'نعم',
                                            onChanged: (value) {
                                              setState(() {
                                                Agressive = value!;
                                              });
                                            },
                                            activeColor: Color(0xff385a4a),
                                          ),
                                        ),
                                        TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: Text(
                                            "نعم ",
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                        Flexible(
                                          child: Radio(
                                            groupValue: Agressive,
                                            value: 'لا',
                                            onChanged: (value) {
                                              setState(() {
                                                Agressive = value!;
                                              });
                                            },
                                            activeColor: Color(0xff385a4a),
                                          ),
                                        ),
                                        TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: Text(
                                            "لا",
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                      ]),
                                      Row(children: [
                                        TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: Text(
                                            "يظهر على الطفل الخوف او القلق؟",
                                            style: TextStyle(
                                                color: Color(0xff6888a0),
                                                fontWeight: FontWeight.w700,
                                                fontFamily: 'Cairo',
                                                fontSize: 13),
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                        Flexible(
                                          child: Radio(
                                            groupValue: fear,
                                            value: 'نعم',
                                            onChanged: (value) {
                                              setState(() {
                                                fear = value!;
                                              });
                                            },
                                            activeColor: Color(0xff385a4a),
                                          ),
                                        ),
                                        TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: Text(
                                            "نعم ",
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                        Flexible(
                                          child: Radio(
                                            groupValue: fear,
                                            value: 'لا',
                                            onChanged: (value) {
                                              setState(() {
                                                fear = value!;
                                              });
                                            },
                                            activeColor: Color(0xff385a4a),
                                          ),
                                        ),
                                        TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: Text(
                                            "لا",
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                      ]),
                                      Row(children: [
                                        TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: Text(
                                            "هل الطفل متعاون مع الاخرين؟",
                                            style: TextStyle(
                                                color: Color(0xff6888a0),
                                                fontWeight: FontWeight.w700,
                                                fontFamily: 'Cairo',
                                                fontSize: 13),
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                        Flexible(
                                          child: Radio(
                                            groupValue: cooperating,
                                            value: "نعم",
                                            onChanged: (value) {
                                              setState(() {
                                                cooperating = value!;
                                              });
                                            },
                                            activeColor: Color(0xff385a4a),
                                          ),
                                        ),
                                        TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: Text(
                                            "نعم ",
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                        Flexible(
                                          child: Radio(
                                            groupValue: cooperating,
                                            value: "لا",
                                            onChanged: (value) {
                                              setState(() {
                                                cooperating = value!;
                                              });
                                            },
                                            activeColor: Color(0xff385a4a),
                                          ),
                                        ),
                                        TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: Text(
                                            "لا",
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                      ]),
                                      Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  minimumSize: Size(160, 39),
                                                  backgroundColor:
                                                      Color(0xff394445),
                                                  shape:
                                                      const RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10)),
                                                  )),
                                              onPressed: () async {
                                                String docId =
                                                    documentSnapshot.id;
                                                updtepersonalBehaviour(docId);
                                                Navigator.pop(context);
                                                showDialog(
                                                    context: context,
                                                    builder: (context) =>
                                                        AlertDialog(
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10), // set the border radius her
                                                          ),
                                                          title: Text(
                                                              "تم ارسال التعديلات بنجاح"),
                                                        ));
                                              },
                                              child: Text('حفظ التغيرات')),
                                        ),
                                      )
                                    ]),
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
            },
          );
        });
  }

  showBottomSheet1(context) {
    return showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(35.0),
            topRight: Radius.circular(35.0),
          ),
        ),
        context: context,
        isScrollControlled: true,
        builder: (builder) {
          return StatefulBuilder(
            builder: (context, setState) {
              final bottomInset = MediaQuery.of(context).viewInsets.bottom;
              return Container(
                height: MediaQuery.of(context).size.height * 0.83,
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
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 25, left: 30, right: 25),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Image.asset("images/GenralHelth.png"),
                                          SizedBox(
                                            width: 9,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 4.0),
                                            child: Text(
                                              "الحالة الصحية العامة",
                                              style: TextStyle(
                                                  fontSize: 19,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: 'Cairo'),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: Text("الحالة البصرية:",
                                            style: textStyle),
                                      ),
                                      Row(children: [
                                        Flexible(
                                          child: Radio(
                                            groupValue: visualCondition,
                                            value: "طبيعي",
                                            onChanged: (value) {
                                              setState(() {
                                                visualCondition = value!;
                                              });
                                            },
                                            activeColor: Color(0xff385a4a),
                                          ),
                                        ),
                                        TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: Text(
                                            "طبيعي",
                                            textAlign: TextAlign.start,
                                            style: textStyle2,
                                          ),
                                        ),
                                        Flexible(
                                          child: Radio(
                                            groupValue: visualCondition,
                                            value: "ضعيف",
                                            onChanged: (value) {
                                              setState(() {
                                                visualCondition = value!;
                                              });
                                            },
                                            activeColor: Color(0xff385a4a),
                                          ),
                                        ),
                                        TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: Text(
                                            'ضعيف',
                                            textAlign: TextAlign.start,
                                            style: textStyle2,
                                          ),
                                        ),
                                        Flexible(
                                          child: Radio(
                                            groupValue: visualCondition,
                                            value: "كفيف",
                                            onChanged: (value) {
                                              setState(() {
                                                visualCondition = value!;
                                              });
                                            },
                                            activeColor: Color(0xff385a4a),
                                          ),
                                        ),
                                        TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: Text(
                                            "كفيف",
                                            textAlign: TextAlign.start,
                                            style: textStyle2,
                                          ),
                                        ),
                                      ]),
                                      //--------------------------------- السمعيةالحالة----------------------------
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: Text("الحالة السمعية:",
                                            style: textStyle),
                                      ),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: Row(
                                          children: [
                                            Flexible(
                                              child: Radio(
                                                groupValue: auditoryCondition,
                                                value: "طبيعي",
                                                onChanged: (value) {
                                                  setState(() {
                                                    auditoryCondition = value!;
                                                  });
                                                },
                                                activeColor: Color(0xff385a4a),
                                              ),
                                            ),
                                            TableCell(
                                              verticalAlignment:
                                                  TableCellVerticalAlignment
                                                      .middle,
                                              child: Text(
                                                "طبيعي",
                                                textAlign: TextAlign.start,
                                                style: textStyle2,
                                              ),
                                            ),
                                            Flexible(
                                              child: Radio(
                                                groupValue: auditoryCondition,
                                                value: "ضعيف",
                                                onChanged: (value) {
                                                  setState(() {
                                                    auditoryCondition = value!;
                                                  });
                                                },
                                                activeColor: Color(0xff385a4a),
                                              ),
                                            ),
                                            TableCell(
                                              verticalAlignment:
                                                  TableCellVerticalAlignment
                                                      .middle,
                                              child: Text(
                                                "ضعيف",
                                                textAlign: TextAlign.start,
                                                style: textStyle2,
                                              ),
                                            ),
                                            Flexible(
                                              child: Radio(
                                                groupValue: auditoryCondition,
                                                value: "اصم",
                                                onChanged: (value) {
                                                  setState(() {
                                                    auditoryCondition = value!;
                                                  });
                                                },
                                                activeColor: Color(0xff385a4a),
                                              ),
                                            ),
                                            TableCell(
                                              verticalAlignment:
                                                  TableCellVerticalAlignment
                                                      .middle,
                                              child: Text(
                                                "أصم",
                                                textAlign: TextAlign.start,
                                                style: textStyle2,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      //-----------------------------مستوى النطق --------------------------------
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Align(
                                        child: Text(
                                          'مستوى النطق',
                                          style: TextStyle(
                                              color: Color(0xff6888a0),
                                              fontSize: 16,
                                              fontWeight: FontWeight.w900,
                                              fontFamily: 'Cairo'),
                                        ),
                                        alignment: Alignment.centerRight,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: Text(
                                            "قدرته على التعبير مقارنه بأقرانه في العمر:",
                                            style: textStyle),
                                      ),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: Row(
                                          children: [
                                            Flexible(
                                              child: Radio(
                                                groupValue: expressionLevel,
                                                value: "طبيعية",
                                                onChanged: (value) {
                                                  setState(() {
                                                    expressionLevel = value!;
                                                  });
                                                },
                                                activeColor: Color(0xff385a4a),
                                              ),
                                            ),
                                            TableCell(
                                              verticalAlignment:
                                                  TableCellVerticalAlignment
                                                      .middle,
                                              child: Text(
                                                "طبيعية",
                                                textAlign: TextAlign.start,
                                                style: textStyle2,
                                              ),
                                            ),
                                            Flexible(
                                              child: Radio(
                                                groupValue: expressionLevel,
                                                value: "صعيفة نوعا ما",
                                                onChanged: (value) {
                                                  setState(() {
                                                    expressionLevel = value!;
                                                  });
                                                },
                                                activeColor: Color(0xff385a4a),
                                              ),
                                            ),
                                            TableCell(
                                              verticalAlignment:
                                                  TableCellVerticalAlignment
                                                      .middle,
                                              child: Text(
                                                "ضعيفة نوعاَ ما",
                                                textAlign: TextAlign.start,
                                                style: textStyle2,
                                              ),
                                            ),
                                            Flexible(
                                              child: Radio(
                                                groupValue: expressionLevel,
                                                value: "ضعيفة",
                                                onChanged: (value) {
                                                  setState(() {
                                                    expressionLevel = value!;
                                                  });
                                                },
                                                activeColor: Color(0xff385a4a),
                                              ),
                                            ),
                                            TableCell(
                                              verticalAlignment:
                                                  TableCellVerticalAlignment
                                                      .middle,
                                              child: Text(
                                                "ضعيفة",
                                                textAlign: TextAlign.start,
                                                style: textStyle2,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: Text("وضوح مخارج الحروف:",
                                            style: textStyle),
                                      ),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: Row(
                                          children: [
                                            Flexible(
                                              child: Radio(
                                                groupValue: LetteringLevel,
                                                value: "واضحة",
                                                onChanged: (value) {
                                                  setState(() {
                                                    LetteringLevel = value!;
                                                  });
                                                },
                                                activeColor: Color(0xff385a4a),
                                              ),
                                            ),
                                            TableCell(
                                              verticalAlignment:
                                                  TableCellVerticalAlignment
                                                      .middle,
                                              child: Text(
                                                "واضحة",
                                                textAlign: TextAlign.start,
                                                style: textStyle2,
                                              ),
                                            ),
                                            Flexible(
                                              child: Radio(
                                                groupValue: LetteringLevel,
                                                value: "واضحة نوعا ما ",
                                                onChanged: (value) {
                                                  setState(() {
                                                    LetteringLevel = value!;
                                                  });
                                                },
                                                activeColor: Color(0xff385a4a),
                                              ),
                                            ),
                                            TableCell(
                                              verticalAlignment:
                                                  TableCellVerticalAlignment
                                                      .middle,
                                              child: Text(
                                                "واضحة نوعاَ ما",
                                                textAlign: TextAlign.start,
                                                style: textStyle2,
                                              ),
                                            ),
                                            Flexible(
                                              child: Radio(
                                                groupValue: LetteringLevel,
                                                value: "ضعيفة",
                                                onChanged: (value) {
                                                  setState(() {
                                                    LetteringLevel = value!;
                                                  });
                                                },
                                                activeColor: Color(0xff385a4a),
                                              ),
                                            ),
                                            TableCell(
                                              verticalAlignment:
                                                  TableCellVerticalAlignment
                                                      .middle,
                                              child: Text(
                                                "ضعيفة",
                                                textAlign: TextAlign.start,
                                                style: textStyle2,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: Text("تصنيف الحركة:",
                                            style: textStyle),
                                      ),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: Row(
                                          children: [
                                            Flexible(
                                              child: Radio(
                                                groupValue:
                                                    MotionClassification,
                                                value: "طبيعي",
                                                onChanged: (value) {
                                                  setState(() {
                                                    MotionClassification =
                                                        value!;
                                                  });
                                                },
                                                activeColor: Color(0xff385a4a),
                                              ),
                                            ),
                                            TableCell(
                                              verticalAlignment:
                                                  TableCellVerticalAlignment
                                                      .middle,
                                              child: Text(
                                                "طبيعي",
                                                textAlign: TextAlign.start,
                                                style: textStyle2,
                                              ),
                                            ),
                                            Flexible(
                                              child: Radio(
                                                groupValue:
                                                    MotionClassification,
                                                value: "صعب التحرك",
                                                onChanged: (value) {
                                                  setState(() {
                                                    MotionClassification =
                                                        value!;
                                                  });
                                                },
                                                activeColor: Color(0xff385a4a),
                                              ),
                                            ),
                                            TableCell(
                                              verticalAlignment:
                                                  TableCellVerticalAlignment
                                                      .middle,
                                              child: Text(
                                                "صعب التحرك",
                                                textAlign: TextAlign.start,
                                                style: textStyle2,
                                              ),
                                            ),
                                            Flexible(
                                              child: Radio(
                                                groupValue:
                                                    MotionClassification,
                                                value: "شلل نصفي",
                                                onChanged: (value) {
                                                  setState(() {
                                                    MotionClassification =
                                                        value!;
                                                  });
                                                },
                                                activeColor: Color(0xff385a4a),
                                              ),
                                            ),
                                            TableCell(
                                              verticalAlignment:
                                                  TableCellVerticalAlignment
                                                      .middle,
                                              child: Text(
                                                "شلل نصفي",
                                                textAlign: TextAlign.start,
                                                style: textStyle2,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Flexible(
                                            child: Radio(
                                              groupValue: MotionClassification,
                                              value: "شلل دماغي",
                                              onChanged: (value) {
                                                setState(() {
                                                  MotionClassification = value!;
                                                });
                                              },
                                              activeColor: Color(0xff385a4a),
                                            ),
                                          ),
                                          TableCell(
                                            verticalAlignment:
                                                TableCellVerticalAlignment
                                                    .middle,
                                            child: Text(
                                              "شلل دماغي",
                                              textAlign: TextAlign.start,
                                              style: textStyle2,
                                            ),
                                          ),
                                          Flexible(
                                            child: Radio(
                                              groupValue: MotionClassification,
                                              value: "شلل رباعي",
                                              onChanged: (value) {
                                                setState(() {
                                                  MotionClassification = value!;
                                                });
                                              },
                                              activeColor: Color(0xff385a4a),
                                            ),
                                          ),
                                          TableCell(
                                            verticalAlignment:
                                                TableCellVerticalAlignment
                                                    .middle,
                                            child: Text(
                                              "شلل رباعي",
                                              textAlign: TextAlign.start,
                                              style: textStyle2,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: Text("النمو الجسمي:",
                                            style: textStyle),
                                      ),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: Row(
                                          children: [
                                            Flexible(
                                              child: Radio(
                                                groupValue: physicalGrowth,
                                                value: "طبيعي",
                                                onChanged: (value) {
                                                  setState(() {
                                                    physicalGrowth = value!;
                                                  });
                                                },
                                                activeColor: Color(0xff385a4a),
                                              ),
                                            ),
                                            TableCell(
                                              verticalAlignment:
                                                  TableCellVerticalAlignment
                                                      .middle,
                                              child: Text(
                                                "طبيعي",
                                                textAlign: TextAlign.start,
                                                style: textStyle2,
                                              ),
                                            ),
                                            Flexible(
                                              child: Radio(
                                                groupValue: physicalGrowth,
                                                value: "غير طبيعي",
                                                onChanged: (value) {
                                                  setState(() {
                                                    physicalGrowth = value!;
                                                  });
                                                },
                                                activeColor: Color(0xff385a4a),
                                              ),
                                            ),
                                            TableCell(
                                              verticalAlignment:
                                                  TableCellVerticalAlignment
                                                      .middle,
                                              child: Text(
                                                "غير طبيعي",
                                                textAlign: TextAlign.start,
                                                style: textStyle2,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: Text("الامراض المزمنة:",
                                            style: textStyle),
                                      ),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: Table(
                                          columnWidths: {
                                            0: FractionColumnWidth(0.1),
                                            1: FractionColumnWidth(0.2),
                                            2: FractionColumnWidth(0.1),
                                            3: FractionColumnWidth(0.2),
                                            4: FractionColumnWidth(0.1),
                                            5: FractionColumnWidth(0.24),
                                          },
                                          children: [
                                            TableRow(
                                              children: [
                                                Flexible(
                                                  child: Radio(
                                                    groupValue: chronicDiseases,
                                                    value: "القلب",
                                                    onChanged: (value) {
                                                      setState(() {
                                                        chronicDiseases =
                                                            value!;
                                                      });
                                                    },
                                                    activeColor:
                                                        Color(0xff385a4a),
                                                  ),
                                                ),
                                                TableCell(
                                                  verticalAlignment:
                                                      TableCellVerticalAlignment
                                                          .middle,
                                                  child: Text(
                                                    "القلب",
                                                    textAlign: TextAlign.start,
                                                    style: textStyle2,
                                                  ),
                                                ),
                                                Flexible(
                                                  child: Radio(
                                                    groupValue: chronicDiseases,
                                                    value: "السكر",
                                                    onChanged: (value) {
                                                      setState(() {
                                                        chronicDiseases =
                                                            value!;
                                                      });
                                                    },
                                                    activeColor:
                                                        Color(0xff385a4a),
                                                  ),
                                                ),
                                                TableCell(
                                                  verticalAlignment:
                                                      TableCellVerticalAlignment
                                                          .middle,
                                                  child: Text(
                                                    "السكر",
                                                    textAlign: TextAlign.start,
                                                    style: textStyle2,
                                                  ),
                                                ),
                                                Flexible(
                                                  child: Radio(
                                                    groupValue: chronicDiseases,
                                                    value: "الربو",
                                                    onChanged: (value) {
                                                      setState(() {
                                                        chronicDiseases =
                                                            value!;
                                                      });
                                                    },
                                                    activeColor:
                                                        Color(0xff385a4a),
                                                  ),
                                                ),
                                                TableCell(
                                                  verticalAlignment:
                                                      TableCellVerticalAlignment
                                                          .middle,
                                                  child: Text(
                                                    "الربو",
                                                    textAlign: TextAlign.start,
                                                    style: textStyle2,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            TableRow(
                                              children: [
                                                Flexible(
                                                  child: Radio(
                                                    groupValue: chronicDiseases,
                                                    value: "الصرع",
                                                    onChanged: (value) {
                                                      setState(() {
                                                        chronicDiseases =
                                                            value!;
                                                      });
                                                    },
                                                    activeColor:
                                                        Color(0xff385a4a),
                                                  ),
                                                ),
                                                TableCell(
                                                  verticalAlignment:
                                                      TableCellVerticalAlignment
                                                          .middle,
                                                  child: Text(
                                                    "الصرع",
                                                    textAlign: TextAlign.start,
                                                    style: textStyle2,
                                                  ),
                                                ),
                                                Flexible(
                                                  child: Radio(
                                                    groupValue: chronicDiseases,
                                                    value: "التشجنات",
                                                    onChanged: (value) {
                                                      setState(() {
                                                        chronicDiseases =
                                                            value!;
                                                      });
                                                    },
                                                    activeColor:
                                                        Color(0xff385a4a),
                                                  ),
                                                ),
                                                TableCell(
                                                  verticalAlignment:
                                                      TableCellVerticalAlignment
                                                          .middle,
                                                  child: Text(
                                                    "التشنجات",
                                                    textAlign: TextAlign.start,
                                                    style: textStyle2,
                                                  ),
                                                ),
                                                Flexible(
                                                  child: Radio(
                                                    groupValue: chronicDiseases,
                                                    value: "امراض اخرى",
                                                    onChanged: (value) {
                                                      setState(() {
                                                        chronicDiseases =
                                                            value!;
                                                      });
                                                    },
                                                    activeColor:
                                                        Color(0xff385a4a),
                                                  ),
                                                ),
                                                TableCell(
                                                  verticalAlignment:
                                                      TableCellVerticalAlignment
                                                          .middle,
                                                  child: Text(
                                                    "أمراض اخرى",
                                                    textAlign: TextAlign.start,
                                                    style: textStyle2,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Center(
                                        child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    minimumSize: Size(160, 39),
                                                    backgroundColor:
                                                        Color(0xff394445),
                                                    shape:
                                                        const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  10)),
                                                    )),
                                                onPressed: () async {
                                                  String docId =
                                                      documentSnapshot.id;
                                                  updateGeneralHealthCondition(
                                                      docId);
                                                  Navigator.pop(context);
                                                  showDialog(
                                                      context: context,
                                                      builder: (context) =>
                                                          AlertDialog(
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10), // set the border radius here
                                                            ),
                                                            title: Text(
                                                                "تم ارسال التعديلات بنجاح"),
                                                          ));
                                                },
                                                child: Text('حفظ التغيرات'))),
                                      )
                                    ]),
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
            },
          );
        });
  }

  showBottomSheet2(context) {
    return showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(35.0),
            topRight: Radius.circular(35.0),
          ),
        ),
        context: context,
        // isScrollControlled: true,
        builder: (builder) {
          return StatefulBuilder(builder: (context, setState) {
            final bottomInset = MediaQuery.of(context).viewInsets.bottom;
            return Container(
              child: StreamBuilder<QuerySnapshot>(
                  stream: usersStream,
                  builder:
                      (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                    if (streamSnapshot.hasData) {
                      CheckupsYesFieldController.text = CheckupsYesField;
                      SurgeryYesFieldController.text = SurgeryYesField;
                      IntelligencetestYesFieldController.text =
                          IntelligencetestYesField;
                      allergyYesFieldController.text = allergyYesField;
                      return ListView.builder(
                          itemCount: streamSnapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            final DocumentSnapshot documentSnapshot =
                                streamSnapshot.data!.docs[index];

                            return SizedBox(
                              child: SingleChildScrollView(
                                reverse: true,
                                child: Container(
                                  padding: EdgeInsets.only(
                                    bottom: bottomInset,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 5),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Image.asset("images/checkup.png"),
                                              SizedBox(
                                                width: 9,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 4.0, top: 10),
                                                child: Text(
                                                  "الفحوصات والعمليات",
                                                  style: TextStyle(
                                                      fontSize: 19,
                                                      fontFamily: "Cairo",
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Align(
                                              alignment: Alignment.topRight,
                                              child: Text(
                                                "هل اجريت له فحوصات واشعة جمجمة ورسم مخ وتحاليل؟   ",
                                                style: textStyle,
                                              )),
                                          Align(
                                            alignment: Alignment.topRight,
                                            child: Table(
                                              columnWidths: {
                                                0: FractionColumnWidth(0.1),
                                                1: FractionColumnWidth(0.2),
                                                2: FractionColumnWidth(0.1),
                                                3: FractionColumnWidth(0.1),
                                              },
                                              children: [
                                                TableRow(
                                                  children: [
                                                    Radio(
                                                      groupValue: checkUp,
                                                      value: "نعم",
                                                      onChanged: (value) {
                                                        setState(() {
                                                          checkUp = value!;
                                                        });
                                                      },
                                                      activeColor:
                                                          Color(0xff385a4a),
                                                    ),
                                                    TableCell(
                                                      verticalAlignment:
                                                          TableCellVerticalAlignment
                                                              .middle,
                                                      child: Text(
                                                        'نعم',
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: textStyle2,
                                                      ),
                                                    ),
                                                    Radio(
                                                      groupValue: checkUp,
                                                      value: "لا",
                                                      onChanged: (value) {
                                                        setState(() {
                                                          checkUp = value!;
                                                        });
                                                      },
                                                      activeColor:
                                                          Color(0xff385a4a),
                                                    ),
                                                    TableCell(
                                                      verticalAlignment:
                                                          TableCellVerticalAlignment
                                                              .middle,
                                                      child: Text(
                                                        "لا    ",
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: textStyle2,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 20.0, right: 2),
                                            child: Visibility(
                                              visible: checkUp == "نعم",
                                              child: TextField(
                                                controller:
                                                    CheckupsYesFieldController,
                                                onChanged: (newValue) {
                                                  setState(() {
                                                    CheckupsYesField = newValue;
                                                  });
                                                },
                                                decoration:
                                                    kStylingInputDec.copyWith(
                                                        hintText:
                                                            'مثال: علاج سلوكي'),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 13,
                                          ),
                                          Align(
                                              alignment: Alignment.topRight,
                                              child: Text(
                                                  "هل أجريت له عمليات جراحية؟ ",
                                                  style: textStyle)),
                                          Align(
                                            alignment: Alignment.topRight,
                                            child: Table(
                                              columnWidths: {
                                                0: FractionColumnWidth(0.1),
                                                1: FractionColumnWidth(0.2),
                                                2: FractionColumnWidth(0.1),
                                                3: FractionColumnWidth(0.1),
                                              },
                                              children: [
                                                TableRow(
                                                  children: [
                                                    Radio(
                                                      groupValue: Surgery,
                                                      value: "نعم",
                                                      onChanged: (value) {
                                                        setState(() {
                                                          Surgery = value!;
                                                        });
                                                      },
                                                      activeColor:
                                                          Color(0xff385a4a),
                                                    ),
                                                    TableCell(
                                                      verticalAlignment:
                                                          TableCellVerticalAlignment
                                                              .middle,
                                                      child: Text(
                                                        'نعم',
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: textStyle2,
                                                      ),
                                                    ),
                                                    Radio(
                                                      groupValue: Surgery,
                                                      value: "لا",
                                                      onChanged: (value) {
                                                        setState(() {
                                                          Surgery = value!;
                                                        });
                                                      },
                                                      activeColor:
                                                          Color(0xff385a4a),
                                                    ),
                                                    TableCell(
                                                      verticalAlignment:
                                                          TableCellVerticalAlignment
                                                              .middle,
                                                      child: Text(
                                                        "لا    ",
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: textStyle2,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 20),
                                            child: Visibility(
                                              visible: Surgery == 'نعم',
                                              child: TextField(
                                                controller:
                                                    SurgeryYesFieldController,
                                                onChanged: (newValue) {
                                                  SurgeryYesField = newValue;
                                                  setState:
                                                  (() {});
                                                },
                                                decoration:
                                                    kStylingInputDec.copyWith(
                                                        hintText:
                                                            'مثال: علاج سلوكي'),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 13,
                                          ),
                                          Align(
                                              alignment: Alignment.topRight,
                                              child: Text(
                                                  "هل خضع لاختبار لتحديد الذكاء؟ ",
                                                  style: textStyle)),
                                          Align(
                                            alignment: Alignment.topRight,
                                            child: Table(
                                              columnWidths: {
                                                0: FractionColumnWidth(0.1),
                                                1: FractionColumnWidth(0.2),
                                                2: FractionColumnWidth(0.1),
                                                3: FractionColumnWidth(0.1),
                                              },
                                              children: [
                                                TableRow(
                                                  children: [
                                                    Radio(
                                                      groupValue:
                                                          DefiningIntelligence,
                                                      value: 'نعم',
                                                      onChanged: (value) {
                                                        setState(() {
                                                          DefiningIntelligence =
                                                              value!;
                                                        });
                                                      },
                                                      activeColor:
                                                          Color(0xff385a4a),
                                                    ),
                                                    TableCell(
                                                      verticalAlignment:
                                                          TableCellVerticalAlignment
                                                              .middle,
                                                      child: Text(
                                                        "نعم",
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: textStyle2,
                                                      ),
                                                    ),
                                                    Radio(
                                                      groupValue:
                                                          DefiningIntelligence,
                                                      value: "لا",
                                                      onChanged: (value) {
                                                        setState(() {
                                                          DefiningIntelligence =
                                                              value!;
                                                        });
                                                      },
                                                      activeColor:
                                                          Color(0xff385a4a),
                                                    ),
                                                    TableCell(
                                                      verticalAlignment:
                                                          TableCellVerticalAlignment
                                                              .middle,
                                                      child: Text(
                                                        "لا    ",
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: textStyle2,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 20),
                                            child: Visibility(
                                              visible:
                                                  DefiningIntelligence == 'نعم',
                                              child: TextField(
                                                controller:
                                                    IntelligencetestYesFieldController,
                                                onChanged: (newValue) {
                                                  IntelligencetestYesField =
                                                      newValue;
                                                  setState:
                                                  (() {});
                                                },
                                                decoration:
                                                    kStylingInputDec.copyWith(
                                                        hintText:
                                                            'مثال: علاج سلوكي'),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 13,
                                          ),
                                          Align(
                                              alignment: Alignment.topRight,
                                              child: Text(
                                                  "هل يوجد لدى الطفل حساسية؟",
                                                  style: textStyle)),
                                          Align(
                                            alignment: Alignment.topRight,
                                            child: Table(
                                              columnWidths: {
                                                0: FractionColumnWidth(0.1),
                                                1: FractionColumnWidth(0.2),
                                                2: FractionColumnWidth(0.1),
                                                3: FractionColumnWidth(0.1),
                                              },
                                              children: [
                                                TableRow(
                                                  children: [
                                                    Radio(
                                                      groupValue: sensitive,
                                                      value: "نعم",
                                                      onChanged: (value) {
                                                        setState(() {
                                                          sensitive = value!;
                                                        });
                                                      },
                                                      activeColor:
                                                          Color(0xff385a4a),
                                                    ),
                                                    TableCell(
                                                      verticalAlignment:
                                                          TableCellVerticalAlignment
                                                              .middle,
                                                      child: Text(
                                                        'نعم',
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: textStyle2,
                                                      ),
                                                    ),
                                                    Radio(
                                                      groupValue: sensitive,
                                                      value: "لا",
                                                      onChanged: (value) {
                                                        setState(() {
                                                          sensitive = value!;
                                                        });
                                                      },
                                                      activeColor:
                                                          Color(0xff385a4a),
                                                    ),
                                                    TableCell(
                                                      verticalAlignment:
                                                          TableCellVerticalAlignment
                                                              .middle,
                                                      child: Text(
                                                        "لا    ",
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: textStyle2,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 20.0),
                                            child: Visibility(
                                              visible: sensitive == 'نعم',
                                              child: TextField(
                                                controller:
                                                    allergyYesFieldController,
                                                onChanged: (newValue) {
                                                  allergyYesField = newValue;
                                                  setState:
                                                  (() {});
                                                },
                                                decoration:
                                                    kStylingInputDec.copyWith(
                                                        hintText:
                                                            'مثال: علاج سلوكي'),
                                              ),
                                            ),
                                          ),
                                          Center(
                                              child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      10.0),
                                                  child: ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                              minimumSize:
                                                                  Size(160, 39),
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
                                                        String docId =
                                                            documentSnapshot.id;
                                                        updateGeneralHealthCondition(
                                                            docId);
                                                        Navigator.pop(context);
                                                        showDialog(
                                                            context: context,
                                                            builder:
                                                                (context) =>
                                                                    AlertDialog(
                                                                      shape:
                                                                          RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(10), // set the border radiu
                                                                      ),
                                                                      title: Text(
                                                                          "تم ارسال التعديلات بنجاح"),
                                                                    ));
                                                      },
                                                      child: Text(
                                                          'حفظ التغيرات')))),
                                          // Padding(
                                          // padding: const EdgeInsets.all(20.0),
                                          // child: ElevatedButton(
                                          // onPressed: () async {
                                          // String docId =
                                          // documentSnapshot.id;
                                          // updateGeneralHealthCondition(
                                          // docId);
                                          // Navigator.pop(context);
                                          // },
                                          // child: Text('حفظ التغيرات')))
                                        ]),
                                  ),
                                ),
                              ),
                            );
                          });
                    }
                    ;
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }),
            );
          });
        });
  }
}

class TabControler extends StatelessWidget {
  late Widget tab1;
  late Widget tab2;
  late Widget widget1;
  late Widget widget2;
  TabControler({
    required this.tab1,
    required this.tab2,
    required this.widget1,
    required this.widget2,
  });
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          Container(
            height: 45,
            decoration: BoxDecoration(
              border: Border(
                  bottom:
                      BorderSide(color: Color.fromARGB(131, 158, 158, 158))),
            ),
            child: TabBar(
              indicator: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        color: Color.fromARGB(111, 66, 65, 65), width: 2)),
              ),
              labelColor: Color.fromARGB(255, 21, 11, 11),
              tabs: [
                Tab(
                  child: tab2,
                ),
                Tab(
                  child: tab1,
                )
              ],
            ),
          ),
          Container(
            child: Expanded(
                child: TabBarView(
              children: [
                widget2,
                widget1,
              ],
            )),
          )
        ],
      ),
    );
  }
}

class ProfileContainer extends StatelessWidget {
  late String ChildName;
  late String Berthday;
  late String EducationLevel;
  late String ChildAvatar;
  ProfileContainer(
      {required this.ChildName,
      required this.Berthday,
      required this.EducationLevel,
      required this.ChildAvatar});

  @override
  Widget build(BuildContext context) {
    var textStyle = TextStyle(
      color: Color(0xff394445),
      fontSize: 16,
      fontFamily: "Cairo",
      fontWeight: FontWeight.w700,
    );
    var textStyle2 = TextStyle(
      color: Color(0xff797979),
      fontSize: 12,
    );
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('test_results')
            .where('ParentID',
                isEqualTo: FirebaseAuth.instance.currentUser!
                    .uid) // Replace 'letters' with your collection name

            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }
          int newCount = 0;
          List<DocumentSnapshot> docs = snapshot.data!.docs;
          for (var doc in docs) {
            if (!doc['isRead']) {
              newCount++;
            } else {
              break;
            }
          }
          return Stack(
            children: [
              Container(
                  width: 423,
                  height: 190,
                  padding:
                      EdgeInsets.only(top: 60, left: 30, right: 30, bottom: 50),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Color(0xffddd6f3),
                        Color(0xfffaaca8),
                        Color(0xffda124e)
                      ],
                    ),
                    color: Color(0xff6888a0),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                        bottomRight: Radius.circular(50)),
                  )),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.only(top: 90),
                  child: Container(
                      child: Center(
                          child: Column(
                        children: [
                          // CircleAvatar(
                          // radius: 60,
                          // backgroundColor: Color(0xffEFF5F2),
                          // foregroundColor: Color(0xffEFF5F2),
                          // backgroundImage: AssetImage(""),
                          // ),
                          SizedBox(
                            height: 76,
                          ),
                          Text(
                            ChildName,
                            style: TextStyle(
                              color: Color(0xff394445),
                              fontSize: 17,
                              fontFamily: "Cairo",
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            "$Berthday\n $EducationLevel",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xff797979),
                              fontSize: 13,
                            ),
                          )
                        ],
                      )),
                      width: 287,
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x16000000),
                            blurRadius: 4,
                            offset: Offset(4, 4),
                          ),
                        ],
                        color: Colors.white,
                      )),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Center(
                  child: CircleAvatar(
                      radius: 60,
                      backgroundColor: Color(0xffEFF5F2),
                      foregroundColor: Color(0xffEFF5F2),
                      backgroundImage: AssetImage(ChildAvatar)),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon:
                      const Icon(Icons.arrow_forward_ios_outlined, size: 20.0),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),

              Positioned(
                right: 5,
                child: Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: Icon(Icons.notifications, color: Colors.white),
                    onPressed: () {
                      // Navigate to notifications screen
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => childEvaluationPage(),
                          ));

                      //
                      // Mark the document as read
                      FirebaseFirestore.instance
                          .collection('test_results')
                          .where('ParentID',
                              isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                          .get()
                          .then((querySnapshot) {
                        querySnapshot.docs.forEach((docSnap) {
                          docSnap.reference
                              .update({'isRead': true})
                              .then((value) => print("Document marked as read"))
                              .catchError((error) => print(
                                  "Failed to mark document as read: $error"));
                        });
                      }).catchError((error) =>
                              print("Failed to retrieve documents: $error"));
                    },
                  ),
                ),
              ),
              Positioned(
                right: 7,
                top: 4,
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red,
                  ),
                  child: Center(
                    child: Text(
                      '$newCount',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              // Align(
              // alignment: Alignment.center,
              // child: Container(
              // child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              // children: [
              // SizedBox(
              // height: 70,
              // ),
              // Text(
              // ChildName,
              // style: TextStyle(
              // color: Color(0xff394445),
              // fontSize: 15,
              // fontFamily: "Cairo",
              // fontWeight: FontWeight.w700,
              // ),
              // ),
              // Text(
              // "$Berthday\n $EducationLevel",
              // textAlign: TextAlign.center,
              // style: TextStyle(
              // color: Color(0xff797979),
              // fontSize: 10,
              // ),
              // )
              // ],
              // ),
              // width: 287,
              // height: 159,
              // decoration: BoxDecoration(
              // borderRadius: BorderRadius.circular(50),
              // boxShadow: [
              // BoxShadow(
              // color: Color(0x16000000),
              // blurRadius: 4,
              // offset: Offset(4, 4),
              // ),
              // ],
              // color: Colors.white,
              // ),
              // ),
              // ),
              // Positioned(
              // top: 30,
              // child: Container(
              // width: 130.53,
              // height: 130.53,
              // child: CircleAvatar(
              // radius: 60,
              // backgroundColor: Color(0xffEFF5F2),
              // foregroundColor: Color(0xffEFF5F2),
              // backgroundImage: AssetImage(""),
              // ),
              // ),
              // ),
            ],
          );
        });
  }
}
