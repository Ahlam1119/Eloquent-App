import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eloquentapp/screens/callPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class preivouse extends StatefulWidget {
  const preivouse({super.key});

  @override
  State<preivouse> createState() => _preivouseState();
}

class _preivouseState extends State<preivouse> {
  //instance for cloud firestore
  final _auth = FirebaseAuth.instance;
  late String TherapistNote;

  late User singedInUser;
  @override
  void initState() {
    super.initState();
    getCurrentUser();
    getUserData();
  }

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        singedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  TextEditingController SessionName = TextEditingController();
  TextEditingController SessionGoul = TextEditingController();

  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  final CollectionReference usersRef = _db.collection('acceptedSessions');
  late Query query = usersRef
      .where('TherapistID', isEqualTo: singedInUser.uid)
      .where('TherapistStatus', isEqualTo: 'attandend');

  late Stream<QuerySnapshot> usersStream = query.snapshots();

  ///get session  id----------------------------------------------------------------
  Map<String, dynamic> SessionData = {};

  //get all user data and store to Map
  getUserData() async {
    await FirebaseFirestore.instance
        .collection('acceptedSessions')
        .where("TherapistID", isEqualTo: singedInUser.uid)
        .get()
        .then((v) {
      for (var element in v.docs) {
        SessionData.addAll(element.data());
      }
    });
  }

  late String SessionID = SessionData['sessionID'];
  late String TherapistName = SessionData['TherapistName'];
  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<QuerySnapshot>(
        stream: usersStream,
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
                itemCount: streamSnapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final DocumentSnapshot documentSnapshot =
                      streamSnapshot.data!.docs[index];

                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 5,
                    ),
                    child: Card(
                      elevation: 4,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(17.80)),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const SizedBox(width: 5),
                                    Text(
                                      documentSnapshot['SessionName'],
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        color: Color(0xff385a4a),
                                        fontSize: 17,
                                        fontFamily: "Cairo",
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Image.asset(
                                      "images/NameCard.png",
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      documentSnapshot['ChildName'],
                                      style: TextStyle(
                                        color: Color(0xff6888a0),
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Image.asset(
                                      "images/Calnder.png",
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      "موعد الجلسة :" +
                                          documentSnapshot['Date'],
                                      style: TextStyle(
                                        color: Color(0xff6888a0),
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                });
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
