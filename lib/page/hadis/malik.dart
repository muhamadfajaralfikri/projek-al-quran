import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:latihan/model/malik.dart';
import 'package:latihan/page/hadiss.dart';

class MalikScreen extends StatefulWidget {
  const MalikScreen({Key? key}) : super(key: key);

  @override
  State<MalikScreen> createState() => _MalikScreenState();
}

class _MalikScreenState extends State<MalikScreen> {
  List<Malik> _allMalik = [];
  List<Malik> _filteredMalik = [];
  final TextEditingController _searchController = TextEditingController();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('id_ID', null);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadHadisData();
  }

  Future<void> _loadHadisData() async {
    try {
      final String jsonString = await DefaultAssetBundle.of(context)
          .loadString('assets/hadis/malik.json');
      final List<Malik> MalikList = await compute(_parseMalikData, jsonString);

      setState(() {
        _allMalik = MalikList;
        _filteredMalik = MalikList;
        _isLoading = false;
      });
    } catch (e) {
      debugPrint("Error loading Malik data: $e");
    }
  }

  static List<Malik> _parseMalikData(String jsonString) {
    final List<dynamic> jsonData = json.decode(jsonString);
    return jsonData.map((e) => Malik.fromJson(e)).toList();
  }

  void _filterHadisList(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredMalik = _allMalik;
      } else {
        _filteredMalik = _allMalik.where((Malik) {
          return Malik.items.any((item) {
            final queryLower = query.toLowerCase();
            return item.arab.toLowerCase().contains(queryLower) ||
                item.id.toLowerCase().contains(queryLower) ||
                item.number.toString().contains(query);
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
                          "HR. IMAM MALIK",
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
                      itemCount: _filteredMalik.length,
                      itemBuilder: (context, index) {
                        return _buildHadisItem(context, _filteredMalik[index]);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHadisItem(BuildContext context, Malik Malik) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: Malik.items.length,
      itemBuilder: (context, index) {
        final item = Malik.items[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: Card(
            elevation: 2,
            child: ListTile(
              title: Text(
                "Hadis No. ${item.number}",
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
