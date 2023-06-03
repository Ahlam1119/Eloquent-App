import 'package:eloquentapp/parents/Pages/TherapistList/TherapistList.dart';
import 'package:flutter/material.dart';
import 'package:eloquentapp/parents/Pages/TherapistList/TherapistList.dart';

class TherapistListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.only(top: 10, right: 10),
              child: Text(
                'قائمة الأخصائيين',
                style: TextStyle(
                  color: Color(0xff385a4a),
                  fontSize: 20,
                  fontFamily: "Cairo",
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Text(
                textAlign: TextAlign.right,
                'أحجز جلسة لطفلك الآن\nمع احد المختصين',
                style: TextStyle(
                  color: Color(0xff9bb0a5),
                  fontSize: 14,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: Container(
                  //هنا اعرض القائمة
                  child: TherapistList()),
            ),
          ]),
        ),
      ),
    );
  }
}
