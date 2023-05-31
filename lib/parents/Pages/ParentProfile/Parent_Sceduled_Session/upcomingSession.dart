import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eloquentapp/screens/callPage.dart';
import 'package:eloquentapp/therapist/available_times/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class ParentUpcoming extends StatefulWidget {
  const ParentUpcoming({super.key});

  @override
  State<ParentUpcoming> createState() => _ParentUpcomingState();
}

class _ParentUpcomingState extends State<ParentUpcoming> {
  //instance for cloud firestore
  final _auth = FirebaseAuth.instance;

  late User singedInUser;
  @override
  void initState() {
    super.initState();
    getCurrentUser();
    getUserData();
    selectedDayNotifier.addListener(checkIfReadyToSubmit);
    selectedTimeNotifier.addListener(checkIfReadyToSubmit);
    notesController.addListener(checkIfReadyToSubmit);
  }

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

  // TextEditingController SessionName = TextEditingController();
  // TextEditingController SessionGoul = TextEditingController();

  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  final CollectionReference usersRef = _db.collection('acceptedSessions');
  late Query query = usersRef
      .where('ParentId', isEqualTo: singedInUser.uid)
      .where('Parentstatus', isEqualTo: 'accepted');

  late Stream<QuerySnapshot> usersStream = query.snapshots();

  ///get session  id----------------------------------------------------------------
  Map<String, dynamic> SessionInfo = {};

  //get all user data and store to Map
  getUserData() async {
    await FirebaseFirestore.instance
        .collection('acceptedSessions')
        .where("ParentId", isEqualTo: singedInUser.uid)
        .get()
        .then((v) {
      for (var element in v.docs) {
        SessionInfo.addAll(element.data());
      }
    });
  }

  late String SessionID = SessionInfo['sessionID'];
  late String ChildName = SessionInfo['ChildName'];
  late String Sessionname = SessionInfo['SessionName'];
  late String SessionGoal = SessionInfo['SessionGoul'];
  final TextEditingController SessionNameController = TextEditingController();
  final TextEditingController SessionGoalController = TextEditingController();
  updateRequestedSessiom(docId) async {
    var sessionRef = _db.collection('acceptedSessions');
    final Map<String, dynamic> changedData = {};
    if (Sessionname.isNotEmpty)
      changedData.putIfAbsent('SessionName', () => SessionGoal);
    if (SessionGoal.isNotEmpty)
      changedData.putIfAbsent('SessionGoul', () => SessionGoal);
    if (selectedDayNotifier.value != null)
      changedData.putIfAbsent(
          'Date',
          () =>
              '${selectedDayNotifier.value!.day}/${selectedDayNotifier.value!.month}/${selectedDayNotifier.value!.year}');
    if (selectedTimeRange.value != null)
      changedData.putIfAbsent(
          'TimeRange', () => getTimeRanges(selectedTimeRange.value!));
    await sessionRef.doc(docId).update(changedData);
  }

