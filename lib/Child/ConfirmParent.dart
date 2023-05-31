import 'dart:math';
import 'dart:ui';

import 'package:eloquentapp/parents/BottomNavBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class ConfairmParent extends StatefulWidget {
  const ConfairmParent({super.key});

  @override
  State<ConfairmParent> createState() => _ConfairmParentState();
}

class _ConfairmParentState extends State<ConfairmParent> {
  int? _userNumber;
  String? _num;
  late int _generatedNumber;
  late int digit1;
  late int digit2;
  late int digit3;
  late int digit4;

  @override
  void initState() {
    super.initState();
    // _generatedNumber = Random().nextInt(100) + 1;

    // Generate four random numbers between 1 and 10
    _generatedNumber = Random().nextInt(9000) + 1000;

    int number = _generatedNumber;
    digit1 = number ~/ 1000; // 1
    digit2 = (number % 1000) ~/ 100; // 2
    digit3 = (number % 100) ~/ 10; // 3
    digit4 = number % 10; // 4
  }

  Color accentPurpleColor = Color(0xFF6A53A1);
  Color primaryColor = Color(0xFF121212);
  Color accentPinkColor = Color(0xFFF99BBD);
  Color accentDarkGreenColor = Color(0xFF115C49);
  Color accentYellowColor = Color(0xFFFFB612);
  Color accentOrangeColor = Color(0xFFEA7A3B);

  TextStyle? createStyle(Color color) {
    ThemeData theme = Theme.of(context);
    return theme.textTheme.headline3?.copyWith(color: color);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "بوابة الأمان",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Color(0xff394445),
                    fontSize: 26,
                    fontFamily: "Cairo",
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "هذه خطوة احترازية لنضمن أنك أحد الوالدين",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Color(0xff6888a0),
                    fontSize: 15,
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Text(
                digit1.toString() +
                    " " +
                    digit2.toString() +
                    " " +
                    digit3.toString() +
                    " " +
                    digit4.toString(),
                style: TextStyle(
                  color: Color(0xff385a4a),
                  fontSize: 32,
                  fontFamily: "Inter",
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              OtpTextField(
                numberOfFields: 4,
                borderColor: accentPurpleColor,
                focusedBorderColor: accentPurpleColor,

                showFieldAsBox: false,
                borderWidth: 4.4,
                margin: EdgeInsets.only(right: 30, bottom: 20),
                // runs when a code is typed in
                onCodeChanged: (value) {
                  setState(() {
                    _userNumber = int.tryParse(value);
                  });

                  //handle validation or checks here if necessary
                },

                onSubmit: (_userNumber) {
                  _num = _userNumber;
                  // print(_userNumber);
                  // if (_userNumber == _generatedNumber) {
                  //   Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //           builder: (context) => MyBottomNavigationBar()));
                  // } else {
                  //   showDialog(
                  //     context: context,
                  //     builder: (BuildContext context) {
                  //       return AlertDialog(
                  //         title: Text('خطأ'),
                  //         content: Text('The number you entered is incorrect.'),
                  //         actions: <Widget>[
                  //           ElevatedButton(
                  //             child: Text('OK'),
                  //             onPressed: () {
                  //               Navigator.of(context).pop();
                  //             },
                  //           ),
                  //         ],
                  //       );
                  //     },
                  //   );
                  // }
                },

                //runs when every textfield is filled
              ),
              // TextField(
              //   keyboardType: TextInputType.number,
              //   decoration: InputDecoration(
              //     labelText: 'Enter the number',
              //   ),
              //   onChanged: (value) {
              //     setState(() {

              //     });
              //   },
              // ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff394445),
                      minimumSize: Size(270, 50),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                      )),
                  child: Text('تحقق'),
                  onPressed: () {
                    if (_num == _generatedNumber.toString()) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyBottomNavigationBar()));
                    } else {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            title: Text(
                              'خطأ',
                              style: TextStyle(
                                color: Color(0xff394445),
                                fontSize: 20,
                                fontFamily: "Cairo",
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            content: Text(
                              'الرقم الذي ادخلته غير صحيح',
                              style: TextStyle(
                                  color: Color(0xff6888a0),
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700),
                            ),
                            actions: <Widget>[
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xff394445),
                                    shape: const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(6)),
                                    )),
                                child: Text(
                                  'حسناَ',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
