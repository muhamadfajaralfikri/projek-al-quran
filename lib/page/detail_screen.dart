import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:latihan/model/alquran.dart';
import 'package:latihan/model/ayat.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class DetailScreen extends StatelessWidget {
  final int noSurat;
  const DetailScreen({super.key, required this.noSurat});
  Future<Artikelmodel> _getDetailSurah() async {
    var data = await Dio().get('https://equran.id/api/surat/$noSurat');
    return Artikelmodel.fromJson(json.decode(data.toString()));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Artikelmodel>(
      future: _getDetailSurah(),
      initialData: null,
      builder: ((context, snapshot) {
        if (!snapshot.hasData) {
          return Scaffold(
              body: Center(
                child: LoadingAnimationWidget.bouncingBall(
                  color: Colors.white,
                  size: 200,
                ),
              ),
              backgroundColor: Colors.blueGrey);
        }
        Artikelmodel artikelmodel = snapshot.data!;
        return Scaffold(
          backgroundColor: Colors.blueGrey,
          appBar: _appBar(context: context, artikelmodel: artikelmodel),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: ListView.separated(
              itemBuilder: (context, index) => _ayatItem(
                ayat: artikelmodel.ayat!
                    .elementAt(index), // Ensure correct access to the element
              ),
              itemCount:
                  artikelmodel.jumlahAyat, // Set the correct number of items
              separatorBuilder: (context, index) =>
                  Container(), // Use any custom separator if needed
            ),
          ),
        );
      }),
    );
  }

  Widget _ayatItem({required Ayat ayat}) => Container(
        margin: const EdgeInsets.only(bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 27,
                        height: 27,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 59, 55, 39),
                          borderRadius: BorderRadius.circular(27 / 2),
                        ),
                        child: Center(
                          child: Text(
                            '${ayat.nomor}',
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          ayat.ar,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                          textAlign: TextAlign.right,
                          // Minimum font size to accommodate smaller text
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Text(
              ayat.tr,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            Text(
              ayat.idn,
              style: const TextStyle(
                color: Colors.white54,
                fontWeight: FontWeight.bold,
                fontSize: 10,
              ),
            ),
          ],
        ),
      );

  AppBar _appBar(
          {required BuildContext context,
          required Artikelmodel artikelmodel}) =>
      AppBar(
        backgroundColor: const Color.fromARGB(255, 65, 101, 132),
        elevation: 0,
        title: Row(
          children: [
            Text(
              '${artikelmodel.namaLatin} | ${artikelmodel.tempatTurun.name} ',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
}
