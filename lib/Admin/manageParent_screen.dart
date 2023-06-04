import 'package:eloquentapp/widget/label.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:input_quantity/input_quantity.dart';

class MParent extends StatefulWidget {
  static String id = 'MParent_screen';

  @override
  State<MParent> createState() => _MParentState();
}

class _MParentState extends State<MParent> {
  final _auth = FirebaseAuth.instance;
  late String name;
  late String email;
  late String pass;
  late String phone;
  late String ParentAvatar = '';
  //step one for streem bulider
  final CollectionReference _Parent =
      FirebaseFirestore.instance.collection('Parent');
  final CollectionReference _Child =
      FirebaseFirestore.instance.collection('Child');
  AddData({
    required String ParentID,
    required String name,
    required String email,
    required String pass,
    required String phone,
    required String ParentAvatar,
  }) async {
    final DocumentReference<Map<String, dynamic>> userRef =
        FirebaseFirestore.instance.collection('Parent').doc();

    await userRef.set({
      "ParentAvatar": ParentAvatar,
      'uid': ParentID,
      'name': name,
      'email': email,
      'password': pass,
      'phone': phone,
    });
  }

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  // Get children names for parent with specified uid
  Future<List<String>> _getChildrenNames(String uid) async {
    final QuerySnapshot<Map<String, dynamic>> childrenSnapshot =
        await FirebaseFirestore.instance
            .collection('Child')
            .where('uidParent', isEqualTo: uid)
            .get();

    final List<String> childrenNames = [];

    for (final DocumentSnapshot childSnapshot in childrenSnapshot.docs) {
      final String childName = childSnapshot['name'];
      childrenNames.add(childName);
    }

    return childrenNames;
  }

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
                      'إدارة الأهل',
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
                Text(
                  textAlign: TextAlign.right,
                  'تعرض هذه القائمة \n جميع الأهالي المسجلين في بليغ ',
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
                              "قائمة الأهل",
                              style: textStyle,
                            ),
                          ),
                          Tab(
                            child: Text(
                              "اضافة الأهل",
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
                      stream: _Parent.snapshots(),
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
                                                backgroundColor:
                                                    Color(0xffEFF5F2),
                                                foregroundColor:
                                                    Color(0xffEFF5F2),
                                                backgroundImage: AssetImage(
                                                    documentSnapshot[
                                                        'ParentAvatar']),
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
                                                        color:
                                                            Color(0xff6888a0),
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  SizedBox(height: 8),
                                                  StreamBuilder<QuerySnapshot>(
                                                    stream: FirebaseFirestore
                                                        .instance
                                                        .collection('Child')
                                                        .where('uidParent',
                                                            isEqualTo:
                                                                documentSnapshot
                                                                    .id)
                                                        .snapshots(),
                                                    builder:
                                                        (context, snapshot) {
                                                      if (snapshot.hasData) {
                                                        final List<
                                                                DocumentSnapshot>
                                                            childrenDocuments =
                                                            snapshot.data!.docs;
                                                        return Column(
                                                          children: [
                                                            for (final DocumentSnapshot childDocument
                                                                in childrenDocuments)
                                                              Row(
                                                                children: [
                                                                  Icon(
                                                                    Icons
                                                                        .child_care,
                                                                    size: 18,
                                                                  ),
                                                                  SizedBox(
                                                                      width: 2),
                                                                  Text(
                                                                    childDocument[
                                                                        'name'],
                                                                    style:
                                                                        TextStyle(
                                                                      color: Color(
                                                                          0xff687c71),
                                                                      fontSize:
                                                                          13,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                          ],
                                                        );
                                                      } else {
                                                        return SizedBox();
                                                      }
                                                    },
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
                              Center(
                                child: Align(
                                  alignment: Alignment.topCenter,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            ParentAvatar = "images/Mother.png";
                                          });
                                          setState(() {
                                            print(ParentAvatar);
                                          });
                                        },
                                        child: Transform.scale(
                                          scale: ParentAvatar ==
                                                  "images/Mother.png"
                                              ? 1.3
                                              : 1.0,
                                          child: Image.asset(
                                            "images/Mother.png",
                                            width: 80,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 25,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            ParentAvatar = "images/Father.png";
                                          });
                                          setState(() {
                                            print(ParentAvatar);
                                          });
                                        },
                                        child: Transform.scale(
                                          scale: ParentAvatar ==
                                                  "images/Father.png"
                                              ? 1.3
                                              : 1.0,
                                          child: Image.asset(
                                            "images/Father.png",
                                            width: 80,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Text('الأسم '),
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
                              SizedBox(height: 10),
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
                              SizedBox(height: 15),
                              Text('رقم الجوال'),
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
                              SizedBox(height: 15),
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
                                                ParentID: newU.user!.uid,
                                                name: name,
                                                phone: phone,
                                                email: email,
                                                pass: pass,
                                                ParentAvatar: ParentAvatar);
                                          }
                                          _showSuccessDialog(
                                              'تمت اضافةالحساب بنجاح');
                                        } catch (e) {
                                          print(e);
                                        }
                                      },
                                      child: Text('إضافة حساب'),
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
                  'تعديل بيانات الأهل',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Color(0xff385a4a),
                    fontSize: 20,
                    //fontFamily: "Cairo",
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text('الاسم'),
                SizedBox(
                  height: 45,
                  child: TextField(
                    controller: _nameController,
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
                Text('كلمة المرور'),
                SizedBox(
                  height: 45,
                  child: TextField(
                    obscureText: true,
                    controller: _passController,
                    decoration: docfiled,
                  ),
                ),
                Text('رقم الجوال'),
                SizedBox(
                  height: 65,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    maxLength: 10,
                    controller: _phoneController,
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
                        final String pass = _passController.text;

                        if (name != null) {
                          await _Parent.doc(documentSnapshot!.id).update({
                            "name": name,
                            "phone": phone,
                            "email": email,
                            "pass": pass,
                          });
                          _nameController.text = '';
                          _phoneController.text = '';
                          _passController.text = '';
                          _emailController.text = '';

                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text('تم تعديل معلومات الحساب بنجاح')));
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

  Future<void> _delete(String uidParent) async {
    WriteBatch batch = FirebaseFirestore.instance.batch();

    // حذف حساب الأم
    batch.delete(_Parent.doc(uidParent));

    // الحصول على جميع حسابات الأطفال وحذفها
    QuerySnapshot childSnapshot =
        await _Child.where('uidParent', isEqualTo: uidParent).get();
    childSnapshot.docs.forEach((doc) {
      batch.delete(doc.reference);
    });

    // تنفيذ دفعة الحذف
    await batch.commit();
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('تم حذف الحساب بنجاح')));
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
