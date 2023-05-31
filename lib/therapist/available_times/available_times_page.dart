import 'package:cloud_firestore/cloud_firestore.dart';
import 'week_button.dart';
import 'weekday_panel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'constants.dart';

class AvailableTimes extends StatefulWidget {
  const AvailableTimes({super.key});

  @override
  State<AvailableTimes> createState() => _AvailableTimesState();
}

class _AvailableTimesState extends State<AvailableTimes> {
  late final ValueNotifier<DefaultAvailableTimesMap> availableTimesNotifier;
  late final ValueNotifier<String> selectedWeekNotifier;

  @override
  void initState() {
    selectedWeekNotifier = ValueNotifier('1');
    availableTimesNotifier = ValueNotifier({...defaultAvailableTimes});
    super.initState();
  }

  Future<void> saveTimes() async {
    final String? uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;
    await FirebaseFirestore.instance
        .collection("Therapist")
        .doc(uid)
        .collection('AvilableTime')
        .doc(DateTime.now().month.toString())
        .set(availableTimesNotifier.value.cast<String, dynamic>());
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance
          .collection("Therapist")
          .doc(FirebaseAuth.instance.currentUser?.uid ?? '')
          .collection('AvilableTime')
          .doc(DateTime.now().month.toString())
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('حدث خطأ!');
        }
        if (snapshot.hasData && snapshot.data?.data() == null) saveTimes();
        if (!snapshot.hasData || snapshot.data?.data() == null) {
          return const Center(
            child: CircularProgressIndicator(
              color: Color(0xff385a4a),
            ),
          );
        }
        availableTimesNotifier.value = parseTimes(snapshot.data!.data()!);

        return ListView(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    WeekButton(
                      index: '4',
                      title: 'الاسبوع الرابع',
                      selectedWeekNotifier: selectedWeekNotifier,
                    ),
                    const SizedBox(width: 10),
                    WeekButton(
                      index: '3',
                      title: 'الاسبوع الثالث',
                      selectedWeekNotifier: selectedWeekNotifier,
                    ),
                    const SizedBox(width: 10),
                    WeekButton(
                      index: '2',
                      title: 'الاسبوع الثاني',
                      selectedWeekNotifier: selectedWeekNotifier,
                    ),
                    const SizedBox(width: 10),
                    WeekButton(
                      index: '1',
                      title: 'الاسبوع الأول',
                      selectedWeekNotifier: selectedWeekNotifier,
                    ),
                  ],
                ),
              ),
            ),
            ValueListenableBuilder(
              valueListenable: selectedWeekNotifier,
              builder: (context, _, child) {
                return Column(
                  children: List.generate(
                    availableDays.length,
                    (index) => WeekDayPanel(
                      dayIndex: (index + 1).toString(),
                      title: availableDays[index],
                      selectedWeekNotifier: selectedWeekNotifier,
                      availableTimesNotifier: availableTimesNotifier,
                    ),
                  ),
                );
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff385a4a)),
              onPressed: () async {
                await saveTimes();
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: Text("تم إضافة الجلسات بنجاح"),
                        ));
              },
              child: const Text('حفظ الجلسات'),
            ),
          ],
        );
      },
    );
  }
}
