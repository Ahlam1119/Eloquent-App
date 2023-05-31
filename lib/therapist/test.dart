// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:eloquentapp/screens/callPage.dart';

// class test extends StatefulWidget {
//   const test({super.key});

//   @override
//   State<test> createState() => _testState();
// }

// class _testState extends State<test> {
//   //instance for auth
//   final _auth = FirebaseAuth.instance;
//   late User singedInUser;

//   void initState() {
//     super.initState();
//     getCurrentUser();
//   }

//   void getCurrentUser() {
//     try {
//       final user = _auth.currentUser;
//       if (user != null) {
//         singedInUser = user;
//         print(singedInUser);
//       }
//     } catch (e) {
//       print(e);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Column(children: [
//           ElevatedButton(
//             onPressed: () {
//               Navigator.push(context, MaterialPageRoute(
//                 builder: (context) {
//                   return CallPage(
//                     callID: "call",
//                     UserId: singedInUser.uid,
//                   );
//                 },
//               ));
//             },
//             child: Text('vediocall'),
//           ),
//         ]),
//       ),
//     );
//   }
// }
