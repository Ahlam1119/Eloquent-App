import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eloquentapp/screens/constants.dart';
import 'package:eloquentapp/therapist/available_times/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:uuid/uuid.dart';

class BookWithTherapistPage extends StatefulWidget {
  final String therapistID;

  const BookWithTherapistPage({
    super.key,
    required this.therapistID,
  });

  @override
  State<BookWithTherapistPage> createState() => _BookWithTherapistPageState();
}

class _BookWithTherapistPageState extends State<BookWithTherapistPage> {
  final ValueNotifier<DateTime?> selectedDayNotifier = ValueNotifier(null);
  final ValueNotifier<String?> selectedTimeNotifier = ValueNotifier(null);
  final TextEditingController notesController = TextEditingController();
  final ValueNotifier<bool> readyToSubmitNotifier = ValueNotifier(false);

  @override
  void initState() {
    selectedDayNotifier.addListener(checkIfReadyToSubmit);
    selectedTimeNotifier.addListener(checkIfReadyToSubmit);
    notesController.addListener(checkIfReadyToSubmit);
    super.initState();
  }

  int getSelectedWeek(DateTime day) => (day.day / 7).ceil();

  int getSelectedDayOfWeek(DateTime day) => (day.day % 7) - 1;

  Map<String, bool>? getAvailableTimes(
      {required DateTime day,
      required Map<String, DefaultAvailableTimesMap> availableTimesMap}) {
    if (!availableTimesMap.keys.contains(day.month.toString())) return null;
    final int week = getSelectedWeek(day);
    if (!availableTimesMap[day.month.toString()]!
        .keys
        .contains(week.toString())) return null;
    final int dayOfWeek = getSelectedDayOfWeek(day);
    if (!availableTimesMap[day.month.toString()]![week.toString()]!
        .keys
        .contains(dayOfWeek.toString())) return null;
    return availableTimesMap[day.month.toString()]![week.toString()]![
        dayOfWeek.toString()];
  }

  bool isDayAvailable(
      {required DateTime day,
      required Map<String, DefaultAvailableTimesMap> availableTimesMap}) {
    final Map<String, bool>? availableTimes =
        getAvailableTimes(day: day, availableTimesMap: availableTimesMap);
    if (availableTimes == null || availableTimes.isEmpty) return false;
    return true;
  }

  buildAvailableTimesList({
    required DateTime day,
    required Map<String, DefaultAvailableTimesMap> availableTimesMap,
  }) {
    final Map<String, bool> availableTimes =
        getAvailableTimes(day: day, availableTimesMap: availableTimesMap)!;
    return availableTimes.entries.map((e) {
      final String text = getTimeRanges(e.key);
      return DropdownMenuItem(
        value: e.key,
        child: Text(
          text,
          textDirection: TextDirection.ltr,
        ),
      );
    }).toList();
  }

  String getTimeRanges(String timeRanges) {
    final List<String> timeRangesList = timeRanges.split('-');
    final List<TimeOfDay> formattedTimeRanges = [];
    for (int i = 0; i < timeRangesList.length; i++) {
      final List<int> nums =
          timeRangesList[i].split(':').map((e) => int.parse(e)).toList();
      final TimeOfDay timeOfDay = TimeOfDay(
        hour: nums.first,
        minute: nums.last,
      );
      formattedTimeRanges.add(timeOfDay);
    }
    return '${formattedTimeRanges.first.format(context)} - ${formattedTimeRanges.last.format(context)}';
  }

