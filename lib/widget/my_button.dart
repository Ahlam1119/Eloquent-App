import 'package:flutter/material.dart';

class MyBoutton extends StatelessWidget {
  const MyBoutton(
      {required this.color, required this.onPressed, required this.tital});

  final Color color;
  final String tital;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Material(
        elevation: 5,
        color: color,
        borderRadius: BorderRadius.circular(10),
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 200,
          height: 42,
          child: Text(
            tital,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
