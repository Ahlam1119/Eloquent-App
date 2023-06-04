import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class frequent_Questions extends StatefulWidget {
  @override
  State<frequent_Questions> createState() => _frequent_QuestionsState();
}

class _frequent_QuestionsState extends State<frequent_Questions> {
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: ListView(
            children: [
              Column(children: [
                Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "الأسئلة الشائعة  ",
                        style: TextStyle(
                          color: Color(0xff385a4a),
                          fontSize: 20,
                          fontFamily: "Cairo",
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_forward_ios_outlined,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                ),
              ]),
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color(0x0c9bb0a5),
                ),
                child: Theme(
                  data: ThemeData().copyWith(
                    dividerColor: Colors.transparent,
                  ),
                  child: const ExpansionTile(
                    trailing: Icon(
                      Icons.arrow_drop_down,
                      size: 30,
                    ),
                    backgroundColor: Color(0x0c9bb0a5),
                    title: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'ماهو بليغ ؟',
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          color: Color(0xff385a4a),
                          fontSize: 16,
                          fontFamily: "Cairo",
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    children: [
                      Divider(
                        indent: 20,
                        endIndent: 20,
                        color: Color.fromARGB(168, 159, 156, 156),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                        child: Text(
                          "هو تطبيق إلكتروني يهدف الى مساعدة كل من الوالدين, الاطفال وحتى \nالاخصائيين بتقديم مجموعة من الخصائص المختلفة.",
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
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color(0x0c9bb0a5),
                ),
                child: const ExpansionTile(
                  trailing: Icon(
                    Icons.arrow_drop_down,
                    size: 30,
                  ),
                  backgroundColor: Color(0x0c9bb0a5),
                  title: Text(
                    textAlign: TextAlign.right,
                    'من هي الفئة المستهدفة لاستخدام بليغ؟',
                    style: TextStyle(
                      color: Color(0xff385a4a),
                      fontSize: 16,
                      fontFamily: "Cairo",
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  children: [
                    Divider(
                      indent: 20,
                      endIndent: 20,
                      color: Color.fromARGB(168, 159, 156, 156),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
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
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color(0x0c9bb0a5),
                ),
                child: const ExpansionTile(
                  trailing: Icon(
                    Icons.arrow_drop_down,
                    size: 30,
                  ),
                  backgroundColor: Color(0x0c9bb0a5),
                  title: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'كيف يستفيد طفلي من تطبيق بليغ؟',
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        color: Color(0xff385a4a),
                        fontSize: 16,
                        fontFamily: "Cairo",
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  children: [
                    Divider(
                      indent: 20,
                      endIndent: 20,
                      color: Color.fromARGB(168, 159, 156, 156),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
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
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color(0x0c9bb0a5),
                ),
                child: const ExpansionTile(
                  trailing: Icon(
                    Icons.arrow_drop_down,
                    size: 30,
                  ),
                  backgroundColor: Color(0x0c9bb0a5),
                  title: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'كيف يمكنني انشاء حساب لطفلي؟',
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        color: Color(0xff385a4a),
                        fontSize: 16,
                        fontFamily: "Cairo",
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  children: [
                    Divider(
                      indent: 20,
                      endIndent: 20,
                      color: Color.fromARGB(168, 159, 156, 156),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
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
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color(0x0c9bb0a5),
                ),
                child: const ExpansionTile(
                  trailing: Icon(
                    Icons.arrow_drop_down,
                    size: 30,
                  ),
                  backgroundColor: Color(0x0c9bb0a5),
                  title: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "كيف يمكنني حجز جلسة؟",
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        color: Color(0xff385a4a),
                        fontSize: 16,
                        fontFamily: "Cairo",
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  children: [
                    Divider(
                      indent: 20,
                      endIndent: 20,
                      color: Color.fromARGB(168, 159, 156, 156),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      child: Text(
                        "يمكنك حجز جلسة مع الاخصائي من خلال قائمة الأخصائيين ",
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
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color(0x0c9bb0a5),
                ),
                child: const ExpansionTile(
                  trailing: Icon(
                    Icons.arrow_drop_down,
                    size: 30,
                  ),
                  backgroundColor: Color(0x0c9bb0a5),
                  title: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "كيف يمكنني الغاء حجز الجلسة؟",
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        color: Color(0xff385a4a),
                        fontSize: 16,
                        fontFamily: "Cairo",
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  children: [
                    Divider(
                      indent: 20,
                      endIndent: 20,
                      color: Color.fromARGB(168, 159, 156, 156),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
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
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color(0x0c9bb0a5),
                ),
                child: const ExpansionTile(
                  trailing: Icon(
                    Icons.arrow_drop_down,
                    size: 30,
                  ),
                  backgroundColor: Color(0x0c9bb0a5),
                  title: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "كيف يمكنني تعديل تاريخ الجلسة؟",
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        color: Color(0xff385a4a),
                        fontSize: 16,
                        fontFamily: "Cairo",
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  children: [
                    Divider(
                      indent: 20,
                      endIndent: 20,
                      color: Color.fromARGB(168, 159, 156, 156),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      child: Text(
                        "من خلال البروفايل الخاص بك يمكنك أستعراض الجلسات القادمة بالنقر على ادارة الجلسات ثم, تفاصيل الجلسة والتعديل على بيانات الجلسة",
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
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color(0x0c9bb0a5),
                ),
                child: const ExpansionTile(
                  trailing: Icon(
                    Icons.arrow_drop_down,
                    size: 30,
                  ),
                  backgroundColor: Color(0x0c9bb0a5),
                  title: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "كيف يمكنني حضور الجلسة؟",
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        color: Color(0xff385a4a),
                        fontSize: 16,
                        fontFamily: "Cairo",
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  children: [
                    Divider(
                      indent: 20,
                      endIndent: 20,
                      color: Color.fromARGB(168, 159, 156, 156),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      child: Text(
                        "من خلال البروفايل الخاص بك يمكنك أستعراض الجلسات القادمة بالنقر على ادارة الجلسات ثم, حضور الجلسة",
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
