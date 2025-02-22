import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:latihan/model/muslim.dart'; // Ensure the correct model import
import 'package:latihan/page/hadiss.dart';

class MuslimScreen extends StatefulWidget {
  const MuslimScreen({Key? key}) : super(key: key);

  @override
  State<MuslimScreen> createState() => _MuslimScreenState();
}

class _MuslimScreenState extends State<MuslimScreen> {
  List<Muslim> _allMuslim = [];
  List<Muslim> _filteredMuslim = [];
  final TextEditingController _searchController = TextEditingController();
  bool _isLoading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('id_ID', null);
    _loadHadisData(); // Load Hadis data
  }

  Future<void> _loadHadisData() async {
    try {
      final String jsonString = await DefaultAssetBundle.of(context)
          .loadString('assets/hadis/muslim.json'); // Ensure correct path

      final List<Muslim> muslimList =
          await compute(_parseMuslimData, jsonString); // Parse the JSON

      setState(() {
        _allMuslim = muslimList;
        _filteredMuslim = muslimList;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Error loading data.';
      });
      debugPrint("Error loading Muslim data: $e");
    }
  }

  static List<Muslim> _parseMuslimData(String jsonString) {
    final List<dynamic> jsonData = json.decode(jsonString);
    return jsonData.map((e) => Muslim.fromJson(e)).toList();
  }

  // Function to filter based on search query
  void _filterMuslim(String query) {
    final lowerCaseQuery = query.toLowerCase();

    final filtered = _allMuslim.where((muslim) {
      // Check if any item inside `muslim.items` matches the query
      return muslim.items.any((item) {
        final itemNumber = "Hadist Imam Muslim No ${item.number}".toLowerCase();
        final arabicText = item.arab.toLowerCase();
        final translationText = item.id.toLowerCase();

        return itemNumber.contains(lowerCaseQuery) ||
            arabicText.contains(lowerCaseQuery) ||
            translationText.contains(lowerCaseQuery);
      });
    }).toList(); // Call toList() only once here

    setState(() {
      _filteredMuslim = filtered; // Update the filtered list
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
                        SizedBox(width: 8),
                        Text(
                          "HR. IMAM Muslim",
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
              padding: const EdgeInsets.all(20),
              child: TextField(
                controller: _searchController,
                onChanged: _filterMuslim,
                decoration: InputDecoration(
                  hintText: 'Cari Hadis...',
                  hintStyle: const TextStyle(color: Colors.white),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.2),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(
                            Icons.clear,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            setState(() {
                              _searchController.clear();
                              _filterMuslim('');
                            });
                          },
                        )
                      : null,
                ),
                style: const TextStyle(color: Colors.white),
                textInputAction: TextInputAction.search,
              ),
            ),
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _filteredMuslim.isEmpty
                      ? Center(
                          child: Text(
                            _errorMessage.isEmpty
                                ? 'Data Tidak Ditemukan'
                                : _errorMessage,
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        )
                      : ListView.builder(
                          itemCount: _filteredMuslim.length,
                          itemBuilder: (context, index) {
                            return _buildHadisItem(
                                context, _filteredMuslim[index]);
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHadisItem(BuildContext context, Muslim muslim) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: muslim.items.length,
      itemBuilder: (context, index) {
        final item = muslim.items[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: Card(
            elevation: 2,
            child: ListTile(
              title: Text(
                "Hadist Imam Muslim No ${item.number}",
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
