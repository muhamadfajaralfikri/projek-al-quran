import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'; // Untuk compute()
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:latihan/model/nasai.dart';
import 'package:latihan/page/hadiss.dart';

class NasaiScreen extends StatefulWidget {
  const NasaiScreen({Key? key}) : super(key: key);

  @override
  State<NasaiScreen> createState() => _NasaiScreenState();
}

class _NasaiScreenState extends State<NasaiScreen> {
  List<Nasai> _allNasai = [];
  List<Nasai> _filteredNasai = [];
  final TextEditingController _searchController = TextEditingController();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('id_ID', null);
    _loadHadisData();
  }

  Future<void> _loadHadisData() async {
    final String jsonString = await DefaultAssetBundle.of(context)
        .loadString('assets/hadis/nasai.json');

    final List<Nasai> NasaiList = await compute(_parseNasaiData, jsonString);

    setState(() {
      _allNasai = NasaiList;
      _filteredNasai = NasaiList;
      _isLoading = false;
    });
  }

  static List<Nasai> _parseNasaiData(String jsonString) {
    final List<dynamic> jsonData = json.decode(jsonString);
    return jsonData.map((e) => Nasai.fromJson(e)).toList();
  }

  void _filterHadisList(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredNasai = _allNasai;
      } else {
        _filteredNasai = _allNasai.where((Nasai) {
          return Nasai.items.any((item) {
            final arabicText = item.arab.toLowerCase();
            final translationText = item.id.toLowerCase();
            final numberText = item.number.toString();

            return arabicText.contains(query.toLowerCase()) ||
                translationText.contains(query.toLowerCase()) ||
                numberText.contains(query);
          });
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();
    final String formattedDate =
        DateFormat('EEEE d MMMM y', 'id_ID').format(now);

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
                          builder: (context) => const Hadiss(),
                        ),
                      );
                    },
                    child: const Row(
                      children: [
                        Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                          size: 30,
                        ),
                        SizedBox(
                            width: 8), // Memberikan jarak antar ikon dan teks
                        Text(
                          "HR. IMAM NASAI",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5, left: 50),
              child: Row(
                children: [
                  const Icon(Icons.date_range, color: Colors.white),
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
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Cari hadis...',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
                onChanged: _filterHadisList,
              ),
            ),
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: _filteredNasai.length,
                      itemBuilder: (context, index) {
                        return _buildHadisItem(context, _filteredNasai[index]);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHadisItem(BuildContext context, Nasai Nasai) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: Nasai.items.length,
      itemBuilder: (context, index) {
        final item = Nasai.items[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: Card(
            elevation: 2,
            child: ListTile(
              title: Text(
                "HR. IMAM Nasai No. ${item.number}",
                style: const TextStyle(fontSize: 20),
              ),
              leading: ClipPath(
                clipper: OctagonClipper(),
                child: Container(
                  height: 30,
                  width: 30,
                  alignment: Alignment.center,
                  color: const Color.fromARGB(255, 255, 161, 161),
                  child: Text(
                    "${item.number}",
                    style: const TextStyle(
                      color: Color.fromARGB(255, 150, 15, 15),
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text(
                        "Hadis Nomor ${item.number}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 27,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      content: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.arab,
                              style: const TextStyle(
                                fontSize: 28,
                                fontStyle: FontStyle.italic,
                              ),
                              textAlign: TextAlign.right,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              item.id,
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Close'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class OctagonClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final double w = size.width;
    final double h = size.height;
    final Path path = Path();

    path.moveTo(w * 0.3, 0);
    path.lineTo(w * 0.7, 0);
    path.lineTo(w, h * 0.3);
    path.lineTo(w, h * 0.7);
    path.lineTo(w * 0.7, h);
    path.lineTo(w * 0.3, h);
    path.lineTo(0, h * 0.7);
    path.lineTo(0, h * 0.3);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
