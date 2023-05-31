import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eloquentapp/parents/Pages/ChildFile/Report_Page.dart';
import 'package:eloquentapp/parents/Pages/ChildFile/alphabet.dart';
import 'package:eloquentapp/parents/Pages/ChildFile/child_evaluation.dart';
import 'package:eloquentapp/screens/constants.dart';
import 'package:eloquentapp/therapist/Pages/Children/Phases/Sound/sounds.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OldChildProfile extends StatefulWidget {
  late String Childid;
  OldChildProfile({required this.Childid});
  @override
  State<OldChildProfile> createState() => _OldChildProfileState();
}

class _OldChildProfileState extends State<OldChildProfile> {
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
        print(ChildInfo['uid']);
        setState(() {
          isLoded = false;
        });
      }
    });
  }

  late String uid = ChildInfo['uidParent'];
  late String name = ChildInfo['name'];

  late String ChildEducationalLevel = ChildInfo['ChildEducationalLevel'];
  late String childIdUsage = ChildInfo['uid'];
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
  // Future<void> _calculateTotalWeeklyUsage() async {
  //   final DocumentReference<Map<String, dynamic>> homeDocument =
  //       FirebaseFirestore.instance
  //           .collection('Child')
  //           .doc(widget.Childid)
  //           .collection('pages')
  //           .doc('Home');
  //   final DocumentSnapshot<Map<String, dynamic>> homeSnapshot =
  //       await homeDocument.get();
  //   final double? weeklyDuration =
  //       homeSnapshot.data()?['average_weekly_duration'];
  //   if (weeklyDuration != null) {
  //     setState(() {
  //       print(weeklyDuration);
  //       _totalWeeklyUsage = weeklyDuration * 60.0; // convert to minutes
  //     });
  //   } else {
  //     setState(() {
  //       _totalWeeklyUsage = 0.0;
  //     });
  //   }
  // }
  //----------------------------

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
                        EducationLevel: ChildEducationalLevel),
                    Expanded(
                      child: DefaultTabController(
                        length: 2,
                        child: Column(children: [
                          Container(
                            height: 45,
                            child: TabBar(
                              indicator: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Color.fromARGB(0, 66, 65, 65),
                                        width: 2)),
                              ),
                              labelColor: Color.fromARGB(255, 21, 11, 11),
                              tabs: [
                                Tab(
                                  child: Text("ملف الطفل"),
                                ),
                                Tab(
                                  child: Text(" تقرير الجلسات"),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Expanded(
                              child: TabBarView(
                                children: [
                                  TabControler(
                                    tab1: Text('معلومات عامة'),
                                    tab2: Text('تتبع تقدم الطفل'),
                                    widget1: ListView(
                                      children: [
                                        Column(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                showBottomSheet(context);
                                              },
                                              child: Card(
                                                elevation: 4,
                                                color: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            17.80)),
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  width: 343,
                                                  height: 110,
                                                  child: ListTile(
                                                    title: Text(
                                                        'الصفات الشخصية والسلوكية '),
                                                    trailing: Icon(Icons.home),
                                                    leading: Icon(Icons
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
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            17.80)),
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  width: 343,
                                                  height: 110,
                                                  child: ListTile(
                                                    title: Text(
                                                        'الحالة الصحية العامة '),
                                                    trailing: Icon(Icons.home),
                                                    leading: Icon(Icons
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
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            17.80)),
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  width: 343,
                                                  height: 110,
                                                  child: ListTile(
                                                    title: Text(
                                                        'الفحوصات والعمليات'),
                                                    trailing: Icon(Icons.home),
                                                    leading: Icon(Icons
                                                        .arrow_back_ios_new_outlined),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
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

                                            Card(
                                                shadowColor:
                                                    Color.fromARGB(94, 0, 0, 0),
                                                elevation: 5,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            18.31)),
                                                color: Colors.white,
                                                child: Container(
                                                  width: 160,
                                                  height: 170,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
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
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            color: Color(
                                                                0xff394445),
                                                            fontSize: 14,
                                                            fontFamily:
                                                                "Montserrat",
                                                          ),
                                                        ),
                                                        Text(
                                                          '${_totalWeeklyUsage.toStringAsFixed(0)} ',
                                                          style: TextStyle(
                                                            color: Color(
                                                                0xff385a4a),
                                                            fontSize: 43,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                        Text(
                                                          "دقيقة",
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            color: Color(
                                                                0xff394445),
                                                            fontSize: 16,
                                                            fontFamily:
                                                                "Montserrat",
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                )),
                                            //----------------------ماقبل اللغة
                                            SizedBox(width: 15),

                                            GestureDetector(
                                              onTap: () {},
                                              child: Card(
                                                  shadowColor: Color.fromARGB(
                                                      94, 0, 0, 0),
                                                  elevation: 5,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              18.31)),
                                                  color: Colors.white,
                                                  child: Container(
                                                    width: 160,
                                                    height: 170,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
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
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                              color: Color(
                                                                  0xff394445),
                                                              fontSize: 14,
                                                              fontFamily:
                                                                  "Montserrat",
                                                            ),
                                                          ),
                                                          Text(
                                                            "خ",
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                              color: Color(
                                                                  0xff385a4a),
                                                              fontSize: 43,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          ),
                                                          Text(
                                                            "في الاسبوع",
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
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
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12),
                                    child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(18.31),
                                          color: Color(0x0c9bb0a5),
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
        context: context,
        builder: (builder) {
          return StatefulBuilder(
            builder: (context, setState) {
              return StreamBuilder<QuerySnapshot>(
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
                            child: Column(children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Text("الصفات الشخصية والسلوكية"),
                              ),
                              Table(
                                columnWidths: {
                                  0: FractionColumnWidth(0.2),
                                  1: FractionColumnWidth(0.1),
                                  2: FractionColumnWidth(0.2),
                                  3: FractionColumnWidth(0.1),
                                  4: FractionColumnWidth(0.2),
                                  5: FractionColumnWidth(0.1),
                                },
                                children: [
                                  TableRow(children: [
                                    TableCell(
                                      verticalAlignment:
                                          TableCellVerticalAlignment.middle,
                                      child: Text(
                                        "قليل الحركة",
                                        textAlign: TextAlign.end,
                                      ),
                                    ),
                                    Radio(
                                      groupValue: Movement,
                                      value: "قليل الحركة",
                                      onChanged: (value) {
                                        setState(() {
                                          Movement = value.toString();
                                        });
                                      },
                                    ),
                                    TableCell(
                                      verticalAlignment:
                                          TableCellVerticalAlignment.middle,
                                      child: Text(
                                        "متوسط الحركة",
                                        textAlign: TextAlign.end,
                                      ),
                                    ),
                                    Radio(
                                      groupValue: Movement,
                                      value: "متوسط الحركة",
                                      onChanged: (value) {
                                        setState(() {
                                          Movement = value.toString();
                                        });
                                      },
                                    ),
                                    TableCell(
                                      verticalAlignment:
                                          TableCellVerticalAlignment.middle,
                                      child: Text(
                                        "سريع الحركة",
                                        textAlign: TextAlign.end,
                                      ),
                                    ),
                                    Radio(
                                      groupValue: Movement,
                                      value: "كثير الحركة",
                                      onChanged: (value) {
                                        setState(() {
                                          Movement = value.toString();
                                        });
                                      },
                                    ),
                                  ]),
                                  TableRow(
                                    children: [
                                      TableCell(
                                        verticalAlignment:
                                            TableCellVerticalAlignment.middle,
                                        child: Text(
                                          "اجتماعي ",
                                          textAlign: TextAlign.end,
                                        ),
                                      ),
                                      Radio(
                                        groupValue: personalBehaviour,
                                        value: 'اجتماعي',
                                        onChanged: (value) {
                                          setState(() {
                                            personalBehaviour =
                                                value.toString();
                                          });
                                        },
                                      ),
                                      TableCell(
                                        verticalAlignment:
                                            TableCellVerticalAlignment.middle,
                                        child: Text(
                                          "انطوائي ",
                                          textAlign: TextAlign.end,
                                        ),
                                      ),
                                      Radio(
                                        groupValue: personalBehaviour,
                                        value: 'انطوائي',
                                        onChanged: (value) {
                                          setState(() {
                                            personalBehaviour =
                                                value.toString();
                                          });
                                        },
                                      ),
                                      TableCell(
                                        verticalAlignment:
                                            TableCellVerticalAlignment.middle,
                                        child: Text(
                                          "خحول ",
                                          textAlign: TextAlign.end,
                                        ),
                                      ),
                                      Radio(
                                        groupValue: personalBehaviour,
                                        value: "خجول",
                                        onChanged: (value) {
                                          setState(() {
                                            personalBehaviour =
                                                value.toString();
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                  TableRow(
                                    children: [
                                      TableCell(
                                        child: Text(
                                          " ",
                                        ),
                                      ),
                                      Text(""),
                                      TableCell(
                                        verticalAlignment:
                                            TableCellVerticalAlignment.middle,
                                        child: Text(
                                          "يغضب بسرعة ",
                                          textAlign: TextAlign.end,
                                        ),
                                      ),
                                      Radio(
                                        groupValue: emotionalBehaviour,
                                        value: 'يغضب بسرعة',
                                        onChanged: (value) {
                                          setState(() {
                                            emotionalBehaviour =
                                                value.toString();
                                          });
                                        },
                                      ),
                                      TableCell(
                                        verticalAlignment:
                                            TableCellVerticalAlignment.middle,
                                        child: Text(
                                          "يحبط بسرعة ",
                                          textAlign: TextAlign.end,
                                        ),
                                      ),
                                      Radio(
                                        groupValue: emotionalBehaviour,
                                        value: 'يحبط بسرعة',
                                        onChanged: (value) {
                                          setState(() {
                                            emotionalBehaviour =
                                                value.toString();
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: Text(
                                    ":الانتباه",
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: Table(
                                    columnWidths: {
                                      0: FractionColumnWidth(0.2),
                                      1: FractionColumnWidth(0.1),
                                      2: FractionColumnWidth(0.2),
                                      3: FractionColumnWidth(0.1),
                                    },
                                    children: [
                                      TableRow(
                                        children: [
                                          TableCell(
                                            verticalAlignment:
                                                TableCellVerticalAlignment
                                                    .middle,
                                            child: Text(
                                              "يتشتت بسهولة ",
                                              textAlign: TextAlign.end,
                                            ),
                                          ),
                                          Radio(
                                            groupValue: dispersion,
                                            value: 'يتشتت بسهولة',
                                            onChanged: (value) {
                                              setState(() {
                                                dispersion = value.toString();
                                              });
                                            },
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
                                          Radio(
                                            groupValue: dispersion,
                                            value: 'قليل التشتت',
                                            onChanged: (value) {
                                              setState(() {
                                                dispersion = value.toString();
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              // الفهم
                              Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: Text(
                                    ":الفهم والاستيعاب",
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: Table(
                                    columnWidths: {
                                      0: FractionColumnWidth(0.4),
                                      1: FractionColumnWidth(0.1),
                                      2: FractionColumnWidth(0.3),
                                      3: FractionColumnWidth(0.1),
                                    },
                                    children: [
                                      TableRow(
                                        children: [
                                          TableCell(
                                            verticalAlignment:
                                                TableCellVerticalAlignment
                                                    .middle,
                                            child: Text(
                                              "يفهم التعليمات بصعوية  ",
                                              textAlign: TextAlign.end,
                                            ),
                                          ),
                                          Radio(
                                            groupValue: understanding,
                                            value: 'يفهم التعليمات بسهولة',
                                            onChanged: (value) {
                                              setState(() {
                                                understanding = value!;
                                              });
                                            },
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
                                          Radio(
                                            groupValue: understanding,
                                            value: 'يفهم التعليمات بصعوبة',
                                            onChanged: (value) {
                                              setState(() {
                                                understanding = value!;
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              // التواصل البصري
                              Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: Text(
                                    ":التواصل البصري",
                                  ),
                                ),
                              ),
                              Table(
                                columnWidths: {
                                  0: FractionColumnWidth(0.2),
                                  1: FractionColumnWidth(0.1),
                                  2: FractionColumnWidth(0.2),
                                  3: FractionColumnWidth(0.1),
                                  4: FractionColumnWidth(0.2),
                                  5: FractionColumnWidth(0.1),
                                },
                                children: [
                                  TableRow(
                                    children: [
                                      TableCell(
                                        verticalAlignment:
                                            TableCellVerticalAlignment.middle,
                                        child: Text(
                                          "لايوجد ",
                                          textAlign: TextAlign.end,
                                        ),
                                      ),
                                      Radio(
                                        groupValue: visualCommunication,
                                        value: 'لا يوجد',
                                        onChanged: (value) {
                                          setState(() {
                                            visualCommunication =
                                                value.toString();
                                          });
                                        },
                                      ),
                                      TableCell(
                                        verticalAlignment:
                                            TableCellVerticalAlignment.middle,
                                        child: Text(
                                          "ضعيف  ",
                                          textAlign: TextAlign.end,
                                        ),
                                      ),
                                      Radio(
                                        groupValue: visualCommunication,
                                        value: 'ضعيف',
                                        onChanged: (value) {
                                          setState(() {
                                            visualCommunication =
                                                value.toString();
                                          });
                                        },
                                      ),
                                      TableCell(
                                        verticalAlignment:
                                            TableCellVerticalAlignment.middle,
                                        child: Text(
                                          "جيد   ",
                                          textAlign: TextAlign.end,
                                        ),
                                      ),
                                      Radio(
                                        groupValue: visualCommunication,
                                        value: 'جيد',
                                        onChanged: (value) {
                                          setState(() {
                                            visualCommunication =
                                                value.toString();
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Table(columnWidths: {
                                0: FractionColumnWidth(0.1),
                                1: FractionColumnWidth(0.1),
                                2: FractionColumnWidth(0.1),
                                3: FractionColumnWidth(0.1),
                                4: FractionColumnWidth(0.5),
                              }, children: [
                                TableRow(children: [
                                  TableCell(
                                    verticalAlignment:
                                        TableCellVerticalAlignment.middle,
                                    child: Text(
                                      "لا",
                                      textAlign: TextAlign.end,
                                    ),
                                  ),
                                  Radio(
                                    groupValue: Agressive,
                                    value: 'لا',
                                    onChanged: (value) {
                                      setState(() {
                                        Agressive = value!;
                                      });
                                    },
                                  ),
                                  TableCell(
                                    verticalAlignment:
                                        TableCellVerticalAlignment.middle,
                                    child: Text(
                                      "نعم ",
                                      textAlign: TextAlign.end,
                                    ),
                                  ),
                                  Radio(
                                    groupValue: Agressive,
                                    value: 'نعم',
                                    onChanged: (value) {
                                      setState(() {
                                        Agressive = value!;
                                      });
                                    },
                                  ),
                                  TableCell(
                                    verticalAlignment:
                                        TableCellVerticalAlignment.middle,
                                    child: Text(
                                      "يظهر على الطفل سلوك عدواني؟",
                                      textAlign: TextAlign.end,
                                    ),
                                  ),
                                ]),
                              ]),
                              Table(columnWidths: {
                                0: FractionColumnWidth(0.1),
                                1: FractionColumnWidth(0.1),
                                2: FractionColumnWidth(0.1),
                                3: FractionColumnWidth(0.1),
                                4: FractionColumnWidth(0.5),
                              }, children: [
                                TableRow(children: [
                                  TableCell(
                                    verticalAlignment:
                                        TableCellVerticalAlignment.middle,
                                    child: Text(
                                      "لا",
                                      textAlign: TextAlign.end,
                                    ),
                                  ),
                                  Radio(
                                    groupValue: fear,
                                    value: 'لا',
                                    onChanged: (value) {
                                      setState(() {
                                        fear = value!;
                                      });
                                    },
                                  ),
                                  TableCell(
                                    verticalAlignment:
                                        TableCellVerticalAlignment.middle,
                                    child: Text(
                                      "نعم ",
                                      textAlign: TextAlign.end,
                                    ),
                                  ),
                                  Radio(
                                    groupValue: fear,
                                    value: 'نعم',
                                    onChanged: (value) {
                                      setState(() {
                                        fear = value!;
                                      });
                                    },
                                  ),
                                  TableCell(
                                    verticalAlignment:
                                        TableCellVerticalAlignment.middle,
                                    child: Text(
                                      "يظهر على الطفل الخوف او القلق؟",
                                      textAlign: TextAlign.end,
                                    ),
                                  ),
                                ]),
                              ]),
                              Table(columnWidths: {
                                0: FractionColumnWidth(0.1),
                                1: FractionColumnWidth(0.1),
                                2: FractionColumnWidth(0.1),
                                3: FractionColumnWidth(0.1),
                                4: FractionColumnWidth(0.5),
                              }, children: [
                                TableRow(children: [
                                  TableCell(
                                    verticalAlignment:
                                        TableCellVerticalAlignment.middle,
                                    child: Text(
                                      "لا",
                                      textAlign: TextAlign.end,
                                    ),
                                  ),
                                  Radio(
                                    groupValue: cooperating,
                                    value: "لا",
                                    onChanged: (value) {
                                      setState(() {
                                        cooperating = value!;
                                      });
                                    },
                                  ),
                                  TableCell(
                                    verticalAlignment:
                                        TableCellVerticalAlignment.middle,
                                    child: Text(
                                      "نعم ",
                                      textAlign: TextAlign.end,
                                    ),
                                  ),
                                  Radio(
                                    groupValue: cooperating,
                                    value: "نعم",
                                    onChanged: (value) {
                                      setState(() {
                                        cooperating = value!;
                                      });
                                    },
                                  ),
                                  TableCell(
                                    verticalAlignment:
                                        TableCellVerticalAlignment.middle,
                                    child: Text(
                                      "هل الطفل متعاون مع الاخرين؟",
                                      textAlign: TextAlign.end,
                                    ),
                                  ),
                                ]),
                              ]),
                              ElevatedButton(
                                  onPressed: () async {
                                    String docId = documentSnapshot.id;
                                    updtepersonalBehaviour(docId);
                                    Navigator.pop(context);
                                  },
                                  child: Text('حفظ التغيرات'))
                            ]),
                          );
                        });
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              );
            },
          );
        });
  }

  showBottomSheet1(context) {
    return showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
        context: context,
        builder: (builder) {
          return StatefulBuilder(
            builder: (context, setState) {
              return StreamBuilder<QuerySnapshot>(
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
                              padding: const EdgeInsets.all(10),
                              child: Column(children: [
                                Text("الحالة الصحية العامة"),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Text(
                                    ":الحالة البصرية",
                                  ),
                                ),
                                Table(
                                  columnWidths: {
                                    0: FractionColumnWidth(0.2),
                                    1: FractionColumnWidth(0.1),
                                    2: FractionColumnWidth(0.2),
                                    3: FractionColumnWidth(0.1),
                                    4: FractionColumnWidth(0.2),
                                    5: FractionColumnWidth(0.1),
                                  },
                                  children: [
                                    TableRow(children: [
                                      TableCell(
                                        verticalAlignment:
                                            TableCellVerticalAlignment.middle,
                                        child: Text(
                                          "كفيف",
                                          textAlign: TextAlign.end,
                                        ),
                                      ),
                                      Radio(
                                        groupValue: visualCondition,
                                        value: "كفيف",
                                        onChanged: (value) {
                                          setState(() {
                                            visualCondition = value!;
                                          });
                                        },
                                      ),
                                      TableCell(
                                        verticalAlignment:
                                            TableCellVerticalAlignment.middle,
                                        child: Text(
                                          'ضعيف',
                                          textAlign: TextAlign.end,
                                        ),
                                      ),
                                      Radio(
                                        groupValue: visualCondition,
                                        value: "ضعيف",
                                        onChanged: (value) {
                                          setState(() {
                                            visualCondition = value!;
                                          });
                                        },
                                      ),
                                      TableCell(
                                        verticalAlignment:
                                            TableCellVerticalAlignment.middle,
                                        child: Text(
                                          "طبيعي",
                                          textAlign: TextAlign.end,
                                        ),
                                      ),
                                      Radio(
                                        groupValue: visualCondition,
                                        value: "طبيعي",
                                        onChanged: (value) {
                                          setState(() {
                                            visualCondition = value!;
                                          });
                                        },
                                      ),
                                    ]),
                                  ],
                                ),
                                //--------------------------------- السمعيةالحالة----------------------------
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Text(
                                    ":الحالة السمعية",
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Table(
                                    columnWidths: {
                                      0: FractionColumnWidth(0.2),
                                      1: FractionColumnWidth(0.1),
                                      2: FractionColumnWidth(0.2),
                                      3: FractionColumnWidth(0.1),
                                      4: FractionColumnWidth(0.2),
                                      5: FractionColumnWidth(0.1),
                                    },
                                    children: [
                                      TableRow(
                                        children: [
                                          TableCell(
                                            verticalAlignment:
                                                TableCellVerticalAlignment
                                                    .middle,
                                            child: Text(
                                              "أصم",
                                              textAlign: TextAlign.end,
                                            ),
                                          ),
                                          Radio(
                                            groupValue: auditoryCondition,
                                            value: "اصم",
                                            onChanged: (value) {
                                              setState(() {
                                                auditoryCondition = value!;
                                              });
                                            },
                                          ),
                                          TableCell(
                                            verticalAlignment:
                                                TableCellVerticalAlignment
                                                    .middle,
                                            child: Text(
                                              "ضعيف",
                                              textAlign: TextAlign.end,
                                            ),
                                          ),
                                          Radio(
                                            groupValue: auditoryCondition,
                                            value: "ضعيف",
                                            onChanged: (value) {
                                              setState(() {
                                                auditoryCondition = value!;
                                              });
                                            },
                                          ),
                                          TableCell(
                                            verticalAlignment:
                                                TableCellVerticalAlignment
                                                    .middle,
                                            child: Text(
                                              "طبيعي",
                                              textAlign: TextAlign.end,
                                            ),
                                          ),
                                          Radio(
                                            groupValue: auditoryCondition,
                                            value: "طبيعي",
                                            onChanged: (value) {
                                              setState(() {
                                                auditoryCondition = value!;
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                //-----------------------------مستوى النطق --------------------------------
                                Align(
                                  child: Text(
                                    'مستوى النطق',
                                  ),
                                  alignment: Alignment.centerRight,
                                ),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Text(
                                    ":قدرته على التعبير مقارنه بأقرانه في العمر",
                                  ),
                                ),

                                Align(
                                  alignment: Alignment.topRight,
                                  child: Table(
                                    columnWidths: {
                                      0: FractionColumnWidth(0.2),
                                      1: FractionColumnWidth(0.1),
                                      2: FractionColumnWidth(0.2),
                                      3: FractionColumnWidth(0.1),
                                      4: FractionColumnWidth(0.2),
                                      5: FractionColumnWidth(0.1),
                                    },
                                    children: [
                                      TableRow(
                                        children: [
                                          TableCell(
                                            verticalAlignment:
                                                TableCellVerticalAlignment
                                                    .middle,
                                            child: Text(
                                              "ضعيفة",
                                              textAlign: TextAlign.end,
                                            ),
                                          ),
                                          Radio(
                                            groupValue: expressionLevel,
                                            value: "ضعيفة",
                                            onChanged: (value) {
                                              setState(() {
                                                expressionLevel = value!;
                                              });
                                            },
                                          ),
                                          TableCell(
                                            verticalAlignment:
                                                TableCellVerticalAlignment
                                                    .middle,
                                            child: Text(
                                              "ضعيفة نوعاَ ما",
                                              textAlign: TextAlign.end,
                                            ),
                                          ),
                                          Radio(
                                            groupValue: expressionLevel,
                                            value: "صعيفة نوعا ما",
                                            onChanged: (value) {
                                              setState(() {
                                                expressionLevel = value!;
                                              });
                                            },
                                          ),
                                          TableCell(
                                            verticalAlignment:
                                                TableCellVerticalAlignment
                                                    .middle,
                                            child: Text(
                                              "طبيعية",
                                              textAlign: TextAlign.end,
                                            ),
                                          ),
                                          Radio(
                                            groupValue: expressionLevel,
                                            value: "طبيعية",
                                            onChanged: (value) {
                                              setState(() {
                                                expressionLevel = value!;
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),

                                Align(
                                  alignment: Alignment.topRight,
                                  child: Text(
                                    ":وضوح مخارج الحروف",
                                  ),
                                ),

                                Align(
                                  alignment: Alignment.topRight,
                                  child: Table(
                                    columnWidths: {
                                      0: FractionColumnWidth(0.2),
                                      1: FractionColumnWidth(0.1),
                                      2: FractionColumnWidth(0.2),
                                      3: FractionColumnWidth(0.1),
                                      4: FractionColumnWidth(0.2),
                                      5: FractionColumnWidth(0.1),
                                    },
                                    children: [
                                      TableRow(
                                        children: [
                                          TableCell(
                                            verticalAlignment:
                                                TableCellVerticalAlignment
                                                    .middle,
                                            child: Text(
                                              "ضعيفة",
                                              textAlign: TextAlign.end,
                                            ),
                                          ),
                                          Radio(
                                            groupValue: LetteringLevel,
                                            value: "ضعيفة",
                                            onChanged: (value) {
                                              setState(() {
                                                LetteringLevel = value!;
                                              });
                                            },
                                          ),
                                          TableCell(
                                            verticalAlignment:
                                                TableCellVerticalAlignment
                                                    .middle,
                                            child: Text(
                                              "واضحة نوعاَ ما",
                                              textAlign: TextAlign.end,
                                            ),
                                          ),
                                          Radio(
                                            groupValue: LetteringLevel,
                                            value: "واضحة نوعا ما ",
                                            onChanged: (value) {
                                              setState(() {
                                                LetteringLevel = value!;
                                              });
                                            },
                                          ),
                                          TableCell(
                                            verticalAlignment:
                                                TableCellVerticalAlignment
                                                    .middle,
                                            child: Text(
                                              "واضحة",
                                              textAlign: TextAlign.end,
                                            ),
                                          ),
                                          Radio(
                                            groupValue: LetteringLevel,
                                            value: "واضحة",
                                            onChanged: (value) {
                                              setState(() {
                                                LetteringLevel = value!;
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Text(
                                    ":تصنيف الحركة",
                                  ),
                                ),

                                Align(
                                  alignment: Alignment.topRight,
                                  child: Table(
                                    columnWidths: {
                                      0: FractionColumnWidth(0.2),
                                      1: FractionColumnWidth(0.1),
                                      2: FractionColumnWidth(0.2),
                                      3: FractionColumnWidth(0.1),
                                      4: FractionColumnWidth(0.2),
                                      5: FractionColumnWidth(0.1),
                                    },
                                    children: [
                                      TableRow(
                                        children: [
                                          TableCell(
                                            verticalAlignment:
                                                TableCellVerticalAlignment
                                                    .middle,
                                            child: Text(
                                              "شلل نصفي",
                                              textAlign: TextAlign.end,
                                            ),
                                          ),
                                          Radio(
                                            groupValue: MotionClassification,
                                            value: "شلل نصفي",
                                            onChanged: (value) {
                                              setState(() {
                                                MotionClassification = value!;
                                              });
                                            },
                                          ),
                                          TableCell(
                                            verticalAlignment:
                                                TableCellVerticalAlignment
                                                    .middle,
                                            child: Text(
                                              "صعب التحرك",
                                              textAlign: TextAlign.end,
                                            ),
                                          ),
                                          Radio(
                                            groupValue: MotionClassification,
                                            value: "صعب التحرك",
                                            onChanged: (value) {
                                              setState(() {
                                                MotionClassification = value!;
                                              });
                                            },
                                          ),
                                          TableCell(
                                            verticalAlignment:
                                                TableCellVerticalAlignment
                                                    .middle,
                                            child: Text(
                                              "طبيعي",
                                              textAlign: TextAlign.end,
                                            ),
                                          ),
                                          Radio(
                                            groupValue: MotionClassification,
                                            value: "طبيعي",
                                            onChanged: (value) {
                                              setState(() {
                                                MotionClassification = value!;
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                      TableRow(
                                        children: [
                                          TableCell(
                                            child: Text(
                                              "",
                                            ),
                                          ),
                                          Text(""),
                                          TableCell(
                                            verticalAlignment:
                                                TableCellVerticalAlignment
                                                    .middle,
                                            child: Text(
                                              "شلل دماغي",
                                              textAlign: TextAlign.end,
                                            ),
                                          ),
                                          Radio(
                                            groupValue: MotionClassification,
                                            value: "شلل دماغي",
                                            onChanged: (value) {
                                              setState(() {
                                                MotionClassification = value!;
                                              });
                                            },
                                          ),
                                          TableCell(
                                            verticalAlignment:
                                                TableCellVerticalAlignment
                                                    .middle,
                                            child: Text(
                                              "شلل رباعي",
                                              textAlign: TextAlign.end,
                                            ),
                                          ),
                                          Radio(
                                            groupValue: MotionClassification,
                                            value: "شلل رباعي",
                                            onChanged: (value) {
                                              setState(() {
                                                MotionClassification = value!;
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Text(
                                    ":النمو الجسمي",
                                  ),
                                ),

                                Align(
                                  alignment: Alignment.topRight,
                                  child: Table(
                                    columnWidths: {
                                      0: FractionColumnWidth(0.2),
                                      1: FractionColumnWidth(0.1),
                                      2: FractionColumnWidth(0.2),
                                      3: FractionColumnWidth(0.1),
                                      4: FractionColumnWidth(0.2),
                                      5: FractionColumnWidth(0.1),
                                    },
                                    children: [
                                      TableRow(
                                        children: [
                                          TableCell(
                                            verticalAlignment:
                                                TableCellVerticalAlignment
                                                    .middle,
                                            child: Text(
                                              "غير طبيعي",
                                              textAlign: TextAlign.end,
                                            ),
                                          ),
                                          Radio(
                                            groupValue: physicalGrowth,
                                            value: "غير طبيعي",
                                            onChanged: (value) {
                                              setState(() {
                                                physicalGrowth = value!;
                                              });
                                            },
                                          ),
                                          TableCell(
                                            verticalAlignment:
                                                TableCellVerticalAlignment
                                                    .middle,
                                            child: Text(
                                              "طبيعي",
                                              textAlign: TextAlign.end,
                                            ),
                                          ),
                                          Radio(
                                            groupValue: physicalGrowth,
                                            value: "طبيعي",
                                            onChanged: (value) {
                                              setState(() {
                                                physicalGrowth = value!;
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),

                                Align(
                                  alignment: Alignment.topRight,
                                  child: Text(
                                    ":الأمراض المزمنة",
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Table(
                                    columnWidths: {
                                      0: FractionColumnWidth(0.2),
                                      1: FractionColumnWidth(0.1),
                                      2: FractionColumnWidth(0.2),
                                      3: FractionColumnWidth(0.1),
                                      4: FractionColumnWidth(0.2),
                                      5: FractionColumnWidth(0.1),
                                    },
                                    children: [
                                      TableRow(
                                        children: [
                                          TableCell(
                                            verticalAlignment:
                                                TableCellVerticalAlignment
                                                    .middle,
                                            child: Text(
                                              "القلب",
                                              textAlign: TextAlign.end,
                                            ),
                                          ),
                                          Radio(
                                            groupValue: chronicDiseases,
                                            value: "القلب",
                                            onChanged: (value) {
                                              setState(() {
                                                chronicDiseases = value!;
                                              });
                                            },
                                          ),
                                          TableCell(
                                            verticalAlignment:
                                                TableCellVerticalAlignment
                                                    .middle,
                                            child: Text(
                                              "السكر",
                                              textAlign: TextAlign.end,
                                            ),
                                          ),
                                          Radio(
                                            groupValue: chronicDiseases,
                                            value: "السكر",
                                            onChanged: (value) {
                                              setState(() {
                                                chronicDiseases = value!;
                                              });
                                            },
                                          ),
                                          TableCell(
                                            verticalAlignment:
                                                TableCellVerticalAlignment
                                                    .middle,
                                            child: Text(
                                              "الربو",
                                              textAlign: TextAlign.end,
                                            ),
                                          ),
                                          Radio(
                                            groupValue: chronicDiseases,
                                            value: "الربو",
                                            onChanged: (value) {
                                              setState(() {
                                                chronicDiseases = value!;
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                      TableRow(
                                        children: [
                                          TableCell(
                                            verticalAlignment:
                                                TableCellVerticalAlignment
                                                    .middle,
                                            child: Text(
                                              "الصرع",
                                              textAlign: TextAlign.end,
                                            ),
                                          ),
                                          Radio(
                                            groupValue: chronicDiseases,
                                            value: "الصرع",
                                            onChanged: (value) {
                                              setState(() {
                                                chronicDiseases = value!;
                                              });
                                            },
                                          ),
                                          TableCell(
                                            verticalAlignment:
                                                TableCellVerticalAlignment
                                                    .middle,
                                            child: Text(
                                              "التشنجات",
                                              textAlign: TextAlign.end,
                                            ),
                                          ),
                                          Radio(
                                            groupValue: chronicDiseases,
                                            value: "التشجنات",
                                            onChanged: (value) {
                                              setState(() {
                                                chronicDiseases = value!;
                                              });
                                            },
                                          ),
                                          TableCell(
                                            verticalAlignment:
                                                TableCellVerticalAlignment
                                                    .middle,
                                            child: Text(
                                              "أمراض اخرى",
                                              textAlign: TextAlign.end,
                                            ),
                                          ),
                                          Radio(
                                            groupValue: chronicDiseases,
                                            value: "امراض اخرى",
                                            onChanged: (value) {
                                              setState(() {
                                                chronicDiseases = value!;
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                ElevatedButton(
                                    onPressed: () async {
                                      String docId = documentSnapshot.id;
                                      updateGeneralHealthCondition(docId);
                                      Navigator.pop(context);
                                    },
                                    child: Text('حفظ التغيرات'))
                              ]),
                            ),
                          );
                        });
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              );
            },
          );
        });
  }

  showBottomSheet2(context) {
    return showModalBottomSheet(
        context: context,
        builder: (builder) {
          return StatefulBuilder(builder: (context, setState) {
            return StreamBuilder<QuerySnapshot>(
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
                          return Container(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 20.0),
                              child: Column(children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Text("الفحوصات والعمليات"),
                                ),
                                Align(
                                    alignment: Alignment.topRight,
                                    child: Text(
                                        "هل اجريت له فحوصات واشعة جمجمة ورسم مخ وتحاليل؟   ")),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Table(
                                    columnWidths: {
                                      0: FractionColumnWidth(0.4),
                                      1: FractionColumnWidth(0.1),
                                      2: FractionColumnWidth(0.3),
                                      3: FractionColumnWidth(0.1),
                                    },
                                    children: [
                                      TableRow(
                                        children: [
                                          TableCell(
                                            verticalAlignment:
                                                TableCellVerticalAlignment
                                                    .middle,
                                            child: Text(
                                              "لا    ",
                                              textAlign: TextAlign.end,
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
                                          ),
                                          TableCell(
                                            verticalAlignment:
                                                TableCellVerticalAlignment
                                                    .middle,
                                            child: Text(
                                              "نعم,اذكرها",
                                              textAlign: TextAlign.end,
                                            ),
                                          ),
                                          Radio(
                                            groupValue: checkUp,
                                            value: "نعم",
                                            onChanged: (value) {
                                              setState(() {
                                                checkUp = value!;
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20.0, right: 2),
                                  child: TextField(
                                    controller: CheckupsYesFieldController,
                                    onChanged: (newValue) {
                                      setState(() {
                                        CheckupsYesField = newValue;
                                      });
                                    },
                                    decoration: kStylingInputDec.copyWith(
                                        hintText: 'مثال: علاج سلوكي'),
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Align(
                                    alignment: Alignment.topRight,
                                    child: Text("هل أجريت له عمليات جراحية؟ ")),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Table(
                                    columnWidths: {
                                      0: FractionColumnWidth(0.4),
                                      1: FractionColumnWidth(0.1),
                                      2: FractionColumnWidth(0.3),
                                      3: FractionColumnWidth(0.1),
                                    },
                                    children: [
                                      TableRow(
                                        children: [
                                          TableCell(
                                            verticalAlignment:
                                                TableCellVerticalAlignment
                                                    .middle,
                                            child: Text(
                                              "لا    ",
                                              textAlign: TextAlign.end,
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
                                          ),
                                          TableCell(
                                            verticalAlignment:
                                                TableCellVerticalAlignment
                                                    .middle,
                                            child: Text(
                                              "نعم,اذكرها",
                                              textAlign: TextAlign.end,
                                            ),
                                          ),
                                          Radio(
                                            groupValue: Surgery,
                                            value: "نعم",
                                            onChanged: (value) {
                                              setState(() {
                                                Surgery = value!;
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: TextField(
                                    controller: SurgeryYesFieldController,
                                    onChanged: (newValue) {
                                      SurgeryYesField = newValue;
                                      setState:
                                      (() {});
                                    },
                                    decoration: kStylingInputDec.copyWith(
                                        hintText: 'مثال: علاج سلوكي'),
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Align(
                                    alignment: Alignment.topRight,
                                    child:
                                        Text("هل خضع لاختبار لتحديد الذكاء؟ ")),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Table(
                                    columnWidths: {
                                      0: FractionColumnWidth(0.4),
                                      1: FractionColumnWidth(0.1),
                                      2: FractionColumnWidth(0.3),
                                      3: FractionColumnWidth(0.1),
                                    },
                                    children: [
                                      TableRow(
                                        children: [
                                          TableCell(
                                            verticalAlignment:
                                                TableCellVerticalAlignment
                                                    .middle,
                                            child: Text(
                                              "لا    ",
                                              textAlign: TextAlign.end,
                                            ),
                                          ),
                                          Radio(
                                            groupValue: DefiningIntelligence,
                                            value: "لا",
                                            onChanged: (value) {
                                              setState(() {
                                                DefiningIntelligence = value!;
                                              });
                                            },
                                          ),
                                          TableCell(
                                            verticalAlignment:
                                                TableCellVerticalAlignment
                                                    .middle,
                                            child: Text(
                                              "نعم,اذكرها",
                                              textAlign: TextAlign.end,
                                            ),
                                          ),
                                          Radio(
                                            groupValue: DefiningIntelligence,
                                            value: "نعم، أذكر النسبة",
                                            onChanged: (value) {
                                              setState(() {
                                                DefiningIntelligence = value!;
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: TextField(
                                    controller:
                                        IntelligencetestYesFieldController,
                                    onChanged: (newValue) {
                                      IntelligencetestYesField = newValue;
                                      setState:
                                      (() {});
                                    },
                                    decoration: kStylingInputDec.copyWith(
                                        hintText: 'مثال: علاج سلوكي'),
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Align(
                                    alignment: Alignment.topRight,
                                    child: Text("هل يوجد لدى الطفل حساسية؟")),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Table(
                                    columnWidths: {
                                      0: FractionColumnWidth(0.4),
                                      1: FractionColumnWidth(0.1),
                                      2: FractionColumnWidth(0.3),
                                      3: FractionColumnWidth(0.1),
                                    },
                                    children: [
                                      TableRow(
                                        children: [
                                          TableCell(
                                            verticalAlignment:
                                                TableCellVerticalAlignment
                                                    .middle,
                                            child: Text(
                                              "لا    ",
                                              textAlign: TextAlign.end,
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
                                          ),
                                          TableCell(
                                            verticalAlignment:
                                                TableCellVerticalAlignment
                                                    .middle,
                                            child: Text(
                                              "نعم,اذكرها",
                                              textAlign: TextAlign.end,
                                            ),
                                          ),
                                          Radio(
                                            groupValue: sensitive,
                                            value: "نعم",
                                            onChanged: (value) {
                                              setState(() {
                                                sensitive = value!;
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20.0),
                                  child: TextField(
                                    controller: allergyYesFieldController,
                                    onChanged: (newValue) {
                                      allergyYesField = newValue;
                                      setState:
                                      (() {});
                                    },
                                    decoration: kStylingInputDec.copyWith(
                                        hintText: 'مثال: علاج سلوكي'),
                                  ),
                                ),
                                Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: ElevatedButton(
                                        onPressed: () async {
                                          String docId = documentSnapshot.id;
                                          updateGeneralHealthCondition(docId);
                                          Navigator.pop(context);
                                        },
                                        child: Text('حفظ التغيرات')))
                              ]),
                            ),
                          );
                        });
                  }
                  ;
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                });
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

// class ProfileContainer extends StatelessWidget {
//   late String ChildName;
//   late String Berthday;
//   late String EducationLevel;
//   ProfileContainer(
//       {required this.ChildName,
//       required this.Berthday,
//       required this.EducationLevel});

//   @override
//   Widget build(BuildContext context) {
//     var textStyle = TextStyle(
//       color: Color(0xff394445),
//       fontSize: 16,
//       fontFamily: "Cairo",
//       fontWeight: FontWeight.w700,
//     );
//     var textStyle2 = TextStyle(
//       color: Color(0xff797979),
//       fontSize: 12,
//     );
//     return Stack(
//       alignment: AlignmentDirectional.center,
//       children: [
//         Positioned(
//           bottom: 0,
//           left: 2,
//           child: Container(
//               width: 20,
//               height: 30,
//               child: IconButton(
//                 onPressed: () {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => childEvaluationPage(),
//                       ));
//                 },
//                 icon: Icon(Icons.arrow_back),
//               )),
//         ),
//         Positioned(
//           child: Container(
//               width: MediaQuery.of(context).size.width,
//               height: 256,
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   begin: Alignment.topRight,
//                   end: Alignment.bottomLeft,
//                   colors: [
//                     Color(0xffddd6f3),
//                     Color(0xfffaaca8),
//                     Color(0xffda124e)
//                   ],
//                 ),
//                 color: Color(0xff6888a0),
//                 borderRadius: BorderRadius.only(
//                     bottomLeft: Radius.circular(50),
//                     bottomRight: Radius.circular(50)),
//               )),
//         ),
//         Positioned(
//           bottom: 20,
//           child: Container(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 SizedBox(
//                   height: 70,
//                 ),
//                 Text(
//                   ChildName,
//                   style: TextStyle(
//                     color: Color(0xff394445),
//                     fontSize: 15,
//                     fontFamily: "Cairo",
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),
//                 Text(
//                   "$Berthday\n $EducationLevel",
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     color: Color(0xff797979),
//                     fontSize: 10,
//                   ),
//                 )
//               ],
//             ),
//             width: 287,
//             height: 159,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(50),
//               boxShadow: [
//                 BoxShadow(
//                   color: Color(0x16000000),
//                   blurRadius: 4,
//                   offset: Offset(4, 4),
//                 ),
//               ],
//               color: Colors.white,
//             ),
//           ),
//         ),
//         Positioned(
//           top: 30,
//           child: Container(
//             width: 130.53,
//             height: 130.53,
//             child: CircleAvatar(
//               radius: 60,
//               backgroundColor: Color(0xffEFF5F2),
//               foregroundColor: Color(0xffEFF5F2),
//               // backgroundImage: AssetImage(""),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

class ProfileContainer extends StatelessWidget {
  late String ChildName;
  late String Berthday;
  late String EducationLevel;
  ProfileContainer(
      {required this.ChildName,
      required this.Berthday,
      required this.EducationLevel});

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
          alignment: AlignmentDirectional.center,
          children: [
            Positioned(
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 256,
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
            ),
            Positioned(
              bottom: 20,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 70,
                    ),
                    Text(
                      ChildName,
                      style: TextStyle(
                        color: Color(0xff394445),
                        fontSize: 15,
                        fontFamily: "Cairo",
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      "$Berthday\n $EducationLevel",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xff797979),
                        fontSize: 10,
                      ),
                    )
                  ],
                ),
                width: 287,
                height: 159,
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
                ),
              ),
            ),
            Positioned(
              right: 16,
              top: 16,
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
                          .catchError((error) =>
                              print("Failed to mark document as read: $error"));
                    });
                  }).catchError((error) =>
                          print("Failed to retrieve documents: $error"));

                  // Navigate to the screen where the user can view the document
                },
              ),
            ),
            Positioned(
              right: 18,
              top: 20,
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
            Positioned(
              top: 30,
              child: Container(
                width: 130.53,
                height: 130.53,
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: Color(0xffEFF5F2),
                  foregroundColor: Color(0xffEFF5F2),
                  backgroundImage: AssetImage("images/CuteGirl.png"),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
