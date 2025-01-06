import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:latihan/page/list_doa.dart';
import 'package:latihan/page/list_asmaul.dart';
import 'package:latihan/page/list_nabi.dart';
import 'package:latihan/page/list_page.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:latihan/page/list_shalat.dart';
import 'package:latihan/page/tentang.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
            SizedBox(
              height: height * 0.22,
              width: width,
              child: Padding(
                padding: const EdgeInsets.only(top: 70.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.date_range,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 8),
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

  // This method returns a list of grid items.
  List<Widget> _buildGridItems(BuildContext context) {
    final List<Map<String, dynamic>> items = [
      {
        'title': 'SEJARAH 25 NABI ALLAH SWT',
        'image': 'assets/images/islamic.png',
        'route': const ListNabi()
      },
      {
        'title': 'NIAT SOLAT',
        'image': 'assets/images/praying.png',
        'route': const ListShalat()
      },
      {
        'title': 'AL QURAN',
        'image': 'assets/images/quran.png',
        'route': const ListPage()
      },
      {
        'title': 'ASMAUL HUSNA',
        'image': 'assets/images/99.png',
        'route': const ListAsmaul()
      },
      {
        'title': 'Doa Sehari hari',
        'image': 'assets/images/logoo.png',
        'route': const ListDoa()
      },
      {
        'title': 'TENTANG',
        'image': 'assets/images/haram.png',
        'route': const ProfilePage()
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
