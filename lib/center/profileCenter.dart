import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eloquentapp/center/Help&Support.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../screens/constants.dart';
import '../screens/welcome.dart';
import 'frequentQuestionsCenter.dart';

class CenterProfile extends StatefulWidget {
  const CenterProfile({super.key});

  @override
  State<CenterProfile> createState() => _CenterProfileState();
}

class _CenterProfileState extends State<CenterProfile> {
  final _auth = FirebaseAuth.instance;
  String? _errorMessage;

  //late User singedInUser;
  User? singedInUser;
  @override
  void initState() {
    super.initState();
    final user = _auth.currentUser;
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

  Map<String, dynamic> CenterInfo = {};
  bool isLoded = true;
  //get all user data and store to Map
  getUserData() async {
    try {
      QuerySnapshot centerSnapshot = await FirebaseFirestore.instance
          .collection('center')
          .where("uid", isEqualTo: singedInUser?.uid)
          .get();
      centerSnapshot.docs.forEach((element) {
        CenterInfo.addAll(element.data() as Map<String, dynamic>);
      });
      setState(() {
        isLoded = false;
      });
    } catch (e) {
      print("Error getting user data: $e");
    }
  }

  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  final CollectionReference usersRef = _db.collection('center');
  late Query query = usersRef.where('uid', isEqualTo: singedInUser?.uid);
  late Stream<QuerySnapshot> usersStream = query.snapshots();

  late String centerName = CenterInfo['name'];
  late String centerEmail = CenterInfo['email'];
  late String centerPhone = CenterInfo['phone'];
  late String centerPasword = CenterInfo['password'];
  late String ConfirmPasword = CenterInfo['password'];
  late String CurrentPass = CenterInfo['password'];

  late String centerID = CenterInfo['uid'];
  final NameController = TextEditingController();
  final EmailController = TextEditingController();
  final phoneController = TextEditingController();
  final paswordController = TextEditingController();
  final ConfirmPaswordController = TextEditingController();
  final CurrentPaswordController = TextEditingController();

  updateCenterInfo(docId) async {
    var usersRef = _db.collection('center');
    await usersRef.doc(docId).update({
      'name': centerName,
      'email': centerEmail,
      'phone': centerPhone,
      'password': centerPasword,
      'Confirmpassword': ConfirmPasword,
    });
  }

  bool passwordConfermd() {
    if (centerPasword == ConfirmPasword) {
      return true;
    } else {
      print('pass not match');
      return false;
    }
  }

//المساعدة والدعم
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
                      Name: centerName,
                      Email: centerEmail,
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    /////////////////
                    Container(
                      child: Expanded(
                          child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              updateTheAccountInfo(context);
                            },
                            child: Card(
                              elevation: 4,
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(17.80)),
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
                                  leading: Image.asset("images/Setting1.png"),
                                  trailing:
                                      Icon(Icons.arrow_back_ios_new_outlined),
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
                                  borderRadius: BorderRadius.circular(17.80)),
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
                                  leading:
                                      Image.asset("images/IconQuestion.png"),
                                  trailing:
                                      Icon(Icons.arrow_back_ios_new_outlined),
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
                                      data: ThemeData(useMaterial3: true),
                                      child: Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: AlertDialog(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(18.31))),
                                          insetPadding: EdgeInsets.all(15),
                                          title: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                "المساعدة والدعم",
                                                style: TextStyle(
                                                  color: Color(0xff385a4a),
                                                  fontSize: 20,
                                                  fontFamily: "Cairo",
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                              Text(
                                                "اهلا وسهلا , تسعدنا مساعدتك في حل مشكلتك",
                                                style: TextStyle(
                                                    color: Color(0xff9bb0a5),
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
                                                  TextInputType.multiline,
                                              maxLines: 8,
                                              textDirection: TextDirection.rtl,
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                  borderSide: BorderSide.none,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          7.0),
                                                ),
                                                filled: true,
                                                fillColor: Color.fromARGB(
                                                    28, 191, 209, 199),
                                                hintText: "اكتب تعليقك هنا",
                                              ),
                                            ),
                                          ),
                                          actions: [
                                            Center(
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
                                                onPressed: (() {
                                                  final String RequestId =
                                                      const Uuid().v4();
                                                  String centerID =
                                                      CenterInfo['uid'];
                                                  _SaveHelpAndSupport(
                                                      UserID: CenterInfo['uid'],
                                                      RequestId: RequestId,
                                                      question: question);
                                                  Navigator.pop(context);
                                                  showDialog(
                                                      context: context,
                                                      builder: (context) =>
                                                          AlertDialog(
                                                            title: Text(
                                                                'تم ارسال طلبك بنجاح'),
                                                          ));
                                                }),
                                                child: Text(
                                                  "ارسال",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15,
                                                    fontFamily: "Cairo",
                                                    fontWeight: FontWeight.w500,
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
                                  borderRadius: BorderRadius.circular(17.80)),
                              child: Container(
                                alignment: Alignment.center,
                                width: 343,
                                height: 80,
                                child: ListTile(
                                  title: const Text(
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
                                  leading:
                                      Image.asset("images/IconSupport.png"),
                                  trailing:
                                      Icon(Icons.arrow_back_ios_new_outlined),
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
                                  backgroundColor:
                                      Color.fromARGB(255, 206, 49, 38),
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(11)))),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => WelcomeScreen(),
                                    ));
                              },
                              child: Text("تسجيل الخروج"))
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
                    NameController.text = centerName;
                    EmailController.text = centerEmail;
                    phoneController.text = centerPhone;
                    paswordController.text = centerPasword;
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
                                    const Align(
                                      alignment: Alignment.topRight,
                                      child: Padding(
                                        padding:
                                            EdgeInsets.only(right: 20, top: 20),
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
                                        const TableRow(children: [
                                          Padding(
                                            padding: EdgeInsets.only(
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
                                                controller: NameController,
                                                onChanged: (newValue) {
                                                  centerName = newValue;
                                                  setState:
                                                  (() {});
                                                },
                                              )),
                                        ]),
                                        const TableRow(children: [
                                          Padding(
                                            padding: EdgeInsets.only(
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
                                                decoration:
                                                    kStylingInputDec.copyWith(),
                                                controller: EmailController,
                                                keyboardType:
                                                    TextInputType.emailAddress,
                                                onChanged: (newValue) {
                                                  centerEmail = newValue;
                                                  setState:
                                                  (() {});
                                                },
                                              )),
                                        ]),
                                        const TableRow(children: [
                                          Padding(
                                            padding: EdgeInsets.only(
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
                                                decoration:
                                                    kStylingInputDec.copyWith(),
                                                controller: phoneController,
                                                onChanged: (newValue) {
                                                  centerPhone = newValue;
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
                                        const TableRow(children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: 10, right: 20),
                                            child: Align(
                                                alignment: Alignment.topRight,
                                                child: Text(
                                                  "كلمة المرور",
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
                                                  centerPasword = newValue;
                                                  setState:
                                                  (() {});
                                                },
                                              )),
                                        ]),
                                        TableRow(children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 20.0,
                                                right: 20,
                                                top: 7,
                                                bottom: 10),
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
                                        ]),
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
                                                    updateCenterInfo(docId);
                                                    if (centerEmail != null &&
                                                        centerEmail
                                                            .isNotEmpty) {
                                                      await user.updateEmail(
                                                          centerEmail);
                                                    }
                                                    if (centerPasword != null &&
                                                        centerPasword
                                                            .isNotEmpty) {
                                                      await user.updatePassword(
                                                          centerPasword);
                                                      CurrentPass =
                                                          centerPasword;
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
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            );
          });
        });
  }
}

class ProfileContainer extends StatelessWidget {
  late String Name;
  late String Email;
  ProfileContainer({super.key, required this.Name, required this.Email});

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
          return Stack(children: [
            Container(
              width: 423,
              height: 260,
              padding:
                  EdgeInsets.only(top: 60, left: 30, right: 30, bottom: 30),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [Color(0xc1000000), Color(0xffcdd1d8)],
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
                            Name,
                            style: textStyle,
                          ),
                          Text(
                            Email,
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
            Padding(
              padding: const EdgeInsets.only(top: 110),
              child: Center(
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: Color(0xffEFF5F2),
                  foregroundColor: Color(0xffEFF5F2),
                  child: SizedBox(
                    width: 80,
                    height: 80,
                    child: Image.asset("images/Mcenter.png"),
                  ),
                ),
              ),
            ),
          ]);
        });
  }

  var textStyle = const TextStyle(
    color: Color(0xff6888a0),
    fontSize: 15,
  );
}
//
