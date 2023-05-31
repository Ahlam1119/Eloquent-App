import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eloquentapp/Child/ConfirmParent.dart';
import 'package:eloquentapp/Child/Page/Home.dart';
import 'package:eloquentapp/parents/Pages/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChildWelcome extends StatefulWidget {
  // late String ParentID;

  @override
  State<ChildWelcome> createState() => _ChildWelcomeState();
}

class _ChildWelcomeState extends State<ChildWelcome> {
  // late String ParentID = widget.ParentID;
  late User singedInUser;

  Future<String?> getChildData() async {
    return await FirebaseFirestore.instance
        .collection('Child')
        .where("uidParent", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((v) {
      if (v.size == 0) return null;
      return v.docs.first['uid'];
    });
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    getUserData();
    getChildData();
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
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

  // Map<String, dynamic> ChildInfo = {};

  // getChildInfo2() async {
  // await FirebaseFirestore.instance
  // .collection('Child')
  // .where("uidParent", isEqualTo: singedInUser.uid)
  // .get()
  // .then((v) {
  // for (var element in v.docs) {
  // ChildInfo.addAll(element.data());
  // setState(() {
  // isLoded = false;
  // });
  // }
  // });
  // }

  // late String ChildAvatar = ChildInfo['ChildAvatar'];
  Map<String, dynamic> ParentInfo = {};
  bool isLoded = true;
  getUserData() async {
    await FirebaseFirestore.instance
        .collection('Parent')
        .where("uid", isEqualTo: singedInUser.uid)
        .get()
        .then((v) {
      for (var element in v.docs) {
        ParentInfo.addAll(element.data());
        setState(() {
          isLoded = false;
        });
      }
    });
  }

//ايرور
  late String ParentAvatar = ParentInfo['ParentAvatar'];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: isLoded == true
          ? Center(child: CircularProgressIndicator())
          : Scaffold(
              backgroundColor: Color(0xffF5F5F5),
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Color(0xffF5F5F5),
                leading: Container(
                    child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ConfairmParent(),
                        ));
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Image.asset(ParentAvatar),
                    radius: 20,
                  ),
                )),
              ),
              body: SafeArea(
                child: FutureBuilder<String?>(
                  future: getChildData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting)
                      return const Center(child: CircularProgressIndicator());
                    if (snapshot.data == null)
                      return const Center(child: Text('لايوجد حساب طفل!'));
                    return FutureBuilder<DocumentSnapshot>(
                      future: FirebaseFirestore.instance
                          .collection('Child')
                          .doc(snapshot
                              .data!) // use the uid returned by getChildData()
                          .get(),
                      builder: (context, snapshot2) {
                        if (snapshot2.connectionState ==
                            ConnectionState.waiting)
                          return const Center(
                              child: CircularProgressIndicator());
                        if (!snapshot2.hasData)
                          return const Center(
                              child: CircularProgressIndicator());
                        if (snapshot2.data == null)
                          return const Center(
                              child: CircularProgressIndicator());
                        // Use the data returned by the second FutureBuilder to build the UI
                        String childImageUrl = snapshot2.data!['ChildAvatar'];
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ChildScreen(
                                            childId: snapshot.data!,
                                            page: 'ChildHomePgae'),
                                      ));
                                },
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  child: Image.asset(
                                    childImageUrl, // use the childImageUrl retrieved from Firestore
                                  ),
                                  radius: 100,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            ),
    );
  }
}
