import 'package:cloud_firestore/cloud_firestore.dart';

class ChartFunctions {
  static const List<String> kDaysOfWeek = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];
  static String getDayOfWeek(Timestamp timestamp) {
    final dateTime = timestamp.toDate();
    return kDaysOfWeek[dateTime.weekday - 1];
  }

  static Future<List<double>> takeSummary(
      String centerId, int daysAgoStart, int daysAgoEnd) async {
    final now = Timestamp.now();
    final startTimestamp = Timestamp.fromMillisecondsSinceEpoch(
        now.millisecondsSinceEpoch - daysAgoStart * 24 * 60 * 60 * 1000);
    final endTimestamp = Timestamp.fromMillisecondsSinceEpoch(
        now.millisecondsSinceEpoch - daysAgoEnd * 24 * 60 * 60 * 1000);

    final querySnapshot = await FirebaseFirestore.instance
        .collection('acceptedSessions')
        .where('DateTime', isGreaterThanOrEqualTo: endTimestamp)
        .where('DateTime', isLessThan: startTimestamp)
        .where('centerid', isEqualTo: centerId)
        .get();

    final counters = List.filled(kDaysOfWeek.length, 0);

    for (final doc in querySnapshot.docs) {
      final dayOfWeek = getDayOfWeek(doc['DateTime']);
      if (doc['TherapistStatus'] == 'attandend') {
        counters[kDaysOfWeek.indexOf(dayOfWeek)]++;
      }
    }

    return counters.map((count) => count.toDouble()).toList();
  }

  static Future<List<double>> takeSummaryThisWeek(String centerId) async {
    return takeSummary(centerId, 0, 7);
  }

  static Future<List<double>> takeSummaryPastWeek(String centerId) async {
    return takeSummary(centerId, 8, 15);
  }
}
