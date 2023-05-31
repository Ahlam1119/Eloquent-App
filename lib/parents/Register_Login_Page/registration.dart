import 'package:eloquentapp/screens/constants.dart';
import 'package:eloquentapp/services/firebase_helper.dart';
import 'package:flutter/material.dart';
import 'package:eloquentapp/parents/Register_Login_Page/child_Registration.dart';

class RegistrationScreen extends StatefulWidget {
  static String id = 'registration_screen';

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  // final _auth = FirebaseAuth.instance;
  //varibale
  late String name;
  late String email;
  late String pass;
  late String ConfirmPass;
  late String phone;

//add user detilas to data base
  // Future AddUserDitals(
  //     String name, String email, String pass, String Phone, String uuId) async {
  //   await FirebaseFirestore.instance.collection("Parent").add({
  //     'Name': name,
  //     'Email': email,
  //     'Password': pass,
  //     'Phone': Phone,
  //     'Uuid': uuId
  //   });
  // }

  //Confirm Password
  bool passwordConfermd() {
    if (pass == ConfirmPass) {
      return true;
    } else {
      print('pass not match');
      return false;
    }
  }
  //The new code with jason will be in this section

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('تسجيل بيانات الوالدين'),
              SizedBox(
                height: 15,
              ),
              //Name Text Filed
              Text('الأسم'),
              TextField(
                onChanged: (value) {
                  name = value;
                },
                decoration: kStylingInputDec,
              ),
              SizedBox(
                height: 10,
              ),
              //Email Text Filed
              Text('البريد الإلكتروني'),
              TextField(
                onChanged: (value) {
                  email = value;
                },
                decoration: kStylingInputDec,
              ),
              SizedBox(
                height: 10,
              ),
              //phone Text Filed
              Text('رقم الجوال'),
              TextField(
                  onChanged: (value) {
                    phone = value;
                  },
                  keyboardType: TextInputType.phone,
                  decoration: kStylingInputDec.copyWith(
                    hintText: '+966 535 241 724',
                    hintStyle:
                        TextStyle(color: Color.fromARGB(170, 158, 158, 158)),
                  )),
              //pass Text Filed
              Text('كلمة المرور'),
              TextField(
                obscureText: true,
                onChanged: (value) {
                  pass = value;
                },
                decoration: kStylingInputDec,
              ),
              SizedBox(
                height: 15,
              ),
              //Confirm Pass Text Filed
              Text('إعادة كلمة المرور'),
              TextField(
                obscureText: true,
                onChanged: (value) {
                  ConfirmPass = value;
                },
                decoration: kStylingInputDec,
              ),
              SizedBox(
                height: 15,
              ),
              ElevatedButton(
                  onPressed: () async {
                    //Naw fuction section
                    if (passwordConfermd()) {
                      try {
                        final isSaved = await FirebaseHelperParent.saveUser(
                            email: email,
                            password: pass,
                            name: name,
                            phone: phone);
                        if (isSaved) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChildRegistration(),
                              ));
                        }

                        print(isSaved);
                      } catch (e) {
                        print(e);
                      }
                    }
                  },
                  child: Text('التالي')),
            ],
          ),
        ),
      )),
    );
  }

  //TODO
  // isValidForm(){

  // }
}
