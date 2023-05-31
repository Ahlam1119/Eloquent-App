import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eloquentapp/parents/Pages/ParentProfile/Parent_Sceduled_Session/CanseldSession.dart';
import 'package:eloquentapp/parents/Pages/ParentProfile/Parent_Sceduled_Session/Help&Support.dart';
import 'package:eloquentapp/parents/Pages/ParentProfile/Parent_Sceduled_Session/RejectSession.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RejectCanceldSession extends StatefulWidget {
  @override
  State<RejectCanceldSession> createState() => _RejectCanceldSessionState();
}

class _RejectCanceldSessionState extends State<RejectCanceldSession> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  // List<QueryDocumentSnapshot> _rejectSessions = [];
  @override
  Widget build(BuildContext context) {
    var textStyle = TextStyle(fontSize: 11.6, fontWeight: FontWeight.w700);

    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            backgroundColor: Color.fromARGB(255, 246, 248, 248),
            title: Padding(
              padding: const EdgeInsets.only(left: 19, top: 30, bottom: 10),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "إدارة الجلسات",
                  style: TextStyle(
                    color: Color(0xff385a4a),
                    fontSize: 25,
                    fontFamily: "Cairo",
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.chevron_right, size: 32.0),
                color: Colors.black,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          body: Padding(
              padding: EdgeInsets.only(top: 25, right: 10, left: 10),
              child: Column(children: [
                Container(
                  height: 45,
                  decoration: BoxDecoration(
                      color: Color(0xff9bb0a5),
                      borderRadius: BorderRadius.circular(16)),
                  child: TabBar(
                    indicator: BoxDecoration(
                      color: Color(0xff385a4a),
                      borderRadius: BorderRadius.circular(11),
                    ),
                    labelColor: Colors.white,
                    tabs: [
                      Tab(
                        child: Text(
                          "الجلسات المرفوضة",
                          style: textStyle,
                        ),
                      ),
                      Tab(
                        child: Text(
                          "الطلبات الملغية",
                          style: textStyle,
                        ),
                      ),
                      Tab(
                        child: Text(
                          "المساعدة والدعم",
                          style: textStyle,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Expanded(
                    child: TabBarView(
                      children: [
                        RejectSessionsScreen(),
                        CanceldSessionsScreen(),
                        MHelpSupport()
                      ],
                    ),
                  ),
                )
              ])),
        ));
  }
}