  void checkIfReadyToSubmit() {
    final bool hasSelectedDay = selectedDayNotifier.value != null;
    final bool hasSelectedTime = selectedTimeNotifier.value != null;
    final bool hasNotes = notesController.text.trim().isNotEmpty;
    readyToSubmitNotifier.value = hasSelectedDay && hasSelectedTime && hasNotes;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      future: FirebaseFirestore.instance
          .collection('Therapist')
          .doc(widget.therapistID)
          .get(),
      builder: (context,
          AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> asyncSnapshot) {
        if (asyncSnapshot.hasError) {
          return const Text('حدث خطأ!');
        }
        if (!asyncSnapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(
              color: Color(0xff385a4a),
            ),
          );
        }
        return StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('Therapist/${widget.therapistID}/AvilableTime')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text('حدث خطأ!');
            }
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Color(0xff385a4a),
                ),
              );
            }
            final Map<String, DefaultAvailableTimesMap> availableTimesMap = {};
            for (QueryDocumentSnapshot<Map<String, dynamic>> element
                in snapshot.data!.docs) {
              availableTimesMap.putIfAbsent(
                  element.id, () => parseTimes(element.data()));
            }
            return ListView(
              children: [
                ValueListenableBuilder(
                  valueListenable: selectedDayNotifier,
                  builder: (context, _, __) {
                    return Column(
                      children: [
                        TableCalendar(
                          calendarFormat: CalendarFormat.month,
                          availableCalendarFormats: const {
                            CalendarFormat.month: 'Month'
                          },
                          currentDay: DateTime.now(),
                          selectedDayPredicate: (day) =>
                              isSameDay(day, selectedDayNotifier.value),
                          availableGestures: AvailableGestures.horizontalSwipe,
                          focusedDay: DateTime.now(),
                          enabledDayPredicate: (day) =>
                              DateTime.now().isBefore(day) &&
                              isDayAvailable(
                                day: day,
                                availableTimesMap: availableTimesMap,
                              ),
                          firstDay: DateTime.utc(2018, 10, 16),
                          lastDay: DateTime.utc(2030, 10, 16),
                          onFormatChanged: (_) {},
                          onDaySelected: (selectedDay, _) {
                            selectedDayNotifier.value = selectedDay;
                            selectedTimeNotifier.value = null;
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: ValueListenableBuilder(
                              valueListenable: selectedTimeNotifier,
                              builder: (context, _, __) {
                                return DropdownButton(
                                  isExpanded: true,
                                  value: selectedTimeNotifier.value,
                                  onChanged: (value) =>
                                      selectedTimeNotifier.value = value,
                                  hint: const Text('إختار وقت الجلسة'),
                                  disabledHint:
                                      const Text('الرجاء إختيار التاريخ اولاً'),
                                  items: selectedDayNotifier.value == null
                                      ? null
                                      : buildAvailableTimesList(
                                          day: selectedDayNotifier.value!,
                                          availableTimesMap: availableTimesMap,
                                        ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: notesController,
                        keyboardType: TextInputType.multiline,
                        minLines: 3,
                        maxLines: 8,
                        textDirection: TextDirection.rtl,
                        decoration: kStylingInputDec.copyWith(
                          hintText: 'الملاحظات',
                          hintTextDirection: TextDirection.rtl,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                ValueListenableBuilder(
                  valueListenable: readyToSubmitNotifier,
                  builder: (context, bool isReady, __) {
                    return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size(100, 45),
                            backgroundColor: Color(0xff394445),
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(17)))),
                        onPressed: !isReady
                            ? null
                            : () async {
                                FocusScope.of(context).unfocus();
                                await showModalBottomSheet(
                                  isScrollControlled: true,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(17))),
                                  context: context,
                                  builder: (context) => _BottomModalSheetInfo(
                                    therapistId: widget.therapistID,
                                    therapistName:
                                        asyncSnapshot.data!.data()!['name'],
                                    date: selectedDayNotifier.value!,
                                    timeRange: getTimeRanges(
                                        selectedTimeNotifier.value!),
                                    notes: notesController.text.trim(),
                                    centerid:
                                        asyncSnapshot.data!.data()!['centerid'],
                                  ),
                                );
                              },
                        child: const Text(
                          'التالي',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ));
                  },
                ),
                const SizedBox(height: 35),
              ],
            );
          },
        );
      },
    );
  }
}

