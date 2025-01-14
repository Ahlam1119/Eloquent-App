import 'package:fl_chart/fl_chart.dart';
import 'package:eloquentapp/center/chart/barData.dart';
import 'package:flutter/material.dart';

class MyBarGraph extends StatelessWidget {
  const MyBarGraph(
      {super.key, required this.weeklySummary, required this.maxY});
  final List<double> weeklySummary;
  final double maxY;
  @override
  Widget build(BuildContext context) {
    BarData barData = BarData(
        weeklySummary[0],
        weeklySummary[1],
        weeklySummary[2],
        weeklySummary[3],
        weeklySummary[4],
        weeklySummary[5],
        weeklySummary[6]);

    barData.initilize();
    return BarChart(
      BarChartData(
          minY: 0,
          maxY: maxY,
          gridData: FlGridData(show: false),
          borderData: FlBorderData(show: false, border: Border.all()),
          titlesData: FlTitlesData(
            show: true,
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                  showTitles: true, interval: maxY / 10, reservedSize: 40),
            ),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                    showTitles: true, getTitlesWidget: customBottomTitile)),
          ),
          barGroups: barData.barData
              .map((data) => BarChartGroupData(x: data.x, barRods: [
                    BarChartRodData(
                      toY: data.y,
                      color: Colors.green,
                      width: 20,
                      gradient: LinearGradient(
                        colors: [
                          const Color.fromARGB(255, 49, 49, 49),
                          Colors.green.shade800,
                          Colors.lightGreen.shade300
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    )
                  ]))
              .toList()),
    );
  }
}

Widget customBottomTitile(double value, TitleMeta meta) {
  const style =
      TextStyle(color: Colors.grey, fontSize: 14, fontWeight: FontWeight.bold);

  Widget text;
  if (value.toInt() == 0) {
    text = const Text(
      'M',
      style: style,
    );
  } else if (value.toInt() == 1) {
    text = const Text(
      'T',
      style: style,
    );
  } else if (value.toInt() == 2) {
    text = const Text(
      'W',
      style: style,
    );
  } else if (value.toInt() == 3) {
    text = const Text(
      'T',
      style: style,
    );
  } else if (value.toInt() == 4) {
    text = const Text(
      'F',
      style: style,
    );
  } else if (value.toInt() == 5) {
    text = const Text(
      'S',
      style: style,
    );
  } else if (value.toInt() == 6) {
    text = const Text(
      'S',
      style: style,
    );
  } else {
    text = const Text("");
  }
  return SideTitleWidget(axisSide: meta.axisSide, child: text);
}
