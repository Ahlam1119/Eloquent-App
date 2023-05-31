import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class evnetsOrder extends StatefulWidget {
  late String childId;
  evnetsOrder({required this.childId});

  @override
  State<evnetsOrder> createState() => _evnetsOrderState();
}

class _evnetsOrderState extends State<evnetsOrder> {
  String? fourPic;
  String? fivePic;
  String? sixPic;
  String? dailyRou;
  late String ChildID = widget.childId;

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  // late String Jointhebeads;
  Map<String, dynamic> ChildInfo = {};
  bool isLoded = true;
  getUserData() async {
    //.where(field)
    await FirebaseFirestore.instance
        .collection('event')
        .where("ChildID", isEqualTo: ChildID)
        .get()
        .then((v) {
      for (var element in v.docs) {
        ChildInfo.addAll(element.data());
        fourPic = ChildInfo['fourPic'];
        fivePic = ChildInfo['fivePic'];
        sixPic = ChildInfo['sixPic'];
        dailyRou = ChildInfo['dailyRou'];
        setState(() {
          isLoded = false;
        });
      }
    });
  }

  AddData({
    required String ChildID,
    required String? fourPic,
    required String? fivePic,
    required String? sixPic,
    required String? dailyRou,
  }) async {
    final DocumentReference<Map<String, dynamic>> userRef =
        FirebaseFirestore.instance.collection('event').doc(ChildID);

    await userRef.set({
      'ChildID': ChildID,
      'fourPic': fourPic,
      'fivePic': fivePic,
      'sixPic': sixPic,
      'dailyRou': dailyRou,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_right, size: 32.0),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          )
        ],
        foregroundColor: Color(0xff385a4a),
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 244, 245, 245),
        title: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              "مرحلة ترتيب الاحداث",
              style: TextStyle(
                color: Color(0xff385a4a),
                fontSize: 20,
                fontFamily: "Cairo",
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        bottom: PreferredSize(
          child: Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 17, left: 10),
              child: Text(
                "تشمل هذه المرحلة على قصص \nمتسلسلة الاحداث لتنمية اللغة التعبيرية\nوالتدريب على سرد احداث متسلسلة ومترابطة",
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xff9bb0a5),
                ),
                textAlign: TextAlign.right,
              ),
            ),
          ),
          preferredSize: Size.fromHeight(70.0),
        ),
      ),
      body: SafeArea(
          child: Container(
        color: Color.fromARGB(255, 244, 245, 245),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: ListView(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, bottom: 5, top: 25),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(11),
                        color: Colors.white,
                      ),
                      child: ExpansionTile(
                        trailing: Transform.rotate(
                          angle: 1.57,
                          child: Icon(
                            Icons.arrow_back_ios_outlined,
                            color: Colors.black,
                            size: 20,
                          ),
                        ),
                        title: Row(
                          children: [
                            Container(
                                width: 23.92,
                                height: 25,
                                child: Image.asset("images/EventOrder.png")),
                            SizedBox(
                              width: 6,
                            ),
                            Text(
                              'سرد الاحداث',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: Color(0xff385a4a),
                                fontSize: 16,
                                fontFamily: "Cairo",
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        children: [
                          Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Text(
                                "ترتيب وسرد حدث من أربع صور",
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  color: Color(0xff6888a0),
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Radio(
                                groupValue: fourPic,
                                value: "اتقن",
                                onChanged: (value) {
                                  setState(() {
                                    fourPic = value.toString();
                                  });
                                },
                                activeColor: Color(0xff385a4a),
                              ),
                              Text(
                                "أتقن",
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  color: Color(0xff030d1c),
                                  fontSize: 14,
                                  fontFamily: "Cairo",
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Radio(
                                groupValue: fourPic,
                                value: "بمساعدة",
                                onChanged: (value) {
                                  setState(() {
                                    fourPic = value.toString();
                                  });
                                },
                                activeColor: Color(0xff385a4a),
                              ),
                              Text(
                                "بمساعدة",
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  color: Color(0xff030d1c),
                                  fontSize: 14,
                                  fontFamily: "Cairo",
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Radio(
                                groupValue: fourPic,
                                value: "لم يتقن",
                                onChanged: (value) {
                                  setState(() {
                                    fourPic = value.toString();
                                  });
                                },
                                activeColor: Color(0xff385a4a),
                              ),
                              Text(
                                "لم يتق",
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  color: Color(0xff030d1c),
                                  fontSize: 14,
                                  fontFamily: "Cairo",
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Text(
                                "ترتيب وسرد حدث من خمس صور",
                                style: TextStyle(
                                  color: Color(0xff6888a0),
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Radio(
                                groupValue: fivePic,
                                value: "اتقن",
                                onChanged: (value) {
                                  setState(() {
                                    fivePic = value.toString();
                                  });
                                },
                                activeColor: Color(0xff385a4a),
                              ),
                              Text(
                                "أتقن",
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  color: Color(0xff030d1c),
                                  fontSize: 14,
                                  fontFamily: "Cairo",
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Radio(
                                groupValue: fivePic,
                                value: "بمساعدة",
                                onChanged: (value) {
                                  setState(() {
                                    fivePic = value.toString();
                                  });
                                },
                                activeColor: Color(0xff385a4a),
                              ),
                              Text(
                                "بمساعدة",
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  color: Color(0xff030d1c),
                                  fontSize: 14,
                                  fontFamily: "Cairo",
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Radio(
                                groupValue: fivePic,
                                value: "لم يتقن",
                                onChanged: (value) {
                                  setState(() {
                                    fivePic = value.toString();
                                  });
                                },
                                activeColor: Color(0xff385a4a),
                              ),
                              Text(
                                "لم يتق",
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  color: Color(0xff030d1c),
                                  fontSize: 14,
                                  fontFamily: "Cairo",
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Text(
                                "ترتيب وسرد حدث من ست صور فأكثر",
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  color: Color(0xff6888a0),
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Radio(
                                groupValue: sixPic,
                                value: "اتقن",
                                onChanged: (value) {
                                  setState(() {
                                    sixPic = value.toString();
                                  });
                                },
                                activeColor: Color(0xff385a4a),
                              ),
                              Text(
                                "أتقن",
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  color: Color(0xff030d1c),
                                  fontSize: 14,
                                  fontFamily: "Cairo",
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Radio(
                                groupValue: sixPic,
                                value: "بمساعدة",
                                onChanged: (value) {
                                  setState(() {
                                    sixPic = value.toString();
                                  });
                                },
                                activeColor: Color(0xff385a4a),
                              ),
                              Text(
                                "بمساعدة",
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  color: Color(0xff030d1c),
                                  fontSize: 14,
                                  fontFamily: "Cairo",
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Radio(
                                groupValue: sixPic,
                                value: "لم يتقن",
                                onChanged: (value) {
                                  setState(() {
                                    sixPic = value.toString();
                                  });
                                },
                                activeColor: Color(0xff385a4a),
                              ),
                              Text(
                                "لم يتق",
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  color: Color(0xff030d1c),
                                  fontSize: 14,
                                  fontFamily: "Cairo",
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Text(
                                "سرد الروتين اليومي",
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  color: Color(0xff6888a0),
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Radio(
                                groupValue: dailyRou,
                                value: "اتقن",
                                onChanged: (value) {
                                  setState(() {
                                    dailyRou = value.toString();
                                  });
                                },
                                activeColor: Color(0xff385a4a),
                              ),
                              Text(
                                "أتقن",
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  color: Color(0xff030d1c),
                                  fontSize: 14,
                                  fontFamily: "Cairo",
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Radio(
                                groupValue: dailyRou,
                                value: "بمساعدة",
                                onChanged: (value) {
                                  setState(() {
                                    dailyRou = value.toString();
                                  });
                                },
                                activeColor: Color(0xff385a4a),
                              ),
                              Text(
                                "بمساعدة",
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  color: Color(0xff030d1c),
                                  fontSize: 14,
                                  fontFamily: "Cairo",
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Radio(
                                groupValue: dailyRou,
                                value: "لم يتقن",
                                onChanged: (value) {
                                  setState(() {
                                    dailyRou = value.toString();
                                  });
                                },
                                activeColor: Color(0xff385a4a),
                              ),
                              Text(
                                "لم يتق",
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  color: Color(0xff030d1c),
                                  fontSize: 14,
                                  fontFamily: "Cairo",
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 150,
                    child: ElevatedButton(
                      onPressed: () async {
                        final DocumentSnapshot<Map<String, dynamic>> snapshot =
                            await FirebaseFirestore.instance
                                .collection('event')
                                .doc(ChildID)
                                .get();

                        final DocumentReference<Map<String, dynamic>> userRef =
                            FirebaseFirestore.instance
                                .collection('event')
                                .doc(ChildID);

                        if (snapshot.exists) {
                          print('Update');
                          // User already has data
                          // Show an "Update" button

                          await userRef.update({
                            // uidParent: uidParent,

                            'fourPic': fourPic,
                            'fivePic': fivePic,
                            'sixPic': sixPic,
                            'dailyRou': dailyRou,
                          });

                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text("تم تحديث التقييم بنجاح"),
                            ),
                          );
                        } else {
                          print('child has no file');
                          // User has no data
                          // Show an "Add" button
                          AddData(
                            ChildID: ChildID,
                            fourPic: fourPic,
                            fivePic: fivePic,
                            sixPic: sixPic,
                            dailyRou: dailyRou,
                          );

                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text(
                                "تم حفظ التقييم بنجاح",
                                style: TextStyle(fontSize: 25),
                              ),
                            ),
                          );
                        }
                      },
                      child: Text('حفظ التقيم'),
                      style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(11)),
                        ),
                        backgroundColor: Color(0xff394445),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      )),
    );
  }
}
