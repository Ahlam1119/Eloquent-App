import 'dart:io';
import 'package:eloquentapp/parents/Pages/blogs/bloglist.dart';
import 'package:eloquentapp/parents/Pages/blogs/mybloglist.dart';
import 'package:eloquentapp/services/firebase_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:mockito/mockito.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class Blogs extends StatefulWidget {
  static String id = 'Home_screen';

  @override
  State<Blogs> createState() => _BlogsState();
}

class _BlogsState extends State<Blogs> {
  //instance of  firestore auth
  final _auth = FirebaseAuth.instance;
  late User singedInUser;
  var uuid = Uuid();
  late String blogs;
  late String blogtitle;
  late String images;
  String imageUrl = '';
  //get current user
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

  void initState() {
    super.initState();
    getCurrentUser();
    getUserData();
    getChildData();
  }

  bool isLoded = true;
  bool hasBolg = true;
  //get Parent Date  and store it to Map
  Map<String, dynamic> ParentData = {};
  getUserData() async {
    await FirebaseFirestore.instance
        .collection('Parent')
        .where("uid", isEqualTo: singedInUser.uid)
        .get()
        .then((v) {
      for (var element in v.docs) {
        ParentData.addAll(element.data());
        setState(() {
          isLoded = false;
        });
      }
    });
  }

  Map<String, dynamic> blogInfo = {};
  getChildData() async {
    await FirebaseFirestore.instance
        .collection('blog')
        .where("Parentuid", isEqualTo: singedInUser.uid)
        .get()
        .then((v) {
      for (var element in v.docs) {
        blogInfo.addAll(element.data());
        setState(() {
          hasBolg = false;
        });
      }
    });
  }

  late String Name = ParentData['name'];
  late String IdParent = ParentData["uid"];

  //retrive
  // final CollectionReference _blog =
  // FirebaseFirestore.instance.collection('blog');
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      //9BB0A5

