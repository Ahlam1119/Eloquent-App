import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'center_information.dart';
import 'chart/barGrapgh.dart';
import 'chart/functionChart.dart';

class CenterHomeScreen extends StatefulWidget {
  static String id = 'HomeScreen_screen';
  const CenterHomeScreen({super.key});
  @override
  State<CenterHomeScreen> createState() => _CenterHomeScreenState();
}

class _CenterHomeScreenState extends State<CenterHomeScreen> {
  int therapistCount = 0;
  int ChildrenCount = 0;
  final _auth = FirebaseAuth.instance;
  late FirebaseAuth _firebaseAuth;
  String? mostActiveTherapist;

  // late User singedInUser;
  User? singedInUser;
  @override
  void initState() {
    super.initState();
    getUserData();
    _getTherapistCount();
    getMostActiveTherapist();
    initchart();
    //initchartt();
    _getChildrenCount();
  }

  Map<String, dynamic> centerData = {};
  bool isLoded = true;

  getUserData() async {
    await FirebaseFirestore.instance
        .collection('center')
        .where("uid", isEqualTo: CenterInformation.uid)
        .get()
        .then((v) {
      for (var element in v.docs) {
        centerData.addAll(element.data());
        setState(() {
          isLoded = false;
        });
      }
    });
  }

  void _getTherapistCount() async {
    QuerySnapshot centerSnapshot = await FirebaseFirestore.instance
        .collection('center')
        .where('email', isEqualTo: CenterInformation.email)
        .get();

    if (centerSnapshot.docs.isEmpty) {
      return;
    }

    String uid = centerSnapshot.docs.first.get('uid');
    QuerySnapshot therapistSnapshot = await FirebaseFirestore.instance
        .collection('Therapist')
        .where('centerid', isEqualTo: uid)
        .where("active", isEqualTo: true)
        .get();

    setState(() {
      therapistCount = therapistSnapshot.docs.length;
    });
  }

  Future<void> getMostActiveTherapist() async {
    QuerySnapshot centerSnapshot = await FirebaseFirestore.instance
        .collection('center')
        .where('email', isEqualTo: CenterInformation.email)
        .get();

    if (centerSnapshot.docs.isEmpty) {
      return;
    }

    String uid = centerSnapshot.docs.first.get('uid');
    final CollectionReference acceptedSessionsCollection =
        FirebaseFirestore.instance.collection('acceptedSessions');
    QuerySnapshot attendedSessions = await acceptedSessionsCollection
        .where('centerid', isEqualTo: uid)
        .where('TherapistStatus', isEqualTo: 'attandend')
        .get();
    Map<String, int> therapistSessions = {};
    attendedSessions.docs.forEach((doc) {
      String therapistName = doc.get("TherapistName");
      therapistSessions[therapistName] =
          therapistSessions.containsKey(therapistName)
              ? therapistSessions[therapistName]! + 1
              : 1;
    });
    String? mostActiveTherapist;
    int maxSessions = 0;
    therapistSessions.forEach((therapistName, sessionsAttended) {
      if (sessionsAttended > maxSessions) {
        maxSessions = sessionsAttended;
        mostActiveTherapist = therapistName;
      }
    });
    setState(() {
      this.mostActiveTherapist = mostActiveTherapist;
    });
  }

  void _getChildrenCount() async {
    QuerySnapshot childrenSnapshot = await FirebaseFirestore.instance
        .collection('acceptedSessions')
        .where('centerid', isEqualTo: CenterInformation.uid)
        .get();

    setState(() {
      // تخزين الـ  في مجموعة لمنع التكرارات
      Set<String> childIds = Set<String>();
      for (var doc in childrenSnapshot.docs) {
        childIds.add(doc.get('ChildID'));
      }

      // حساب عدد الأطفال بدون تكرار الـ
      ChildrenCount = childIds.fold(0, (count, id) => count + 1);
    });
  }

  late String Name = centerData['name'];
  List<double> weeklySummary = [0, 0, 0, 0, 0, 0, 0];
  int choose = 0;
  bool isLoadingChart = false;

