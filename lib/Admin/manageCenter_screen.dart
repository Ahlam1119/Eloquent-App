import 'package:eloquentapp/widget/label.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MCenter extends StatefulWidget {
  static String id = 'MCenter_screen';

  @override
  State<MCenter> createState() => _MCenterState();
}

class _MCenterState extends State<MCenter> {
  final _auth = FirebaseAuth.instance;
  late String centerID;
  late String name;
  late String phone;
  late String email;
  late String location;
  late String pass;
  late String GeneralInfo;

  //step one for streem bulider
  final CollectionReference _center =
      FirebaseFirestore.instance.collection('center');
  AddData({
    required String centerID,
    required String name,
    required String phone,
    required String email,
    required String location,
    required String pass,
    required String GeneralInfo,
  }) async {
    final DocumentReference<Map<String, dynamic>> userRef =
        FirebaseFirestore.instance.collection('center').doc();

    await userRef.set({
      'uid': centerID,
      'name': name,
      'phone': phone,
      'location': location,
      'email': email,
      'password': pass,
      'GeneralInfo': GeneralInfo,
    });
  }

//update
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

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
                    const Text(
                      'إدارة المركز',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          color: Color(0xff385a4a),
                          fontSize: 25,
                          //fontFamily: "Cairo",
                          fontWeight: FontWeight.w700),
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
                const Text(
                  textAlign: TextAlign.right,
                  'تعرض هذه القائمة \n جميع المراكز في بليغ ',
                  style: TextStyle(
                    color: Color(0xff9bb0a5),
                    fontWeight: FontWeight.w800,
                    fontSize: 15,
                  ),
                ),
                SizedBox(
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
                              "قائمة المراكز",
                              style: textStyle,
                            ),
                          ),
                          Tab(
                            child: Text(
                              "اضافة مركز",
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
                      stream: _center.snapshots(),
                      builder: (context,
                          AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                        if (streamSnapshot.hasData) {
                          return ListView.builder(
                            itemCount: streamSnapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              final DocumentSnapshot documentSnapshot =
                                  streamSnapshot.data!.docs[index];
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
                                                child: Image.asset(
                                                  'images/Mcenter.png',
                                                  height: 25,
                                                ),
                                                backgroundColor:
                                                    Color(0xffEFF5F2),
                                                foregroundColor:
                                                    Color(0xffEFF5F2),
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
                                                  Text(
                                                    documentSnapshot[
                                                        'GeneralInfo'],
                                                    textAlign: TextAlign.right,
                                                    style: TextStyle(
                                                      color: Color(0xff385a4a),
                                                      fontSize: 13,
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons.location_on,
                                                        size: 17,
                                                      ),
                                                      SizedBox(width: 3),
                                                      Text(
                                                        documentSnapshot[
                                                            'location'],
                                                        textAlign:
                                                            TextAlign.right,
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xff385a4a),
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                    ],
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
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(11)),
                          color: Color.fromRGBO(155, 176, 165, 0.09),
                        ),
                        padding: EdgeInsets.all(15),
                        alignment: Alignment.topRight,
                        margin: EdgeInsets.only(top: 15),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text('اسم المركز'),
                              SizedBox(
                                height: 45,
                                child: TextField(
                                  onChanged: (value) {
                                    name = value;
                                  },
                                  //controller: nameController,
                                  decoration: docfiled,
                                ),
                              ),
                              SizedBox(height: 15),
                              Text('رقم المركز'),
                              SizedBox(
                                height: 65,
                                child: TextField(
                                  onChanged: (value) {
                                    phone = value;
                                  },
                                  keyboardType: TextInputType.number,
                                  maxLength: 10,
                                  //controller: nameController,
                                  decoration: docfiled,
                                ),
                              ),
                              Text('البريد الإلكتروني'),
                              SizedBox(
                                height: 45,
                                child: TextField(
                                  onChanged: (value) {
                                    email = value;
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                  //controller: nameController,
                                  decoration: docfiled,
                                ),
                              ),
                              SizedBox(height: 15),
                              Text('المدينة'),
                              SizedBox(
                                height: 45,
                                child: TextField(
                                  onChanged: (value) {
                                    location = value;
                                  },
                                  decoration: docfiled,
                                ),
                              ),
                              const SizedBox(height: 10),
                              const Text(' نبذة عامة عن المركز'),
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
                              SizedBox(height: 15),
                              Text('كلمة المرور'),
                              SizedBox(
                                height: 45,
                                child: TextField(
                                  onChanged: (value) {
                                    pass = value;
                                  },
                                  obscureText: true,
                                  //controller: nameController,
                                  decoration: docfiled,
                                ),
                              ),
                              SizedBox(height: 20),
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
                                              centerID: newU.user!.uid,
                                              name: name,
                                              phone: phone,
                                              location: location,
                                              email: email,
                                              pass: pass,
                                              GeneralInfo: GeneralInfo,
                                            );
                                          }
                                          _showSuccessDialog(
                                              'تمت اضافة المركز بنجاح');
                                        } catch (e) {
                                          print(e);
                                        }
                                      },
                                      child: Text('إضافة المركز'),
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

  Future<void> _update([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      _nameController.text = documentSnapshot['name'];
      _passController.text = documentSnapshot['password'];
      _phoneController.text = documentSnapshot['phone'];
      _locationController.text = documentSnapshot['location'];
      _emailController.text = documentSnapshot['email'];
    }

    await showModalBottomSheet(
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'تعديل بيانات المركز',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Color(0xff385a4a),
                    fontSize: 20,
                    //fontFamily: "Cairo",
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text('اسم المركز'),
                SizedBox(
                  height: 45,
                  child: TextField(
                    controller: _nameController,
                    decoration: docfiled,
                  ),
                ),
                Text('رقم المركز'),
                SizedBox(
                  height: 65,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    maxLength: 10,
                    controller: _phoneController,
                    decoration: docfiled,
                  ),
                ),
                Text('البريد الإلكتروني'),
                SizedBox(
                  height: 45,
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                    decoration: docfiled,
                  ),
                ),
                Text('المدينة'),
                SizedBox(
                  height: 45,
                  child: TextField(
                    controller: _locationController,
                    decoration: docfiled,
                  ),
                ),
                Text('كلمة المرور'),
                SizedBox(
                  height: 45,
                  child: TextField(
                    obscureText: true,
                    controller: _passController,
                    decoration: docfiled,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      child: Text('حفظ التغييرات'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff385a4a),
                      ),
                      onPressed: () async {
                        final String name = _nameController.text;
                        final String phone = _phoneController.text;
                        final String email = _emailController.text;
                        final String location = _locationController.text;
                        final String pass = _passController.text;

                        if (name != null) {
                          await _center.doc(documentSnapshot!.id).update({
                            "name": name,
                            "phone": phone,
                            "email": email,
                            "location": location,
                            "pass": pass,
                          });

                          _nameController.text = '';
                          _phoneController.text = '';
                          _passController.text = '';
                          _emailController.text = '';
                          _locationController.text = '';

                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text('تم تعديل معلومات المركز بنجاح')));
                        }
                      },
                    ),
                  ],
                )
              ],
            ),
          );
        });
  }

  Future<void> _delete(String center) async {
    await _center.doc(center).delete();

    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('تم حذف المركز بنجاح')));
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
}
