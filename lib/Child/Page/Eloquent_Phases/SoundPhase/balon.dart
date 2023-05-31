import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class BalloonParty extends StatefulWidget {
  const BalloonParty({Key? key}) : super(key: key);

  @override
  _BalloonPartyState createState() => _BalloonPartyState();
}

class _BalloonPartyState extends State<BalloonParty> {
  late Timer _timer;
  bool _isPartyStarted = false;
  List<BalloonState> _balloonStates = [];

  List<Color> _availableColors = [
    Color.fromARGB(255, 224, 131, 127),
    Color.fromARGB(255, 99, 160, 182),
    Color.fromARGB(255, 202, 233, 210),
    Color(0xffa8a3ec),
    Color.fromARGB(188, 245, 252, 116),
    Color.fromARGB(158, 213, 132, 66),
  ];

  void _startParty() {
    setState(() {
      _isPartyStarted = true;
      _balloonStates = List.generate(
        10,
        (_) => BalloonState(
          position: Offset(
            Random().nextDouble() * MediaQuery.of(context).size.width,
            MediaQuery.of(context).size.height,
          ),
          color: _availableColors[Random().nextInt(_availableColors.length)],
          startTime: DateTime.now().millisecondsSinceEpoch.toDouble(),
        ),
      );
    });
  }

