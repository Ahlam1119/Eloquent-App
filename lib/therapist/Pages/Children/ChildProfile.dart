import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eloquentapp/screens/constants.dart';
import 'package:eloquentapp/therapist/Pages/Children/Phases/BuildingConcepts.dart';
import 'package:eloquentapp/therapist/Pages/Children/Phases/Sound/sounds.dart';
import 'package:eloquentapp/therapist/Pages/Children/Phases/evnetsOrder.dart';
import 'package:eloquentapp/therapist/Pages/Children/Phases/pre_language%20.dart';
import 'package:eloquentapp/therapist/Pages/Children/TherapistReport.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChildFile extends StatefulWidget {
  late String ChildID;

  ChildFile({required this.ChildID});
  @override
  State<ChildFile> createState() => _ChildFileState();
}

class _ChildFileState extends State<ChildFile> {
  final _auth = FirebaseAuth.instance;
  late String ChildID = widget.ChildID;

  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseFirestore firestorex = FirebaseFirestore.instance;

  Map<String, dynamic> ChildInfo = {};
  bool isLoded = true;
  getUserData() async {
    await FirebaseFirestore.instance
        .collection('Child')
        .where("uid", isEqualTo: ChildID)
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

  late String uidParent = ChildInfo['uidParent'];

  late String name = ChildInfo['name'];
  late String ParentName = ChildInfo['ParentName'];
  late var BirthDate = ChildInfo['BirthDate'];
  late String ChildEducationalLevel = ChildInfo['ChildEducationalLevel'];
  late String Movement = ChildInfo['Movement'];
  late String personalBehaviour = ChildInfo['personalBehaviour'];
  late String emotionalBehaviour = ChildInfo['emotionalBehaviour'];
  late String understanding = ChildInfo['understanding'];
  late String dispersion = ChildInfo['dispersion'];
  late String visualCommunication = ChildInfo['visualCommunication'];
  late String Agressive = ChildInfo['Agressive'];
  late String fear = ChildInfo['fear'];
  late String cooperating = ChildInfo['cooperating'];
  late String visualCondition = ChildInfo['visualCondition'];
  late String auditoryCondition = ChildInfo['auditoryCondition'];
  late String expressionLevel = ChildInfo['expressionLevel'];
  late String LetteringLevel = ChildInfo['LetteringLevel'];
  late String MotionClassification = ChildInfo['MotionClassification'];
  late String physicalGrowth = ChildInfo['physicalGrowth'];
  late String chronicDiseases = ChildInfo['chronicDiseases'];
  late String previousTreatment = ChildInfo['previousTreatment'];
  late String checkUp = ChildInfo['checkUp'];
  late String Surgery = ChildInfo['Surgery'];
  late String DefiningIntelligence = ChildInfo['DefiningIntelligence'];
  late String sensitive = ChildInfo['sensitive'];

  late String childName = ChildInfo['name'];

  final CollectionReference usersRef = _db.collection('Child');
  late Query query = usersRef.where('uid', isEqualTo: ChildID);
  late Stream<QuerySnapshot> usersStream = query.snapshots();

  late String chronicdiseasesOtherField =
      ChildInfo['chronicdiseasesOtherField'];

  late String previoustreatmentYesField =
      ChildInfo['previoustreatmentYesField'];

  late bool isChecked = true;
  final CheckupsYesFieldController = TextEditingController();
  final SurgeryYesFieldController = TextEditingController();
  final IntelligencetestYesFieldController = TextEditingController();
  final allergyYesFieldController = TextEditingController();
  late String CheckupsYesField = ChildInfo['CheckupsYesField'];

  late String SurgeryYesField = ChildInfo['SurgeryYesField'];

  late String IntelligencetestYesField = ChildInfo['IntelligencetestYesField'];
  late String allergyYesField = ChildInfo['allergyYesField'];
  @override
  void initState() {
    super.initState();

    getUserData();
  }

  String formatDate(Timestamp timestamp) {
    var format = DateTime.fromMillisecondsSinceEpoch(timestamp.seconds * 1000);
    return DateFormat('dd-MM-yyyy').format(format);
  }

  var textStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    fontFamily: 'Cairo',
    color: Color(0xff6888a0),
  );

