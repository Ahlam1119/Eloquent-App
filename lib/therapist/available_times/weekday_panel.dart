import 'package:flutter/material.dart';
import 'package:time_range_picker/time_range_picker.dart';

import 'constants.dart';

class WeekDayPanel extends StatelessWidget {
  final String dayIndex;
  final String title;
  final ValueNotifier<DefaultAvailableTimesMap> availableTimesNotifier;
  final ValueNotifier<String> selectedWeekNotifier;

  const WeekDayPanel({
    super.key,
    required this.dayIndex,
    required this.title,
    required this.availableTimesNotifier,
    required this.selectedWeekNotifier,
  });

  Map<String, bool>? get times =>
      availableTimesNotifier.value[selectedWeekNotifier.value]![dayIndex];
  bool get isActive => times != null;

  Future<TimeRange?> showCustomTimePicker({
    required BuildContext context,
    TimeOfDay? start,
    TimeOfDay? end,
  }) async {
    final ThemeData theme = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xff385a4a),
      ),
    );
    final TimeRange? result = await showTimeRangePicker(
      context: context,
      start: start ?? const TimeOfDay(hour: 8, minute: 0),
      end: end ?? const TimeOfDay(hour: 9, minute: 0),
      interval: const Duration(minutes: 30),
      minDuration: const Duration(minutes: 30),
      maxDuration: const Duration(hours: 6),
      autoAdjustLabels: true,
      use24HourFormat: false,
      clockRotation: -180,
      handlerColor: const Color(0xff385a4a),
      strokeColor: const Color(0xff385a4a),
      selectedColor: const Color(0xff385a4a),
      labels: [
        ClockLabel.fromTime(
            time: const TimeOfDay(hour: 0, minute: 0), text: '12 AM'),
        ClockLabel.fromTime(
            time: const TimeOfDay(hour: 2, minute: 0), text: '2 AM'),
        ClockLabel.fromTime(
            time: const TimeOfDay(hour: 4, minute: 0), text: '4 AM'),
        ClockLabel.fromTime(
            time: const TimeOfDay(hour: 6, minute: 0), text: '6 AM'),
        ClockLabel.fromTime(
            time: const TimeOfDay(hour: 8, minute: 0), text: '8 AM'),
        ClockLabel.fromTime(
            time: const TimeOfDay(hour: 10, minute: 0), text: '10 AM'),
        ClockLabel.fromTime(
            time: const TimeOfDay(hour: 12, minute: 0), text: '12 PM'),
        ClockLabel.fromTime(
            time: const TimeOfDay(hour: 14, minute: 0), text: '2 PM'),
        ClockLabel.fromTime(
            time: const TimeOfDay(hour: 16, minute: 0), text: '4 PM'),
        ClockLabel.fromTime(
            time: const TimeOfDay(hour: 18, minute: 0), text: '6 PM'),
        ClockLabel.fromTime(
            time: const TimeOfDay(hour: 20, minute: 0), text: '8 PM'),
        ClockLabel.fromTime(
            time: const TimeOfDay(hour: 22, minute: 0), text: '10 PM'),
      ],
      labelStyle: const TextStyle(color: Color(0xff385a4a), fontSize: 10),
      handlerRadius: 8,
      snap: true,
      ticks: 24,
      ticksColor: Colors.grey.shade300,
      ticksLength: 1,
      ticksOffset: 0,
      ticksWidth: 2,
      paintingStyle: PaintingStyle.fill,
      disabledTime: TimeRange(
        startTime: const TimeOfDay(hour: 0, minute: 0),
        endTime: const TimeOfDay(hour: 8, minute: 0),
      ),
      fromText: 'من',
      toText: 'الى',
      builder: (context, child) => Theme(
        data: theme,
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: child!,
        ),
      ),
    );
    return result;
  }

  List<TimeOfDay> getTimeRanges(String timeRanges) {
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
    return formattedTimeRanges;
  }

  void toggleDayOfWeek() {
    final DefaultAvailableTimesMap updated = availableTimesNotifier.value;
    if (isActive) {
      updated[selectedWeekNotifier.value]![dayIndex] = null;
    } else {
      updated[selectedWeekNotifier.value]![dayIndex] = {
        '8:0-9:0': true,
      };
    }
    availableTimesNotifier.value = {...updated};
  }

  Future<void> changeTimeSlot({
    required BuildContext context,
    required int index,
    TimeOfDay? start,
    TimeOfDay? end,
  }) async {
    TimeRange? result =
        await showCustomTimePicker(context: context, start: start, end: end);
    if (result == null) return;
    final String timeSlotKey = times!.keys.elementAt(index);
    final String newTimeSlotKey =
        '${result.startTime.hour}:${result.startTime.minute}-${result.endTime.hour}:${result.endTime.minute}';
    final DefaultAvailableTimesMap updated = availableTimesNotifier.value;
    updated[selectedWeekNotifier.value]![dayIndex]?.putIfAbsent(
      newTimeSlotKey,
      () => updated[selectedWeekNotifier.value]![dayIndex]![timeSlotKey]!,
    );

    updated[selectedWeekNotifier.value]![dayIndex]!.remove(timeSlotKey);
    availableTimesNotifier.value = {...updated};
  }

  Future<void> addNewTimeSlot(BuildContext context) async {
    TimeRange? result = await showCustomTimePicker(context: context);
    if (result == null) return;
    final DefaultAvailableTimesMap updated = availableTimesNotifier.value;
    updated[selectedWeekNotifier.value]![dayIndex]!.putIfAbsent(
        '${result.startTime.hour}:${result.startTime.minute}-${result.endTime.hour}:${result.endTime.minute}',
        () => true);
    availableTimesNotifier.value = {...updated};
  }

  int sortTimesKeys(String a, String b) {
    final List<int> firstList =
        a.split('-').first.split(':').map((e) => int.parse(e)).toList();
    int firstSum = (firstList[0] * 60) + firstList[1];
    final List<int> secondList =
        b.split('-').first.split(':').map((e) => int.parse(e)).toList();
    int secondSum = (secondList[0] * 60) + secondList[1];
    return firstSum.compareTo(secondSum);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData(
      useMaterial3: true,
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: const Color(0xff385a4a).withOpacity(.7)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xff385a4a),
      ),
    );
    return AnimatedSize(
      duration: const Duration(milliseconds: 1500),
      curve: Curves.fastLinearToSlowEaseIn,
      alignment: Alignment.topCenter,
      child: ValueListenableBuilder(
        valueListenable: availableTimesNotifier,
        builder: (context, _, child) {
          return Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 0,
            clipBehavior: Clip.antiAlias,
            child: Theme(
              data: theme,
              child: Column(
                children: [
                  InkWell(
                    onTap: toggleDayOfWeek,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IgnorePointer(
                            child: Switch(
                              value: isActive,
                              inactiveTrackColor: Colors.white,
                              inactiveThumbColor: const Color(0xff385a4a),
                              onChanged: (_) {},
                            ),
                          ),
                          Text(
                            title,
                            style: Theme.of(context).textTheme.titleLarge,
                          )
                        ],
                      ),
                    ),
                  ),
                  if (isActive)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Column(
                        children: [
                          Builder(
                            builder: (context) {
                              final List<String> sortedTimesKeys =
                                  times!.keys.toList();
                              sortedTimesKeys.sort(sortTimesKeys);
                              return ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: sortedTimesKeys.length,
                                itemBuilder: (context, index) {
                                  final List<TimeOfDay> timeRanges =
                                      getTimeRanges(
                                          sortedTimesKeys.elementAt(index));
                                  return InkWell(
                                    onTap: () async => changeTimeSlot(
                                      context: context,
                                      index: index,
                                      start: timeRanges.first,
                                      end: timeRanges.last,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4),
                                      child: Row(
                                        children: [
                                          const SizedBox(width: 20),
                                          Expanded(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .primary),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 16),
                                                child: Text(
                                                  timeRanges.last
                                                      .format(context),
                                                  style: TextStyle(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .primary,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              'الى',
                                              style: TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .primary),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 16),
                                                child: Text(
                                                  timeRanges.first
                                                      .format(context),
                                                  style: TextStyle(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .primary,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 20),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                          const SizedBox(height: 10),
                          Directionality(
                            textDirection: TextDirection.rtl,
                            child: TextButton.icon(
                              onPressed: () async =>
                                  await addNewTimeSlot(context),
                              icon: const Icon(Icons.add, size: 20),
                              label: const Text('اضافة ساعات جديدة'),
                            ),
                          )
                        ],
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
