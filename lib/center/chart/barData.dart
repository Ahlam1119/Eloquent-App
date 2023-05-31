import 'IndividualBar.dart';

class BarData {
  final double satAmount;
  final double sunAmount;
  final double monAmount;
  final double tueAmount;
  final double wedAmount;
  final double thirAmount;
  final double friAmount;

  BarData(this.satAmount, this.sunAmount, this.monAmount, this.tueAmount,
      this.wedAmount, this.thirAmount, this.friAmount);

  List<IndividualBar> barData = [];

  // initilize data bar

  void initilize() {
    barData = [
      IndividualBar(x: 0, y: satAmount),
      IndividualBar(x: 1, y: sunAmount),
      IndividualBar(x: 2, y: monAmount),
      IndividualBar(x: 3, y: tueAmount),
      IndividualBar(x: 4, y: wedAmount),
      IndividualBar(x: 5, y: thirAmount),
      IndividualBar(x: 6, y: friAmount),
    ];
  }
}
