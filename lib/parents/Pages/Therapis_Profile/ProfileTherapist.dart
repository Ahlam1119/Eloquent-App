import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eloquentapp/parents/Pages/Therapis_Profile/Comment.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'book_with_therapist_page.dart';

class Profilet extends StatefulWidget {
  static String id = 'avilableTime';

  late String therapisid;
  Profilet({required this.therapisid});

  @override
  State<Profilet> createState() => _ProfiletState();
}

class _ProfiletState extends State<Profilet> {
  late var therapistID = widget.therapisid;
  DateTime date = DateTime.now();

  late bool _arabicLanguage;
  late bool _englishLanguage;
  late String _arabic;
  late String _english;
  late bool onlineconsultation;
  late bool inCenterconsultation;
  late String online;
  late String inCenter;

  TimeOfDay timeOfDay = TimeOfDay.now();
  DateTime today = DateTime.now();
  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
  }

  late String _uid;
  //instance for auth
  final _auth = FirebaseAuth.instance;
  //instance for cloud firestore
  final _firestore = FirebaseFirestore.instance;
  late User singedInUser;
  void initState() {
    super.initState();
    getCurrentUser();
    getUserData();

    getParentData();
  }

  late String Note;
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

  Map<String, dynamic> TherapistInfo = {};
  bool isLoded = true;
  getUserData() async {
    await FirebaseFirestore.instance
        .collection('Therapist')
        .where("uid", isEqualTo: therapistID)
        .get()
        .then((v) {
      for (var element in v.docs) {
        TherapistInfo.addAll(element.data());
        print(TherapistInfo);
        getBoolData();
        setState(() {
          isLoded = false;
        });
      }
    });
  }

  late String TherapistName = TherapistInfo['name'];
  late String Level = TherapistInfo['JobTitle'];

  //-----------------------------------------------

  Map<String, dynamic> ParentData = {};

  //get all user data and store to Map
  getParentData() async {
    await FirebaseFirestore.instance
        .collection('Parent')
        .where("uid", isEqualTo: singedInUser.uid)
        .get()
        .then((v) {
      for (var element in v.docs) {
        ParentData.addAll(element.data());
        print(ParentData['name']);
      }
    });
  }

  late String ParentName = ParentData['name'];

  //------------------------------------------------

  Map<String, dynamic> RequstInfoData = {};
  getRequstInfo(RequestId) async {
    await FirebaseFirestore.instance
        .collection('Request')
        .where("RequestId", isEqualTo: RequestId)
        .get()
        .then((v) {
      for (var element in v.docs) {
        RequstInfoData.addAll(element.data());
        print(RequstInfoData['ParentName']);
      }
    });
  }

  Future RequstInfo(String name, String Statu, String TherapistName,
      String RequestId, String TherapistID, String Note, DateTime today) async {
    await FirebaseFirestore.instance.collection("Request").add({
      'ParentName': name,
      'Statu': Statu,
      'TherapistName': TherapistName,
      'RequestId': RequestId,
      'TherapistID': TherapistID,
      'ParentNote': Note,
      'DateTime': today,
    });
  }

  String formatDate(Timestamp timestamp) {
    var format = DateTime.fromMillisecondsSinceEpoch(timestamp.seconds * 1000);
    return DateFormat('dd-MM-yyyy').format(format);
  }

  late Timestamp reDate = RequstInfoData['DateTime'];
  //----------------------------------------------------------------

  getBoolData() {
    _arabicLanguage = TherapistInfo['arabicLanguage'];
    _englishLanguage = TherapistInfo['englishLanguage'];
    onlineconsultation = TherapistInfo['online'];
    inCenterconsultation = TherapistInfo['incenter'];

    if (_arabicLanguage == true) {
      _arabic = "العربية";
    } else {
      _arabic = "";
    }

    if (_englishLanguage = true) {
      _english = "الأنجيليزية";
    } else {
      _english = "";
    }
    if (inCenterconsultation == true) {
      inCenter = "بالمركز";
    } else {
      inCenter = "";
    }

    if (onlineconsultation == true) {
      online = ",عن بعد";
    } else {
      online = "";
    }
  }
  //--------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: isLoded == true
            ? Center(child: CircularProgressIndicator())
            : SafeArea(
                child: Column(
                  children: [
                    ProfileContainer(
                      TherapistAvatar: TherapistInfo['TherapistAvatar'],
                      TherapistName: TherapistName,
                      EducationLevel: Level,
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Expanded(
                      child: DefaultTabController(
                        length: 3,
                        child: Container(
                          width: 400,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18.31),
                          ),
                          child: Column(children: [
                            Container(
                              child: TabBar(
                                indicator: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Color.fromARGB(0, 66, 65, 65),
                                          width: 2)),
                                ),
                                labelColor: Color(0xff385a4a),
                                unselectedLabelColor: Color(0xff9bb0a5),
                                tabs: [
                                  Tab(
                                    child: Text(
                                      "معلومات عامة",
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ),
                                  Tab(
                                    child: Text(
                                      "الجلسات المتاحة",
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ),
                                  Tab(
                                    child: Text(
                                      "المراجعات",
                                      style: TextStyle(fontSize: 14),
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
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: Color(0x0c9bb0a5),
                                        ),
                                        child: ListView(
                                          children: [
                                            Column(children: [
                                              SizedBox(
                                                height: 27,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 10.0, left: 16),
                                                child: Row(
                                                  children: [
                                                    Image.asset(
                                                        "images/lang.png"),
                                                    SizedBox(
                                                      width: 6,
                                                    ),
                                                    Text(
                                                      "اللغات: " +
                                                          _arabic +
                                                          "," +
                                                          _english,
                                                      textAlign: TextAlign.end,
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xff687c71),
                                                        fontSize: 11,
                                                        fontFamily: "Cairo",
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                    Spacer(),
                                                    Image.asset(
                                                        "images/ExperinceYears.png"),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      "سنوات الخبرة: ${TherapistInfo['YearsofExperience']} سنة",
                                                      textAlign: TextAlign.end,
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xff687c71),
                                                        fontSize: 11,
                                                        fontFamily: "Cairo",
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 10.0, left: 10),
                                                child: Row(
                                                  children: [
                                                    Image.asset(
                                                        "images/SessionDuration.png"),
                                                    SizedBox(
                                                      width: 6,
                                                    ),
                                                    Text(
                                                      "مدة الجلسة :" +
                                                          TherapistInfo[
                                                              'duration'] +
                                                          " دقيقة",
                                                      textAlign: TextAlign.end,
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xff687c71),
                                                        fontSize: 11,
                                                        fontFamily: "Cairo",
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                    Spacer(),
                                                    Image.asset(
                                                        "images/Consaltant.png"),
                                                    SizedBox(
                                                      width: 6,
                                                    ),
                                                    Text(
                                                      "يقدم استشارات: " +
                                                          inCenter +
                                                          online,
                                                      textAlign: TextAlign.end,
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xff687c71),
                                                        fontSize: 11,
                                                        fontFamily: "Cairo",
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 25,
                                              ),
                                              Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 16),
                                                    child: Align(
                                                      alignment:
                                                          Alignment.centerRight,
                                                      child: Text(
                                                        "نبذة عن المختص",
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 18,
                                                          fontFamily: "Cairo",
                                                          fontWeight:
                                                              FontWeight.w700,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      TherapistInfo[
                                                          'GeneralInfo'],
                                                      textAlign:
                                                          TextAlign.start,
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xff6888a0),
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ]),
                                          ],
                                        ),
                                      ),
                                    ),

                                    //-----------------------------------------------

                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: Color(0x0c9bb0a5),
                                        ),
                                        child: BookWithTherapistPage(
                                            therapistID: therapistID),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 3),
                                      child:
                                          CommentPage(therpaistId: therapistID),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ]),
                        ),
                      ),
                    )
                  ],
                ),
              ));
  }
}