  void _updatePositions(Timer timer) {
    if (_isPartyStarted) {
      setState(() {
        for (int i = 0; i < _balloonStates.length; i++) {
          final state = _balloonStates[i];
          final duration = DateTime.now().millisecondsSinceEpoch.toDouble() -
              state.startTime;
          final screenHeight = MediaQuery.of(context).size.height;
          final balloonHeight = 75.0;
          final distance = duration / 5000 * screenHeight;
          final newPosition = Offset(
            state.position.dx,
            screenHeight - distance - balloonHeight,
          );

          _balloonStates[i] = state.copyWith(position: newPosition);

          if (newPosition.dy < -balloonHeight) {
            _balloonStates[i] = state.copyWith(
              position: Offset(
                Random().nextDouble() * MediaQuery.of(context).size.width,
                screenHeight,
              ),
              startTime: DateTime.now().millisecondsSinceEpoch.toDouble(),
            );
          }
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 1), _updatePositions);
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Balloon Party'),
      ),
      body: Center(
        child: Stack(
          children: [
            for (int i = 0; i < _balloonStates.length; i++)
              Positioned(
                left: _balloonStates[i].position.dx,
                top: _balloonStates[i].position.dy,
                child: Image.asset(
                  'images/gbaloon.png',
                  width: 50,
                  height: 75,
                  color: _balloonStates[i].color,
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _startParty,
        child: Icon(Icons.party_mode),
      ),
    );
  }
}

class BalloonState {
  final Offset position;
  final Color color;
  final double startTime;

  BalloonState({
    required this.position,
    required this.color,
    required this.startTime,
  });

  BalloonState copyWith({Offset? position, Color? color, double? startTime}) {
    return BalloonState(
      position: position ?? this.position,
      color: color ?? this.color,
      startTime: startTime ?? this.startTime,
    );
  }
}

// class BalloonParty extends StatefulWidget {
//   const BalloonParty({Key? key}) : super(key: key);

//   @override
//   _BalloonPartyState createState() => _BalloonPartyState();
// }

// class _BalloonPartyState extends State<BalloonParty> {
//   late Timer _timer;
//   bool _isPartyStarted = false;
//   List<BalloonState> _balloonStates = [];

//   List<Color> _availableColors = [
//     Color.fromARGB(255, 206, 91, 85),
//     Color.fromARGB(255, 99, 160, 182),
//     Color(0xffd3e7d8),
//     Color(0xffa8a3ec),
//     Color.fromARGB(255, 234, 246, 9),
//   ];

//   void _startParty(List<Color> colors) {
//     setState(() {
//       _isPartyStarted = true;
//       _balloonStates = List.generate(
//         10,
//         (_) => BalloonState(
//           position: Offset(
//             Random().nextDouble() * MediaQuery.of(context).size.width,
//             Random().nextDouble() * MediaQuery.of(context).size.height,
//           ),
//           color: colors[Random().nextInt(colors.length)],
//         ),
//       );
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     _timer = Timer.periodic(const Duration(milliseconds: 16), _updatePositions);
//   }

//   void _updatePositions(Timer timer) {
//     if (_isPartyStarted) {
//       setState(() {
//         for (int i = 0; i < _balloonStates.length; i++) {
//           final state = _balloonStates[i];
//           final duration = DateTime.now().millisecondsSinceEpoch.toDouble() -
//               state.startTime;
//           final screenHeight = MediaQuery.of(context).size.height;
//           final screenTop = MediaQuery.of(context).padding.top;
//           final balloonHeight = 75.0;
//           final distance = duration / 5000 * screenHeight;
//           state.position = Offset(
//             state.position.dx,
//             screenHeight - distance - balloonHeight - screenTop,
//           );
//         }
//       });
//     }
//   }

//   @override
//   void dispose() {
//     _timer.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Stack(
//           children: [
//             Align(
//               alignment: Alignment.bottomCenter,
//               child: ElevatedButton(
//                 onPressed: () {
//                   _startParty(_availableColors);
//                 },
//                 child: const Text('Launch Balloons'),
//               ),
//             ),
//             for (int i = 0; i < _balloonStates.length; i++)
//               Positioned(
//                 left: _balloonStates[i].position.dx,
//                 top: _balloonStates[i].position.dy,
//                 child: Container(
//                   width: 50,
//                   height: 75,
//                   decoration: BoxDecoration(
//                     color: _balloonStates[i].color,
//                     shape: BoxShape.circle,
//                   ),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class BalloonState {
//   late Offset position;
//   late double startTime;
//   late Color color;

//   BalloonState({
//     required this.position,
//     required this.color,
//   }) {
//     startTime = DateTime.now().millisecondsSinceEpoch.toDouble();
//   }
// }

// class BalloonParty extends StatefulWidget {
//   const BalloonParty({Key? key}) : super(key: key);

//   @override
//   _BalloonPartyState createState() => _BalloonPartyState();
// }

// class _BalloonPartyState extends State<BalloonParty> {
//   late Timer _timer;
//   bool _isPartyStarted = false;
//   List<BalloonState> _balloonStates = [];

//   List<Color> _availableColors = [
//     Color.fromARGB(255, 231, 149, 145),
//     Color.fromARGB(255, 99, 160, 182),
//     Color(0xffd3e7d8),
//     Color(0xffa8a3ec),
//     Color.fromARGB(255, 243, 255, 15),
//   ];

//   void _startParty(List<Color> colors) {
//     setState(() {
//       _isPartyStarted = true;
//       _balloonStates = List.generate(
//         10,
//         (_) => BalloonState(
//           position: Offset(
//             Random().nextDouble() * MediaQuery.of(context).size.width,
//             Random().nextDouble() * MediaQuery.of(context).size.height,
//           ),
//           color: colors[Random().nextInt(colors.length)],
//         ),
//       );
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     _timer = Timer.periodic(const Duration(milliseconds: 16), _updatePositions);
//   }

//   void _updatePositions(Timer timer) {
//     if (_isPartyStarted) {
//       setState(() {
//         for (int i = 0; i < _balloonStates.length; i++) {
//           final state = _balloonStates[i];
//           final duration = DateTime.now().millisecondsSinceEpoch.toDouble() -
//               state.startTime;
//           final screenHeight = MediaQuery.of(context).size.height;
//           final screenTop = MediaQuery.of(context).padding.top;
//           final balloonHeight = 75.0;
//           final distance = duration / 5000 * screenHeight;
//           state.position = Offset(
//             state.position.dx,
//             screenHeight - distance - balloonHeight - screenTop,
//           );
//         }
//       });
//     }
//   }

//   @override
//   void dispose() {
//     _timer.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Stack(
//           children: [
//             Align(
//               alignment: Alignment.bottomCenter,
//               child: ElevatedButton(
//                 onPressed: () {
//                   _startParty(_availableColors);
//                 },
//                 child: const Text('Launch Balloons'),
//               ),
//             ),
//             for (int i = 0; i < _balloonStates.length; i++)
//               Positioned(
//                 left: _balloonStates[i].position.dx,
//                 top: _balloonStates[i].position.dy,
//                 child: CustomPaint(
//                   painter: BalloonRopePainter(),
//                   child: Container(
//                     width: 50,
//                     height: 75,
//                     decoration: BoxDecoration(
//                       color: _balloonStates[i].color,
//                       shape: BoxShape.circle,
//                     ),
//                   ),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class BalloonState {
//   late Offset position;
//   late double startTime;
//   late Color color;

//   BalloonState({
//     required this.position,
//     required this.color,
//   }) {
//     startTime = DateTime.now().millisecondsSinceEpoch.toDouble();
//   }
// }

// class BalloonRopePainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = Colors.black
//       ..strokeWidth = 2.0
//       ..strokeCap = StrokeCap.round;
//     canvas.drawLine(
//       Offset(size.width / 2, size.height),
//       Offset(size.width / 2, 0),
//       paint,
//     );
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return false;
//   }
// }

// class BalloonParty extends StatefulWidget {
//   const BalloonParty({Key? key}) : super(key: key);

//   @override
//   _BalloonPartyState createState() => _BalloonPartyState();
// }

// class _BalloonPartyState extends State<BalloonParty> {
//   late Timer _timer;
//   bool _isPartyStarted = false;
//   List<BalloonState> _balloonStates = [];

//   void _startParty() {
//     setState(() {
//       _isPartyStarted = true;
//       _balloonStates = List.generate(
//         10,
//         (_) => BalloonState(
//           position: Offset(
//             Random().nextDouble() * MediaQuery.of(context).size.width,
//             Random().nextDouble() * MediaQuery.of(context).size.height,
//           ),
//         ),
//       );
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     _timer = Timer.periodic(const Duration(milliseconds: 16), _updatePositions);
//   }

//   void _updatePositions(Timer timer) {
//     if (_isPartyStarted) {
//       setState(() {
//         for (int i = 0; i < _balloonStates.length; i++) {
//           final state = _balloonStates[i];
//           final duration = DateTime.now().millisecondsSinceEpoch.toDouble() -
//               state.startTime;
//           final screenHeight = MediaQuery.of(context).size.height;
//           final screenTop = MediaQuery.of(context).padding.top;
//           final balloonHeight = 75.0;
//           final distance = duration / 5000 * screenHeight;
//           state.position = Offset(
//             state.position.dx,
//             screenHeight - distance - balloonHeight - screenTop,
//           );
//         }
//       });
//     }
//   }

//   @override
//   void dispose() {
//     _timer.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Stack(
//           children: [
//             Align(
//               alignment: Alignment.bottomCenter,
//               child: ElevatedButton(
//                 onPressed: _startParty,
//                 child: const Text('Launch Balloons'),
//               ),
//             ),
//             for (int i = 0; i < _balloonStates.length; i++)
//               Positioned(
//                 left: _balloonStates[i].position.dx,
//                 top: _balloonStates[i].position.dy,
//                 child: Container(
//                   width: 50,
//                   height: 75,
//                   decoration: BoxDecoration(
//                     color: _balloonStates[i].color,
//                     shape: BoxShape.circle,
//                   ),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class BalloonState {
//   late Offset position;
//   late double startTime;
//   late Color color;

//   BalloonState({
//     required this.position,
//   }) {
//     startTime = DateTime.now().millisecondsSinceEpoch.toDouble();
//     color = Colors.primaries[Random().nextInt(Colors.primaries.length)];
//   }
// }
