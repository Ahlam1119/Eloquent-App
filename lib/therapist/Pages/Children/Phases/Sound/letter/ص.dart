import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LetterSaD extends StatefulWidget {
  late String childId;
  LetterSaD({required this.childId});

  @override
  State<LetterSaD> createState() => _LetterSaDState();
}

class _LetterSaDState extends State<LetterSaD> {
  late var Singlelettersound = false;

  late var syllableA = false;
  late var syllableW = false;
  late var syllableY = false;
  late var firstWord = false;
  late var MidtWord = false;
  late var LasttWord = false;

  late String ChildID;
  late DocumentReference checkboxesDocRef;

  @override
  void initState() {
    super.initState();
    ChildID = widget.childId;
    checkboxesDocRef =
        FirebaseFirestore.instance.collection('Sounds').doc(ChildID);
    _loadValues();
  }

  void _loadValues() async {
    try {
      final snapshot = await checkboxesDocRef.get();
      if (snapshot.exists) {
        setState(() {
          final checkboxesMap = snapshot.get('ص'); //هنا يتم تغير الحرف

          Singlelettersound = checkboxesMap['Singlelettersound'] ?? false;
          syllableA = checkboxesMap['syllableA'] ?? false;
          syllableY = checkboxesMap['syllableY'] ?? false;
          syllableW = checkboxesMap['syllableW'] ?? false;
          firstWord = checkboxesMap['firstWord'] ?? false;
          MidtWord = checkboxesMap['MidtWord'] ?? false;
          LasttWord = checkboxesMap['LasttWord'] ?? false;
        });
      }
    } catch (e) {
      print('Error loading values: $e');
      // _showErrorDialog('حدث خطأ أثناء تحميل البيانات');
    }
  }

  void _saveValues() async {
    try {
      await checkboxesDocRef.set({
        "ص": {
          'Singlelettersound': Singlelettersound,
          'syllableA': syllableA,
          'syllableW': syllableW,
          'syllableY': syllableY,
          'firstWord': firstWord,
          'MidtWord': MidtWord,
          'LasttWord': LasttWord,
        }
      });
      _showSuccessDialog('تم حفظ البيانات بنجاح');
    } catch (e) {
      print('Error saving values: $e');
      _showErrorDialog('حدث خطأ أثناء حفظ البيانات');
    }
  }