  var textStyle2 =
      TextStyle(fontSize: 14, fontWeight: FontWeight.w600, fontFamily: 'Cairo');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: isLoded == true
            ? Center(child: CircularProgressIndicator())
            : SafeArea(
                child: SafeArea(
                  child: Column(
                    children: [
                      ProfileContainer(
                          ChildAvatar: ChildInfo['ChildAvatar'],
                          ChildName: childName,
                          Berthday: formatDate(ChildInfo['BirthDate']),
                          EducationLevel: ChildEducationalLevel),
                      SizedBox(
                        height: 15,
                      ),
                      Expanded(
                        child: DefaultTabController(
                          length: 2,
                          child: Column(children: [
                            Container(
                              height: 45,
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
                                      style: TextStyle(fontFamily: 'Cairo'),
                                    ),
                                  ),
                                  Tab(
                                    child: Text(
                                      "تقرير الجلسات",
                                      style: TextStyle(fontFamily: 'Cairo'),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
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
                                          'تتبع تقدم الطفل',
                                          style: TextStyle(fontFamily: 'Cairo'),
                                        ),
                                        tab2: Text(
                                          'معلومات عامة',
                                          style: TextStyle(fontFamily: 'Cairo'),
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
                                                //--------------------------------الاصوات
                                                GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              Sounds(
                                                            childId: ChildID,
                                                          ),
                                                        ));
                                                  },
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
                                                      color: Color(0xffEEF3F3),
                                                      child: Container(
                                                        width: 140,
                                                        height: 190,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      18.31),
                                                        ),
                                                        child: Center(
                                                          child: ListTile(
                                                            title: Text(
                                                              "مرحلة",
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                color: Color(
                                                                    0xff687c71),
                                                                fontSize: 30,
                                                                fontFamily:
                                                                    "Cairo",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                            ),
                                                            subtitle: Text(
                                                              " الأصوات",
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                color: Color(
                                                                    0xff6888a0),
                                                                fontSize: 14,
                                                                fontFamily:
                                                                    "Cairo",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      )),
                                                ),
                                                //----------------------ماقبل اللغة
                                                SizedBox(width: 15),
                                                GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              Pre_lsnguage(
                                                            childId: ChildID,
                                                          ),
                                                        ));
                                                  },
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
                                                      color: Color(0xfffcf2ef),
                                                      child: Container(
                                                        width: 140,
                                                        height: 190,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      18.31),
                                                        ),
                                                        child: Center(
                                                          child: ListTile(
                                                            title: Text(
                                                              "مرحلة",
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                color: Color(
                                                                    0xff687c71),
                                                                fontSize: 30,
                                                                fontFamily:
                                                                    "Cairo",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                            ),
                                                            subtitle: Text(
                                                              'ماقبل اللغة',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                color: Color(
                                                                    0xffab9a95),
                                                                fontSize: 16,
                                                                fontFamily:
                                                                    "Cairo",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      )),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            Row(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                //--------------------------------الاصوات
                                                GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              evnetsOrder(
                                                            childId: ChildID,
                                                          ),
                                                        ));
                                                  },
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
                                                      color: Color(0xfff4f4fa),
                                                      child: Container(
                                                        width: 140,
                                                        height: 190,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      18.31),
                                                        ),
                                                        child: Center(
                                                          child: ListTile(
                                                            title: Text(
                                                              "مرحلة",
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                color: Color(
                                                                    0xff687c71),
                                                                fontSize: 30,
                                                                fontFamily:
                                                                    "Cairo",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                            ),
                                                            subtitle: Text(
                                                              ' ترتيب الأحداث',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                color: Color(
                                                                    0xff7c7cab),
                                                                fontSize: 13,
                                                                fontFamily:
                                                                    "Cairo",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      )),
                                                ),
                                                //----------------------ماقبل اللغة
                                                SizedBox(width: 15),
                                                GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                BuildingConcepts(
                                                                    childId:
                                                                        ChildID)));
                                                  },
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
                                                      color: Color(0xfffaeedb),
                                                      child: Container(
                                                        width: 140,
                                                        height: 190,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      18.31),
                                                        ),
                                                        child: Center(
                                                          child: ListTile(
                                                            title: Text(
                                                              "مرحلة",
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                color: Color(
                                                                    0xff687c71),
                                                                fontSize: 30,
                                                                fontFamily:
                                                                    "Cairo",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                            ),
                                                            subtitle: Text(
                                                              " بناء المفاهيم",
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                color: Color(
                                                                    0xff9a8769),
                                                                fontSize: 13,
                                                                fontFamily:
                                                                    "Cairo",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      )),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10,
                                            )
                                          ],
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
                                                      color: Color.fromARGB(
                                                          255, 251, 250, 250),
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
                                                                fontFamily:
                                                                    'Cairo'),
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
                                                      showBottomSheetGenralHelth(
                                                          context);
                                                    },
                                                    child: Card(
                                                      elevation: 4,
                                                      color: Color.fromARGB(
                                                          255, 251, 250, 250),
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
                                                            'الحالة الصحية العامة',
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'Cairo'),
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
                                                      color: Color.fromARGB(
                                                          255, 251, 250, 250),
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
                                                            'الفحوصات والعمليات   ',
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'Cairo'),
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
                                      ),
                                    ),
                                  ),
                                  TherapistReport(
                                    ChildID: ChildID,
                                  )
                                ],
                              ),
                            )
                          ]),
                        ),
                      ),
                    ],
                  ),
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
                height: MediaQuery.of(context).size.height * 0.54,
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
                            var textStyle = TextStyle(
                                color: Color(0xff6888a0),
                                fontSize: 16,
                                fontWeight: FontWeight.w600);
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
                                          Text(
                                            "الصفات الشخصية والسلوكية",
                                            style: TextStyle(
                                                fontSize: 19,
                                                fontFamily: "Cairo",
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                      Row(children: [
                                        Flexible(
                                          child: Checkbox(
                                            activeColor: Color(0xff394445),
                                            value: isChecked,
                                            onChanged: (newVlaue) {},
                                          ),
                                        ),
                                        TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: Text(
                                            emotionalBehaviour,
                                            textAlign: TextAlign.end,
                                          ),
                                        ),
                                        Flexible(
                                          child: Checkbox(
                                            activeColor: Color(0xff394445),
                                            value: isChecked,
                                            onChanged: (newVlaue) {},
                                          ),
                                        ),
                                        TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: Text(
                                            personalBehaviour,
                                            textAlign: TextAlign.end,
                                          ),
                                        ),
                                        Flexible(
                                          child: Checkbox(
                                            activeColor: Color(0xff394445),
                                            value: isChecked,
                                            onChanged: (newVlaue) {},
                                          ),
                                        ),
                                        TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: Text(
                                            Movement,
                                            textAlign: TextAlign.end,
                                          ),
                                        ),
                                      ]),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: Row(children: [
                                          TableCell(
                                            verticalAlignment:
                                                TableCellVerticalAlignment
                                                    .middle,
                                            child: Text(
                                              "الإنتباه:",
                                              textAlign: TextAlign.right,
                                              style: textStyle,
                                            ),
                                          ),
                                          Flexible(
                                            child: Checkbox(
                                              activeColor: Color(0xff394445),
                                              value: isChecked,
                                              onChanged: (newVlaue) {},
                                            ),
                                          ),
                                          TableCell(
                                            verticalAlignment:
                                                TableCellVerticalAlignment
                                                    .middle,
                                            child: Text(
                                              dispersion,
                                              textAlign: TextAlign.end,
                                            ),
                                          ),
                                        ]),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: Row(children: [
                                          TableCell(
                                            verticalAlignment:
                                                TableCellVerticalAlignment
                                                    .middle,
                                            child: Text(
                                              "الفهم والاستيعاب:",
                                              textAlign: TextAlign.right,
                                              style: textStyle,
                                            ),
                                          ),
                                          Flexible(
                                            child: Checkbox(
                                              activeColor: Color(0xff394445),
                                              value: isChecked,
                                              onChanged: (newVlaue) {},
                                            ),
                                          ),
                                          TableCell(
                                            verticalAlignment:
                                                TableCellVerticalAlignment
                                                    .middle,
                                            child: Text(
                                              understanding,
                                              textAlign: TextAlign.end,
                                            ),
                                          ),
                                        ]),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: Row(children: [
                                          TableCell(
                                            verticalAlignment:
                                                TableCellVerticalAlignment
                                                    .middle,
                                            child: Text(
                                              "التواصل البصري:",
                                              textAlign: TextAlign.right,
                                              style: textStyle,
                                            ),
                                          ),
                                          Flexible(
                                            child: Checkbox(
                                              activeColor: Color(0xff394445),
                                              value: isChecked,
                                              onChanged: (newVlaue) {},
                                            ),
                                          ),
                                          TableCell(
                                            verticalAlignment:
                                                TableCellVerticalAlignment
                                                    .middle,
                                            child: Text(
                                              visualCommunication,
                                              textAlign: TextAlign.end,
                                            ),
                                          ),
                                        ]),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: Row(children: [
                                          TableCell(
                                            verticalAlignment:
                                                TableCellVerticalAlignment
                                                    .middle,
                                            child: Text(
                                              "السلوك العدواني:",
                                              textAlign: TextAlign.right,
                                              style: textStyle,
                                            ),
                                          ),
                                          Flexible(
                                            child: Checkbox(
                                              activeColor: Color(0xff394445),
                                              value: isChecked,
                                              onChanged: (newVlaue) {},
                                            ),
                                          ),
                                          TableCell(
                                            verticalAlignment:
                                                TableCellVerticalAlignment
                                                    .middle,
                                            child: Text(
                                              Agressive,
                                              textAlign: TextAlign.end,
                                            ),
                                          ),
                                        ]),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: Table(
                                          columnWidths: {
                                            0: FractionColumnWidth(0.4),
                                            1: FractionColumnWidth(0.1),
                                            2: FractionColumnWidth(0.08),
                                          },
                                          children: [
                                            TableRow(children: [
                                              TableCell(
                                                verticalAlignment:
                                                    TableCellVerticalAlignment
                                                        .middle,
                                                child: Text(
                                                  "ظهور الخوف والقلق:",
                                                  textAlign: TextAlign.right,
                                                  style: textStyle,
                                                ),
                                              ),
                                              Checkbox(
                                                activeColor: Color(0xff394445),
                                                value: isChecked,
                                                onChanged: (newVlaue) {},
                                              ),
                                              TableCell(
                                                verticalAlignment:
                                                    TableCellVerticalAlignment
                                                        .middle,
                                                child: Text(
                                                  fear,
                                                  textAlign: TextAlign.end,
                                                ),
                                              ),
                                            ])
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: Table(
                                          columnWidths: {
                                            0: FractionColumnWidth(0.4),
                                            1: FractionColumnWidth(0.1),
                                            2: FractionColumnWidth(0.08),
                                          },
                                          children: [
                                            TableRow(children: [
                                              TableCell(
                                                verticalAlignment:
                                                    TableCellVerticalAlignment
                                                        .middle,
                                                child: Text(
                                                  "التعاون مع الآخرين:",
                                                  textAlign: TextAlign.right,
                                                  style: textStyle,
                                                ),
                                              ),
                                              Flexible(
                                                child: Checkbox(
                                                  activeColor:
                                                      Color(0xff394445),
                                                  value: isChecked,
                                                  onChanged: (newVlaue) {},
                                                ),
                                              ),
                                              TableCell(
                                                verticalAlignment:
                                                    TableCellVerticalAlignment
                                                        .middle,
                                                child: Text(
                                                  cooperating,
                                                  textAlign: TextAlign.end,
                                                ),
                                              ),
                                            ])
                                          ],
                                        ),
                                      ),
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

//--------------------الحالة الصحية العامة -------------------------------------//

  showBottomSheetGenralHelth(context) {
    return showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(35.0),
            topRight: Radius.circular(35.0),
          ),
        ),
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
                          var textStyle = TextStyle(
                              color: Color(0xff6888a0),
                              fontSize: 15,
                              fontWeight: FontWeight.w700);
                          return Container(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 25, left: 30, right: 25),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset("images/GenralHelth.png"),
                                        SizedBox(
                                          width: 9,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 4.0),
                                          child: Text(
                                            'الحالة الصحية العامة',
                                            style: TextStyle(
                                                fontSize: 19,
                                                fontFamily: "Cairo",
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Row(children: [
                                        TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: Text(
                                            "الحالة البصرية:",
                                            textAlign: TextAlign.right,
                                            style: textStyle,
                                          ),
                                        ),
                                        Flexible(
                                          child: Checkbox(
                                            activeColor: Color(0xff394445),
                                            value: isChecked,
                                            onChanged: (newVlaue) {},
                                          ),
                                        ),
                                        TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: Text(
                                            visualCondition,
                                            textAlign: TextAlign.end,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ]),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Row(children: [
                                        TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: Text(
                                            "الحالة السمعية:",
                                            textAlign: TextAlign.right,
                                            style: textStyle,
                                          ),
                                        ),
                                        Flexible(
                                          child: Checkbox(
                                            activeColor: Color(0xff394445),
                                            value: isChecked,
                                            onChanged: (newVlaue) {},
                                          ),
                                        ),
                                        TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: Text(
                                            auditoryCondition,
                                            textAlign: TextAlign.end,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ]),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Row(children: [
                                        TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: Text(
                                            "القدرة التعبرية:",
                                            textAlign: TextAlign.right,
                                            style: textStyle,
                                          ),
                                        ),
                                        Flexible(
                                          child: Checkbox(
                                            activeColor: Color(0xff394445),
                                            value: isChecked,
                                            onChanged: (newVlaue) {},
                                          ),
                                        ),
                                        TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: Text(
                                            expressionLevel,
                                            textAlign: TextAlign.end,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ]),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Row(children: [
                                        TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: Text(
                                            "وضوح المخارج:",
                                            textAlign: TextAlign.right,
                                            style: textStyle,
                                          ),
                                        ),
                                        Flexible(
                                          child: Checkbox(
                                            activeColor: Color(0xff394445),
                                            value: isChecked,
                                            onChanged: (newVlaue) {},
                                          ),
                                        ),
                                        TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: Text(
                                            LetteringLevel,
                                            textAlign: TextAlign.end,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ]),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Row(children: [
                                        TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: Text(
                                            "تصنيف الحركة:",
                                            textAlign: TextAlign.right,
                                            style: textStyle,
                                          ),
                                        ),
                                        Flexible(
                                          child: Checkbox(
                                            activeColor: Color(0xff394445),
                                            value: isChecked,
                                            onChanged: (newVlaue) {},
                                          ),
                                        ),
                                        TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: Text(
                                            MotionClassification,
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ]),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 13),
                                      child: Row(children: [
                                        TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: Text(
                                            "النمو الجسم:",
                                            textAlign: TextAlign.right,
                                            style: textStyle,
                                          ),
                                        ),
                                        Flexible(
                                          child: Checkbox(
                                            activeColor: Color(0xff394445),
                                            value: isChecked,
                                            onChanged: (newVlaue) {},
                                          ),
                                        ),
                                        TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: Text(
                                            physicalGrowth,
                                            textAlign: TextAlign.end,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ]),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Row(children: [
                                        TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: Text(
                                            "الأمراض المزمنة:",
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                                color: Color(0xff6888a0),
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                        Flexible(
                                          child: Checkbox(
                                            activeColor: Color(0xff394445),
                                            value: isChecked,
                                            onChanged: (newVlaue) {},
                                          ),
                                        ),
                                        TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: Text(
                                            chronicDiseases,
                                            textAlign: TextAlign.end,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ]),
                                    ),
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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(35.0),
            topRight: Radius.circular(35.0),
          ),
        ),
        context: context,
        builder: (builder) {
          return StatefulBuilder(
            builder: (context, setState) {
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

                            var textStyleYesy = TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Cairo',
                              color: Color(0xff6888a0),
                            );

                            var textStyleNo = TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Cairo',
                              color: Color(0xff6888a0),
                            );

                            return Container(
                                child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 25, right: 25, bottom: 20),
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
                                              Text(
                                                "الفحوصات والعمليات",
                                                style: TextStyle(
                                                    fontSize: 19,
                                                    fontFamily: "Cairo",
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ],
                                          ),
                                          checkUp == 'لا'
                                              ? SizedBox(
                                                  height: 15,
                                                )
                                              : SizedBox(
                                                  height: 1,
                                                ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Row(
                                            children: [
                                              TableCell(
                                                verticalAlignment:
                                                    TableCellVerticalAlignment
                                                        .middle,
                                                child: Text(
                                                    "الفحوصات واشعة جمجمة ورسم مخ وتحاليل:  ",
                                                    textAlign: TextAlign.right,
                                                    style: checkUp == 'لا'
                                                        ? textStyleNo
                                                        : textStyleYesy),
                                              ),
                                              checkUp == 'نعم'
                                                  ? SizedBox(
                                                      width: 1,
                                                    )
                                                  : SizedBox(
                                                      width: 12,
                                                    ),
                                              Visibility(
                                                visible: checkUp == 'نعم',
                                                child: Checkbox(
                                                  activeColor:
                                                      Color(0xff394445),
                                                  value: isChecked,
                                                  onChanged: (newVlaue) {},
                                                ),
                                              ),
                                              TableCell(
                                                verticalAlignment:
                                                    TableCellVerticalAlignment
                                                        .middle,
                                                child: Text(
                                                  checkUp,
                                                  textAlign: TextAlign.end,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 14,
                                                      fontFamily: 'Cairo'),
                                                ),
                                              ),
                                            ],
                                          ),
                                          checkUp == 'لا'
                                              ? SizedBox(
                                                  height: 15,
                                                )
                                              : SizedBox(
                                                  height: 1,
                                                ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 20.0, right: 2),
                                            child: Visibility(
                                              visible: checkUp == 'نعم',
                                              child: TextField(
                                                controller:
                                                    CheckupsYesFieldController,
                                                onChanged: (newValue) {
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
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10),
                                            child: Row(children: [
                                              TableCell(
                                                verticalAlignment:
                                                    TableCellVerticalAlignment
                                                        .middle,
                                                child: Text(
                                                    "العمليات الجراحية :",
                                                    textAlign: TextAlign.right,
                                                    style: Surgery == 'لا'
                                                        ? textStyleNo
                                                        : textStyleYesy),
                                              ),
                                              Surgery == 'نعم'
                                                  ? SizedBox(
                                                      width: 135,
                                                    )
                                                  : SizedBox(
                                                      width: 148,
                                                    ),
                                              Visibility(
                                                visible: Surgery == 'نعم',
                                                child: Checkbox(
                                                  activeColor:
                                                      Color(0xff394445),
                                                  value: isChecked,
                                                  onChanged: (newVlaue) {},
                                                ),
                                              ),
                                              TableCell(
                                                verticalAlignment:
                                                    TableCellVerticalAlignment
                                                        .middle,
                                                child: Text(
                                                  Surgery,
                                                  textAlign: TextAlign.end,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 14,
                                                      fontFamily: 'Cairo'),
                                                ),
                                              ),
                                            ]),
                                          ),
                                          Surgery == 'لا'
                                              ? SizedBox(
                                                  height: 15,
                                                )
                                              : SizedBox(
                                                  height: 1,
                                                ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 20, top: 10),
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
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10, top: 10),
                                            child: Row(children: [
                                              TableCell(
                                                verticalAlignment:
                                                    TableCellVerticalAlignment
                                                        .middle,
                                                child: Text(
                                                    "اختبار تحديد الذكاء :",
                                                    textAlign: TextAlign.right,
                                                    style:
                                                        DefiningIntelligence ==
                                                                'لا'
                                                            ? textStyleNo
                                                            : textStyleYesy),
                                              ),
                                              DefiningIntelligence == 'نعم'
                                                  ? SizedBox(
                                                      width: 129,
                                                    )
                                                  : SizedBox(
                                                      width: 146,
                                                    ),
                                              Visibility(
                                                visible: DefiningIntelligence ==
                                                    "نعم",
                                                child: Checkbox(
                                                  activeColor:
                                                      Color(0xff394445),
                                                  value: isChecked,
                                                  onChanged: (newVlaue) {},
                                                ),
                                              ),
                                              TableCell(
                                                verticalAlignment:
                                                    TableCellVerticalAlignment
                                                        .middle,
                                                child: Text(
                                                  DefiningIntelligence,
                                                  textAlign: TextAlign.end,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 14,
                                                      fontFamily: 'Cairo'),
                                                ),
                                              ),
                                            ]),
                                          ),
                                          DefiningIntelligence == 'لا'
                                              ? SizedBox(
                                                  height: 15,
                                                )
                                              : SizedBox(
                                                  height: 1,
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
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10),
                                            child: Row(children: [
                                              TableCell(
                                                verticalAlignment:
                                                    TableCellVerticalAlignment
                                                        .middle,
                                                child: Text(
                                                  "هل يوجد لدى الطفل حساسية؟ ",
                                                  textAlign: TextAlign.right,
                                                  style: sensitive == 'لا'
                                                      ? textStyleNo
                                                      : textStyleYesy,
                                                ),
                                              ),
                                              sensitive == 'نعم'
                                                  ? SizedBox(
                                                      width: 60,
                                                    )
                                                  : SizedBox(
                                                      width: 79,
                                                    ),
                                              Visibility(
                                                visible: sensitive == 'نعم',
                                                child: Checkbox(
                                                  activeColor:
                                                      Color(0xff394445),
                                                  value: isChecked,
                                                  onChanged: (newVlaue) {},
                                                ),
                                              ),
                                              TableCell(
                                                verticalAlignment:
                                                    TableCellVerticalAlignment
                                                        .middle,
                                                child: Text(
                                                  sensitive,
                                                  textAlign: TextAlign.end,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 14,
                                                      fontFamily: 'Cairo'),
                                                ),
                                              ),
                                            ]),
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
                                        ])));
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
                widget1,
                widget2,
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
    return Stack(
      children: [
        Container(
          width: 423,
          height: 200,
          padding: EdgeInsets.only(top: 60, left: 30, right: 30, bottom: 30),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color(0xffddd6f3),
                Color(0xfffaaca8),
                Color.fromARGB(255, 227, 136, 164)
              ],
            ),
            color: Color(0xff6888a0),
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50)),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.only(top: 100),
            child: Container(
              child: Center(
                  child: Column(
                children: [
                  SizedBox(
                    height: 85,
                  ),
                  Text(
                    "$ChildName",
                    style: textStyle,
                  ),
                  Text(
                    "$Berthday",
                    style: textStyle2,
                  ),
                  Text(
                    "$EducationLevel",
                    style: textStyle2,
                  ),
                ],
              )),
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
        ),
        Padding(
          padding: const EdgeInsets.all(55.0),
          child: Center(
            child: CircleAvatar(
              radius: 60,
              backgroundColor: Color(0xffEFF5F2),
              foregroundColor: Color(0xffEFF5F2),
              backgroundImage: AssetImage(ChildAvatar),
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
    );
  }
}
