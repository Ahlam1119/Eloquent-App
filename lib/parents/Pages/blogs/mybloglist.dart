import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eloquentapp/parents/Pages/blogs/blogPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class mybloglist extends StatefulWidget {
  const mybloglist({super.key});

  @override
  State<mybloglist> createState() => _mybloglistState();
}

class _mybloglistState extends State<mybloglist> {
  final FirebaseStorage storage = FirebaseStorage.instance;
  final _auth = FirebaseAuth.instance;

  late User singedInUser;
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

  //Get User info from database
  final CollectionReference blog =
      FirebaseFirestore.instance.collection('blog');
  late Query query = blog.where('Parentuid', isEqualTo: singedInUser.uid);
  late Stream<QuerySnapshot> blogStream = query.snapshots();
  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }
  //----------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFFFBFBFB),
      body: StreamBuilder<QuerySnapshot>(
        stream: blogStream,
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: streamSnapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final DocumentSnapshot documentSnapshot =
                      streamSnapshot.data!.docs[index];
                  String imageUrl = documentSnapshot['image'];
                  return Container(
                    padding: EdgeInsets.only(right: 15),
                    width: 220,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                    ),
                    child: GestureDetector(
                      onTap: (() {
                        final String blogid = documentSnapshot['uid'];
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => blogPage(
                                      blogId: blogid,
                                    )));
                      }),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(17.80)),
                        child: Column(
                          children: [
                            Container(
                              height: 120,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10.0),
                                    topRight: Radius.circular(10.0),
                                  ),
                                  image: DecorationImage(
                                    image: NetworkImage(imageUrl),
                                    fit: BoxFit.fill,
                                  )),
                            ),
                            Text(
                              documentSnapshot['blogTitle'],
                              style: TextStyle(fontSize: 20),
                              textAlign: TextAlign.center,
                            )
                            // SizedBox(
                            // height: 100,
                            // child: CircleAvatar(
                            // backgroundImage:
                            // NetworkImage(imageUrl),
                            // ),
                            // )
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
             //  Card(
             //  elevation: 4,
             //  color: Colors.white,
             //  shape: RoundedRectangleBorder(
             //  borderRadius: BorderRadius.circular(17.80)),
             //  child: Container(
             //  width: MediaQuery.of(context).size.width,
             //  padding:
             //  EdgeInsets.symmetric(horizontal: 10, vertical: 10),
             //  child: Column(
             //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
             //  crossAxisAlignment: CrossAxisAlignment.start,
             //  children: [
             //  Row(
             //  children: [
             //  Container(
             //  padding: EdgeInsets.only(left: 60),
             //  child: Icon(
             //  Icons.home,
             //  size: 17,
             //  )),
             //  Text(
             //  ' مركز المدينة للتخاطب',
             //  style: TextStyle(
             //  color: Color(0xff687c71),
             //  fontSize: 11,
             //  ),
             //  ),
             //  SizedBox(
             //  width: 55,
             //  ),
             //  Icon(
             //  Icons.timer,
             //  size: 16,
             //  ),
             //  Text(
             //  '9:00 صباحاَ',
             //  style: TextStyle(
             //  color: Color(0xff687c71),
             //  fontSize: 11,
             //  ),
             //  )
             //  ],
             //  ),
             //  SizedBox(
             //  height: 14,
             //  ),
             //  Row(
             //  mainAxisAlignment: MainAxisAlignment.center,
             //  children: [
             //  ElevatedButton(
             //  style: ElevatedButton.styleFrom(
             //  minimumSize: Size(129, 27),
             //  backgroundColor: Color(0xff394445),
             //  elevation: 3,
             //  shape: const RoundedRectangleBorder(
             //  borderRadius:
             //  BorderRadius.all(Radius.circular(6)),
             //  )),
             //  onPressed: () {
             //  late String name = documentSnapshot['name'];
             //  late String uid = documentSnapshot['uid'];
             //  Navigator.push(
             //  context,
             //  MaterialPageRoute(
             //  builder: (context) => Profilet(
             //  therapisid: uid,
             //  ),
             //  ));
             //  },
             //  child: Text(
             //  'احجز جلستك  ',
             //  style: TextStyle(
             //  color: Colors.white,
             //  fontSize: 14,
             //  fontFamily: "Cairo",
             //  fontWeight: FontWeight.w500,
             //  ),
             //  ),
             //  ),
             // ElevatedButton(
             //     onPressed: () {
             //       final RequestId = Uuid().v4();
             //       _TherapistName = documentSnapshot['Name'];
             //       late String uid = documentSnapshot['Uuid'];
             //       Navigator.push(
             //           context,
             //           MaterialPageRoute(
             //             builder: (context) => Request(
             //               TherapistId: uid,
             //             ),
             //           ));
             //       RequstInfo(
             //           _ParentName,
             //           'InPrograss',
             //           _TherapistName,
             //           RequestId,
             //           _TherapistID);
             //     },
             //     child: Text("ارسال طلب"))
             //  ],
             //  )
             //  ],
             //  ),
             //  ),
             // ListTile(
             //   title: Text(documentSnapshot['Name']),
             //   subtitle: Text(documentSnapshot['Email']),
             //   trailing: ElevatedButton(
             //     onPressed: () {
             //       RequstInfo(
             //           documentSnapshot['Name'], 'InPrograss');
             //     },
             //     child: Text('حجز جلسة'),
             //   ),
             // ),
//  );
