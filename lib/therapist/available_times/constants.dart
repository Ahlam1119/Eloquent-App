typedef KeySubDefaultAvailableTimesMap = String;
typedef ValueSubDefaultAvailableTimesMap = Map<String, Map<String, bool>?>;
typedef DefaultAvailableTimesMap
    = Map<KeySubDefaultAvailableTimesMap, ValueSubDefaultAvailableTimesMap>;

const DefaultAvailableTimesMap defaultAvailableTimes = {
  // first index = week number
  // second index = day of week
  // value = true (available), false or null (unavailable)
  '1': {
    '1': null,
    '2': null,
    '3': null,
    '4': null,
    '5': null,
    '6': null,
    '7': null
  },
  '2': {
    '1': null,
    '2': null,
    '3': null,
    '4': null,
    '5': null,
    '6': null,
    '7': null
  },
  '3': {
    '1': null,
    '2': null,
    '3': null,
    '4': null,
    '5': null,
    '6': null,
    '7': null
  },
  '4': {
    '1': null,
    '2': null,
    '3': null,
    '4': null,
    '5': null,
    '6': null,
    '7': null
  },
};

DefaultAvailableTimesMap parseTimes(Map<String, dynamic> data) {
  final DefaultAvailableTimesMap map = {};
  for (String weekIndex in defaultAvailableTimes.keys) {
    map.putIfAbsent(weekIndex, () => {});
    for (String dayIndex in defaultAvailableTimes[weekIndex]!.keys) {
      if (data[weekIndex][dayIndex] == null) {
        map[weekIndex]?[dayIndex] = null;
        continue;
      }
      map[weekIndex]?[dayIndex] = {...data[weekIndex][dayIndex]};
    }
  }
  return map;
}

const List<String> availableDays = [
  // You can change these, if you want to disable a weekday, remove it from this list.
  // note: order of the list matters.
  'الأحد',
  'الإثنين',
  'الثلاثاء',
  'الأربعاء',
  'الخميس',
  'الجمعة',
  'السبت',
];

const Map<int, String> monthNames = {
  1: 'January',
  2: 'February',
  3: 'March',
  4: 'April',
  5: 'May',
  6: 'June',
  7: 'July',
  8: 'August',
  9: 'September',
  10: 'October',
  11: 'November',
  12: 'December',
};
