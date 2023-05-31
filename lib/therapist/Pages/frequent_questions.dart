import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class frequentQuestions extends StatefulWidget {
  @override
  State<frequentQuestions> createState() => _frequentQuestionsState();
}

class _frequentQuestionsState extends State<frequentQuestions> {
  @override
  void initState() {
    super.initState();
    getUserData();
  }

  // late String Jointhebeads;
  Map<String, dynamic> ChildInfo = {};
  bool isLoded = true;
  getUserData() async {
    //.where(field)
    await FirebaseFirestore.instance
        .collection('frequentQuestions')
        .get()
        .then((v) {
      for (var element in v.docs) {
        ChildInfo.addAll(element.data());

        setState(() {
          isLoded = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        foregroundColor: Color(0xff385a4a),
        elevation: 0,
        backgroundColor: Color(0xffFBFBFB),
        title: Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              "الأسئلة الشائعة",
              textAlign: TextAlign.right,
              style: TextStyle(
                color: Color(0xff2a3447),
                fontSize: 22,
                fontFamily: "Cairo",
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        actions: [
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_right, size: 32.0),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: ListView(
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Color(0x0c9bb0a5),
                ),
                child: Theme(
                  data: ThemeData().copyWith(
                    dividerColor: Colors.transparent,
                  ),
                  child: ExpansionTile(
                    iconColor: Color(0xff385a4a),
                    trailing: Icon(
                      Icons.arrow_drop_down,
                      size: 30,
                    ),
                    leading: Text(
                      'ماهو بليغ ؟',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Color(0xff385a4a),
                        fontSize: 16,
                        fontFamily: "Cairo",
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    title: Text(""),
                    backgroundColor: Color(0x0c9bb0a5),
                    children: [
                      Divider(
                        indent: 20,
                        endIndent: 20,
                        color: Color.fromARGB(168, 159, 156, 156),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 5),
                        child: Text(
                          "هو تطبيق إلكتروني يهدف الى مساعدة كل من الوالدين, الاطفال \nوحتى الاخصائيين بتقديم مجموعة من الخصائص المختلفة.",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Color(0xff6888a0),
                            fontSize: 13,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Color(0x0c9bb0a5),
                ),
                child: ExpansionTile(
                  iconColor: Color(0xff385a4a),
                  trailing: Icon(
                    Icons.arrow_drop_down,
                    size: 30,
                  ),
                  leading: Text(
                    'من هي الفئة المستهدفة لاستخدام \nبليغ؟',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Color(0xff385a4a),
                      fontSize: 16,
                      fontFamily: "Cairo",
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  backgroundColor: Color(0x0c9bb0a5),
                  title: Text(""),
                  children: [
                    Divider(
                      indent: 20,
                      endIndent: 20,
                      color: Color.fromARGB(168, 159, 156, 156),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 5),
                      child: Text(
                        "أهالي الأطفال ذوي صعوبات النطق والأطفال, المراكز والأخصائيين",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Color(0xff6888a0),
                          fontSize: 13,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Color(0x0c9bb0a5),
                ),
                child: ExpansionTile(
                  iconColor: Color(0xff385a4a),
                  trailing: Icon(
                    Icons.arrow_drop_down,
                    size: 30,
                  ),
                  leading: Text(
                    'كيف يستفيد طفلي من تطبيق بليغ؟',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Color(0xff385a4a),
                      fontSize: 16,
                      fontFamily: "Cairo",
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  backgroundColor: Color(0x0c9bb0a5),
                  title: Text(""),
                  children: [
                    Divider(
                      indent: 20,
                      endIndent: 20,
                      color: Color.fromARGB(168, 159, 156, 156),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 5),
                      child: Text(
                        "يوفر تطبيق بليغ عدة مراحل تساعد الأطفال ذوي صعوبات النطق, كما يوفر التطبيق أمكانية حجز جلسات مع الأخصائيين",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Color(0xff6888a0),
                          fontSize: 13,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Color(0x0c9bb0a5),
                ),
                child: ExpansionTile(
                  iconColor: Color(0xff385a4a),
                  trailing: Icon(
                    Icons.arrow_drop_down,
                    size: 30,
                  ),
                  leading: Text(
                    'كيف يمكنني انشاء حساب لطفلي؟',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Color(0xff385a4a),
                      fontSize: 16,
                      fontFamily: "Cairo",
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  backgroundColor: Color(0x0c9bb0a5),
                  title: Text(""),
                  children: [
                    Divider(
                      indent: 20,
                      endIndent: 20,
                      color: Color.fromARGB(168, 159, 156, 156),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 5),
                      child: Text(
                        "من خلال الصفحة الرئيسية يمكن انشاء حساب للطفل وتعبئة البيانات",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Color(0xff6888a0),
                          fontSize: 13,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Color(0x0c9bb0a5),
                ),
                child: ExpansionTile(
                  iconColor: Color(0xff385a4a),
                  trailing: Icon(
                    Icons.arrow_drop_down,
                    size: 30,
                  ),
                  leading: Text(
                    'هل يستطيع طفلي البدء من المرحلة \nالثانية؟',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Color(0xff385a4a),
                      fontSize: 16,
                      fontFamily: "Cairo",
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  backgroundColor: Color(0x0c9bb0a5),
                  title: Text(""),
                  children: [
                    Divider(
                      indent: 20,
                      endIndent: 20,
                      color: Color.fromARGB(168, 159, 156, 156),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 5),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Text(
                          "نعم, يستطيع طفلك البدء من اي مرحلة ",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Color(0xff6888a0),
                            fontSize: 13,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Color(0x0c9bb0a5),
                ),
                child: ExpansionTile(
                  iconColor: Color(0xff385a4a),
                  trailing: Icon(
                    Icons.arrow_drop_down,
                    size: 30,
                  ),
                  leading: Text(
                    'كيف يمكنني حجز جلسة؟',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Color(0xff385a4a),
                      fontSize: 16,
                      fontFamily: "Cairo",
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  backgroundColor: Color(0x0c9bb0a5),
                  title: Text(""),
                  children: [
                    Divider(
                      indent: 20,
                      endIndent: 20,
                      color: Color.fromARGB(168, 159, 156, 156),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 5),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Text(
                          "يمكنك حجز جلسة مع الاخصائي من خلال قائمة الأخصائيين ",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Color(0xff6888a0),
                            fontSize: 13,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Color(0x0c9bb0a5),
                ),
                child: ExpansionTile(
                  iconColor: Color(0xff385a4a),
                  trailing: Icon(
                    Icons.arrow_drop_down,
                    size: 30,
                  ),
                  leading: Text(
                    'كيف يمكنني الغاء حجز جلسة؟',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Color(0xff385a4a),
                      fontSize: 16,
                      fontFamily: "Cairo",
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  backgroundColor: Color(0x0c9bb0a5),
                  title: Text(""),
                  children: [
                    Divider(
                      indent: 20,
                      endIndent: 20,
                      color: Color.fromARGB(168, 159, 156, 156),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 5),
                      child: Text(
                        "من خلال البروفايل الخاص بك يمكنك أستعراض الجلسات القادمة ,تفاصيل الجلسة, حذف الجلسة",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Color(0xff6888a0),
                          fontSize: 13,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
