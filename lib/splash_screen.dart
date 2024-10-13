import 'package:flutter/material.dart';
import 'package:latihan/home_page.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Lottie.asset('assets/lotties/lottie.json'),
          const Text(
            'Tempatnya belajar pemula',
            style: TextStyle(
                color: Colors.white, fontSize: 25, fontStyle: FontStyle.italic),
          ),
          const SizedBox(
            height: 50,
          ),
          Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.lightBlue,
                    Colors.lightBlueAccent,
                  ],
                ),
                borderRadius: BorderRadius.all(Radius.circular(15.0))),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const HomePage();
                    },
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Colors.transparent, // Make button's background transparent
                shadowColor: Colors.transparent, // Optional: Remove the shadow
                padding: const EdgeInsets.symmetric(
                    vertical: 12, horizontal: 24), // Button padding
              ),
              child: const Text(
                'Mulai',
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
