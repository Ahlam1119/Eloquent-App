import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Pre_lsnguage extends StatefulWidget {
  late String childId;
  Pre_lsnguage({required this.childId});

  @override
  State<Pre_lsnguage> createState() => _Pre_lsnguageState();
}

class _Pre_lsnguageState extends State<Pre_lsnguage> {
  String? Jointhebeads;
  String? movingthecar;
  String? twoElement;
  String? threeElement;
  String? fourElement;
  String? oneThing;
  String? twoThing;
  String? threeThing;
  String? same;
  String? shadow;
  String? different;
  String? carCat;
  String? inFront;
  String? twoImage;
  String? threeimage;
  String? fourImage;
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
        .collection('preLanguage')
        .where("ChildID", isEqualTo: ChildID)
        .get()
        .then((v) {
      for (var element in v.docs) {
        ChildInfo.addAll(element.data());
        Jointhebeads = ChildInfo['Jointhebeads'];
        movingthecar = ChildInfo['movingthecar'];
        twoElement = ChildInfo['twoElement'];
        threeElement = ChildInfo['threeElement'];
        fourElement = ChildInfo['fourElement'];
        oneThing = ChildInfo['oneThing'];
        twoThing = ChildInfo['twoThing'];
        threeThing = ChildInfo['threeThing'];
        same = ChildInfo['same'];
        shadow = ChildInfo['shadow'];
        different = ChildInfo['different'];
        carCat = ChildInfo['carCat'];
        inFront = ChildInfo['inFront'];
        twoImage = ChildInfo['twoImage'];
        threeimage = ChildInfo['threeimage'];
        fourImage = ChildInfo['fourImage'];
        setState(() {
          isLoded = false;
        });
      }
    });
  }

  AddData({
    required String ChildID,
    required String? Jointhebeads,
    required String? movingthecar,
    required String? twoElement,
    required String? threeElement,
    required String? fourElement,
    required String? oneThing,
    required String? twoThing,
    required String? threeThing,
    required String? same,
    required String? shadow,
    required String? different,
    required String? carCat,
    required String? inFront,
    required String? twoImage,
    required String? threeimage,
    required String? fourImage,
  }) async {
    final DocumentReference<Map<String, dynamic>> userRef =
        FirebaseFirestore.instance.collection('preLanguage').doc(ChildID);

    await userRef.set({
      'ChildID': ChildID,
      'Jointhebeads': Jointhebeads,
      'movingthecar': movingthecar,
      'twoElement': twoElement,
      'threeElement': threeElement,
      'fourElement': fourElement,
      'oneThing': oneThing,
      'twoThing': twoThing,
      'threeThing': threeThing,
      "same": same,
      "shadow": shadow,
      "different": different,
      "carCat": carCat,
      "inFront": inFront,
      "twoImage": twoImage,
      "threeimage": threeimage,
      "fourImage": fourImage,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        foregroundColor: Color(0xff385a4a),
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 244, 245, 245),
        title: Align(
          alignment: Alignment.centerRight,
          child: Text(
            "مرحلة ما قبل اللغة",
            style: TextStyle(
              color: Color(0xff385a4a),
              fontSize: 20,
              fontFamily: "Cairo",
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        actions: [
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_right, size: 32),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          )
        ],
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
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, top: 25),
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
                            Image.asset("images/visual.png"),
                            SizedBox(
                              width: 9,
                            ),
                            Text(
                              'التواصل البصري',
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
                                "مهارة نضم الخرز ",
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
                                groupValue: Jointhebeads,
                                value: "اتقن",
                                onChanged: (value) {
                                  setState(() {
                                    Jointhebeads = value.toString();
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
                                groupValue: Jointhebeads,
                                value: "بمساعدة",
                                onChanged: (value) {
                                  setState(() {
                                    Jointhebeads = value.toString();
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
                                groupValue: Jointhebeads,
                                value: "لم يتقن",
                                onChanged: (value) {
                                  setState(() {
                                    Jointhebeads = value.toString();
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
                                "تحريك السيارة في المسار المحدد",
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
                                groupValue: movingthecar,
                                value: "اتقن",
                                onChanged: (value) {
                                  setState(() {
                                    movingthecar = value.toString();
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
                                groupValue: movingthecar,
                                value: "بمساعدة",
                                onChanged: (value) {
                                  setState(() {
                                    movingthecar = value.toString();
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
                                groupValue: movingthecar,
                                value: "لم يتقن",
                                onChanged: (value) {
                                  setState(() {
                                    movingthecar = value.toString();
                                  });
                                },
                                activeColor: Color(0xff385a4a),
                              ),
                              Text(
                                "لم يتقن",
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
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, top: 25),
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
                            Image.asset("images/FOCUS.png"),
                            SizedBox(
                              width: 9,
                            ),
                            Text(
                              'درجة الانتباه والتركيز ',
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
                                "مطابقة الصور المتشابة   ",
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
                                groupValue: same,
                                value: "اتقن",
                                onChanged: (value) {
                                  setState(() {
                                    same = value.toString();
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
                                groupValue: same,
                                value: "بمساعدة",
                                onChanged: (value) {
                                  setState(() {
                                    same = value.toString();
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
                                groupValue: same,
                                value: "لم يتقن",
                                onChanged: (value) {
                                  setState(() {
                                    same = value.toString();
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
                                "مطابقة الصورة وظلها",
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
                                groupValue: shadow,
                                value: "اتقن",
                                onChanged: (value) {
                                  setState(() {
                                    shadow = value.toString();
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
                                groupValue: shadow,
                                value: "بمساعدة",
                                onChanged: (value) {
                                  setState(() {
                                    shadow = value.toString();
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
                                groupValue: shadow,
                                value: "لم يتقن",
                                onChanged: (value) {
                                  setState(() {
                                    shadow = value.toString();
                                  });
                                },
                                activeColor: Color(0xff385a4a),
                              ),
                              Text(
                                "لم يتقن",
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
                                "تمييز الشكل الشاذ",
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
                                groupValue: different,
                                value: "اتقن",
                                onChanged: (value) {
                                  setState(() {
                                    different = value.toString();
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
                                groupValue: different,
                                value: "بمساعدة",
                                onChanged: (value) {
                                  setState(() {
                                    different = value.toString();
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
                                groupValue: different,
                                value: "لم يتقن",
                                onChanged: (value) {
                                  setState(() {
                                    different = value.toString();
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
                            Image.asset("images/repaet.png"),
                            SizedBox(
                              width: 9,
                            ),
                            Text(
                              'التقليد ',
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
                                "يقلد أصوات (سيارة، قطة، صفيرة)",
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
                                groupValue: carCat,
                                value: "اتقن",
                                onChanged: (value) {
                                  setState(() {
                                    carCat = value.toString();
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
                                groupValue: carCat,
                                value: "بمساعدة",
                                onChanged: (value) {
                                  setState(() {
                                    carCat = value.toString();
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
                                groupValue: carCat,
                                value: "لم يتقن",
                                onChanged: (value) {
                                  setState(() {
                                    carCat = value.toString();
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
                                "تقليد حركات الشخص الذي أمامه",
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
                                groupValue: inFront,
                                value: "اتقن",
                                onChanged: (value) {
                                  setState(() {
                                    inFront = value.toString();
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
                                groupValue: inFront,
                                value: "بمساعدة",
                                onChanged: (value) {
                                  setState(() {
                                    inFront = value.toString();
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
                                groupValue: inFront,
                                value: "لم يتقن",
                                onChanged: (value) {
                                  setState(() {
                                    inFront = value.toString();
                                  });
                                },
                                activeColor: Color(0xff385a4a),
                              ),
                              Text(
                                "لم يتقن",
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
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
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
                            Image.asset("images/audio.png"),
                            SizedBox(
                              width: 9,
                            ),
                            Text(
                              'الانتباه السمعي ',
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
                                "سيارة، كرة",
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
                                groupValue: twoElement,
                                value: "اتقن",
                                onChanged: (value) {
                                  setState(() {
                                    twoElement = value.toString();
                                  });
                                },
                                activeColor: Color(0xff385a4a),
                              ),
                              Text(
                                "اتقن ",
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  color: Color(0xff030d1c),
                                  fontSize: 14,
                                  fontFamily: "Cairo",
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Radio(
                                groupValue: twoElement,
                                value: "بمساعدة",
                                onChanged: (value) {
                                  setState(() {
                                    twoElement = value.toString();
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
                                groupValue: twoElement,
                                value: "لم يتقن",
                                onChanged: (value) {
                                  setState(() {
                                    twoElement = value.toString();
                                  });
                                },
                                activeColor: Color(0xff385a4a),
                              ),
                              Text(
                                "لم يتقن",
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
                                "سيارة، كرة، باص",
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
                                groupValue: threeElement,
                                value: "اتقن",
                                onChanged: (value) {
                                  setState(() {
                                    threeElement = value.toString();
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
                                groupValue: threeElement,
                                value: "بمساعدة",
                                onChanged: (value) {
                                  setState(() {
                                    threeElement = value.toString();
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
                                groupValue: threeElement,
                                value: "لم يتقن",
                                onChanged: (value) {
                                  setState(() {
                                    threeElement = value.toString();
                                  });
                                },
                                activeColor: Color(0xff385a4a),
                              ),
                              Text(
                                "لم يتقن",
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
                                "سيارة، كرة، باص، قلم",
                                style: TextStyle(
                                  color: Color(0xff6888a0),
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Radio(
                                  groupValue: fourElement,
                                  value: "اتقن",
                                  onChanged: (value) {
                                    setState(() {
                                      fourElement = value.toString();
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
                                  groupValue: fourElement,
                                  value: "بمساعدة",
                                  onChanged: (value) {
                                    setState(() {
                                      fourElement = value.toString();
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
                                  groupValue: fourElement,
                                  value: "لم يتقن",
                                  onChanged: (value) {
                                    setState(() {
                                      fourElement = value.toString();
                                    });
                                  },
                                  activeColor: Color(0xff385a4a),
                                ),
                                Text(
                                  "لم يتقن",
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
                          ),
                        ],
                      ),
                    ),
                  ),
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
                            Image.asset("images/visualBrian.png"),
                            SizedBox(
                              width: 9,
                            ),
                            Text(
                              'الذاكرة البصرية ',
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
                                "صورتين",
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
                                groupValue: twoImage,
                                value: "اتقن",
                                onChanged: (value) {
                                  setState(() {
                                    twoImage = value.toString();
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
                                groupValue: twoImage,
                                value: "بمساعدة",
                                onChanged: (value) {
                                  setState(() {
                                    twoImage = value.toString();
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
                                groupValue: twoImage,
                                value: "لم يتقن",
                                onChanged: (value) {
                                  setState(() {
                                    twoImage = value.toString();
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
                                "ثلاث صور",
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
                                groupValue: threeimage,
                                value: "اتقن",
                                onChanged: (value) {
                                  setState(() {
                                    threeimage = value.toString();
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
                                groupValue: threeimage,
                                value: "بمساعدة",
                                onChanged: (value) {
                                  setState(() {
                                    threeimage = value.toString();
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
                                groupValue: threeimage,
                                value: "لم يتقن",
                                onChanged: (value) {
                                  setState(() {
                                    threeimage = value.toString();
                                  });
                                },
                                activeColor: Color(0xff385a4a),
                              ),
                              Text(
                                "لم يتقن",
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
                                "اربع صور",
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
                                groupValue: fourImage,
                                value: "اتقن",
                                onChanged: (value) {
                                  setState(() {
                                    fourImage = value.toString();
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
                                groupValue: fourImage,
                                value: "بمساعدة",
                                onChanged: (value) {
                                  setState(() {
                                    fourImage = value.toString();
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
                                groupValue: fourImage,
                                value: "لم يتقن",
                                onChanged: (value) {
                                  setState(() {
                                    fourImage = value.toString();
                                  });
                                },
                                activeColor: Color(0xff385a4a),
                              ),
                              Text(
                                "لم يتقن",
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
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, bottom: 8, top: 5),
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
                            Image.asset("images/order.png"),
                            SizedBox(
                              width: 9,
                            ),
                            Text(
                              'تنفيذ الأوامر ',
                              textAlign: TextAlign.end,
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
                                "تنفيذ أمر واحد   ",
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
                                groupValue: oneThing,
                                value: "لم يتقن",
                                onChanged: (value) {
                                  setState(() {
                                    oneThing = value.toString();
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
                                groupValue: oneThing,
                                value: "بمساعدة",
                                onChanged: (value) {
                                  setState(() {
                                    oneThing = value.toString();
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
                                groupValue: oneThing,
                                value: "لم يتقن",
                                onChanged: (value) {
                                  setState(() {
                                    oneThing = value.toString();
                                  });
                                },
                                activeColor: Color(0xff385a4a),
                              ),
                              Text(
                                "لم يتقن",
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
                                "تنفيذ امرين    ",
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
                                groupValue: twoThing,
                                value: "اتقن ",
                                onChanged: (value) {
                                  setState(() {
                                    twoThing = value.toString();
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
                                groupValue: twoThing,
                                value: "بمساعدة",
                                onChanged: (value) {
                                  setState(() {
                                    twoThing = value.toString();
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
                                groupValue: twoThing,
                                value: "لم يتقن",
                                onChanged: (value) {
                                  setState(() {
                                    twoThing = value.toString();
                                  });
                                },
                                activeColor: Color(0xff385a4a),
                              ),
                              Text(
                                "لم يتقن",
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
                                "تنفيذ ثلاث أوامر   ",
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
                                groupValue: threeThing,
                                value: "اتقن ",
                                onChanged: (value) {
                                  setState(() {
                                    threeThing = value.toString();
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
                                groupValue: threeThing,
                                value: "بمساعدة",
                                onChanged: (value) {
                                  setState(() {
                                    threeThing = value.toString();
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
                                groupValue: threeThing,
                                value: "لم يتقن",
                                onChanged: (value) {
                                  setState(() {
                                    threeThing = value.toString();
                                  });
                                },
                                activeColor: Color(0xff385a4a),
                              ),
                              Text(
                                "لم يتقن",
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
                    width: 155,
                    child: ElevatedButton(
                      onPressed: () async {
                        final DocumentSnapshot<Map<String, dynamic>> snapshot =
                            await FirebaseFirestore.instance
                                .collection('preLanguage')
                                .doc(ChildID)
                                .get();

                        final DocumentReference<Map<String, dynamic>> userRef =
                            FirebaseFirestore.instance
                                .collection('preLanguage')
                                .doc(ChildID);

                        if (snapshot.exists) {
                          print('Update');
                          // User already has data
                          // Show an "Update" button

                          await userRef.update({
                            // uidParent: uidParent,

                            'Jointhebeads': Jointhebeads,
                            'movingthecar': movingthecar,
                            'twoElement': twoElement,
                            'threeElement': threeElement,
                            'fourElement': fourElement,
                            'oneThing': oneThing,
                            'twoThing': twoThing,
                            'threeThing': threeThing,
                            "same": same,
                            "shadow": shadow,
                            "different": different,
                            "carCat": carCat,
                            "inFront": inFront,
                            "twoImage": twoImage,
                            "threeimage": threeimage,
                            "fourImage": fourImage,
                          });

                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text(
                                "تم تحديث التقييم بنجاح",
                                style: TextStyle(fontSize: 25),
                              ),
                            ),
                          );
                        } else {
                          print('child has no file');
                          // User has no data
                          // Show an "Add" button
                          AddData(
                              ChildID: ChildID,
                              Jointhebeads: Jointhebeads,
                              movingthecar: movingthecar,
                              twoElement: twoElement,
                              threeElement: threeElement,
                              fourElement: fourElement,
                              oneThing: oneThing,
                              twoThing: twoThing,
                              threeThing: threeThing,
                              same: same,
                              shadow: shadow,
                              inFront: inFront,
                              different: different,
                              twoImage: twoImage,
                              threeimage: threeimage,
                              fourImage: fourImage,
                              carCat: carCat);

                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text("تم حفظ التقييم بنجاح"),
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