  // late DocumentReference CanceldSession =
  // FirebaseFirestore.instance.collection('canceldSession').doc();
  // void _saveValues({
  // required String Sessionname,
  // required String ParentUid,
  // required String sessionID,
  // required String therapistName,
  // }) async {
  // try {
  // await CanceldSession.set({
  // 'SessionName': Sessionname,
  // 'TherapistName': therapistName,
  // 'TherapistID': singedInUser.uid,
  // 'ParentId': ParentUid,
  // 'sessionID': sessionID,
  // 'status': "canceld",
  // });
  //  _showSuccessDialog('تم حفظ البيانات بنجاح');
  // } catch (e) {
  // print('Error saving values: $e');
  //  _showErrorDialog('حدث خطأ أثناء حفظ البيانات');
  // }
  // }
//  void _showSuccessDialog(String message) {
  //  showDialog(
  //  context: context,
  //  builder: (BuildContext context) {
  //  return AlertDialog(
  //  title: Text('نجاح'),
  //  content: Text(message),
  //  actions: <Widget>[
  //  TextButton(
  //  child: Text('حسنا'),
  //  onPressed: () {
  //  Navigator.of(context).pop();
  //  },
  //  ),
  //  ],
  //  );
  //  },
  //  );
//  }
  final ValueNotifier<DateTime?> selectedDayNotifier = ValueNotifier(null);
  final ValueNotifier<String?> selectedTimeNotifier = ValueNotifier(null);
  final TextEditingController notesController = TextEditingController();
  final ValueNotifier<bool> readyToSubmitNotifier = ValueNotifier(false);
  final ValueNotifier<String?> selectedTimeRange = ValueNotifier(null);

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
        getAvailableTimes(day: day, availableTimesMap: availableTimesMap) ?? {};
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
    return Container(
      child: StreamBuilder<QuerySnapshot>(
        stream: usersStream,
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
                itemCount: streamSnapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final DocumentSnapshot documentSnapshot =
                      streamSnapshot.data!.docs[index];
                  String timeRange = documentSnapshot['TimeRange'];

                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    child: Card(
                      elevation: 0,
                      color: Color(0xfffbfbfb),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(17.80)),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Column(
                                    children: [
                                      Text(timeRange.split(
                                          ' - ')[0]), // Display the start time
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        height: 28.0,
                                        child: VerticalDivider(
                                            color: Color.fromARGB(
                                                255, 59, 52, 52)),
                                      ), // Display the vertical line
                                      Text(timeRange.split(
                                          ' - ')[1]), // Display the end time
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          'جلسة ' +
                                              documentSnapshot['SessionName'],
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            color: Color(0xff385a4a),
                                            fontSize: 17,
                                            fontFamily: "Cairo",
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        Image.asset(
                                          "images/NameCard.png",
                                        ),
                                        const SizedBox(width: 5),
                                        Text(
                                          "د/ " +
                                              documentSnapshot['TherapistName'],
                                          style: TextStyle(
                                            color: Color(0xff6888a0),
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        Image.asset(
                                          "images/Calnder.png",
                                        ),
                                        const SizedBox(width: 5),
                                        Text(
                                          documentSnapshot['Date'],
                                          style: TextStyle(
                                            color: Color(0xff6888a0),
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                ElevatedButton(
                                  onPressed: () async {
                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (context) {
                                        return CallPage(
                                          callID: SessionID,
                                          UserId: singedInUser.uid,
                                          Name: ChildName,
                                        );
                                      },
                                    ));
                                    if (documentSnapshot['Parentstatus'] !=
                                        null) {
                                      QuerySnapshot querySnapshot =
                                          await FirebaseFirestore.instance
                                              .collection('acceptedSessions')
                                              .where('Parentstatus',
                                                  isEqualTo: 'accepted')
                                              .get();

                                      querySnapshot.docs.forEach((document) {
                                        document.reference.update(
                                            {"Parentstatus": "attandend"});
                                      });
                                    }
                                  },
                                  child: Text(
                                    "حضور الجلسة ",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontFamily: "Cairo",
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                      minimumSize: Size(40, 30),
                                      backgroundColor: Color(0xff394445),
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                      )),
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    showModalBottomSheet(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(35.0),
                                            topRight: Radius.circular(35.0),
                                          ),
                                        ),
                                        isScrollControlled: true,
                                        constraints: BoxConstraints(
                                            maxHeight: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                1.1),
                                        context: context,
                                        builder: (BuildContext context) {
                                          return StatefulBuilder(builder:
                                              (BuildContext context,
                                                  StateSetter setState) {
                                            final bottomInset =
                                                MediaQuery.of(context)
                                                    .viewInsets
                                                    .bottom;
                                            return SingleChildScrollView(
                                              reverse: true,
                                              child: Container(
                                                padding: EdgeInsets.only(
                                                  bottom: bottomInset,
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 25,
                                                      vertical: 10),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 15),
                                                        child: Row(
                                                          children: [
                                                            Image.asset(
                                                              "images/SessionDitals.png",
                                                            ),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            Text(
                                                              'تفاصيل الجلسة',
                                                              textAlign:
                                                                  TextAlign
                                                                      .right,
                                                              style: TextStyle(
                                                                color: Color(
                                                                    0xff385a4a),
                                                                fontSize: 23,
                                                                fontFamily:
                                                                    "Cairo",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 15,
                                                      ),
                                                      SizedBox(
                                                        height: 50,
                                                        child: TextField(
                                                          controller:
                                                              TextEditingController(
                                                            text: documentSnapshot[
                                                                'SessionName'],
                                                          ),
                                                          style: TextStyle(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    50,
                                                                    81,
                                                                    66),
                                                            fontSize: 16,
                                                            fontFamily: "Rubik",
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                          readOnly: true,
                                                          decoration:
                                                              InputDecoration(
                                                            border:
                                                                OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide
                                                                      .none,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.0),
                                                            ),
                                                            filled: true,
                                                            fillColor:
                                                                Color.fromARGB(
                                                                    251,
                                                                    242,
                                                                    242,
                                                                    242),
                                                            prefixIcon: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: <
                                                                  Widget>[
                                                                Padding(
                                                                  padding: EdgeInsets
                                                                      .only(
                                                                          right:
                                                                              8.0,
                                                                          top:
                                                                              15),
                                                                  child: Text(
                                                                    " اسم الجلسة: ",
                                                                    textAlign:
                                                                        TextAlign
                                                                            .right,
                                                                    style:
                                                                        TextStyle(
                                                                      color: Color(
                                                                          0xff385a4a),
                                                                      fontSize:
                                                                          16,
                                                                      fontFamily:
                                                                          "Rubik",
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 15,
                                                      ),

                                                      ///---------------------------------------
                                                      SizedBox(
                                                        height: 50,
                                                        child: TextField(
                                                          controller:
                                                              TextEditingController(
                                                            text: documentSnapshot[
                                                                'TherapistName'],
                                                          ),
                                                          style: TextStyle(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    50,
                                                                    81,
                                                                    66),
                                                            fontSize: 16,
                                                            fontFamily: "Rubik",
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                          readOnly: true,
                                                          decoration:
                                                              InputDecoration(
                                                            border:
                                                                OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide
                                                                      .none,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.0),
                                                            ),
                                                            filled: true,
                                                            fillColor:
                                                                Color.fromARGB(
                                                                    251,
                                                                    242,
                                                                    242,
                                                                    242),
                                                            prefixIcon: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: <
                                                                  Widget>[
                                                                Padding(
                                                                  padding: EdgeInsets
                                                                      .only(
                                                                          right:
                                                                              8.0,
                                                                          top:
                                                                              15),
                                                                  child: Text(
                                                                    " اسم الأخصائي:  " +
                                                                        "د/",
                                                                    textAlign:
                                                                        TextAlign
                                                                            .right,
                                                                    style:
                                                                        TextStyle(
                                                                      color: Color(
                                                                          0xff385a4a),
                                                                      fontSize:
                                                                          16,
                                                                      fontFamily:
                                                                          "Rubik",
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 15,
                                                      ),

                                                      TextField(
                                                        textAlign:
                                                            TextAlign.right,

                                                        keyboardType:
                                                            TextInputType
                                                                .multiline,
                                                        maxLines: 3,

                                                        // minLines: 10,
                                                        // maxLength: 12,
                                                        controller:
                                                            TextEditingController(
                                                                text:
                                                                    SessionGoal),
                                                        onChanged: ((value) {
                                                          SessionGoal = value;
                                                        }),
                                                        decoration:
                                                            InputDecoration(
                                                          border:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide.none,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8.0),
                                                          ),
                                                          filled: true,
                                                          fillColor:
                                                              Color.fromARGB(
                                                                  251,
                                                                  242,
                                                                  242,
                                                                  242),
                                                          prefixIcon: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: <Widget>[
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        right:
                                                                            8.0,
                                                                        bottom:
                                                                            35),
                                                                child: Text(
                                                                  "وصف الجلسة: ",
                                                                  style:
                                                                      TextStyle(
                                                                    color: Color(
                                                                        0xff385a4a),
                                                                    fontSize:
                                                                        15,
                                                                    fontFamily:
                                                                        "Rubik",
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 20,
                                                      ),
                                                      FutureBuilder<
                                                          DocumentSnapshot<
                                                              Map<String,
                                                                  dynamic>>>(
                                                        future: FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                'Therapist')
                                                            .doc((documentSnapshot
                                                                        .data()!
                                                                    as Map)[
                                                                'TherapistID'])
                                                            .get(),
                                                        builder: (context,
                                                            AsyncSnapshot<
                                                                    DocumentSnapshot<
                                                                        Map<String,
                                                                            dynamic>>>
                                                                asyncSnapshot) {
                                                          if (asyncSnapshot
                                                              .hasError) {
                                                            return const Text(
                                                                'حدث خطأ!');
                                                          }
                                                          if (!asyncSnapshot
                                                              .hasData) {
                                                            return const Center(
                                                              child:
                                                                  CircularProgressIndicator(
                                                                color: Color(
                                                                    0xff385a4a),
                                                              ),
                                                            );
                                                          }
                                                          final Map data =
                                                              (documentSnapshot
                                                                      .data()!
                                                                  as Map);
                                                          final List<String>
                                                              splittedDate =
                                                              data['Date']
                                                                  .toString()
                                                                  .split('/');
                                                          if (splittedDate[0]
                                                                  .length ==
                                                              1)
                                                            splittedDate[0] =
                                                                '0${splittedDate[0]}';
                                                          if (splittedDate[1]
                                                                  .length ==
                                                              1)
                                                            splittedDate[1] =
                                                                '0${splittedDate[1]}';
                                                          final DateTime
                                                              dateTime =
                                                              DateTime.parse(
                                                                  splittedDate
                                                                      .reversed
                                                                      .join(
                                                                          '-'));
                                                          return StreamBuilder(
                                                            stream: FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    'Therapist/${asyncSnapshot.data!.id}/AvilableTime')
                                                                .snapshots(),
                                                            builder: (context,
                                                                snapshot) {
                                                              if (snapshot
                                                                  .hasError) {
                                                                return const Text(
                                                                    'حدث خطأ!');
                                                              }
                                                              if (!snapshot
                                                                  .hasData) {
                                                                return const Center(
                                                                  child:
                                                                      CircularProgressIndicator(
                                                                    color: Color(
                                                                        0xff385a4a),
                                                                  ),
                                                                );
                                                              }
                                                              final Map<String,
                                                                      DefaultAvailableTimesMap>
                                                                  availableTimesMap =
                                                                  {};
                                                              for (QueryDocumentSnapshot<
                                                                      Map<String,
                                                                          dynamic>> element
                                                                  in snapshot
                                                                      .data!
                                                                      .docs) {
                                                                availableTimesMap
                                                                    .putIfAbsent(
                                                                        element
                                                                            .id,
                                                                        () => parseTimes(
                                                                            element.data()));
                                                              }
                                                              return ListView(
                                                                shrinkWrap:
                                                                    true,
                                                                physics:
                                                                    const NeverScrollableScrollPhysics(),
                                                                children: [
                                                                  ValueListenableBuilder(
                                                                    valueListenable:
                                                                        selectedDayNotifier,
                                                                    builder:
                                                                        (context,
                                                                            _,
                                                                            __) {
                                                                      return Column(
                                                                        children: [
                                                                          TableCalendar(
                                                                            calendarFormat:
                                                                                CalendarFormat.month,
                                                                            availableCalendarFormats: const {
                                                                              CalendarFormat.month: 'Month'
                                                                            },
                                                                            currentDay:
                                                                                DateTime.now(),
                                                                            selectedDayPredicate: (day) =>
                                                                                isSameDay(day, dateTime),
                                                                            availableGestures:
                                                                                AvailableGestures.horizontalSwipe,
                                                                            focusedDay:
                                                                                DateTime.now(),
                                                                            enabledDayPredicate: (day) =>
                                                                                DateTime.now().isBefore(day) &&
                                                                                isDayAvailable(
                                                                                  day: day,
                                                                                  availableTimesMap: availableTimesMap,
                                                                                ),
                                                                            firstDay: DateTime.utc(
                                                                                2018,
                                                                                10,
                                                                                16),
                                                                            lastDay: DateTime.utc(
                                                                                2030,
                                                                                10,
                                                                                16),
                                                                            onFormatChanged:
                                                                                (_) {},
                                                                            onDaySelected:
                                                                                (selectedDay, _) {
                                                                              selectedDayNotifier.value = selectedDay;
                                                                              selectedTimeNotifier.value = null;
                                                                            },
                                                                          ),
                                                                          Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
                                                                            child:
                                                                                Directionality(
                                                                              textDirection: TextDirection.rtl,
                                                                              child: ValueListenableBuilder(
                                                                                valueListenable: selectedTimeRange,
                                                                                builder: (context, _, __) {
                                                                                  return DropdownButton(
                                                                                    isExpanded: true,
                                                                                    value: selectedTimeRange.value,
                                                                                    onChanged: (value) => selectedTimeRange.value = value!,
                                                                                    hint: Text(timeRange),
                                                                                    disabledHint: const Text('الرجاء إختيار التاريخ اولاً'),
                                                                                    items: buildAvailableTimesList(
                                                                                      day: dateTime,
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
                                                                ],
                                                              );
                                                            },
                                                          );
                                                        },
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            ElevatedButton(
                                                                style: ElevatedButton
                                                                    .styleFrom(
                                                                  minimumSize:
                                                                      Size(100,
                                                                          45),
                                                                  backgroundColor:
                                                                      Color(
                                                                          0xff406553),
                                                                  shape:
                                                                      const RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.all(
                                                                            Radius.circular(10)),
                                                                  ),
                                                                ),
                                                                onPressed: () {
                                                                  String docId =
                                                                      documentSnapshot
                                                                          .id;
                                                                  updateRequestedSessiom(
                                                                      docId);
                                                                  Navigator.pop(
                                                                      context);
                                                                  showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (context) =>
                                                                              AlertDialog(
                                                                                title: Text("!تم ارسال التعديلات بنجاح"),
                                                                              ));
                                                                },
                                                                child: Text(
                                                                    'حفظ التغيرات')),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            ElevatedButton(
                                                                style: ElevatedButton
                                                                    .styleFrom(
                                                                        minimumSize:
                                                                            Size(100,
                                                                                45),
                                                                        backgroundColor:
                                                                            Colors
                                                                                .red,
                                                                        shape:
                                                                            const RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.all(Radius.circular(10)),
                                                                        )),
                                                                onPressed:
                                                                    () async {
                                                                  String
                                                                      sessionID =
                                                                      documentSnapshot[
                                                                          'sessionID'];
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                  QuerySnapshot querySnapshot = await FirebaseFirestore
                                                                      .instance
                                                                      .collection(
                                                                          'acceptedSessions')
                                                                      .where(
                                                                          'sessionID',
                                                                          isEqualTo:
                                                                              sessionID)
                                                                      .get();
                                                                  querySnapshot
                                                                      .docs
                                                                      .forEach(
                                                                          (document) {
                                                                    document
                                                                        .reference
                                                                        .delete();
                                                                  });
                                                                  // Send reason to Parent page
                                                                  FirebaseFirestore
                                                                      .instance
                                                                      .collection(
                                                                          'Parent')
                                                                      .doc(documentSnapshot[
                                                                          'ParentId'])
                                                                      .collection(
                                                                          'canceld')
                                                                      .add({
                                                                    'sessionID':
                                                                        sessionID,
                                                                    'status':
                                                                        "canceld",
                                                                  });
                                                                },
                                                                child: Text(
                                                                    'حذف الجلسة '))
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          });
                                        });
                                  },
                                  child: Text(
                                    "تفاصيل الجلسة ",
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 12,
                                      fontFamily: "Cairo",
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      minimumSize: const Size(40, 30),
                                      backgroundColor: const Color(0xfffbfbfb),
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                      )),
                                ),
                              ],
                            ),
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