class ProfileContainer extends StatelessWidget {
  late String TherapistName;
  late String EducationLevel;
  late String TherapistAvatar;
  ProfileContainer(
      {required this.TherapistName,
      required this.EducationLevel,
      required this.TherapistAvatar});

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
    return Stack(children: [
      Container(
        width: 423,
        height: 260,
        padding: EdgeInsets.only(top: 60, left: 30, right: 30, bottom: 30),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Color(0xff9bb0a5), Color(0xff6888a0)],
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
          padding: const EdgeInsets.only(top: 160),
          child: Container(
              child: Center(
                child: Column(
                  children: [
                    Icon(
                      Icons.arrow_back_ios_new_outlined,
                      color: Colors.white,
                    ),
                    // SizedBox(
                    // height: 50,
                    // ),
                    // CircleAvatar(
                    // radius: 60,
                    // backgroundColor: Color(0xffEFF5F2),
                    // foregroundColor: Color(0xffEFF5F2),
                    // backgroundImage: AssetImage(""),
                    // ),
                    SizedBox(
                      height: 60,
                    ),
                    Text(
                      "$TherapistName",
                      style: textStyle,
                    ),
                    Text(
                      "$EducationLevel",
                      style: textStyle2,
                    ),
                  ],
                ),
              ),
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
        padding: const EdgeInsets.only(top: 110),
        child: Center(
          child: CircleAvatar(
            radius: 60,
            backgroundColor: Color(0xffEFF5F2),
            foregroundColor: Color(0xffEFF5F2),
            backgroundImage: AssetImage(TherapistAvatar),
          ),
        ),
      ),
      Align(
        alignment: Alignment.topLeft,
        child: IconButton(
          icon: const Icon(Icons.arrow_forward_ios_outlined, size: 20.0),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    ]);
  }
}
