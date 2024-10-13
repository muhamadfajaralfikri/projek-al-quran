import 'package:flutter/material.dart';
import 'package:latihan/splash_screen.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
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
        child: const SplashScreen(),
      ),
    ),
  ));
}