      body: isLoded == true
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: SafeArea(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 1.3,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 13,
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      " اهلاَ " + Name,
                                      style: TextStyle(
                                        color: Color(0xff385a4a),
                                        fontSize: 20,
                                        fontFamily: "Cairo",
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Text(
                                      "لست وحيدة في هذه الرحلة,\nشارك تجربتك وقصتك مع الاخرين ",
                                      style: TextStyle(
                                          color: Color(0xff9bb0a5),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                      textAlign: TextAlign.right,
                                    ),
                                  ],
                                ),
                                Spacer(),
                                CircleAvatar(
                                  backgroundColor: Colors.white,
                                  child: Image.asset("images/hazem.jpg"),
                                  radius: 24,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: 70,
                            child: TextField(
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                maxLength: 25,
                                expands: true,
                                onChanged: (value) {
                                  setState(() {
                                    blogtitle = value;
                                  });
                                },
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  filled: true, //<-- SEE HERE
                                  fillColor: Color.fromARGB(6, 27, 28, 27),
                                  focusedBorder: InputBorder.none,
                                  hintText: "عنوان المدونة",
                                  hintStyle: TextStyle(),
                                )),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 200,
                            child: TextField(
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                expands: true,
                                onChanged: (value) {
                                  setState(() {
                                    blogs = value;
                                  });
                                },
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  filled: true, //<-- SEE HERE
                                  fillColor: Color.fromARGB(6, 27, 28, 27),
                                  focusedBorder: InputBorder.none,
                                  hintText: "اكتب قصتك هنا",
                                  hintStyle: TextStyle(),
                                )),
                          ),
                          SizedBox(
                            height: 9,
                          ),
                          CircleAvatar(
                            backgroundColor: Color(0xff385a4a),
                            child: IconButton(
                                color: Color.fromARGB(255, 244, 235, 235),
                                onPressed: () async {
                                  ImagePicker imagePicker = ImagePicker();
                                  XFile? file = await imagePicker.pickImage(
                                      source: ImageSource.gallery);
                                  print("${file?.path}");
                                  if (file == null) return;
                                  String uniqueFileName = DateTime.now()
                                      .millisecondsSinceEpoch
                                      .toString();
                                  Reference referenceRoot =
                                      FirebaseStorage.instance.ref();
                                  Reference referenceDirImages =
                                      referenceRoot.child("images");
                                  //ref to upload
                                  Reference referenceImageToUpload =
                                      referenceDirImages.child(uniqueFileName);
                                  try {
                                    await referenceImageToUpload
                                        .putFile(File(file.path));
                                    imageUrl = await referenceImageToUpload
                                        .getDownloadURL();
                                  } catch (e) {}
                                  //ref to store
                                },
                                icon: Icon(Icons.camera_alt)),
                          ),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    minimumSize: Size(100, 35),
                                    backgroundColor: Color(0xff394445),
                                    elevation: 3,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(11)),
                                    )),
                                onPressed: () async {
                                  if (imageUrl.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text("")));
                                    return;
                                  }
                                  late final blogId = uuid.v4();
                                  try {
                                    final isSaved = await bolgHelper.saveUser(
                                        ParentName: Name,
                                        Parentuid: IdParent,
                                        blog: blogs,
                                        blogTitle: blogtitle,
                                        uid: blogId,
                                        image: imageUrl);

                                    if (isSaved) {
                                      // Navigator.push(
                                      // context,
                                      // MaterialPageRoute(
                                      // builder: (context) =>
                                      // parentProfile()));
                                      // Navigator.pop(context);
                                      showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                                title: Text(
                                                    "تم نشر المدونة بنجاح"),
                                              ));
                                    }
                                  } catch (e) {
                                    print(e);
                                  }
                                },
                                child: Text(
                                  "شارك قصتك",
                                )),
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Text(
                            "مدوناتك السابقة",
                            style: TextStyle(
                              color: Color(0xff385a4a),
                              fontSize: 23,
                              fontFamily: "Cairo",
                              fontWeight: FontWeight.w600,
                            ),
                          ),

                          hasBolg == true
                              ? Padding(
                                  padding: const EdgeInsets.only(
                                      top: 30, bottom: 85, right: 10),
                                  child: Text(
                                    "لايوجد لديك مدونات",
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 217, 8, 8),
                                      fontSize: 24,
                                      fontFamily: "Cairo",
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                )
                              : const Expanded(
                                  child: mybloglist(),
                                ),

                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "المدونات",
                            style: TextStyle(
                              color: Color(0xff385a4a),
                              fontSize: 23,
                              fontFamily: "Cairo",
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Expanded(
                            child: bloglist(),
                          ),

                          // Padding(
                          // padding: const EdgeInsets.all(8.0),
                          // child: SingleChildScrollView(
                          // scrollDirection: Axis.horizontal,
                          // child: Row(
                          // children: [
                          // NeumorphicButton(
                          // padding: EdgeInsets.all(80),
                          // onPressed: () {},
                          // ),
                          // SizedBox(
                          // width: 20,
                          // ),
                          // NeumorphicButton(
                          // padding: EdgeInsets.all(80),
                          // onPressed: () {},
                          // ),
                          // SizedBox(
                          // width: 20,
                          // ),
                          // NeumorphicButton(
                          // padding: EdgeInsets.all(80),
                          // onPressed: () {},
                          // ),
                          // ],
                          // ),
                          // ),
                          // ),

                          // Expanded(
                          // child: Container(
                          // child: StreamBuilder<QuerySnapshot>(
                          // stream: _blog.snapshots(),
                          // builder: (context,
                          // AsyncSnapshot<QuerySnapshot>
                          // streamSnapshot) {
                          // if (streamSnapshot.hasData) {
                          // return ListView.builder(
                          // itemCount:
                          // streamSnapshot.data!.docs.length,
                          // itemBuilder: (context, index) {
                          // final DocumentSnapshot
                          // documentSnapshot =
                          // streamSnapshot.data!.docs[index];
                          // return NeumorphicButton(
                          // child: Text(
                          // documentSnapshot['blogTitle'],
                          // textAlign: TextAlign.right,
                          // style: TextStyle(
                          // color: Color(0xff385a4a),
                          // fontSize: 15,
                          // fontFamily: "Cairo",
                          // fontWeight: FontWeight.w700,
                          // ),
                          // ),
                          // padding: EdgeInsets.all(80),
                          // onPressed: () {},
                          // );
                          // });
                          // }
                          // return Center(
                          // child: CircularProgressIndicator(),
                          // );
                          // },
                          // ),
                          // ),
                          // ),
                          // Expanded(
                          // child: Container(
                          // width: 200, height: 200, child: bloglist()),
                          // ),
                          // Padding(
                          // padding: const EdgeInsets.all(8.0),
                          // child: SingleChildScrollView(
                          // scrollDirection: Axis.horizontal,
                          // child: Row(
                          // children: [
                          // NeumorphicButton(
                          // padding: EdgeInsets.all(80),
                          // onPressed: () {

                          // },
                          // ),
                          // SizedBox(
                          // width: 20,
                          // ),
                          // NeumorphicButton(
                          // padding: EdgeInsets.all(80),
                          // onPressed: () {},
                          // ),
                          // SizedBox(
                          // width: 20,
                          // ),
                          // NeumorphicButton(
                          // padding: EdgeInsets.all(80),
                          // onPressed: () {},
                          // ),
                          // ],
                          // ),
                          // ),
                          // ),
                        ]),
                  ),
                ),
              ),
            ),
    );
  }
}
