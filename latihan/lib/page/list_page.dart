import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:latihan/home_page.dart';
import 'package:latihan/model/alquran.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'detail_screen.dart'; // Ensure this file includes parseArticles and Artikelmodel

class ListPage extends StatelessWidget {
  const ListPage({super.key});

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('id_ID', null);

    final DateTime now = DateTime.now();
    final String formattedDate = DateFormat(
      ' EEEE d MMMM y',
      'id_ID',
    ).format(now);
    return Scaffold(
      body: Container(
        color: const Color.fromARGB(255, 65, 101, 132),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage()),
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
            ),
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
              child: FutureBuilder<String>(
                future: DefaultAssetBundle.of(context)
                    .loadString('assets/artikel.json'),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(child: Text('Error loading data'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No data available'));
                  } else {
                    final List<Artikelmodel> artikel =
                        parseArticles(snapshot.data!);
                    return ListView.builder(
                      itemCount: artikel.length,
                      itemBuilder: (context, index) {
                        return _buildArticleItem(context, artikel[index]);
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildArticleItem(BuildContext context, Artikelmodel artikel) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          bottomRight: Radius.circular(15),
        ),
        color: Colors.blueGrey,
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => DetailScreen(
                noSurat: artikel.nomor,
              ),
            ),
          );
        },
        child: ListTile(
          leading: Container(
            height: 30,
            width: 31,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.white,
                width: 2,
              ),
            ),
            child: Text(
              artikel.nomor.toString(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
              ),
            ),
          ),
          title: Text(
            artikel.namaLatin,
            style: const TextStyle(
                color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            '${artikel.jumlahAyat} ayat | ${artikel.arti} | ${artikel.tempatTurun.name}',
            style: const TextStyle(
              color: Colors.white70,
            ),
          ),
          trailing: Text(
            artikel.nama,
            style: const TextStyle(
                color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