  Future<void> _showDialog(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          children: <Widget>[
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, 0);
              },
              child: const Text("هذا الأسبوع"),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, 1);
              },
              child: const Text("الأسبوع الماضي"),
            ),
          ],
        );
      },
    ).then((value) {
      if (value != null) {
        setState(() {
          choose = value;
          setState(() {
            isLoadingChart = true;
          });
          getsummary(choose);
        });
      }
    });
  }

  getsummary(int choose) async {
    if (choose == 0) {
      weeklySummary = await ChartFunctions.takeSummaryThisWeek(
          FirebaseAuth.instance.currentUser!.uid);
      setState(() {
        isLoadingChart = false;
      });
    } else {
      weeklySummary = await ChartFunctions.takeSummaryPastWeek(
          FirebaseAuth.instance.currentUser!.uid);
      setState(() {
        isLoadingChart = false;
      });
    }
  }

  initchart() async {
    weeklySummary = await ChartFunctions.takeSummaryThisWeek(
        FirebaseAuth.instance.currentUser!.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoded == true
          ? const Center(child: CircularProgressIndicator())
          : SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'أهلًا، $Name',
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                            color: Color(0xff385a4a),
                            fontSize: 30,
                            fontFamily: "Cairo",
                            fontWeight: FontWeight.w700),
                      ),
                      const Text(
                        "الآن مع بليغ يمكنك الإطلاع \n على جميع أنشطة المركز وإدارة الأخصائيين",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            color: Color(0xff687c71),
                            fontSize: 15,
                            fontFamily: "Cairo",
                            fontWeight: FontWeight.w800),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: 90,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 15),
                                          child: CircleAvatar(
                                            radius: 30,
                                            backgroundColor: Colors.grey[300],
                                            child: const Icon(
                                              Icons.child_care,
                                              color: Color(0xff385a4a),
                                              size: 35,
                                            ),
                                          ),
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(right: 20),
                                              child: Text(
                                                '$ChildrenCount',
                                                style: const TextStyle(
                                                  fontSize: 20,
                                                  color: Color(0xff385a4a),
                                                ),
                                              ),
                                            ),
                                            const Padding(
                                              padding:
                                                  EdgeInsets.only(right: 20),
                                              child: Text(
                                                'عدد الأطفال المنسوبين',
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xff687C71),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: 90,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 15),
                                          child: CircleAvatar(
                                            backgroundColor: Colors.grey[300],
                                            radius: 30,
                                            child: const Icon(
                                              Icons.people,
                                              color: Color(0xff385a4a),
                                              size: 35,
                                            ),
                                          ),
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(right: 40),
                                              child: Text(
                                                '$therapistCount',
                                                style: const TextStyle(
                                                  fontSize: 24,
                                                  color: Color(0xff385a4a),
                                                ),
                                              ),
                                            ),
                                            const Padding(
                                              padding:
                                                  EdgeInsets.only(right: 50),
                                              child: Text(
                                                'عدد الأخصائيين',
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xff687C71),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: 90,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 15),
                                          child: CircleAvatar(
                                            child: Image.asset(
                                                'images/TheStar.png'),
                                            radius: 30,
                                            backgroundColor: Colors.grey[300],
                                          ),
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            mostActiveTherapist != null
                                                ? Text(
                                                    '$mostActiveTherapist',
                                                    style: const TextStyle(
                                                      fontSize: 24,
                                                      color: Color(0xff385a4a),
                                                    ),
                                                  )
                                                : Text(
                                                    'لا يوجد',
                                                    style: const TextStyle(
                                                      fontSize: 24,
                                                      color: Color(0xff385a4a),
                                                    ),
                                                  ),
                                            const Padding(
                                              padding:
                                                  EdgeInsets.only(right: 20),
                                              child: Text(
                                                'الاخصائي الاكثر تفاعل ',
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xff687C71),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      isLoadingChart
                          ? SizedBox(
                              width: MediaQuery.of(context).size.width / 1.2,
                              height: MediaQuery.of(context).size.height / 2.4,
                              child: const Center(
                                  child: CircularProgressIndicator()),
                            )
                          : SizedBox(
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                      elevation: 8,
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 20),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                const Text(
                                                  "الجلسات",
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                                ),
                                                InkWell(
                                                  onTap: () async {
                                                    await _showDialog(context);
                                                    setState(() {
                                                      isLoadingChart = false;
                                                    });
                                                  },
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(8),
                                                    decoration: BoxDecoration(
                                                        border: Border.all(),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(7)),
                                                    child: Row(children: [
                                                      choose == 0
                                                          ? const Text(
                                                              "هذا الاسبوع")
                                                          : const Text(
                                                              "الأسبوع الماضي"),
                                                      const Icon(Icons
                                                          .arrow_drop_down),
                                                    ]),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Container(
                                              padding: const EdgeInsets.all(8),
                                              margin: const EdgeInsets.all(15),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  1.2,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  2.4,
                                              child: MyBarGraph(
                                                  maxY: 100,
                                                  weeklySummary: weeklySummary),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
