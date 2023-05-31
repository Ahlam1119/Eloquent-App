// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class PassLeterScreen extends StatefulWidget {
//   @override
//   _PassLeterScreenState createState() => _PassLeterScreenState();
// }

// class _PassLeterScreenState extends State<PassLeterScreen> {
//   Future<String?> getMostFrequentLetter() async {
//     final snapshot = await FirebaseFirestore.instance
//         .collection('PassLeter')
//         .where('pass', isEqualTo: false)
//         .get();

//     final documents = snapshot.docs;
//     final letterMap = Map<String, int>();

//     for (final doc in documents) {
//       final letterName = doc.get('letterName');
//       letterMap[letterName] = (letterMap[letterName] ?? 0) + 1;
//     }

//     final letterList = letterMap.entries.toList();

//     letterList.sort((a, b) => b.value - a.value);

//     if (letterList.isEmpty) {
//       return null;
//     }

//     final mostFrequentLetter = letterList.first.key;

//     print('Most frequent letter: $mostFrequentLetter');

//     return mostFrequentLetter;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('PassLeter'),
//       ),
//       body: FutureBuilder<String?>(
//         future: getMostFrequentLetter(),
//         builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           }

//           if (snapshot.hasError || snapshot.data == null) {
//             return Text('Error: ${snapshot.error}');
//           }

//           final mostFrequentLetter = snapshot.data!;

//           return Center(
//             child: Text(
//               'Most frequent letter: $mostFrequentLetter',
//               style: TextStyle(fontSize: 24),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
