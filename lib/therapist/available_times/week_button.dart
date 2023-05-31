import 'package:flutter/material.dart';

import 'constants.dart';

class WeekButton extends StatelessWidget {
  final String index;
  final String title;
  final ValueNotifier<String> selectedWeekNotifier;

  const WeekButton({
    super.key,
    required this.index,
    required this.title,
    required this.selectedWeekNotifier,
  });

  @override
  Widget build(BuildContext context) {
    final DateTime currentTime = DateTime.now();
    final ButtonStyle selectedButtonStyle = ElevatedButton.styleFrom(
      elevation: 0,
      backgroundColor: const Color(0xff385a4a),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    );
    final ButtonStyle notSelectedButtonStyle = ElevatedButton.styleFrom(
      elevation: 0,
      backgroundColor: const Color(0xff385a4a).withOpacity(.2),
      foregroundColor: const Color(0xff385a4a),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    );

    return Expanded(
      child: ValueListenableBuilder(
        valueListenable: selectedWeekNotifier,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 11),
              ),
              Text(monthNames[currentTime.month].toString()),
            ],
          ),
        ),
        builder: (context, _, child) {
          return ElevatedButton(
            onPressed: () => selectedWeekNotifier.value = index,
            style: selectedWeekNotifier.value == index
                ? selectedButtonStyle
                : notSelectedButtonStyle,
            child: child,
          );
        },
      ),
    );
  }
}
