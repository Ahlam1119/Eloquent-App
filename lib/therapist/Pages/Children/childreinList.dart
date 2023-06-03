import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eloquentapp/therapist/Pages/Children/ChildProfile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChildrenList extends StatefulWidget {
  const ChildrenList({super.key});

  @override
  State<ChildrenList> createState() => _ChildrenListState();
}

class _ChildrenListState extends State<ChildrenList> {
  final CollectionReference _Child =
      FirebaseFirestore.instance.collection('Child');

  Future<List<String>> getChildrenIds() async {
    return await FirebaseFirestore.instance
        .collection('acceptedSessions')
        .where('TherapistID', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) => value.docs
            .map((doc) => doc.data()['ChildID'] as String)
            .toSet()
            .toList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                'قائمة الأطفال',
                style: TextStyle(
                  color: Color(0xff385a4a),
                  fontSize: 20,
                  fontFamily: "Cairo",
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Text(
              textAlign: TextAlign.right,
              'تعرض هذه القائمة جميع الأطفال\nالمسجلين لدى الأخصائي',
              style: TextStyle(
                color: Color(0xff385a4a),
                fontSize: 14,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: Container(
                //هنا اعرض القائمة
                child: FutureBuilder(
                  future: getChildrenIds(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState != ConnectionState.done)
                      return const Center(child: CircularProgressIndicator());
                    if (!snapshot.hasData ||
                        snapshot.data == null ||
                        snapshot.data!.isEmpty) {
                      return Row(children: const [SizedBox()]);
                    }
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Card(
                                elevation: 4,
                                shadowColor: Color.fromARGB(105, 0, 0, 0),
                                color: Color(0xfff6f7f7),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(17.80)),
                                child: AnimatedSize(
                                  duration: const Duration(milliseconds: 750),
                                  curve: Curves.fastLinearToSlowEaseIn,
                                  child: StreamBuilder(
                                      stream: _Child.doc(snapshot.data![index])
                                          .snapshots(),
                                      builder: (context, streamSnapshot) {
                                        if (streamSnapshot.connectionState !=
                                            ConnectionState.active) {
                                          return const Padding(
                                            padding: EdgeInsets.all(16.0),
                                            child: Center(
                                                child:
                                                    CircularProgressIndicator(
                                                        color: Colors.grey)),
                                          );
                                        }
                                        if (!streamSnapshot.hasData ||
                                            streamSnapshot.data == null ||
                                            !streamSnapshot.data!.exists) {
                                          return Row(
                                              children: const [SizedBox()]);
                                        }
                                        final DocumentSnapshot
                                            documentSnapshot =
                                            streamSnapshot.data!;
                                        return GestureDetector(
                                          onTap: () {
                                            final String ChildId =
                                                documentSnapshot['uid'];
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ChildFile(
                                                          ChildID: ChildId),
                                                ));
                                          },
                                          child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 5, vertical: 10),
                                              alignment: Alignment.center,
                                              width: 275,
                                              height: 80,
                                              child: ListTile(
                                                leading: CircleAvatar(
                                                  radius: 25,
                                                  backgroundColor:
                                                      Color(0xffEFF5F2),
                                                  foregroundColor:
                                                      Color(0xffEFF5F2),
                                                  backgroundImage: AssetImage(
                                                      documentSnapshot[
                                                          'ChildAvatar']),
                                                ),
                                                title: Text(
                                                  documentSnapshot['name'],
                                                  textAlign: TextAlign.right,
                                                  style: TextStyle(
                                                    color: Color(0xff385a4a),
                                                    fontSize: 17,
                                                    fontFamily: "Cairo",
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                                subtitle: Row(
                                                  children: [
                                                    Image.asset(
                                                        'images/parent.png'),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      documentSnapshot[
                                                          'ParentName'],
                                                      textAlign:
                                                          TextAlign.right,
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xff6888a0),
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                trailing: Icon(Icons.more_vert),
                                              )),
                                        );
                                      }),
                                )),
                          );
                        });
                  },
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
