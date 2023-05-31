import 'package:eloquentapp/widget/label.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:input_quantity/input_quantity.dart';
import 'package:uuid/uuid.dart';

class supportAndHelp extends StatefulWidget {
  static String id = 'MParent_screen';

  @override
  State<supportAndHelp> createState() => _supportAndHelpState();
}

class _supportAndHelpState extends State<supportAndHelp> {
  final _auth = FirebaseAuth.instance;

  late String UserId;
  late String Respond;

  final CollectionReference _HelpAndSupport =
      FirebaseFirestore.instance.collection('HelpAndSupport');

  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  final CollectionReference freQRef = _db.collection('Respond');
  void _ResopndHelpAndSupport(
      {required String RespondID,
      required String Respond,
      required String UserID,
      required bool isRead}) async {
    try {
      await freQRef.add({
        "Respond": Respond,
        "RespondID": RespondID,
        "UserID": UserID,
        "isRead": false
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    var textStyle = TextStyle(fontSize: 13, fontWeight: FontWeight.w700);
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'طلبات الصيانة والدعم ',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              color: Color(0xff385a4a),
                              fontSize: 25,
                              //fontFamily: "Cairo",
                              fontWeight: FontWeight.w700),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.arrow_forward_ios_outlined,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                    Text(
                      textAlign: TextAlign.right,
                      "جميع طلبات الصيانة والدعم تعرض في هذه القائمة ",
                      style: TextStyle(
                        color: Color(0xff9bb0a5),
                        fontWeight: FontWeight.w800,
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    //هيكل التاب بار ولازم يكون بالترتيب مع الجزء الثاني

                    Expanded(
                      child: TabBarView(
                        children: [
                          StreamBuilder(
                            stream: _HelpAndSupport.snapshots(),
                            builder: (context,
                                AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                              if (streamSnapshot.hasData) {
                                return ListView.builder(
                                  itemCount: streamSnapshot.data!.docs.length,
                                  itemBuilder: (context, index) {
                                    final DocumentSnapshot documentSnapshot =
                                        streamSnapshot.data!.docs[index];

                                    return Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 5),
                                      child: Card(
                                        elevation: 4,
                                        shadowColor:
                                            Color.fromARGB(105, 0, 0, 0),
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(17.80),
                                        ),
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 10),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                      width: 55,
                                                      height: 55,
                                                      child: Image.asset(
                                                          "images/support.png")),
                                                  SizedBox(width: 10),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          documentSnapshot[
                                                              'question'],
                                                          textAlign:
                                                              TextAlign.right,
                                                          style: TextStyle(
                                                            color: Color(
                                                                0xff385a4a),
                                                            fontSize: 15,
                                                            fontFamily: "Cairo",
                                                            fontWeight:
                                                                FontWeight.w700,
                                                          ),
                                                        ),
                                                        SizedBox(height: 8),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(width: 10),
                                                  IconButton(
                                                    icon: Icon(Icons.edit),
                                                    onPressed: () {
                                                      showDialog(
                                                          context: context,
                                                          builder: (context) =>
                                                              Theme(
                                                                  data: ThemeData(
                                                                      useMaterial3:
                                                                          true),
                                                                  child:
                                                                      Directionality(
                                                                    textDirection:
                                                                        TextDirection
                                                                            .rtl,
                                                                    child:
                                                                        AlertDialog(
                                                                      shape: RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.all(Radius.circular(18.31))),
                                                                      insetPadding:
                                                                          EdgeInsets.all(
                                                                              15),
                                                                      title:
                                                                          Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          const Text(
                                                                            "المساعدة والدعم",
                                                                            style:
                                                                                TextStyle(
                                                                              color: Color(0xff385a4a),
                                                                              fontSize: 20,
                                                                              fontFamily: "Cairo",
                                                                              fontWeight: FontWeight.w700,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      content:
                                                                          SizedBox(
                                                                        width:
                                                                            365,
                                                                        height:
                                                                            200,
                                                                        child:
                                                                            TextField(
                                                                          onChanged:
                                                                              (Value) {
                                                                            Respond =
                                                                                Value;
                                                                          },
                                                                          keyboardType:
                                                                              TextInputType.multiline,
                                                                          maxLines:
                                                                              8,
                                                                          textDirection:
                                                                              TextDirection.rtl,
                                                                          decoration:
                                                                              InputDecoration(
                                                                            border:
                                                                                OutlineInputBorder(
                                                                              borderSide: BorderSide.none,
                                                                              borderRadius: BorderRadius.circular(7.0),
                                                                            ),
                                                                            filled:
                                                                                true,
                                                                            fillColor: Color.fromARGB(
                                                                                28,
                                                                                191,
                                                                                209,
                                                                                199),
                                                                            hintText:
                                                                                "اكتب ردك هنا",
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      actions: [
                                                                        Center(
                                                                          child:
                                                                              ElevatedButton(
                                                                            style: ElevatedButton.styleFrom(
                                                                                minimumSize: Size(160, 39),
                                                                                backgroundColor: Color(0xff385a4a),
                                                                                shape: const RoundedRectangleBorder(
                                                                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                                                                )),
                                                                            onPressed:
                                                                                (() {
                                                                              final String RespondID = const Uuid().v4();
                                                                              _ResopndHelpAndSupport(UserID: documentSnapshot['UserID'], RespondID: RespondID, Respond: Respond, isRead: false);

                                                                              Navigator.pop(context);
                                                                              showDialog(
                                                                                  context: context,
                                                                                  builder: (context) => AlertDialog(
                                                                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(18.31))),
                                                                                        insetPadding: EdgeInsets.all(15),
                                                                                        title: Text(
                                                                                          'هل انت متاكد من ارسال الرد؟',
                                                                                        ),
                                                                                        actions: [
                                                                                          Center(
                                                                                            child: ElevatedButton(
                                                                                                style: ElevatedButton.styleFrom(
                                                                                                  backgroundColor: Color(0xff385a4a),
                                                                                                ),
                                                                                                onPressed: () {
                                                                                                  _delete(documentSnapshot.id);
                                                                                                  Navigator.pop(context); // Dismiss the AlertDialog
                                                                                                },
                                                                                                child: Text("نعم")),
                                                                                          ),
                                                                                        ],
                                                                                      ));
                                                                            }),
                                                                            child:
                                                                                Text(
                                                                              "ارسال",
                                                                              style: TextStyle(
                                                                                color: Colors.white,
                                                                                fontSize: 15,
                                                                                fontFamily: "Cairo",
                                                                                fontWeight: FontWeight.w500,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  )));
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              }
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ]),
            ),
          ),
        ));
  }

  Future<void> _delete(String document) async {
    await _HelpAndSupport.doc(document).delete();
  }
}
