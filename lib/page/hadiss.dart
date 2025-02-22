import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:latihan/home_page.dart';
import 'package:latihan/page/hadis/ahmad.dart';
import 'package:latihan/page/hadis/bukhari.dart';
import 'package:latihan/page/hadis/darimi.dart';
import 'package:latihan/page/hadis/dawud.dart';
import 'package:latihan/page/hadis/majah.dart';
import 'package:latihan/page/hadis/malik.dart';
import 'package:latihan/page/hadis/muslim.dart';
import 'package:latihan/page/hadis/nasai.dart';
import 'package:latihan/page/hadis/tirmidzi.dart';

class Hadiss extends StatelessWidget {
  const Hadiss({super.key});

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('id_ID', null);

    final DateTime now = DateTime.now();
    final String formattedDate =
        DateFormat('EEEE d MMMM y', 'id_ID').format(now);
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        color: const Color.fromARGB(255, 65, 101, 132),
        height: height,
        width: width,
        child: Column(
          children: [
            _buildHeader(context),
            Padding(
              padding: const EdgeInsets.only(top: 5, left: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.date_range,
                          color: Colors.white), // Icon displayed here
                      const SizedBox(
                          width:
                              8), // Adds some spacing between the icon and text
                      Text(
                        formattedDate,
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                padding: const EdgeInsets.all(10.0),
                child: GridView.count(
                  primary: false,
                  padding: const EdgeInsets.all(20),
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 13,
                  crossAxisCount: 2,
                  children: _buildGridItems(context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              );
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }

  // This method returns a list of grid items.
  List<Widget> _buildGridItems(BuildContext context) {
    final List<Map<String, dynamic>> items = [
      {
        'title': 'HR. IMAM ABU DAWUD',
        'image': 'assets/images/man.png',
        'route': const DawudScreen()
      },
      {
        'title': 'HR. IMAM AHMAD ',
        'image': 'assets/images/man.png',
        'route': const AhmadScreen()
      },
      {
        'title': 'HR. IMAM BUKHARI',
        'image': 'assets/images/man.png',
        'route': const BukhariScreen()
      },
      {
        'title': 'HR. IMAM DARIMI',
        'image': 'assets/images/man.png',
        'route': const DarimiScreen()
      },
      {
        'title': 'HR. IMAM IBNU MAJAH',
        'image': 'assets/images/man.png',
        'route': const MajahScreen()
      },
      {
        'title': 'HR. IMAM MALIK',
        'image': 'assets/images/man.png',
        'route': const MalikScreen()
      },
      {
        'title': 'HR. IMAM MUSLIM',
        'image': 'assets/images/man.png',
        'route': const MuslimScreen()
      },
      {
        'title': 'HR. IMAM TIRMIDZI',
        'image': 'assets/images/man.png',
        'route': const TirmidziScreen()
      },
      {
        'title': 'HR. IMAM NASAI',
        'image': 'assets/images/man.png',
        'route': const NasaiScreen()
      },
    ];

    return items.map((item) {
      return InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => item['route']),
          );
        },
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(color: Colors.black26, spreadRadius: 1, blurRadius: 6)
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                item['image'],
                width: 100,
              ),
              Text(
                item['title'],
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }).toList();
  }
}
