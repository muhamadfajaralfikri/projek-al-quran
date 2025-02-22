import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:latihan/login_page.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/images/logo.png',
            width: 250,
          ),
          const Text(
            'Tempatnya belajar pemula',
            style: TextStyle(
                color: Colors.white, fontSize: 15, fontStyle: FontStyle.italic),
          ),
          const SizedBox(
            height: 50,
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginPage();
                    },
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors
                    .blue.shade400, // Background color of the ElevatedButton
              ),
              child: const Text(
                'mulai',
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
    );
  }
}
