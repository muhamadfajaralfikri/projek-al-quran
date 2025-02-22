import 'package:flutter/material.dart';
import 'package:latihan/start_screen.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.lightBlue,
                Colors.lightBlueAccent,
              ],
            ),
          ),
          child: const StartScreen()),
    ),
  ));
}
