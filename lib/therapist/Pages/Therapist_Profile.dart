import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eloquentapp/screens/constants.dart';
// import 'package:eloquentapp/parents/Pages/ParentProfile/screenTime.dart';
import 'package:eloquentapp/screens/welcome.dart';
import 'package:eloquentapp/therapist/Pages/Help&Support.dart';
import 'package:eloquentapp/therapist/Pages/frequent_questions.dart';
import 'package:eloquentapp/therapist/Pages/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class TherapistProfile extends StatefulWidget {
  const TherapistProfile({super.key});

  @override
  State<TherapistProfile> createState() => _TherapistProfileState();
}

class _TherapistProfileState extends State<TherapistProfile> {
  final _auth = FirebaseAuth.instance;
  String? _errorMessage;

  //instance for cloud firestore
  //  final _firestore = FirebaseFirestore.instance;
//  //get data from database
//  final CollectionReference _Request =
//      FirebaseFirestore.instance.collection('Request');
  late User singedInUser;
  void initState() {
    super.initState();
    getCurrentUser();
    getUserData();
    //اسال عليها
    // getChildData();
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

  Map<String, dynamic> TherapistInfo = {};
  bool isLoded = true;
  //get all user data and store to Map
  getUserData() async {
    await FirebaseFirestore.instance
        .collection('Therapist')
        .where("uid", isEqualTo: singedInUser.uid)
        .get()
        .then((v) {
      for (var element in v.docs) {
        TherapistInfo.addAll(element.data());
        setState(() {
          isLoded = false;
        });
      }
    });
  }

  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  final CollectionReference usersRef = _db.collection('Therapist');
  late Query query = usersRef.where('uid', isEqualTo: singedInUser.uid);
  late Stream<QuerySnapshot> usersStream = query.snapshots();

  late String TherapisttName = TherapistInfo['name'];
  late String TherapistEmail = TherapistInfo['email'];
  late String TherapistPhone = TherapistInfo['phone'];
  late String TherapistPasword = TherapistInfo['password'];
  late String ConfirmPasword = TherapistInfo['password'];
  late String TherapistAvatar = TherapistInfo['TherapistAvatar'];
  late String CurrentPass = TherapistInfo['password'];

  final NameController = TextEditingController();
  final EmailController = TextEditingController();
  final phoneController = TextEditingController();
  final paswordController = TextEditingController();
  final ConfirmPaswordController = TextEditingController();
  final CurrentPaswordController = TextEditingController();

  updateTherapistInfo(docId) async {
    var usersRef = _db.collection('Therapist');
    await usersRef.doc(docId).update({
      'name': TherapisttName,
      'email': TherapistEmail,
      'phone': TherapistPhone,
      'password': TherapistPasword,
      'Confirmpassword': ConfirmPasword,
    });
  }

  bool passwordConfermd() {
    if (TherapistPasword == ConfirmPasword) {
      return true;
    } else {
      print('pass not match');
      return false;
    }
  }

  // Map<String, dynamic> ChildInfo = {};

  // getChildData() async {
  // await FirebaseFirestore.instance
  // .collection('Child')
  // .where("uidParent", isEqualTo: singedInUser.uid)
  // .get()
  // .then((v) {
  // for (var element in v.docs) {
  // ChildInfo.addAll(element.data());
  // print(ChildID);
  // }
  // });
  // }

  // late String ChildID = ChildInfo['uid'];
  // _fetch() async {
  // final firebaseUser = await FirebaseAuth.instance.currentUser;
  // if (firebaseUser != null)
  // await FirebaseFirestore.instance
  // .collection("Parent")
  // .doc(firebaseUser.uid)
  // .get()
  // .then((ds) {
  // _name = ds.get("name");
  // _email = ds.get("Email");
  // }).catchError((e) {
  // print(e);
  // });
  // }
  final CollectionReference freQRef = _db.collection('HelpAndSupport');
  void _SaveHelpAndSupport(
      {required String RequestId,
      required String question,
      required String UserID}) async {
    try {
      await freQRef.add(
          {"RequestId": RequestId, "question": question, 'UserID': UserID});
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: isLoded == true
            ? Center(child: CircularProgressIndicator())
            : SafeArea(
                child: SingleChildScrollView(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Column(children: [
                    ProfileContainer(
                        Name: TherapisttName,
                        Email: TherapistEmail,
                        TherapistAvatar: TherapistAvatar),
                    SizedBox(
                      height: 12,
                    ),
                    Expanded(
                      child: DefaultTabController(
                          length: 1,
                          child: Column(
                            children: [
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
                                    )),
                                  ),
                                  labelColor: Color.fromARGB(255, 21, 11, 11),
                                  tabs: [
                                    // Tab(
                                    // child: Text("ادراة الجلسات "),
                                    // ),
                                    Tab(
                                      child: Text(" الاعدادات "),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                child: Expanded(
                                    child: TabBarView(children: [
                                  Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          updateTheAccountInfo(context);
                                        },
                                        child: Card(
                                          elevation: 4,
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(17.80)),
                                          child: Container(
                                            alignment: Alignment.center,
                                            width: 343,
                                            height: 80,
                                            child: ListTile(
                                              title: Text(
                                                'تعديل بيانات الحساب',
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  color: Color(0xff385a4a),
                                                  fontSize: 17,
                                                  fontFamily: "Cairo",
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              minLeadingWidth: 0,
                                              leading: Image.asset(
                                                  "images/editing.png"),
                                              trailing: Icon(Icons
                                                  .arrow_back_ios_new_outlined),
                                            ),
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: (() {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      frequentQuestions()));
                                        }),
                                        child: Card(
                                          elevation: 4,
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(17.80)),
                                          child: Container(
                                            alignment: Alignment.center,
                                            width: 343,
                                            height: 80,
                                            child: ListTile(
                                              dense: true,
                                              title: Text(
                                                'الاسئلة الشائعة',
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  color: Color(0xff385a4a),
                                                  fontSize: 17,
                                                  fontFamily: "Cairo",
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              minLeadingWidth: 0,
                                              leading: Image.asset(
                                                  "images/freQ.png"),
                                              trailing: Icon(Icons
                                                  .arrow_back_ios_new_outlined),
                                            ),
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          String question = '';
                                          showDialog(
                                              context: context,
                                              builder: (context) => Theme(
                                                  data: ThemeData(
                                                      useMaterial3: true),
                                                  child: Directionality(
                                                    textDirection:
                                                        TextDirection.rtl,
                                                    child: AlertDialog(
                                                      shape: RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius.circular(
                                                                      18.31))),
                                                      insetPadding:
                                                          EdgeInsets.all(15),
                                                      title: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          const Text(
                                                            "المساعدة والدعم",
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
                                                          ),
                                                          Text(
                                                            "اهلا وسهلا , تسعدنا مساعدتك في حل مشكلتك",
                                                            style: TextStyle(
                                                                color: Color(
                                                                    0xff9bb0a5),
                                                                fontSize: 13),
                                                          ),
                                                        ],
                                                      ),
                                                      content: SizedBox(
                                                        width: 365,
                                                        height: 200,
                                                        child: TextField(
                                                          onChanged: (Value) {
                                                            question = Value;
                                                          },
                                                          keyboardType:
                                                              TextInputType
                                                                  .multiline,
                                                          maxLines: 8,
                                                          textDirection:
                                                              TextDirection.rtl,
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
                                                                          7.0),
                                                            ),
                                                            filled: true,
                                                            fillColor:
                                                                Color.fromARGB(
                                                                    28,
                                                                    191,
                                                                    209,
                                                                    199),
                                                            hintText:
                                                                "اكتب تعليقك هنا",
                                                          ),
                                                        ),
                                                      ),
                                                      actions: [
                                                        Center(
                                                          child: ElevatedButton(
                                                            style: ElevatedButton
                                                                .styleFrom(
                                                                    minimumSize:
                                                                        Size(
                                                                            160,
                                                                            39),
                                                                    backgroundColor:
                                                                        Color(
                                                                            0xff394445),
                                                                    shape:
                                                                        const RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.all(
                                                                              Radius.circular(10)),
                                                                    )),
                                                            onPressed: (() {
                                                              final String
                                                                  RequestId =
                                                                  const Uuid()
                                                                      .v4();
                                                              String
                                                                  TherapistID =
                                                                  TherapistInfo[
                                                                      'uid'];
                                                              _SaveHelpAndSupport(
                                                                  UserID:
                                                                      TherapistInfo[
                                                                          'uid'],
                                                                  RequestId:
                                                                      RequestId,
                                                                  question:
                                                                      question);
                                                              Navigator.pop(
                                                                  context);
                                                              showDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (context) =>
                                                                          AlertDialog(
                                                                            title:
                                                                                Text('تم ارسال طلبك بنجاح'),
                                                                          ));
                                                            }),
                                                            child: Text(
                                                              "ارسال",
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 15,
                                                                fontFamily:
                                                                    "Cairo",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  )));
                                        },
                                        child: Card(
                                          elevation: 4,
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(17.80)),
                                          child: Container(
                                            alignment: Alignment.center,
                                            width: 343,
                                            height: 80,
                                            child: ListTile(
                                              title: Text(
                                                'المساعدة والدعم',
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  color: Color(0xff385a4a),
                                                  fontSize: 17,
                                                  fontFamily: "Cairo",
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              minLeadingWidth: 0,
                                              leading: Image.asset(
                                                  "images/Helping.png"),
                                              trailing: Icon(Icons
                                                  .arrow_back_ios_new_outlined),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              minimumSize: Size(170, 40),
                                              backgroundColor: Color.fromARGB(
                                                  255, 206, 49, 38),
                                              shape:
                                                  const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  11)))),
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      WelcomeScreen(),
                                                ));
                                          },
                                          child: Text("تسجيل الخروج"))
                                    ],
                                  ),
                                ])),
                              )
                            ],
                          )),
                    )
                  ]),
                ),
              )));
  }

  updateTheAccountInfo(context) {
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
          return StatefulBuilder(builder: (context, setState) {
            final bottomInset = MediaQuery.of(context).viewInsets.bottom;
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.83,
              child: StreamBuilder<QuerySnapshot>(
                stream: usersStream,
                builder:
                    (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                  if (streamSnapshot.hasData) {
                    NameController.text = TherapisttName;
                    EmailController.text = TherapistEmail;
                    phoneController.text = TherapistPhone;
                    paswordController.text = TherapistPasword;
                    ConfirmPaswordController.text = ConfirmPasword;
                    CurrentPaswordController.text = CurrentPass;
                    return ListView.builder(
                        itemCount: streamSnapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          final DocumentSnapshot documentSnapshot =
                              streamSnapshot.data!.docs[index];
                          return SingleChildScrollView(
                            reverse: true,
                            child: Container(
                                padding: EdgeInsets.only(
                                  bottom: bottomInset,
                                ),
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          right: 20,
                                          top: 20,
                                        ),
                                        child: Text(
                                          "تعديل بيانات الحساب  ",
                                          style: TextStyle(
                                            color: Color(0xff385a4a),
                                            fontSize: 25,
                                            fontFamily: "Cairo",
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Table(
                                      children: [
                                        TableRow(children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10, right: 20),
                                            child: Align(
                                                alignment: Alignment.topRight,
                                                child: Text(
                                                  "الاسم",
                                                  style: TextStyle(
                                                    color: Color(0xff385a4a),
                                                    fontSize: 15,
                                                    fontFamily: "Cairo",
                                                    fontWeight: FontWeight.w800,
                                                  ),
                                                )),
                                          )
                                        ]),
                                        TableRow(children: [
                                          Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20.0,
                                                  right: 20,
                                                  top: 7,
                                                  bottom: 10),
                                              child: TextField(
                                                decoration:
                                                    kStylingInputDec.copyWith(),
                                                // decoration: InputDecoration(
                                                // border: OutlineInputBorder(
                                                // borderRadius: BorderRadius.circular(10.0),
                                                // borderSide: BorderSide(
                                                // color: Colors.red,
                                                // width: 2.0,
                                                // ),
                                                // ),
                                                controller: NameController,
                                                onChanged: (newValue) {
                                                  TherapisttName = newValue;
                                                  setState:
                                                  (() {});
                                                },
                                              )),
                                        ]),
                                        TableRow(children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10, right: 20),
                                            child: Align(
                                                alignment: Alignment.topRight,
                                                child: Text(
                                                  "البريد الالكتروني",
                                                  style: TextStyle(
                                                    color: Color(0xff385a4a),
                                                    fontSize: 15,
                                                    fontFamily: "Cairo",
                                                    fontWeight: FontWeight.w800,
                                                  ),
                                                )),
                                          )
                                        ]),
                                        TableRow(children: [
                                          Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20.0,
                                                  right: 20,
                                                  top: 7,
                                                  bottom: 10),
                                              child: TextField(
                                                style: TextStyle(
                                                  fontSize: 14.0,
                                                ),
                                                decoration:
                                                    kStylingInputDec.copyWith(),
                                                controller: EmailController,
                                                keyboardType:
                                                    TextInputType.emailAddress,
                                                onChanged: (newValue) {
                                                  TherapistEmail = newValue;
                                                  setState:
                                                  (() {});
                                                },
                                              )),
                                        ]),
                                        TableRow(children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10, right: 20),
                                            child: Align(
                                                alignment: Alignment.topRight,
                                                child: Text(
                                                  "رقم الجوال",
                                                  style: TextStyle(
                                                    color: Color(0xff385a4a),
                                                    fontSize: 15,
                                                    fontFamily: "Cairo",
                                                    fontWeight: FontWeight.w800,
                                                  ),
                                                )),
                                          )
                                        ]),
                                        TableRow(children: [
                                          Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20.0,
                                                  right: 20,
                                                  top: 7,
                                                  bottom: 10),
                                              child: TextField(
                                                keyboardType:
                                                    TextInputType.number,
                                                decoration:
                                                    kStylingInputDec.copyWith(),
                                                controller: phoneController,
                                                onChanged: (newValue) {
                                                  TherapistPhone = newValue;
                                                  setState:
                                                  (() {});
                                                },
                                              )),
                                        ]),
                                        TableRow(children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10, right: 20),
                                            child: Align(
                                                alignment: Alignment.topRight,
                                                child: Text(
                                                  "كلمة المرور الحالية ",
                                                  style: TextStyle(
                                                    color: Color(0xff385a4a),
                                                    fontSize: 15,
                                                    fontFamily: "Cairo",
                                                    fontWeight: FontWeight.w800,
                                                  ),
                                                )),
                                          )
                                        ]),
                                        TableRow(children: [
                                          Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20.0,
                                                  right: 20,
                                                  top: 7,
                                                  bottom: 10),
                                              child: TextField(
                                                decoration:
                                                    kStylingInputDec.copyWith(),
                                                controller:
                                                    CurrentPaswordController,
                                                onChanged: (newValue) {
                                                  CurrentPass = newValue;
                                                  setState:
                                                  (() {});
                                                },
                                              )),
                                        ]),
                                        TableRow(children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10, right: 20),
                                            child: Align(
                                                alignment: Alignment.topRight,
                                                child: Text(
                                                  " كلمة المرور الجديدة",
                                                  style: TextStyle(
                                                    color: Color(0xff385a4a),
                                                    fontSize: 15,
                                                    fontFamily: "Cairo",
                                                    fontWeight: FontWeight.w800,
                                                  ),
                                                )),
                                          )
                                        ]),
                                        TableRow(children: [
                                          Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20.0,
                                                  right: 20,
                                                  top: 7,
                                                  bottom: 10),
                                              child: TextField(
                                                decoration:
                                                    kStylingInputDec.copyWith(),
                                                onChanged: (newValue) {
                                                  TherapistPasword = newValue;
                                                  setState:
                                                  (() {});
                                                },
                                              )),
                                        ]),
                                        TableRow(children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10, right: 20),
                                            child: Align(
                                                alignment: Alignment.topRight,
                                                child: Text(
                                                  "اعادة كلمة المرور",
                                                  style: TextStyle(
                                                    color: Color(0xff385a4a),
                                                    fontSize: 15,
                                                    fontFamily: "Cairo",
                                                    fontWeight: FontWeight.w800,
                                                  ),
                                                )),
                                          )
                                        ]),
                                        TableRow(children: [
                                          Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20.0,
                                                  right: 20,
                                                  top: 7,
                                                  bottom: 10),
                                              child: TextField(
                                                decoration:
                                                    kStylingInputDec.copyWith(),
                                                onChanged: (newValue) {
                                                  ConfirmPasword = newValue;
                                                  setState:
                                                  (() {});
                                                },
                                              )),
                                        ])
                                      ],
                                    ),
                                    if (_errorMessage != null)
                                      Text(
                                        _errorMessage!,
                                        style: TextStyle(
                                          color: Colors.red,
                                        ),
                                      ),
                                    Padding(
                                        padding: const EdgeInsets.all(6.0),
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                minimumSize: Size(160, 39),
                                                backgroundColor:
                                                    Color(0xff394445),
                                                shape:
                                                    const RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10)),
                                                )),
                                            onPressed: () async {
                                              String docId =
                                                  documentSnapshot.id;
                                              if (passwordConfermd()) {
                                                try {
                                                  final user =
                                                      _auth.currentUser;
                                                  if (user != null) {
                                                    // Reauthenticate the user using their current password
                                                    AuthCredential credential =
                                                        EmailAuthProvider
                                                            .credential(
                                                                email:
                                                                    user.email!,
                                                                password:
                                                                    CurrentPass);
                                                    await user
                                                        .reauthenticateWithCredential(
                                                            credential);
                                                    updateTherapistInfo(docId);
                                                    if (TherapistEmail !=
                                                            null &&
                                                        TherapistEmail
                                                            .isNotEmpty) {
                                                      await user.updateEmail(
                                                          TherapistEmail);
                                                    }
                                                    if (TherapistPasword !=
                                                            null &&
                                                        TherapistPasword
                                                            .isNotEmpty) {
                                                      await user.updatePassword(
                                                          TherapistPasword);
                                                      CurrentPass =
                                                          TherapistPasword;
                                                    }
                                                  }
                                                  Navigator.pop(context);
                                                  showDialog(
                                                      context: context,
                                                      builder: (context) =>
                                                          AlertDialog(
                                                            title: Text(
                                                                "تم ارسال التعديلات بنجاح"),
                                                          ));
                                                } catch (e) {
                                                  print(e);
                                                }
                                              } else {
                                                setState(() {
                                                  _errorMessage =
                                                      ' كلمة المرور غير متطابقة، الرجاء المحاولة مرا اخرى';
                                                });
                                              }
                                            },
                                            child: Text('حفظ التغيرات')))
                                  ],
                                )),
                          );
                        });
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            );
          });
        });
  }

  UserUpdateInfo() {}
}

