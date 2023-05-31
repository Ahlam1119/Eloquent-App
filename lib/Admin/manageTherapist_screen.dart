import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:eloquentapp/widget/label.dart';
import 'package:eloquentapp/widget/drop_down_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:input_quantity/input_quantity.dart';
import 'package:eloquentapp/center/center_information.dart';

class MTherapist extends StatefulWidget {
  static String id = 'MTherapist_screen';

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
  late String JobTitle;
  late String YearsofExperience;
  late String GeneralInfo;
  late String duration;
  var active = true;
  var arabicLanguage = false;
  var englishLanguage = false;
  var incenter = false;
  var online = false;
  late String TherapistAvatar = '';

  //step one for streem bulider
  final CollectionReference _Therapist =
      FirebaseFirestore.instance.collection('Therapist');
  AddData({
    required String TheapistID,
    required String name,
    required String email,
    required String pass,
    required String phone,
    required String JobTitle,
    required String YearsofExperience,
    required String GeneralInfo,
    required String duration,
    required var arabicLanguage,
    required var englishLanguage,
    required var incenter,
    required var online,
    required String? centerid,
    required bool active,
    required String TherapistAvatar,
    required String centerName,
  }) async {
    final DocumentReference<Map<String, dynamic>> userRef =
        FirebaseFirestore.instance.collection('Therapist').doc(TheapistID);

    await userRef.set({
      'uid': TheapistID,
      'name': name,
      'email': email,
      'password': pass,
      'phone': phone,
      'JobTitle': JobTitle,
      'YearsofExperience': YearsofExperience,
      'duration': duration,
      'GeneralInfo': GeneralInfo,
      'arabicLanguage': arabicLanguage,
      'englishLanguage': englishLanguage,
      'online': online,
      'incenter': incenter,
      'active': true,
      "centerid": centerid,
      "centerName": centerName,
      'TherapistAvatar': TherapistAvatar
    });
  }

  getCenterID() async {
    QuerySnapshot<Map<String, dynamic>> temp = await FirebaseFirestore.instance
        .collection("center")
        .where("name", isEqualTo: dropname.text)
        .get();

    final String centerUID = temp.docs[0]["uid"];
  }

// الدروب داون ليست
  TextEditingController dropname = TextEditingController();
  TextEditingController dropid = TextEditingController();
  List<SelectedListItem> data = [];
  getCenterNames() async {
    QuerySnapshot<Map<String, dynamic>> center =
        await FirebaseFirestore.instance.collection("center").get();
    for (var element in center.docs) {
      data.add(SelectedListItem(name: element['name'], value: element.id));
    }
  }

