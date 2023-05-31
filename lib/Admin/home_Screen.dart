import 'package:eloquentapp/Admin/manageCenter_screen.dart';
import 'package:eloquentapp/Admin/manageParent_screen.dart';
import 'package:eloquentapp/Admin/manageTherapist_screen.dart';
import 'package:eloquentapp/Admin/supportAndHelp.dart';
import 'package:eloquentapp/widget/AdminContinerStyle.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatefulWidget {
  static String id = 'HomeScreen_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _auth = FirebaseAuth.instance;

  late User singedInUser;

  @override
  void initState() {
    super.initState();
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
      print(singedInUser.uid);
    }
  }

  Map<String, dynamic> adminData = {};
  bool isLoded = true;
  //get all user data and store to Map
  getUserData() async {
    await FirebaseFirestore.instance
        .collection('admin')
        .where("uid", isEqualTo: singedInUser.uid)
        .get()
        .then((v) {
      for (var element in v.docs) {
        adminData.addAll(element.data());

        setState(() {
          isLoded = false;
        });
      }
    });
  }

  late String Name = adminData['name'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: isLoded == true
            ? Center(child: CircularProgressIndicator())
            : SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'أهلا ' + Name,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              color: Color(0xff385a4a),
                              fontSize: 30,
                              //fontFamily: "Cairo",
                              fontWeight: FontWeight.w700),
                        ),
                        Text(
                          "الآن يمكنك إدارة النظام \n وحسابات المستخدمين بكل سهولة",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              color: Color(0xff687c71),
                              fontSize: 15,
                              //fontFamily: "Cairo",
                              fontWeight: FontWeight.w800),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // center
                            ElevatedButton(
                              style: adminButton,
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MCenter(),
                                    ));
                              },
                              child: Row(
                                children: [
                                  Image.asset(
                                    'images/Mcenter.png',
                                    height: 25,
                                  ),
                                  SizedBox(
                                    width: 12,
                                  ),
                                  Text(
                                    "إدارة المركز",
                                    style: TextStyle(
                                        color: Color(0xff385a4a),
                                        fontSize: 23,
                                        //fontFamily: "Cairo",
                                        fontWeight: FontWeight.w800),
                                  ),
                                  SizedBox(
                                    width: 95,
                                  ),
                                  Icon(
                                    Icons.arrow_back_ios_new,
                                    color: Color(0xff385a4a),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            // therapist
                            ElevatedButton(
                              style: adminButton,
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MTherapist(),
                                    ));
                              },
                              child: Row(
                                children: [
                                  Image.asset(
                                    'images/Mtherapist.png',
                                    height: 25,
                                  ),
                                  SizedBox(
                                    width: 12,
                                  ),
                                  Text(
                                    "إدارة الأخصائيين",
                                    style: TextStyle(
                                        color: Color(0xff385a4a),
                                        fontSize: 23,
                                        //fontFamily: "Cairo",
                                        fontWeight: FontWeight.w800),
                                  ),
                                  SizedBox(
                                    width: 45,
                                  ),
                                  Icon(
                                    Icons.arrow_back_ios_new,
                                    color: Color(0xff385a4a),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            // parent
                            ElevatedButton(
                              style: adminButton,
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MParent(),
                                    ));
                              },
                              child: Row(
                                children: [
                                  Image.asset(
                                    'images/Mparent.png',
                                    height: 25,
                                  ),
                                  SizedBox(
                                    width: 12,
                                  ),
                                  Text(
                                    "إدارة الأهل",
                                    style: TextStyle(
                                        color: Color(0xff385a4a),
                                        fontSize: 23,
                                        //fontFamily: "Cairo",
                                        fontWeight: FontWeight.w800),
                                  ),
                                  SizedBox(
                                    width: 100,
                                  ),
                                  Icon(
                                    Icons.arrow_back_ios_new,
                                    color: Color(0xff385a4a),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            ElevatedButton(
                              style: adminButton,
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => supportAndHelp(),
                                    ));
                              },
                              child: Row(
                                children: [
                                  Image.asset(
                                    'images/support.png',
                                    height: 20,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    " الصيانة والدعم  ",
                                    style: TextStyle(
                                        color: Color(0xff385a4a),
                                        fontSize: 25,
                                        //fontFamily: "Cairo",
                                        fontWeight: FontWeight.w800),
                                  ),
                                  Spacer(),
                                  Icon(
                                    Icons.arrow_back_ios_new,
                                    color: Color(0xff385a4a),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            // exercise
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ));
  }
}
