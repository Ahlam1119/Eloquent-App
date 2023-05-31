import 'package:eloquentapp/therapist/Register_Login_Page/login.dart';
import 'package:eloquentapp/therapist/Register_Login_Page/register.dart';
import 'package:eloquentapp/therapist/Register_Login_Page/registration.dart';
import 'package:flutter/material.dart';
import 'package:eloquentapp/screens/welcome.dart';
import 'package:eloquentapp/parents/Register_Login_Page/login.dart';
import 'package:eloquentapp/parents/Register_Login_Page/registration.dart';
import 'package:eloquentapp/parents/Pages/home.dart';
import 'package:eloquentapp/therapist/Pages/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  //conect the project to firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(eloquent());
}

class eloquent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:
          false, // Set this property to false to remove the "Debug" banner

      //تحويل التطبيق للعربي
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ar', 'AE'), // English
      ],
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        ParentHomeScreen.id: (context) => ParentHomeScreen(),
        TherapistHomeScreen.id: (context) => TherapistHomeScreen(),
        ThtRegistration.id: (context) => const ThtRegistration(),
        // TherapistList.id: (context) => TherapistList(),
      },
    );
  }
}
