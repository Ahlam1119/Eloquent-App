import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BuildingConcepts extends StatefulWidget {
  late String childId;
  BuildingConcepts({required this.childId});

  @override
  _BuildingConceptsState createState() => _BuildingConceptsState();
}

class _BuildingConceptsState extends State<BuildingConcepts> {
  late String ChildID;
  late DocumentReference checkboxesDocRef;

  bool foot = false;
  bool fingers = false;
  bool ear = false;
  bool nose = false;
  bool hand = false;
  bool hair = false;
  bool eye = false;
  bool eyeBrows = false;
  bool bike = false;
  bool Train = false;
  bool Bus = false;
  bool boat = false;
  bool car = false;
  bool bridge = false;
  bool red = false;
  bool blue = false;
  bool yellow = false;
  bool green = false;
  bool purple = false;
  bool white = false;
  bool pants = false;
  bool dress = false;
  bool shoes = false;
  bool sock = false;
  bool blouse = false;
  bool shemagh = false;
  bool cap = false;

  bool Strawberry = false;
  bool pineapple = false;
  bool apples = false;
  bool banana = false;

  @override
  void initState() {
    super.initState();
    ChildID = widget.childId;
    checkboxesDocRef =
        FirebaseFirestore.instance.collection('BuildingConcepts').doc(ChildID);
    _loadValues();
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final CollectionReference valuesRef =
      FirebaseFirestore.instance.collection('BuildingConcepts');

  void _loadValues() async {
    try {
      final snapshot = await checkboxesDocRef.get();
      if (snapshot.exists) {
        setState(() {
          final checkboxesMap = snapshot.get('أجزاءالجسم');
          foot = checkboxesMap['foot'] ?? false;
          fingers = checkboxesMap['fingers'] ?? false;
          ear = checkboxesMap['ear'] ?? false;
          nose = checkboxesMap['nose'] ?? false;
          hand = checkboxesMap['hand'] ?? false;
          hair = checkboxesMap['hair'] ?? false;
          eyeBrows = checkboxesMap['eyeBrows'] ?? false;

          final checkboxesMap1 = snapshot.get('وسائل المواصلات');
          bike = checkboxesMap1['bike'] ?? false;
          Train = checkboxesMap1['Train'] ?? false;
          Bus = checkboxesMap1['Bus'] ?? false;
          boat = checkboxesMap1['boat'] ?? false;
          car = checkboxesMap1['car'] ?? false;
          bridge = checkboxesMap1['bridge'] ?? false;

          final checkboxesMapColor = snapshot.get('الألوان');
          red = checkboxesMapColor['red'] ?? false;
          blue = checkboxesMapColor['blue'] ?? false;
          yellow = checkboxesMapColor['yellow'] ?? false;
          green = checkboxesMapColor['green'] ?? false;
          purple = checkboxesMapColor['purple'] ?? false;
          white = checkboxesMapColor['white'] ?? false;

          final checkboxesMap2 = snapshot.get('ملابس');
          pants = checkboxesMap2['pants'] ?? false;
          blouse = checkboxesMap2['blouse'] ?? false;
          dress = checkboxesMap2['dress'] ?? false;
          shoes = checkboxesMap2['shoes'] ?? false;
          sock = checkboxesMap2['sock'] ?? false;
          shemagh = checkboxesMap2['shemagh'] ?? false;

          final checkboxesMap3 = snapshot.get('الفواكه');
          Strawberry = checkboxesMap3['Strawberry'] ?? false;
          pineapple = checkboxesMap3['pineapple'] ?? false;
          apples = checkboxesMap3['apples'] ?? false;
          banana = checkboxesMap3['banana'] ?? false;
        });
      }
    } catch (e) {
      print('Error loading values: $e');
      _showErrorDialog('حدث خطأ أثناء تحميل البيانات');
    }
  }

  void _saveValues() async {
    try {
      await checkboxesDocRef.set({
        'أجزاءالجسم': {
          'foot': foot,
          'fingers': fingers,
          'ear': ear,
          'nose': nose,
          'hand': hand,
          'hair': hair,
          'eyeBrows': eyeBrows,
        },
        "وسائل المواصلات": {
          'bike': bike,
          'Train': Train,
          'Bus': Bus,
          'boat': boat,
          'car': car,
          'bridge': bridge,
        },
        "الألوان": {
          'red': red,
          'blue': blue,
          'yellow': yellow,
          'green': green,
          'purple': purple,
          'white': white,
        },
        "ملابس": {
          'pants': pants,
          'blouse': blouse,
          'dress': dress,
          'shoes': shoes,
          'sock': sock,
          'shemagh': shemagh,
        },
        "الفواكه": {
          'Strawberry': Strawberry,
          'pineapple': pineapple,
          'apples': apples,
          'banana': banana,
        },
      });
      _showSuccessDialog('تم حفظ التقييم بنجاح');
    } catch (e) {
      print('Error saving values: $e');
      _showErrorDialog('حدث خطأ أثناء حفظ البيانات');
    }
  }

  void _updateValues() async {
    try {
      await checkboxesDocRef.update({
        'أجزاءالجسم': {
          'foot': foot,
          'fingers': fingers,
          'ear': ear,
          'nose': nose,
          'hand': hand,
          'hair': hair,
          'eyeBrows': eyeBrows,
        },
        "وسائل المواصلات": {
          'bike': bike,
          'Train': Train,
          'Bus': Bus,
          'boat': boat,
          'car': car,
          'bridge': bridge,
        },
        "الألوان": {
          'red': red,
          'blue': blue,
          'yellow': yellow,
          'green': green,
          'purple': purple,
          'white': white,
        },
        "ملابس": {
          'pants': pants,
          'blouse': blouse,
          'dress': dress,
          'shoes': shoes,
          'sock': sock,
          'shemagh': shemagh,
        },
        "الفواكه": {
          'Strawberry': Strawberry,
          'pineapple': pineapple,
          'apples': apples,
          'banana': banana,
        },
      });
      _showSuccessDialog('تم تحديث التقييم بنجاح');
    } catch (e) {
      print('Error updating values: $e');
      _showErrorDialog('حدث خطأ أثناء تحديث البيانات');
    }
  }

  void _showSuccessDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          // customize the width of the dialog
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          title: Text(''),
          content: Text(
            message,
            style: TextStyle(fontSize: 25),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(''),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('خطأ'),
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

  @override
  Widget build(BuildContext context) {
    var textStyle = TextStyle(
      color: Color(0xff030d1c),
      fontSize: 14,
      fontFamily: "Cairo",
      fontWeight: FontWeight.w500,
    );
    var textStyle2 = TextStyle(
      color: Color(0xff6888a0),
      fontSize: 19,
      fontFamily: "Cairo",
      fontWeight: FontWeight.w600,
    );
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
              "مرحلة بناء المفاهيم ",
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
                "تشمل هذه المرحلة مجموعة من \nالكلمات لبناء المفاهيم و تنمية اللغة الإدراكية",
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xff9bb0a5),
                ),
                textAlign: TextAlign.right,
              ),
            ),
          ),
          preferredSize: Size.fromHeight(50.0),
        ),
      ),
      body: SafeArea(
        child: Container(
          color: Color.fromARGB(255, 244, 245, 245),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: ListView(
              children: [
                Container(
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [],
                      ),
                    ),
                  ]),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                        ),
                        child: Theme(
                          data: ThemeData().copyWith(
                            dividerColor: Colors.transparent,
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
                                Image.asset("images/Vector.png"),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "أجزاء الجسم",
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
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 25),
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Table(
                                    columnWidths: {
                                      0: FractionColumnWidth(0.7),
                                      1: FractionColumnWidth(0.1),
                                      2: FractionColumnWidth(0.2),
                                      3: FractionColumnWidth(0.3),
                                    },
                                    children: [
                                      TableRow(children: [
                                        TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: Text(
                                            "قدم",
                                            textAlign: TextAlign.right,
                                            style: textStyle2,
                                          ),
                                        ),
                                        CheckboxListTile(
                                          activeColor: Color(0xff385a4a),
                                          value: foot,
                                          onChanged: (bool? value) {
                                            setState(() {
                                              foot = value!;
                                            });
                                          },
                                        ),
                                        TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: Text(
                                            "أتقن",
                                            textAlign: TextAlign.right,
                                            style: textStyle,
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: Text(
                                            "أصابع",
                                            textAlign: TextAlign.right,
                                            style: textStyle2,
                                          ),
                                        ),
                                        CheckboxListTile(
                                          activeColor: Color(0xff385a4a),
                                          value: fingers,
                                          onChanged: (bool? value) {
                                            setState(() {
                                              fingers = value!;
                                            });
                                          },
                                        ),
                                        TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: Text(
                                            "أتقن",
                                            textAlign: TextAlign.right,
                                            style: textStyle,
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: Text(
                                            "أذن",
                                            textAlign: TextAlign.right,
                                            style: textStyle2,
                                          ),
                                        ),
                                        CheckboxListTile(
                                          activeColor: Color(0xff385a4a),
                                          value: ear,
                                          onChanged: (bool? value) {
                                            setState(() {
                                              ear = value!;
                                            });
                                          },
                                        ),
                                        TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: Text(
                                            "أتقن",
                                            textAlign: TextAlign.right,
                                            style: textStyle,
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: Text(
                                            "أنف",
                                            textAlign: TextAlign.right,
                                            style: textStyle2,
                                          ),
                                        ),
                                        CheckboxListTile(
                                          activeColor: Color(0xff385a4a),
                                          value: nose,
                                          onChanged: (bool? value) {
                                            setState(() {
                                              nose = value!;
                                            });
                                          },
                                        ),
                                        TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: Text(
                                            "أتقن",
                                            textAlign: TextAlign.right,
                                            style: textStyle,
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: Text(
                                            "يد",
                                            textAlign: TextAlign.right,
                                            style: textStyle2,
                                          ),
                                        ),
                                        CheckboxListTile(
                                          activeColor: Color(0xff385a4a),
                                          value: hand,
                                          onChanged: (bool? value) {
                                            setState(() {
                                              hand = value!;
                                            });
                                          },
                                        ),
                                        TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: Text(
                                            "أتقن",
                                            textAlign: TextAlign.right,
                                            style: textStyle,
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: Text(
                                            "شعر",
                                            textAlign: TextAlign.right,
                                            style: textStyle2,
                                          ),
                                        ),
                                        CheckboxListTile(
                                          activeColor: Color(0xff385a4a),
                                          value: hair,
                                          onChanged: (bool? value) {
                                            setState(() {
                                              hair = value!;
                                            });
                                          },
                                        ),
                                        TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: Text(
                                            "أتقن",
                                            textAlign: TextAlign.right,
                                            style: textStyle,
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: Text(
                                            "حواجب",
                                            textAlign: TextAlign.right,
                                            style: textStyle2,
                                          ),
                                        ),
                                        CheckboxListTile(
                                          activeColor: Color(0xff385a4a),
                                          value: eyeBrows,
                                          onChanged: (bool? value) {
                                            setState(() {
                                              eyeBrows = value!;
                                            });
                                          },
                                        ),
                                        TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: Text(
                                            "أتقن",
                                            textAlign: TextAlign.right,
                                            style: textStyle,
                                          ),
                                        ),
                                      ]),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      //---------------------وسائل المواصلات------------//
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                        ),
                        child: Theme(
                          data: ThemeData().copyWith(
                            dividerColor: Colors.transparent,
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
                                Image.asset(
                                  "images/VectorCar.png",
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "وسائل الموصلات",
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
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 25),
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Table(
                                    columnWidths: {
                                      0: FractionColumnWidth(0.7),
                                      1: FractionColumnWidth(0.1),
                                      2: FractionColumnWidth(0.2),
                                      3: FractionColumnWidth(0.3),
                                    },
                                    children: [
                                      TableRow(children: [
                                        TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: Text(
                                            "دراجة",
                                            textAlign: TextAlign.right,
                                            style: textStyle2,
                                          ),
                                        ),
                                        CheckboxListTile(
                                          activeColor: Color(0xff385a4a),
                                          value: bike,
                                          onChanged: (bool? value) {
                                            setState(() {
                                              bike = value!;
                                            });
                                          },
                                        ),
                                        TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: Text(
                                            "أتقن",
                                            textAlign: TextAlign.right,
                                            style: textStyle,
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: Text(
                                            "قطار",
                                            textAlign: TextAlign.right,
                                            style: textStyle2,
                                          ),
                                        ),
                                        CheckboxListTile(
                                          activeColor: Color(0xff385a4a),
                                          value: Train,
                                          onChanged: (bool? value) {
                                            setState(() {
                                              Train = value!;
                                            });
                                          },
                                        ),
                                        TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: Text(
                                            "أتقن",
                                            textAlign: TextAlign.right,
                                            style: textStyle,
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: Text(
                                            "باص",
                                            textAlign: TextAlign.right,
                                            style: textStyle2,
                                          ),
                                        ),
                                        CheckboxListTile(
                                          activeColor: Color(0xff385a4a),
                                          value: Bus,
                                          onChanged: (bool? value) {
                                            setState(() {
                                              Bus = value!;
                                            });
                                          },
                                        ),
                                        TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: Text(
                                            "أتقن",
                                            textAlign: TextAlign.right,
                                            style: textStyle,
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: Text(
                                            "سفينة",
                                            textAlign: TextAlign.right,
                                            style: textStyle2,
                                          ),
                                        ),
                                        CheckboxListTile(
                                          activeColor: Color(0xff385a4a),
                                          value: boat,
                                          onChanged: (bool? value) {
                                            setState(() {
                                              boat = value!;
                                            });
                                          },
                                        ),
                                        TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: Text(
                                            "أتقن",
                                            textAlign: TextAlign.right,
                                            style: textStyle,
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: Text(
                                            "سيارة",
                                            textAlign: TextAlign.right,
                                            style: textStyle2,
                                          ),
                                        ),
                                        CheckboxListTile(
                                          activeColor: Color(0xff385a4a),
                                          value: car,
                                          onChanged: (bool? value) {
                                            setState(() {
                                              car = value!;
                                            });
                                          },
                                        ),
                                        TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: Text(
                                            "أتقن",
                                            textAlign: TextAlign.right,
                                            style: textStyle,
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: Text(
                                            "جسر",
                                            textAlign: TextAlign.right,
                                            style: textStyle2,
                                          ),
                                        ),
                                        CheckboxListTile(
                                          activeColor: Color(0xff385a4a),
                                          value: bridge,
                                          onChanged: (bool? value) {
                                            setState(() {
                                              bridge = value!;
                                            });
                                          },
                                        ),
                                        TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: Text(
                                            "أتقن",
                                            textAlign: TextAlign.right,
                                            style: textStyle,
                                          ),
                                        ),
                                      ]),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      //---------------------الألوان ------------//
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                        ),
                        child: Theme(
                          data: ThemeData().copyWith(
                            dividerColor: Colors.transparent,
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
                                Image.asset(
                                  "images/Color.png",
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "الألوان",
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
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 25),
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Table(
                                    columnWidths: {
                                      0: FractionColumnWidth(0.7),
                                      1: FractionColumnWidth(0.1),
                                      2: FractionColumnWidth(0.2),
                                      3: FractionColumnWidth(0.3),
                                    },
                                    children: [
                                      TableRow(children: [
                                        TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: Text(
                                            "احمر",
                                            textAlign: TextAlign.right,
                                            style: textStyle2,
                                          ),
                                        ),
                                        CheckboxListTile(
                                          activeColor: Color(0xff385a4a),
                                          value: red,
                                          onChanged: (bool? value) {
                                            setState(() {
                                              red = value!;
                                            });
                                          },
                                        ),
                                        TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: Text(
                                            "أتقن",
                                            textAlign: TextAlign.right,
                                            style: textStyle,
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: Text(
                                            "أزرق",
                                            textAlign: TextAlign.right,
                                            style: textStyle2,
                                          ),
                                        ),
                                        CheckboxListTile(
                                          activeColor: Color(0xff385a4a),
                                          value: blue,
                                          onChanged: (bool? value) {
                                            setState(() {
                                              blue = value!;
                                            });
                                          },
                                        ),
                                        TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: Text(
                                            "أتقن",
                                            textAlign: TextAlign.right,
                                            style: textStyle,
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: Text(
                                            "اصفر",
                                            textAlign: TextAlign.right,
                                            style: textStyle2,
                                          ),
                                        ),
                                        CheckboxListTile(
                                          activeColor: Color(0xff385a4a),
                                          value: yellow,
                                          onChanged: (bool? value) {
                                            setState(() {
                                              yellow = value!;
                                            });
                                          },
                                        ),
                                        TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: Text(
                                            "أتقن",
                                            textAlign: TextAlign.right,
                                            style: textStyle,
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: Text(
                                            "اخضر",
                                            textAlign: TextAlign.right,
                                            style: textStyle2,
                                          ),
                                        ),
                                        CheckboxListTile(
                                          activeColor: Color(0xff385a4a),
                                          value: green,
                                          onChanged: (bool? value) {
                                            setState(() {
                                              green = value!;
                                            });
                                          },
                                        ),
                                        TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: Text(
                                            "أتقن",
                                            textAlign: TextAlign.right,
                                            style: textStyle,
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: Text(
                                            "بنفسجي",
                                            textAlign: TextAlign.right,
                                            style: textStyle2,
                                          ),
                                        ),
                                        CheckboxListTile(
                                          activeColor: Color(0xff385a4a),
                                          value: purple,
                                          onChanged: (bool? value) {
                                            setState(() {
                                              purple = value!;
                                            });
                                          },
                                        ),
                                        TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: Text(
                                            "أتقن",
                                            textAlign: TextAlign.right,
                                            style: textStyle,
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: Text(
                                            "ابيض",
                                            textAlign: TextAlign.right,
                                            style: textStyle2,
                                          ),
                                        ),
                                        CheckboxListTile(
                                          activeColor: Color(0xff385a4a),
                                          value: white,
                                          onChanged: (bool? value) {
                                            setState(() {
                                              white = value!;
                                            });
                                          },
                                        ),
                                        TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: Text(
                                            "أتقن",
                                            textAlign: TextAlign.right,
                                            style: textStyle,
                                          ),
                                        ),
                                      ]),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      //---------------------ملابس ------------//
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                        ),
                        child: Theme(
                          data: ThemeData().copyWith(
                            dividerColor: Colors.transparent,
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
                                Image.asset(
                                  "images/clothes.png",
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "الملابس",
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
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 25),
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Table(
                                    columnWidths: {
                                      0: FractionColumnWidth(0.7),
                                      1: FractionColumnWidth(0.1),
                                      2: FractionColumnWidth(0.2),
                                      3: FractionColumnWidth(0.3),
                                    },
                                    children: [
                                      TableRow(children: [
                                        TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: Text(
                                            "بنطلون",
                                            textAlign: TextAlign.right,
                                            style: textStyle2,
                                          ),
                                        ),
                                        CheckboxListTile(
                                          activeColor: Color(0xff385a4a),
                                          value: pants,
                                          onChanged: (bool? value) {
                                            setState(() {
                                              pants = value!;
                                            });
                                          },
                                        ),
                                        TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: Text(
                                            "أتقن",
                                            textAlign: TextAlign.right,
                                            style: textStyle,
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: Text(
                                            "بلوزة",
                                            textAlign: TextAlign.right,
                                            style: textStyle2,
                                          ),
                                        ),
                                        CheckboxListTile(
                                          activeColor: Color(0xff385a4a),
                                          value: blouse,
                                          onChanged: (bool? value) {
                                            setState(() {
                                              blouse = value!;
                                            });
                                          },
                                        ),
                                        TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: Text(
                                            "أتقن",
                                            textAlign: TextAlign.right,
                                            style: textStyle,
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: Text(
                                            "فستان",
                                            textAlign: TextAlign.right,
                                            style: textStyle2,
                                          ),
                                        ),
                                        CheckboxListTile(
                                          activeColor: Color(0xff385a4a),
                                          value: dress,
                                          onChanged: (bool? value) {
                                            setState(() {
                                              dress = value!;
                                            });
                                          },
                                        ),
                                        TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: Text(
                                            "أتقن",
                                            textAlign: TextAlign.right,
                                            style: textStyle,
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: Text(
                                            "حذاء",
                                            textAlign: TextAlign.right,
                                            style: textStyle2,
                                          ),
                                        ),
                                        CheckboxListTile(
                                          activeColor: Color(0xff385a4a),
                                          value: shoes,
                                          onChanged: (bool? value) {
                                            setState(() {
                                              shoes = value!;
                                            });
                                          },
                                        ),
                                        TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: Text(
                                            "أتقن",
                                            textAlign: TextAlign.right,
                                            style: textStyle,
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: Text(
                                            "جورب",
                                            textAlign: TextAlign.right,
                                            style: textStyle2,
                                          ),
                                        ),
                                        CheckboxListTile(
                                          activeColor: Color(0xff385a4a),
                                          value: sock,
                                          onChanged: (bool? value) {
                                            setState(() {
                                              sock = value!;
                                            });
                                          },
                                        ),
                                        TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: Text(
                                            "أتقن",
                                            textAlign: TextAlign.right,
                                            style: textStyle,
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: Text(
                                            "شماغ",
                                            textAlign: TextAlign.right,
                                            style: textStyle2,
                                          ),
                                        ),
                                        CheckboxListTile(
                                          activeColor: Color(0xff385a4a),
                                          value: shemagh,
                                          onChanged: (bool? value) {
                                            setState(() {
                                              shemagh = value!;
                                            });
                                          },
                                        ),
                                        TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: Text(
                                            "أتقن",
                                            textAlign: TextAlign.right,
                                            style: textStyle,
                                          ),
                                        ),
                                      ]),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      //---------------------فواكه ------------//
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                        ),
                        child: Theme(
                          data: ThemeData().copyWith(
                            dividerColor: Colors.transparent,
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
                                Image.asset(
                                  "images/Vector5.png",
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "الفواكه",
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
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 25),
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Table(
                                    columnWidths: {
                                      0: FractionColumnWidth(0.7),
                                      1: FractionColumnWidth(0.1),
                                      2: FractionColumnWidth(0.2),
                                      3: FractionColumnWidth(0.3),
                                    },
                                    children: [
                                      TableRow(children: [
                                        TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: Text(
                                            "فراولة",
                                            textAlign: TextAlign.right,
                                            style: textStyle2,
                                          ),
                                        ),
                                        CheckboxListTile(
                                          activeColor: Color(0xff385a4a),
                                          value: Strawberry,
                                          onChanged: (bool? value) {
                                            setState(() {
                                              Strawberry = value!;
                                            });
                                          },
                                        ),
                                        TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: Text(
                                            "أتقن",
                                            textAlign: TextAlign.right,
                                            style: textStyle,
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: Text(
                                            "أناناس",
                                            textAlign: TextAlign.right,
                                            style: textStyle2,
                                          ),
                                        ),
                                        CheckboxListTile(
                                          activeColor: Color(0xff385a4a),
                                          value: pineapple,
                                          onChanged: (bool? value) {
                                            setState(() {
                                              pineapple = value!;
                                            });
                                          },
                                        ),
                                        TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: Text(
                                            "أتقن",
                                            textAlign: TextAlign.right,
                                            style: textStyle,
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: Text(
                                            "تفاح",
                                            textAlign: TextAlign.right,
                                            style: textStyle2,
                                          ),
                                        ),
                                        CheckboxListTile(
                                          activeColor: Color(0xff385a4a),
                                          value: apples,
                                          onChanged: (bool? value) {
                                            setState(() {
                                              apples = value!;
                                            });
                                          },
                                        ),
                                        TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: Text(
                                            "أتقن",
                                            textAlign: TextAlign.right,
                                            style: textStyle,
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: Text(
                                            "موز",
                                            textAlign: TextAlign.right,
                                            style: textStyle2,
                                          ),
                                        ),
                                        CheckboxListTile(
                                          activeColor: Color(0xff385a4a),
                                          value: banana,
                                          onChanged: (bool? value) {
                                            setState(() {
                                              banana = value!;
                                            });
                                          },
                                        ),
                                        TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: Text(
                                            "أتقن",
                                            textAlign: TextAlign.right,
                                            style: textStyle,
                                          ),
                                        ),
                                      ]),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        width: 155,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xff394445),
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              )),
                          child: Text(
                            'حفظ التقيم',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontFamily: "Cairo",
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          onPressed: () async {
                            final snapshot = await checkboxesDocRef.get();
                            if (snapshot.exists) {
                              _updateValues();
                            } else {
                              _saveValues();
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//  CheckboxListTile(
//                                 value: foot,
//                                 onChanged: (bool? value) {
//                                   setState(() {
//                                     foot = value!;
//                                   });
//                                 },
//                               ),
//                               CheckboxListTile(
//                                 title: Text(
//                                   "أصابع",
//                                   textAlign: TextAlign.right,
//                                   style: textStyle2,
//                                 ),
//                                 value: fingers,
//                                 onChanged: (bool? value) {
//                                   setState(() {
//                                     fingers = value!;
//                                   });
//                                 },
//                               ),
//                               CheckboxListTile(
//                                 title: Text('Checkbox 3'),
//                                 value: ear,
//                                 onChanged: (bool? value) {
//                                   setState(() {
//                                     ear = value!;
//                                   });
//                                 },
//                               ),
