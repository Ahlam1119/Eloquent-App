import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eloquentapp/center/center_information.dart';
import 'package:eloquentapp/center/mailer.dart';
import 'package:eloquentapp/widget/label.dart';
import 'package:eloquentapp/widget/therapistRequests.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:input_quantity/input_quantity.dart';
import 'package:jiffy/jiffy.dart';

import '../screens/constants.dart';

class MTherapist extends StatefulWidget {
  static String id = 'MTherapist_screen';

  const MTherapist({super.key});
  @override
  State<MTherapist> createState() => _MTherapistState();
}

class _MTherapistState extends State<MTherapist> {
  final _auth = FirebaseAuth.instance;
  late String name;
  late String email;
  late String pass;
  late String ConfirmPass;
  late String phone;
  late String GeneralInfo;
  late String YearsofExperience;
  late String JobTitle;
  late String duration;
  bool arabicLanguage = false;
  bool englishLanguage = false;
  bool incenter = false;
  bool online = false;

  late String TherapistAvatar = '';
  //step one for streem bulider
  // ignore: non_constant_identifier_names
  final CollectionReference _Therapist =
      FirebaseFirestore.instance.collection('Therapist');
  // ignore: non_constant_identifier_names
  AddData({
    required String TheapistID,
    required String name,
    required String email,
    required String pass,
    required String phone,
    required String GeneralInfo,
    required String JobTitle,
    required String YearsofExperience,
    required String duration,
    required var arabicLanguage,
    required var englishLanguage,
    required var incenter,
    required var online,
    required String? centerid,
    required String TherapistAvatar,
  }) async {
    final DocumentReference<Map<String, dynamic>> userRef =
        FirebaseFirestore.instance.collection('Therapist').doc(TheapistID);

    await userRef.set({
      'uid': TheapistID,
      'name': name,
      'email': email,
      'password': pass,
      'phone': phone,
      'GeneralInfo': GeneralInfo,
      'JobTitle': JobTitle,
      'YearsofExperience': YearsofExperience,
      'duration': duration,
      'arabicLanguage': arabicLanguage,
      'englishLanguage': englishLanguage,
      'online': online,
      'incenter': incenter,
      "active": true,
      'time': FieldValue.serverTimestamp(),
      "centerid": centerid,
      "centerName": CenterInformation.name,
      'TherapistAvatar': TherapistAvatar
    });
  }

