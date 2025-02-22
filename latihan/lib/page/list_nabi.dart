import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:latihan/home_page.dart';
import 'package:latihan/model/nabi.dart';


class ListNabi extends StatelessWidget {
  const ListNabi({super.key});

  @override
  Widget build(BuildContext context) {
    // Mengambil tanggal dalam format bahasa Indonesia
    final DateTime now = DateTime.now();
    final String formattedDate = DateFormat('EEEE, d MMMM y', 'id_ID').format(now);


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
            Expanded(
              child: FutureBuilder<String>(
                future: DefaultAssetBundle.of(context).loadString('assets/nabi.json'),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(child: Text('Error loading data'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No data available'));
                  } else {
                    final List<Nabi> nabi = parseNabi(snapshot.data!);
                    return ListView.builder(
                      itemCount: nabi.length,
                      itemBuilder: (context, index) {
                        return _buildArticleItem(context, nabi[index]);
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

  Widget _buildArticleItem(BuildContext context, Nabi nabi) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Card(
        elevation: 0,
        child: ListTile(
          title: Text(
            nabi.name,
            style: const TextStyle(fontSize: 20),
          ),
          leading: Container(
            height: 30,
            width: 30,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.black, width: 2),
            ),
            child: Center(
              child: Text(
                nabi.nomor.toString(),
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () {
            _showDetailsDialog(context, nabi);
          },
        ),
      ),
    );
  }

  void _showDetailsDialog(BuildContext context, Nabi nabi) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            nabi.name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 27,
            ),
            textAlign: TextAlign.center,
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Tempat dilahirkan: ${nabi.tmp}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Usia wafat: ${nabi.usia} tahun',
                  style: const TextStyle(
                    fontSize: 20,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  nabi.description,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          insetPadding: const EdgeInsets.all(10),
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
  }
}