  @override
  void initState() {
    getCenterNames();
    super.initState();
  }

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _JobTitleController = TextEditingController();
  final TextEditingController _YearsofExperienceController =
      TextEditingController();
  final TextEditingController _durationController = TextEditingController();
  late TextEditingController _arabicLanguageController =
      TextEditingController();
  TextEditingController _englishLanguageController = TextEditingController();
  TextEditingController _onlineController = TextEditingController();
  TextEditingController _incenterController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var textStyle = TextStyle(fontSize: 13, fontWeight: FontWeight.w700);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: SafeArea(
            child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'إدارة الأخصائيين',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Color(0xff385a4a),
                        fontSize: 25,
                        //fontFamily: "Cairo",
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.arrow_forward_ios_outlined,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
                Text(
                  textAlign: TextAlign.right,
                  'تعرض هذه القائمة \n جميع الأخصائيين في بليغ ',
                  style: TextStyle(
                    color: Color(0xff9bb0a5),
                    fontSize: 15,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                //هيكل التاب بار ولازم يكون بالترتيب مع الجزء الثاني
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
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
                            ),
                          ),
                          Tab(
                            child: Text(
                              "اضافة أخصائي",
                              style: textStyle,
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
                      stream: _Therapist.snapshots(),
                      builder: (context,
                          AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                        if (streamSnapshot.hasData) {
                          return ListView.builder(
                            itemCount: streamSnapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              final DocumentSnapshot documentSnapshot =
                                  streamSnapshot.data!.docs[index];

                              String therpistAvatar =
                                  documentSnapshot['TherapistAvatar'];
                              return Padding(
                                padding: EdgeInsets.symmetric(vertical: 5),
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
                                                  SizedBox(
                                                    height: 5,
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
                                                _update(documentSnapshot);
                                              },
                                            ),
                                            SizedBox(width: 1),
                                            IconButton(
                                              icon: Icon(
                                                Icons.delete,
                                                color: Colors.red,
                                              ),
                                              onPressed: () {
                                                _delete(documentSnapshot.id);
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
                              const Text('الأسم '),
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
                              const Text('البريد الإلكتروني'),
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
                              const Text('كلمة المرور'),
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
                              const Text('رقم الجوال'),
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
                              const Text('المسمى الوظيفي '),
                              SizedBox(
                                height: 45,
                                child: TextField(
                                  onChanged: (value) {
                                    JobTitle = value;
                                  },
                                  decoration: docfiled,
                                ),
                              ),
                              const Text(' نبذة عامة عن الاخصائي'),
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
                              const Align(
                                  alignment: Alignment.centerRight,
                                  child: Text('اختر المركز الخاص بالأخصائي')),
                              SizedBox(
                                  height: 45,
                                  child: DropDownList(
                                    title: "المراكز",
                                    data: data,
                                    id: dropid,
                                    name: dropname,
                                  )),
                              const SizedBox(height: 10),
                              const Text('سنوات الخبرة'),
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
                              const Text('مدة الجلسة'),
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
                              const Text('اللغات'),
                              Row(
                                children: [
                                  const Text('اللغة العربية'),
                                  Checkbox(
                                      value: englishLanguage,
                                      onChanged: (value) {
                                        setState(() {
                                          englishLanguage = value!;
                                        });
                                      }),
                                  const Spacer(),
                                  const Text('اللغة الانجليزية'),
                                  Checkbox(
                                      value: arabicLanguage,
                                      onChanged: (value) {
                                        setState(() {
                                          arabicLanguage = value!;
                                        });
                                      }),
                                  // const Text('اللغة العربية'),
                                ],
                              ),
                              const SizedBox(height: 10),
                              const Text('تقديم الأستشارات'),
                              Row(
                                children: [
                                  const Text('في المركز'),
                                  Checkbox(
                                      value: online,
                                      onChanged: (value) {
                                        setState(() {
                                          online = value!;
                                        });
                                      }),
                                  const Spacer(),
                                  const Text('عن بعد'),
                                  Checkbox(
                                      value: incenter,
                                      onChanged: (value) {
                                        setState(() {
                                          incenter = value!;
                                        });
                                      }),
                                  //const Text('في المركز'),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                      onPressed: () async {
                                        try {
                                          QuerySnapshot<Map<String, dynamic>>
                                              temp = await FirebaseFirestore
                                                  .instance
                                                  .collection("center")
                                                  .where("name",
                                                      isEqualTo: dropname.text)
                                                  .get();

                                          final String centerUID =
                                              temp.docs[0]["uid"];
                                          //
                                          final UserCredential newU = await _auth
                                              .createUserWithEmailAndPassword(
                                                  email: email, password: pass);
                                          if (newU.user == null) {
                                            print("not found");
                                          } else {
                                            AddData(
                                                centerid: centerUID,
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
                                                active: active,
                                                arabicLanguage: arabicLanguage,
                                                englishLanguage:
                                                    englishLanguage,
                                                incenter: incenter,
                                                centerName: dropname.text,
                                                TherapistAvatar:
                                                    TherapistAvatar);
                                          }
                                          _showSuccessDialog(
                                              'تمت اضافة الأخصائي بنجاح');
                                        } catch (e) {
                                          print(e);
                                        }
                                      },
                                      child: Text('إضافة أخصائي'),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Color(0xff385a4a),
                                      ))
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
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

  Future<void> _delete(String center) async {
    await _Therapist.doc(center).delete();

    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('تم حذف الأخصائي بنجاح')));
  }

  void _showSuccessDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Image.asset(
            'images/True.png',
            height: 70,
          ),
          content: Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(fontFamily: 'Cairo', fontSize: 16),
          ),
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
}
