import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class blogPage extends StatefulWidget {
  late String blogId;
  blogPage({required this.blogId});

  @override
  State<blogPage> createState() => _blogPageState();
}

class _blogPageState extends State<blogPage> {
  final _auth = FirebaseAuth.instance;
  late String blogId = widget.blogId;
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  Map<String, dynamic> blogDetails = {};
  bool isLoded = true;
  getUserBlog() async {
    await FirebaseFirestore.instance
        .collection('blog')
        .where("uid", isEqualTo: blogId)
        .get()
        .then((v) {
      for (var element in v.docs) {
        blogDetails.addAll(element.data());
        setState(() {
          isLoded = false;
        });
      }
    });
  }

  late String title = blogDetails['blogTitle'];
  late String Content = blogDetails['blog'];

  void initState() {
    super.initState();
    getUserBlog();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: isLoded == true
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: SafeArea(
                    child: Stack(
                  children: [
                    Container(
                      width: 423,
                      height: 200,
                      padding: EdgeInsets.only(
                          top: 60, left: 30, right: 30, bottom: 30),
                      decoration: BoxDecoration(
                        color: Color(0xff385a4a),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30)),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 90),
                        child: Text(
                          "$title",
                          style: TextStyle(
                            color: Color.fromARGB(255, 244, 245, 245),
                            fontSize: 20,
                            fontFamily: "Cairo",
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_forward_ios_outlined,
                            color: Colors.white, size: 20.0),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    SizedBox(
                      height: 100,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 190),
                      child: Column(children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 20),
                          child: SizedBox(
                              // color: Color.fromARGB(255, 198, 195, 195),

                              ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Text("$Content"),
                        )
                      ]),
                    ),
                  ],
                )),
              ));
  }
}
