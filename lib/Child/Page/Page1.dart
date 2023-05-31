import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChildPage extends StatefulWidget {
  final String childId;
  final String page;

  ChildPage({required this.childId, required this.page});

  @override
  _ChildPageState createState() => _ChildPageState();
}

class _ChildPageState extends State<ChildPage> {
  DateTime? _startTimePage;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _startTimePage = DateTime.now();
  }

  @override
  void dispose() {
    if (_startTimePage != null) {
      final DateTime endTime = DateTime.now();
      addUsageData(widget.page, _startTimePage!, endTime);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.page),
      ),
      body: Center(
        child: Text('Child is on ${widget.page} page'),
      ),
    );
  }

  Future<void> addUsageData(
      String page, DateTime startTime, DateTime endTime) async {
    final CollectionReference<Map<String, dynamic>> usageCollection =
        FirebaseFirestore.instance.collection('usage');
    await usageCollection.add({
      'childId': widget.childId,
      'page': page,
      'startTime': Timestamp.fromDate(startTime.toUtc()),
      'endTime': Timestamp.fromDate(endTime.toUtc())
    });
    await _calculateAverageWeeklyUsage();
  }

  Future<void> _calculateAverageWeeklyUsage() async {
    final CollectionReference<Map<String, dynamic>> usageCollection =
        FirebaseFirestore.instance.collection('usage');
    final DateTime now = DateTime.now();
    final DateTime oneWeekAgo = now.subtract(Duration(days: 7));
    final QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await usageCollection
            .where('childId', isEqualTo: widget.childId)
            .where('startTime',
                isGreaterThanOrEqualTo: Timestamp.fromDate(oneWeekAgo.toUtc()))
            .get();
    final List<DocumentSnapshot<Map<String, dynamic>>> documents =
        querySnapshot.docs;
    final Map<String, double> pageDurations = {};
    // Calculate the total duration and count the number of visits for each page
    for (final document in documents) {
      final String page = document.get('page');
      final DateTime startTime =
          (document.get('startTime') as Timestamp).toDate();
      final DateTime endTime = (document.get('endTime') as Timestamp).toDate();
      final double duration =
          endTime.difference(startTime).inSeconds.toDouble();
      pageDurations[page] = (pageDurations[page] ?? 0) + duration;
    }
    final double totalDuration = pageDurations.values.fold(0, (a, b) => a + b);
    final double averageWeeklyDuration =
        totalDuration / 604800; // 7 days in seconds
    // Save the average weekly duration for each page to Cloud Firestore
    final batch = FirebaseFirestore.instance.batch();
    for (final entry in pageDurations.entries) {
      final String page = entry.key;
      final double duration = entry.value;
      final double averageDuration = duration / 604800;
      batch.set(
        FirebaseFirestore.instance.doc('Child/${widget.childId}/pages/$page'),
        {'average_weekly_duration': averageDuration},
        SetOptions(merge: true),
      );
    }
    await batch.commit();
  }
}