class _BottomModalSheetInfo extends StatelessWidget {
  final String therapistId;
  final String therapistName;
  final DateTime date;
  final String timeRange;
  final String notes;
  final String centerid;

  const _BottomModalSheetInfo({
    required this.therapistId,
    required this.therapistName,
    required this.date,
    required this.timeRange,
    required this.notes,
    required this.centerid,
  });

  Future<void> saveDoc() async {
    late final String parentName;
    await FirebaseFirestore.instance
        .collection('Parent')
        .where("uid", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((doc) async {
      final Map<String, dynamic> docData = doc.docs.first.data();
      parentName = docData['name'];
    });
    //-------------
    late final String ChildName;
    late final String ChildID;
    await FirebaseFirestore.instance
        .collection('Child')
        .where("uidParent", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((doc) async {
      final Map<String, dynamic> docData = doc.docs.first.data();
      ChildName = docData['name'];
      ChildID = docData['uid'];
    });
    final String requestId = const Uuid().v4();
    await FirebaseFirestore.instance.collection("requestedSessions").add({
      'ParentName': parentName,
      'status': 'requested', //Default status
      'TherapistName': therapistName,
      'RequestId': requestId,
      'TherapistID': therapistId,
      'ParentNote': notes,
      'DateTime': date,
      'timeRange': timeRange,
      'Date': '${date.day}/${date.month}/${date.year}',
      'ChildName': ChildName,
      'ChildID': ChildID,
      'ParentId': FirebaseAuth.instance.currentUser!.uid,
      'centerid': centerid,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'ملخص حجز الجلسة',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: const Color(0xff385a4a),
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(
                        Icons.medical_information_rounded,
                        color: const Color(0xff385a4a).withOpacity(.7),
                        size: 20,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'د/ $therapistName',
                        style: const TextStyle(color: Color(0xff385a4a)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(
                        Icons.date_range,
                        color: const Color(0xff385a4a).withOpacity(.7),
                        size: 20,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        '${date.day}/${date.month}/${date.year}',
                        style: const TextStyle(color: Color(0xff385a4a)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(
                        Icons.watch_later,
                        color: const Color(0xff385a4a).withOpacity(.7),
                        size: 20,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        timeRange,
                        style: const TextStyle(color: Color(0xff385a4a)),
                        textDirection: TextDirection.ltr,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: TextEditingController(text: notes),
                    readOnly: true,
                    keyboardType: TextInputType.multiline,
                    textDirection: TextDirection.rtl,
                    decoration: kStylingInputDec,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: Theme(
                          data: ThemeData(useMaterial3: true),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xff394445)),
                              onPressed: () async {
                                final Parent = FirebaseFirestore.instance
                                    .collection('Parent');
                                final therapistsCollection = FirebaseFirestore
                                    .instance
                                    .collection('Therapist');
                                final requestedSessionsCollection =
                                    FirebaseFirestore.instance
                                        .collection('requestedSessions');
                                final acceptedSessionsCollection =
                                    FirebaseFirestore.instance
                                        .collection('acceptedSessions');
                                late String date1 =
                                    '${date.day}/${date.month}/${date.year}';
// Check if the mother has a requested session in progress
                                final requestedSessionQuery =
                                    requestedSessionsCollection
                                        .where('ParentId',
                                            isEqualTo: FirebaseAuth
                                                .instance.currentUser!.uid)
                                        .where('TherapistID',
                                            isEqualTo: therapistId)
                                        .where('status', isEqualTo: 'requested')
                                        .where(
                                          'Date',
                                          isEqualTo: date1,
                                        );

                                final requestedSessionSnapshot =
                                    await requestedSessionQuery.get();

                                if (requestedSessionSnapshot.docs.isNotEmpty) {
                                  await showDialog(
                                    context: context,
                                    builder: (context) => Theme(
                                      data: ThemeData(
                                          useMaterial3: true,
                                          colorScheme: ColorScheme.fromSeed(
                                              seedColor:
                                                  const Color(0xff385a4a))),
                                      child: Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: AlertDialog(
                                          title: const Text(
                                              "يوجد لديك طلب سابق جاري العمل عليه"),
                                          content: const Text(
                                              "عند قبول الأخصائي للجسلة، سوف تضاف جلستك الى قائمة الجلسات القادمة"),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text('حسناً'),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                } else {
                                  late String date1 =
                                      '${date.day}/${date.month}/${date.year}';
                                  // Check if the mother is trying to book a session at the same time as a previously accepted session
                                  final requestedSessionQuery =
                                      requestedSessionsCollection
                                          .where('ParentId',
                                              isEqualTo: FirebaseAuth
                                                  .instance.currentUser!.uid)
                                          .where('status',
                                              isEqualTo: 'requested')
                                          .where(
                                            'Date',
                                            isEqualTo: date1,
                                          );

                                  final proposedSessionSnapshot =
                                      await requestedSessionQuery.get();

                                  if (proposedSessionSnapshot.docs.isNotEmpty) {
                                    await showDialog(
                                      context: context,
                                      builder: (context) => Theme(
                                        data: ThemeData(
                                            useMaterial3: true,
                                            colorScheme: ColorScheme.fromSeed(
                                                seedColor:
                                                    const Color(0xff385a4a))),
                                        child: Directionality(
                                          textDirection: TextDirection.rtl,
                                          child: AlertDialog(
                                            title: const Text('طلب مسبق'),
                                            content: const Text(
                                                'لديك طلب مسبق في هذه اليوم جاري العمل عليه انتظري قبول الأخصائي او قومي بإلغاء الجلسة'),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text('حسناً'),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  } else {
                                    late String date1 =
                                        '${date.day}/${date.month}/${date.year}';
                                    // Check if the mother is trying to book a session at the same time as a previously accepted session
                                    final proposedSessionQuery =
                                        acceptedSessionsCollection
                                            .where('ParentId',
                                                isEqualTo: FirebaseAuth
                                                    .instance.currentUser!.uid)
                                            .where('TherapistStatus',
                                                isEqualTo: 'accepted')
                                            // .where('timeRange',
                                            //     isEqualTo: timeRange)
                                            .where(
                                              'Date',
                                              isEqualTo: date1,
                                            );

                                    final proposedSessionSnapshot =
                                        await proposedSessionQuery.get();

                                    if (proposedSessionSnapshot
                                        .docs.isNotEmpty) {
                                      await showDialog(
                                        context: context,
                                        builder: (context) => Theme(
                                          data: ThemeData(
                                              useMaterial3: true,
                                              colorScheme: ColorScheme.fromSeed(
                                                  seedColor:
                                                      const Color(0xff385a4a))),
                                          child: Directionality(
                                            textDirection: TextDirection.rtl,
                                            child: AlertDialog(
                                              title: const Text(
                                                  'تعارض في الجلسات'),
                                              content: const Text(
                                                  'لديك جلسة مع الأخصائي في نفس الوقت يرجى اختيار وقت آخر او قم بإلغاء الطلب'),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Text('حسناً'),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    } else {
                                      await saveDoc();

                                      await showDialog(
                                        context: context,
                                        builder: (context) => Theme(
                                          data: ThemeData(
                                              useMaterial3: true,
                                              colorScheme: ColorScheme.fromSeed(
                                                  seedColor:
                                                      const Color(0xff385a4a))),
                                          child: Directionality(
                                            textDirection: TextDirection.rtl,
                                            child: AlertDialog(
                                              title: const Text(
                                                  "تم ارسال طلبك بنجاح"),
                                              content: const Text(
                                                  "عند قبول الأخصائي للجسلة، سوف تضاف جلستك الى قائمة الجلسات القادمة"),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                    Navigator.of(context).pop();
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Text('حسناً'),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                  }

                                  // await saveDoc();
                                }
                              },
                              child: const Text(
                                'التالي',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              )),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
