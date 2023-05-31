import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TwoSyllableWords extends StatefulWidget {
  late String childId;
  TwoSyllableWords({required this.childId});

  @override
  State<TwoSyllableWords> createState() => _TwoSyllableWordsState();
}

class _TwoSyllableWordsState extends State<TwoSyllableWords> {
  bool mama = false;

  bool baba = false;
  bool kaf = false;
  bool hand = false;
  bool Ab = false;
  bool Om = false;
  bool Rz = false;
  bool hj = false;
  bool qat = false;
  bool sh7 = false;
  bool fun = false;
  bool Am = false;
  bool tho = false;

  late String ChildID = widget.childId;
  late DocumentReference checkboxesDocRef;

  @override
  void initState() {
    super.initState();
    ChildID = widget.childId;
    checkboxesDocRef =
        FirebaseFirestore.instance.collection('TwoSyllableWords').doc(ChildID);
    _loadValues();
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final CollectionReference valuesRef =
      FirebaseFirestore.instance.collection('TwoSyllableWords');

  void _loadValues() async {
    try {
      final snapshot = await checkboxesDocRef.get();
      if (snapshot.exists) {
        setState(() {
          mama = snapshot['mama'] ?? false;
          baba = snapshot['baba'] ?? false;
          kaf = snapshot['kaf'] ?? false;
          hand = snapshot['hand'] ?? false;
          Ab = snapshot['Ab'] ?? false;
          Om = snapshot['Om'] ?? false;
          Rz = snapshot['Rz'] ?? false;
          hj = snapshot['hj'] ?? false;
          qat = snapshot['qat'] ?? false;
          sh7 = snapshot['sh7'] ?? false;
          fun = snapshot['fun'] ?? false;

          Am = snapshot['Am'] ?? false;
          tho = snapshot['tho'] ?? false;
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
        'mama': mama,
        'baba': baba,
        'kaf': kaf,
        'hand': hand,
        'Ab': Ab,
        'Om': Om,
        'Rz': Rz,
        'sh7': sh7,
        'hj': hj,
        'qat': qat,
        'fun': fun,
        'Am': Am,
        'tho': tho,
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
        'mama': mama,
        'baba': baba,
        'kaf': kaf,
        'hand': hand,
        'Ab': Ab,
        'Om': Om,
        'Rz': Rz,
        'sh7': sh7,
        'hj': hj,
        'qat': qat,
        'fun': fun,
        'Am': Am,
        'tho': tho,
      });
      _showSuccessDialog('تم تحديث البيانات بنجاح');
    } catch (e) {
      print('Error updating values: $e');
      _showErrorDialog('حدث خطأ أثناء تحديث البيانات');
    }
  }

  //Dialog section
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
    var textStyle6 = TextStyle(
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
                icon: const Icon(Icons.chevron_right, size: 32),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          )
        ],
        foregroundColor: Color(0xff385a4a),
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 248, 252, 252),
        title: Padding(
          padding: const EdgeInsets.only(left: 19, top: 19, bottom: 10),
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              "مرحلة الاصوات",
              style: TextStyle(
                color: Color(0xff385a4a),
                fontSize: 20,
                fontFamily: "Cairo",
                fontWeight: FontWeight.w800,
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
                "كلمات ذات مقطعين",
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xff385a4a),
                ),
                textAlign: TextAlign.start,
              ),
            ),
          ),
          preferredSize: Size.fromHeight(30.0),
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
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
                    child: Text(
                      "كلمات ذات مقطعين",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Color(0xff385a4a),
                        fontSize: 20,
                        fontFamily: "Cairo",
                        fontWeight: FontWeight.w700,
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
                              "ماما",
                              textAlign: TextAlign.right,
                              style: textStyle6,
                            ),
                          ),
                          CheckboxListTile(
                            activeColor: Color(0xff385a4a),
                            value: mama,
                            onChanged: (bool? value) {
                              setState(() {
                                mama = value!;
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
                        TableRow(children: [
                          TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Text(
                              "بابا",
                              textAlign: TextAlign.right,
                              style: textStyle6,
                            ),
                          ),
                          CheckboxListTile(
                            activeColor: Color(0xff385a4a),
                            value: baba,
                            onChanged: (bool? value) {
                              setState(() {
                                baba = value!;
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
                        TableRow(children: [
                          TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Text(
                              "كف",
                              textAlign: TextAlign.right,
                              style: textStyle6,
                            ),
                          ),
                          CheckboxListTile(
                            activeColor: Color(0xff385a4a),
                            value: kaf,
                            onChanged: (bool? value) {
                              setState(() {
                                kaf = value!;
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
                        TableRow(children: [
                          TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Text(
                              "يد",
                              textAlign: TextAlign.right,
                              style: textStyle6,
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
                              'اتقن',
                              textAlign: TextAlign.right,
                              style: textStyle2,
                            ),
                          ),
                        ]),
                        TableRow(children: [
                          TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Text(
                              "أب",
                              textAlign: TextAlign.right,
                              style: textStyle6,
                            ),
                          ),
                          CheckboxListTile(
                            activeColor: Color(0xff385a4a),
                            value: Ab,
                            onChanged: (bool? value) {
                              setState(() {
                                Ab = value!;
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
                        TableRow(children: [
                          TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Text(
                              "رز",
                              textAlign: TextAlign.right,
                              style: textStyle6,
                            ),
                          ),
                          CheckboxListTile(
                            activeColor: Color(0xff385a4a),
                            value: Rz,
                            onChanged: (bool? value) {
                              setState(() {
                                Rz = value!;
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
                        TableRow(children: [
                          TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Text(
                              "شح",
                              textAlign: TextAlign.right,
                              style: textStyle6,
                            ),
                          ),
                          CheckboxListTile(
                            activeColor: Color(0xff385a4a),
                            value: sh7,
                            onChanged: (bool? value) {
                              setState(() {
                                sh7 = value!;
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
                        TableRow(children: [
                          TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Text(
                              "أم",
                              textAlign: TextAlign.right,
                              style: textStyle6,
                            ),
                          ),
                          CheckboxListTile(
                            activeColor: Color(0xff385a4a),
                            value: Om,
                            onChanged: (bool? value) {
                              setState(() {
                                Om = value!;
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
                        TableRow(children: [
                          TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Text(
                              "هج",
                              textAlign: TextAlign.right,
                              style: textStyle6,
                            ),
                          ),
                          CheckboxListTile(
                            activeColor: Color(0xff385a4a),
                            value: hj,
                            onChanged: (bool? value) {
                              setState(() {
                                hj = value!;
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
                        TableRow(children: [
                          TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Text(
                              "قط",
                              textAlign: TextAlign.right,
                              style: textStyle6,
                            ),
                          ),
                          CheckboxListTile(
                            activeColor: Color(0xff385a4a),
                            value: qat,
                            onChanged: (bool? value) {
                              setState(() {
                                qat = value!;
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
                        TableRow(children: [
                          TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Text(
                              "فن",
                              textAlign: TextAlign.right,
                              style: textStyle6,
                            ),
                          ),
                          CheckboxListTile(
                            activeColor: Color(0xff385a4a),
                            value: fun,
                            onChanged: (bool? value) {
                              setState(() {
                                fun = value!;
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
                        TableRow(children: [
                          TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Text(
                              "عم",
                              textAlign: TextAlign.right,
                              style: textStyle6,
                            ),
                          ),
                          CheckboxListTile(
                            activeColor: Color(0xff385a4a),
                            value: Am,
                            onChanged: (bool? value) {
                              setState(() {
                                Am = value!;
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
                        TableRow(children: [
                          TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Text(
                              "ذو",
                              textAlign: TextAlign.right,
                              style: textStyle6,
                            ),
                          ),
                          CheckboxListTile(
                            activeColor: Color(0xff385a4a),
                            value: tho,
                            onChanged: (bool? value) {
                              setState(() {
                                tho = value!;
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
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    width: 155,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff394445),
                      ),
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
                ]),
              ),
            )
          ],
        ),
      )),
    );
  }
}
