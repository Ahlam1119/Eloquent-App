import 'package:eloquentapp/screens/loginTC.dart';
import 'package:flutter/material.dart';
import 'package:eloquentapp/parents/Register_Login_Page/login.dart';
import 'package:eloquentapp/therapist/Register_Login_Page/login.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = 'Welcome_screen';

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                /**-------------- image logo section -------------------**/
                Container(
                    width: 228,
                    height: 322,
                    child: Image(image: AssetImage('images/hazem.jpg'))),
                SizedBox(height: 10),
                Text(
                  'اهلا بكم,في بليغ',
                  style: TextStyle(
                    color: Color(0xff385a4a),
                    fontSize: 30,
                    fontFamily: "Cairo",
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 59.50),

                /**--------------Parent login -------------------**/
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(230, 30),
                    backgroundColor: Color(0xff394445),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, LoginScreen.id);
                  },
                  child: Text(
                    'ولي امر الطفل',
                    style: TextStyle(
                      color: Color(0xffF8F8F8),
                      fontSize: 14,
                      fontFamily: "Cairo",
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                /**----------------Therapis Login-----------------------------**/

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(230, 30),
                      backgroundColor: const Color(0xff394445),
                      elevation: 3,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                      )),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => loginTC(),
                        ));
                  },
                  child: const Text(
                    ' المختصين',
                    style: TextStyle(
                      color: Color(0xffF8F8F8),
                      fontSize: 14,
                      fontFamily: "Cairo",
                      fontWeight: FontWeight.w500,
                    ),
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