  void _updateValues() async {
    try {
      await checkboxesDocRef.update({
        "ص": {
          'Singlelettersound': Singlelettersound,
          'syllableA': syllableA,
          'syllableW': syllableW,
          'syllableY': syllableY,
          'firstWord': firstWord,
          'MidtWord': MidtWord,
          'LasttWord': LasttWord,
        }
      });

      _showSuccessDialog('تم تحديث البيانات بنجاح');
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
          title: Text('نجاح'),
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
    var boxDecoration = BoxDecoration(
      borderRadius: BorderRadius.circular(11),
      color: Color.fromARGB(255, 233, 239, 236),
    );

    const textStyle = TextStyle(
        color: Color(0xff385a4a),
        fontSize: 38,
        fontFamily: "Cairo",
        fontWeight: FontWeight.w800);
    var textStyle2 = TextStyle(
      color: Color(0xff030d1c),
      fontSize: 15,
      fontFamily: "Cairo",
      fontWeight: FontWeight.w600,
    );
    var textStyle3 = TextStyle(
      color: Color(0xff6888a0),
      fontSize: 16,
      fontFamily: "Cairo",
      fontWeight: FontWeight.w600,
    );
    var textStyle4 = TextStyle(
      color: Color(0xff6888a0),
      fontSize: 19,
      fontFamily: "Cairo",
      fontWeight: FontWeight.w600,
    );
    var textStyle5 = TextStyle(
      color: Color(0xff6888a0),
      fontSize: 19,
      fontFamily: "Cairo",
      fontWeight: FontWeight.w600,
    );
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Color(0xff385a4a),
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 249, 252, 252),
        title: Align(
          alignment: Alignment.centerRight,
          child: Text(
            "مرحلة الأصوات",
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
          child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 25,
        ),
        child: ListView(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                "حرف الصاد",
                style: TextStyle(
                  color: Color(0xff9bb0a5),
                  fontSize: 18,
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Container(
                        width: 62,
                        decoration: boxDecoration,
                        padding: const EdgeInsets.all(1),
                        child: Text(
                          "ص",
                          textAlign: TextAlign.center,
                          style: textStyle,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Align(
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
                              'صوت الحرف مفرد',
                              textAlign: TextAlign.right,
                              style: textStyle3,
                            ),
                          ),
                          Checkbox(
                            activeColor: Color(0xff385a4a),
                            value: Singlelettersound,
                            onChanged: (value) {
                              setState(() {
                                Singlelettersound = value!;
                              });
                            },
                          ),
                          TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Text(
                              'اتقن',
                              textAlign: TextAlign.right,
                              style: textStyle2,
                            ),
                          ),
                        ])
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "صوت الحرف بمقاطع",
                      style: TextStyle(
                        color: Color(0xff385a4a),
                        fontSize: 16,
                        fontFamily: "Cairo",
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Align(
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
                              "صا",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: Color(0xff6888a0),
                                fontSize: 19,
                                fontFamily: "Cairo",
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Checkbox(
                            activeColor: Color(0xff385a4a),
                            value: syllableA,
                            onChanged: (value) {
                              setState(() {
                                syllableA = value!;
                              });
                            },
                          ),
                          TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Text(
                              'اتقن',
                              textAlign: TextAlign.right,
                              style: textStyle2,
                            ),
                          ),
                        ])
                      ],
                    ),
                  ),
                  Align(
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
                              "صو",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: Color(0xff6888a0),
                                fontSize: 19,
                                fontFamily: "Cairo",
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Checkbox(
                            activeColor: Color(0xff385a4a),
                            value: syllableW,
                            onChanged: (value) {
                              setState(() {
                                syllableW = value!;
                              });
                            },
                          ),
                          TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Text(
                              'اتقن',
                              textAlign: TextAlign.right,
                              style: textStyle2,
                            ),
                          )
                        ])
                      ],
                    ),
                  ),
                  Align(
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
                              "صي",
                              textAlign: TextAlign.right,
                              style: textStyle4,
                            ),
                          ),
                          Checkbox(
                            activeColor: Color(0xff385a4a),
                            value: syllableY,
                            onChanged: (value) {
                              setState(() {
                                syllableY = value!;
                              });
                            },
                          ),
                          TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Text(
                              'اتقن',
                              textAlign: TextAlign.right,
                              style: textStyle2,
                            ),
                          ),
                        ])
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "الحرف في أول الكلمة",
                      style: TextStyle(
                        color: Color(0xff385a4a),
                        fontSize: 16,
                        fontFamily: "Cairo",
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Align(
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
                              "صقر",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: Color(0xff6888a0),
                                fontSize: 19,
                                fontFamily: "Cairo",
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Checkbox(
                            activeColor: Color(0xff385a4a),
                            value: firstWord,
                            onChanged: (value) {
                              setState(() {
                                firstWord = value!;
                              });
                            },
                          ),
                          TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Text(
                              'اتقن',
                              textAlign: TextAlign.right,
                              style: textStyle2,
                            ),
                          ),
                        ])
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "الحرف في وسط الكلمة",
                      style: TextStyle(
                        color: Color(0xff385a4a),
                        fontSize: 16,
                        fontFamily: "Cairo",
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Align(
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
                              "بصل",
                              textAlign: TextAlign.right,
                              style: textStyle5,
                            ),
                          ),
                          Checkbox(
                            activeColor: Color(0xff385a4a),
                            value: MidtWord,
                            onChanged: (value) {
                              setState(() {
                                MidtWord = value!;
                              });
                            },
                          ),
                          TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Text(
                              'اتقن',
                              textAlign: TextAlign.right,
                              style: textStyle2,
                            ),
                          ),
                        ])
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "الحرف في أخر الكلمة",
                      style: TextStyle(
                        color: Color(0xff385a4a),
                        fontSize: 16,
                        fontFamily: "Cairo",
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Align(
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
                              "قفص",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: Color(0xff6888a0),
                                fontSize: 19,
                                fontFamily: "Cairo",
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Checkbox(
                            activeColor: Color(0xff385a4a),
                            value: LasttWord,
                            onChanged: (value) {
                              setState(() {
                                LasttWord = value!;
                              });
                            },
                          ),
                          TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Text(
                              'اتقن',
                              textAlign: TextAlign.right,
                              style: textStyle2,
                            ),
                          ),
                        ]),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        onPressed: () async {
                          final snapshot = await checkboxesDocRef.get();
                          if (snapshot.exists) {
                            _updateValues();
                          } else {
                            _saveValues();
                          }
                        },
                        child: Text("حفظ التقيم"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff394445),
                        )),
                  )
                ]),
              ),
            )
          ],
        ),
      )),
    );
  }
}