class ProfileContainer extends StatelessWidget {
  late String Name;
  late String Email;
  late String TherapistAvatar;
  ProfileContainer(
      {required this.Name, required this.Email, required this.TherapistAvatar});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Respond')
            .where('UserID', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
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
                height: 260,
                padding:
                    EdgeInsets.only(top: 60, left: 30, right: 30, bottom: 30),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [Color(0xffa7a6cb), Color(0xff60607e)],
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
                          // CircleAvatar(
                          // radius: 60,
                          // backgroundColor: Color(0xffEFF5F2),
                          // foregroundColor: Color(0xffEFF5F2),
                          // backgroundImage: AssetImage(""),
                          // ),
                          SizedBox(
                            height: 85,
                          ),
                          Text("$Name",
                              style: TextStyle(
                                  color: Color(0xff6888a0),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700)),
                          SizedBox(
                            height: 3,
                          ),

                          Text(
                            "$Email",
                            style: textStyle,
                          ),
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
              Positioned(
                right: 16,
                top: 16,
                child: IconButton(
                  icon: Icon(Icons.notifications, color: Colors.white),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            // RejectSessionsScreen(_rejectSessions),
                            HelpSupport(),
                      ),
                    );
                    //
                    // Mark the document as read
                    FirebaseFirestore.instance
                        .collection('Respond')
                        .where('UserID',
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
            ],
          );
        });
  }

  var textStyle = TextStyle(
    color: Color(0xff6888a0),
    fontSize: 15,
  );
}