  final TextEditingController _GeneralInfoController = TextEditingController();
  final TextEditingController _JobTitleController = TextEditingController();
  final TextEditingController _YearsofExperienceController =
      TextEditingController();
  final TextEditingController _durationController = TextEditingController();
  // sending reject message
  final TextEditingController _rejectMessageController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    var textStyle = const TextStyle(fontSize: 13, fontWeight: FontWeight.w700);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'إدارة الأخصائيين',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Color(0xff385a4a),
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const Text(
                  textAlign: TextAlign.right,
                  'تعرض هذه القائمة \n جميع الأخصائيين المسجلين في المركز ',
                  style: TextStyle(
                    color: Color(0xff9bb0a5),
                    fontWeight: FontWeight.w800,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                //هيكل التاب بار ولازم يكون بالترتيب مع الجزء الثاني
                Padding(
                  padding: EdgeInsets.only(top: 10, right: 10, left: 10),
                  child: Column(children: [
                    Container(
                      height: 45,
                      decoration: BoxDecoration(
                          color: Color(0xff9bb0a5),
                          borderRadius: BorderRadius.circular(11)),
                      child: TabBar(
                        indicator: BoxDecoration(
                          color: Color(0xff385a4a),
                          borderRadius: BorderRadius.circular(11),
                        ),
                        labelColor: Colors.white,
                        tabs: [
                          Tab(
                            child: Text(
                              "قائمة الأخصائيين",
                              style: textStyle,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Tab(
                            child: Text(
                              "اضافة أخصائي",
                              style: textStyle,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Tab(
                            child: Text(
                              "طلبات الأخصائيين",
                              style: textStyle,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
                ),
                Expanded(
                    child: TabBarView(
                  children: [
                    StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('Therapist')
                          .where("active", isEqualTo: true)
                          .where("centerid", isEqualTo: CenterInformation.uid)
                          .snapshots(),
                      builder: (context,
                          AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                        if (streamSnapshot.hasData) {
                          return ListView.builder(
                            itemCount: streamSnapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              final DocumentSnapshot documentSnapshot =
                                  streamSnapshot.data!.docs[index];
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4),
                                child: Card(
                                  elevation: 4,
                                  shadowColor: Color.fromARGB(105, 0, 0, 0),
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(17.80),
                                  ),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              width: 55,
                                              height: 55,
                                              child: CircleAvatar(
                                                backgroundColor:
                                                    Color(0xffEFF5F2),
                                                foregroundColor:
                                                    Color(0xffEFF5F2),
                                                backgroundImage: AssetImage(
                                                    documentSnapshot[
                                                        'TherapistAvatar']),
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    documentSnapshot['name'],
                                                    textAlign: TextAlign.right,
                                                    style: TextStyle(
                                                      color: Color(0xff385a4a),
                                                      fontSize: 15,
                                                      fontFamily: "Cairo",
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                  Text(
                                                    documentSnapshot['email'],
                                                    textAlign: TextAlign.right,
                                                    style: TextStyle(
                                                      color: Color(0xff6888a0),
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    documentSnapshot[
                                                        'JobTitle'],
                                                    textAlign: TextAlign.right,
                                                    style: TextStyle(
                                                      color: Color(0xff385a4a),
                                                      fontSize: 13,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            IconButton(
                                              icon: Icon(Icons.edit),
                                              onPressed: () {
                                                showDialog(
                                                  context: context,
                                                  barrierDismissible: false,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      insetPadding:
                                                          const EdgeInsets.all(
                                                              0),
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      content: Container(
                                                        height: 140,
                                                        width: 300,
                                                        child: Container(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 20,
                                                                  right: 10,
                                                                  left: 10),
                                                          decoration: BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15)),
                                                          child: Column(
                                                            children: [
                                                              Text(
                                                                'هل انت متأكد من رغبتك في حذف الحساب ؟ ',
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                              SizedBox(
                                                                height: 7,
                                                              ),
                                                              Container(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        top: 15,
                                                                        bottom:
                                                                            10),
                                                                child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      SizedBox(
                                                                        height:
                                                                            45,
                                                                        width:
                                                                            120,
                                                                        child:
                                                                            Material(
                                                                          color: Colors
                                                                              .red
                                                                              .shade900,
                                                                          shape:
                                                                              RoundedRectangleBorder(borderRadius: BorderRadius.circular(11)),
                                                                          child: MaterialButton(
                                                                              onPressed: () {
                                                                                _update(documentSnapshot);
                                                                                Navigator.of(context).pop();
                                                                              },
                                                                              child: const Text(
                                                                                "حذف الحساب",
                                                                                style: TextStyle(fontSize: 16, color: Colors.white),
                                                                              )),
                                                                        ),
                                                                      ),
                                                                      const SizedBox(
                                                                        width:
                                                                            15,
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            45,
                                                                        width:
                                                                            120,
                                                                        child:
                                                                            Material(
                                                                          color:
                                                                              Colors.black,
                                                                          shape:
                                                                              RoundedRectangleBorder(borderRadius: BorderRadius.circular(11)),
                                                                          child: MaterialButton(
                                                                              splashColor: Colors.white,
                                                                              onPressed: () {
                                                                                Navigator.of(context).pop();
                                                                              },
                                                                              child: const Text(
                                                                                "إلغاء",
                                                                                style: TextStyle(fontSize: 16, color: Colors.white),
                                                                              )),
                                                                        ),
                                                                      ),
                                                                    ]),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                );
                                              },
                                            ),
                                            SizedBox(width: 1),
                                            IconButton(
                                              icon: Icon(
                                                Icons.delete,
                                                color: Colors.red,
                                              ),
                                              onPressed: () {
                                                showDialog(
                                                  context: context,
                                                  barrierDismissible: false,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      insetPadding:
                                                          const EdgeInsets.all(
                                                              0),
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      content: Container(
                                                        height: 140,
                                                        width: 300,
                                                        child: Container(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 20,
                                                                  right: 10,
                                                                  left: 10),
                                                          decoration: BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15)),
                                                          child: Column(
                                                            children: [
                                                              Text(
                                                                'هل انت متأكد من رغبتك في حذف الحساب ؟ ',
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                              SizedBox(
                                                                height: 7,
                                                              ),
                                                              Container(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        top: 15,
                                                                        bottom:
                                                                            10),
                                                                child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      SizedBox(
                                                                        height:
                                                                            45,
                                                                        width:
                                                                            120,
                                                                        child:
                                                                            Material(
                                                                          color: Colors
                                                                              .red
                                                                              .shade900,
                                                                          shape:
                                                                              RoundedRectangleBorder(borderRadius: BorderRadius.circular(11)),
                                                                          child: MaterialButton(
                                                                              onPressed: () {
                                                                                _delete(documentSnapshot.id);
                                                                                Navigator.of(context).pop();
                                                                              },
                                                                              child: const Text(
                                                                                "حذف الحساب",
                                                                                style: TextStyle(fontSize: 16, color: Colors.white),
                                                                              )),
                                                                        ),
                                                                      ),
                                                                      const SizedBox(
                                                                        width:
                                                                            15,
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            45,
                                                                        width:
                                                                            120,
                                                                        child:
                                                                            Material(
                                                                          color:
                                                                              Colors.black,
                                                                          shape:
                                                                              RoundedRectangleBorder(borderRadius: BorderRadius.circular(11)),
                                                                          child: MaterialButton(
                                                                              splashColor: Colors.white,
                                                                              onPressed: () {
                                                                                Navigator.of(context).pop();
                                                                              },
                                                                              child: const Text(
                                                                                "إلغاء",
                                                                                style: TextStyle(fontSize: 16, color: Colors.white),
                                                                              )),
                                                                        ),
                                                                      ),
                                                                    ]),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        }
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    ),
// اضافه الاخصائي
                    Center(
                      child: Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(11)),
                          color: Color.fromRGBO(155, 176, 165, 0.09),
                        ),
                        padding: const EdgeInsets.all(15),
                        alignment: Alignment.topRight,
                        margin: const EdgeInsets.only(top: 15),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Center(
                                child: Align(
                                  alignment: Alignment.topCenter,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            TherapistAvatar =
                                                "images/TherpistWomen.png";
                                          });
                                          setState(() {
                                            print(TherapistAvatar);
                                          });
                                        },
                                        child: Transform.scale(
                                          scale: TherapistAvatar ==
                                                  "images/TherpistWomen.png"
                                              ? 1.2
                                              : 1.0,
                                          child: Image.asset(
                                            "images/TherpistWomen.png",
                                            width: 80,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            TherapistAvatar =
                                                "images/TherpisMan.png";
                                          });
                                          setState(() {
                                            print(TherapistAvatar);
                                          });
                                        },
                                        child: Transform.scale(
                                          scale: TherapistAvatar ==
                                                  "images/TherpisMan.png"
                                              ? 1.2
                                              : 1.0,
                                          child: Image.asset(
                                            "images/TherpisMan.png",
                                            width: 80,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const Text(
                                'الأسم ',
                                style: SStyleTextOfTextFeild,
                              ),
                              SizedBox(
                                height: 45,
                                child: TextField(
                                  onChanged: (value) {
                                    name = value;
                                  },
                                  decoration: docfiled,
                                ),
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                'البريد الإلكتروني',
                                style: SStyleTextOfTextFeild,
                              ),
                              SizedBox(
                                height: 45,
                                child: TextField(
                                  onChanged: (value) {
                                    email = value;
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                  //controller: _emailController,
                                  decoration: docfiled,
                                ),
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                'كلمة المرور',
                                style: SStyleTextOfTextFeild,
                              ),
                              SizedBox(
                                height: 45,
                                child: TextField(
                                  onChanged: (value) {
                                    pass = value;
                                  },
                                  obscureText: true,
                                  decoration: docfiled,
                                ),
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                'رقم الجوال',
                                style: SStyleTextOfTextFeild,
                              ),
                              SizedBox(
                                height: 65,
                                child: TextField(
                                  onChanged: (value) {
                                    phone = value;
                                  },
                                  keyboardType: TextInputType.number,
                                  maxLength: 10,
                                  decoration: docfiled,
                                ),
                              ),
                              const Text(
                                'المسمى الوظيفي ',
                                style: SStyleTextOfTextFeild,
                              ),
                              SizedBox(
                                height: 45,
                                child: TextField(
                                  onChanged: (value) {
                                    JobTitle = value;
                                  },
                                  decoration: docfiled,
                                ),
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                ' نبذة عامة عن الاخصائي',
                                style: SStyleTextOfTextFeild,
                              ),
                              SizedBox(
                                height: 150,
                                width: 240,
                                child: TextField(
                                  maxLines: null,
                                  expands: true,
                                  onChanged: (value) {
                                    GeneralInfo = value;
                                  },
                                  //controller: _GeneralInfoController,
                                  decoration: docfiled,
                                ),
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                'سنوات الخبرة',
                                style: SStyleTextOfTextFeild,
                              ),
                              InputQty(
                                maxVal: 100,
                                minVal: 0,
                                initVal: 0,
                                isIntrinsicWidth: false,
                                onQtyChanged: (val) {
                                  YearsofExperience = val.toString();
                                  print(YearsofExperience);
                                },
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                'مدة الجلسة',
                                style: SStyleTextOfTextFeild,
                              ),
                              InputQty(
                                maxVal: 60,
                                minVal: 0,
                                initVal: 0,
                                isIntrinsicWidth: false,
                                onQtyChanged: (val) {
                                  duration = val.toString();
                                  print(duration);
                                },
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                'اللغات',
                                style: SStyleTextOfTextFeild,
                              ),
                              Row(
                                children: [
                                  Checkbox(
                                      value: englishLanguage,
                                      onChanged: (value) {
                                        setState(() {
                                          englishLanguage = value!;
                                        });
                                      }),
                                  const Text('اللغة العربية'),
                                  SizedBox(
                                    width: 12,
                                  ),
                                  Checkbox(
                                      value: arabicLanguage,
                                      onChanged: (value) {
                                        setState(() {
                                          arabicLanguage = value!;
                                        });
                                      }),
                                  const Text('اللغة الانجليزية'),
                                ],
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                'تقديم الأستشارات',
                                style: SStyleTextOfTextFeild,
                              ),
                              Row(
                                children: [
                                  Checkbox(
                                      value: online,
                                      onChanged: (value) {
                                        setState(() {
                                          online = value!;
                                        });
                                      }),
                                  const Text('في المركز'),
                                  SizedBox(
                                    width: 25,
                                  ),
                                  Checkbox(
                                      value: incenter,
                                      onChanged: (value) {
                                        setState(() {
                                          incenter = value!;
                                        });
                                      }),
                                  const Text('عن بعد'),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                      onPressed: () async {
                                        try {
                                          final UserCredential newU = await _auth
                                              .createUserWithEmailAndPassword(
                                                  email: email, password: pass);
                                          if (newU.user == null) {
                                            print("not found");
                                          } else {
                                            AddData(
                                                centerid: CenterInformation.uid,
                                                TheapistID: newU.user!.uid,
                                                name: name,
                                                phone: phone,
                                                email: email,
                                                pass: pass,
                                                GeneralInfo: GeneralInfo,
                                                JobTitle: JobTitle,
                                                online: online,
                                                YearsofExperience:
                                                    YearsofExperience,
                                                duration: duration,
                                                arabicLanguage: arabicLanguage,
                                                englishLanguage:
                                                    englishLanguage,
                                                incenter: incenter,
                                                TherapistAvatar:
                                                    TherapistAvatar);
                                          }
                                          AwesomeDialog(
                                              dialogType: DialogType.noHeader,
                                              context: context,
                                              title: "نجاح",
                                              body: Container(
                                                height: 50,
                                                child: const Text(
                                                    "تمت اضافة الاخصائي بنجاح"),
                                              )).show();
                                        } catch (e) {
                                          AwesomeDialog(
                                              dialogType: DialogType.noHeader,
                                              context: context,
                                              title: "فشل",
                                              body: Container(
                                                height: 50,
                                                child: Text(
                                                    'يرجى التأكد من تعبئة جميع الحقول'),
                                              )).show();
                                          print(e);
                                        }
                                      },
                                      child: const Text('إضافة أخصائي'),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            const Color(0xff385a4a),
                                      ))
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),

//طلبات الاخصائيين
                    StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('Therapist')
                          .where("active", isEqualTo: false)
                          .where("centerid", isEqualTo: CenterInformation.uid)
                          .snapshots(),
                      builder: ((context,
                          AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                        if (streamSnapshot.hasData) {
                          return ListView.builder(
                              itemCount: streamSnapshot.data!.docs.length,
                              itemBuilder: ((context, index) {
                                return CustomTherapistCard(
                                  arabic: streamSnapshot.data!.docs[index]
                                      ['arabicLanguage'],

                                  date: Jiffy(DateTime.parse(streamSnapshot
                                          .data!.docs[index]['time']
                                          .toDate()
                                          .toString()))
                                      .format("yyyy/MM/dd"),

                                  english: streamSnapshot.data!.docs[index]
                                      ['englishLanguage'],
                                  experince: streamSnapshot.data!.docs[index]
                                      ['YearsofExperience'],
                                  JobTitle: streamSnapshot.data!.docs[index]
                                      ['JobTitle'],
                                  name: streamSnapshot.data!.docs[index]
                                      ['name'],
                                  TherapistAvatar: streamSnapshot
                                      .data!.docs[index]['TherapistAvatar'],
                                  onAccept: () {
                                    CollectionReference temp = FirebaseFirestore
                                        .instance
                                        .collection("Therapist");

                                    temp
                                        .doc(
                                            streamSnapshot.data!.docs[index].id)
                                        .update({"active": true});
//1
                                    MailManagement.sendEmail(
                                      recieverEmail: streamSnapshot
                                          .data!.docs[index]['email'],
                                      senderEmail: CenterInformation.email,
                                      senderName: CenterInformation.name,
                                      smtpServer: MailManagement().smtpServer,
                                      title: "طلب الانضمام -تطبيق بليغ",
                                      body:
                                          "   عزيزي/تي \n نشعرك بقبول طلبك بالانضمام للمركز عبر تطبيق بليغ\n \n \n  مع تمنياتنا لك بالتوفيق ",
                                    );
                                  },
                                  ///////////////////////
                                  onReject: () {
                                    showAlertDialogForReject(
                                        context: context,
                                        controller: _rejectMessageController,
                                        onClick: () {
                                          CollectionReference temp =
                                              FirebaseFirestore.instance
                                                  .collection("Therapist");
                                          temp
                                              .doc(streamSnapshot
                                                  .data!.docs[index].id)
                                              .delete();

                                          MailManagement.sendEmail(
                                            recieverEmail: streamSnapshot
                                                .data!.docs[index]['email'],
                                            senderEmail:
                                                CenterInformation.email,
                                            senderName: CenterInformation.name,
                                            smtpServer:
                                                MailManagement().smtpServer,
                                            title: "طلب الانضمام -تطبيق بليغ",
                                            body: _rejectMessageController.text,
                                          );
                                          _rejectMessageController.clear();
                                          Navigator.of(context).pop();
                                        });
                                  },
                                  ///////////////////////
                                  cardClick: () {
                                    showAlertDialog(
                                      arabic: streamSnapshot.data!.docs[index]
                                          ['arabicLanguage'],
                                      context: context,
                                      duration: streamSnapshot.data!.docs[index]
                                          ['duration'],
                                      email: streamSnapshot.data!.docs[index]
                                          ['email'],
                                      english: streamSnapshot.data!.docs[index]
                                          ['englishLanguage'],
                                      experience: streamSnapshot.data!
                                          .docs[index]['YearsofExperience'],
                                      inCenter: streamSnapshot.data!.docs[index]
                                          ['incenter'],
                                      JobTitle: streamSnapshot.data!.docs[index]
                                          ['JobTitle'],
                                      name: streamSnapshot.data!.docs[index]
                                          ['name'],
                                      TherapistAvatar: streamSnapshot
                                          .data!.docs[index]['TherapistAvatar'],
                                      onAccept: () async {
                                        CollectionReference temp =
                                            FirebaseFirestore.instance
                                                .collection("Therapist");

                                        await temp
                                            .doc(streamSnapshot
                                                .data!.docs[index].id)
                                            .update({"active": true});
//2
                                        MailManagement.sendEmail(
                                          recieverEmail: streamSnapshot
                                              .data!.docs[index]['email'],
                                          senderEmail: CenterInformation.email,
                                          senderName: CenterInformation.name,
                                          smtpServer:
                                              MailManagement().smtpServer,
                                          title: "طلب الانضمام -تطبيق بليغ",
                                          body:
                                              " عزيزي/تي \n نشعرك بقبول طلبك بالانضمام للمركز عبر تطبيق بليغ\n \n \n  مع تمنياتنا لك بالتوفيق ",
                                        );

                                        Navigator.of(context).pop();
                                      },
                                      ////////////////////////////
                                      onReject: () {
                                        showAlertDialogForReject(
                                            context: context,
                                            controller:
                                                _rejectMessageController,
                                            onClick: () async {
                                              CollectionReference temp =
                                                  FirebaseFirestore.instance
                                                      .collection("Therapist");

                                              await temp
                                                  .doc(streamSnapshot
                                                      .data!.docs[index].id)
                                                  .delete();
                                              MailManagement.sendEmail(
                                                recieverEmail: streamSnapshot
                                                    .data!.docs[index]['email'],
                                                senderEmail:
                                                    CenterInformation.email,
                                                senderName:
                                                    CenterInformation.name,
                                                smtpServer:
                                                    MailManagement().smtpServer,
                                                title:
                                                    "طلب الانضمام -تطبيق بليغ",
                                                body: _rejectMessageController
                                                    .text,
                                              );
                                              _rejectMessageController.clear();
                                              Navigator.of(context,
                                                      rootNavigator: true)
                                                  .pop();
                                              Navigator.of(context,
                                                      rootNavigator: true)
                                                  .pop();
                                            });
                                      },
                                      GeneralInfo: streamSnapshot
                                          .data!.docs[index]['GeneralInfo'],
                                    );
                                  },
                                );
                              }));
                        } else {
                          return const CircularProgressIndicator();
                        }
                      }),
                    )
                  ],
                ))
              ]),
        )),
      ),
    );
  }

//تعديل بيانات الأخصائي'
  Future<void> _update([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      _GeneralInfoController.text = documentSnapshot['GeneralInfo'];
      _JobTitleController.text = documentSnapshot['JobTitle'];
      _YearsofExperienceController.text = documentSnapshot['YearsofExperience'];
      _durationController.text = documentSnapshot['duration'];
      arabicLanguage = documentSnapshot['arabicLanguage'];
      englishLanguage = documentSnapshot['englishLanguage'];
      online = documentSnapshot['online'];
      incenter = documentSnapshot['incenter'];
    }
    await showModalBottomSheet(
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
        context: context,
        builder: (BuildContext ctx) {
          return StatefulBuilder(
            builder: (context, setState) {
              return Padding(
                padding: EdgeInsets.only(
                    top: 20,
                    left: 20,
                    right: 20,
                    bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'تعديل بيانات الأخصائي',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Color(0xff385a4a),
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const Text('المسمى الوظيفي'),
                      SizedBox(
                        height: 45,
                        child: TextField(
                          controller: _JobTitleController,
                          decoration: docfiled,
                        ),
                      ),
                      const Text('نبذة عامة عن الاخصائي'),
                      SizedBox(
                        height: 100,
                        width: 500,
                        child: TextField(
                          maxLines: null,
                          expands: true,
                          controller: _GeneralInfoController,
                          decoration: docfiled,
                        ),
                      ),
                      const SizedBox(height: 15),
                      const Text('مدة الجلسة'),
                      InputQty(
                        maxVal: 60,
                        minVal: 0,
                        initVal: int.parse(_durationController.text),
                        isIntrinsicWidth: false,
                        onQtyChanged: (val) {
                          _durationController.text = val.toString();
                          //  print(duration);
                        },
                      ),
                      const SizedBox(height: 15),
                      const Text('سنوات الخبرة'),
                      InputQty(
                        maxVal: 100,
                        minVal: 0,
                        initVal: int.parse(_YearsofExperienceController.text),
                        isIntrinsicWidth: false,
                        onQtyChanged: (val) {
                          _YearsofExperienceController.text = val.toString();
                          // print(YearsofExperience);
                        },
                      ),
                      const Text('اللغات'),
                      Row(
                        children: [
                          SizedBox(
                            child: Checkbox(
                                value: englishLanguage,
                                onChanged: (value) {
                                  setState(() {
                                    englishLanguage = value!;
                                  });
                                }),
                          ),
                          const Text('اللغة الانجليزية'),
                          Checkbox(
                              value: arabicLanguage,
                              onChanged: (value) {
                                setState(() {
                                  arabicLanguage = value!;
                                });
                              }),
                          const Text('اللغة العربية'),
                        ],
                      ),
                      const Text('تقديم الأستشارات'),
                      Row(
                        children: [
                          Checkbox(
                              value: online,
                              onChanged: (value) {
                                setState(() {
                                  online = value!;
                                });
                              }),
                          const Text('عن بعد'),
                          Checkbox(
                              value: incenter,
                              onChanged: (value) {
                                setState(() {
                                  incenter = value!;
                                });
                              }),
                          const Text('في المركز'),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff385a4a),
                            ),
                            onPressed: () async {
                              await _Therapist.doc(documentSnapshot!.id)
                                  .update({
                                "YearsofExperience":
                                    _YearsofExperienceController.text,
                                "GeneralInfo": _GeneralInfoController.text,
                                "JobTitle": _JobTitleController.text,
                                "duration": _durationController.text,
                                "arabicLanguage": arabicLanguage,
                                "englishLanguage": englishLanguage,
                                "online": online,
                                "incenter": incenter,
                              });
                              Navigator.of(context).pop();
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          'تم تعديل معلومات الأخصائي بنجاح')));
                            },
                            child: const Text('حفظ التغييرات'),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          );
        });
  }

  Future<void> _delete(String therapist) async {
    await _Therapist.doc(therapist).delete();

    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('تم حذف الأخصائي بنجاح')));
  }
}

//صفحه رفض الطلب
Future<void> showAlertDialogForReject({
  context,
  required TextEditingController controller,
  required onClick,
}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
          insetPadding: const EdgeInsets.all(0),
          backgroundColor: Colors.transparent,
          content: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            height: MediaQuery.of(context).size.height / 2,
            width: MediaQuery.of(context).size.width / 1.1,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30), color: Colors.white),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "رفض الطلب",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const Text(
                  "فضلا اذكر سبب رفض الاخصائي",
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                const SizedBox(
                  height: 10,
                ),
                Form(
                    child: Column(
                  children: [
                    TextFormField(
                      controller: controller,
                      maxLines: 10,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "ادخل السبب هنا",
                          filled: true,
                          fillColor: Colors.grey[100]),
                    )
                  ],
                )),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 45,
                      width: 120,
                      child: Material(
                        color: Colors.black87,
                        clipBehavior: Clip.antiAlias,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        child: MaterialButton(
                            splashColor: Colors.black,
                            onPressed: onClick,
                            child: const Text(
                              "ارسال",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            )),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ));
    },
  );
}
