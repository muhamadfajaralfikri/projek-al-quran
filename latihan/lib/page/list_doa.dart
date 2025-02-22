import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:latihan/home_page.dart';
import 'package:latihan/model/doa.dart';

class ListDoa extends StatelessWidget {
  const ListDoa({super.key});

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('id_ID', null);

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
                    .loadString('assets/doa.json'),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(child: Text('Error loading data'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No data available'));
                  } else {
                    final List<Doa> doa = parseDoa(snapshot.data!);
                    return ListView.builder(
                      itemCount: doa.length,
                      itemBuilder: (context, index) {
                        return _buildArticleItem(context, doa[index]);
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

  Widget _buildArticleItem(BuildContext context, Doa doa) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Card(
        elevation: 0,
        child: ListTile(
          title: Text(
            doa.doa,
            style: const TextStyle(fontSize: 20),
          ),
          leading: Container(
            height: 30,
            width: 30,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20 / 2),
              border: Border.all(color: Colors.black, width: 2),
            ),
            child: Center(
              child: Text(
                doa.id.toString(),
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
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
                    doa.doa,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 27,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  titlePadding: const EdgeInsets.all(
                      20), // Adjust the padding around the title
                  content: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize
                          .min, // Ensures the dialog doesn't take up more space than needed
                      children: [
                        Text(
                          doa.ayat,
                          style: const TextStyle(
                            fontSize: 33,
                            fontStyle: FontStyle.italic,
                          ),
                          textAlign: TextAlign.right,
                        ),
                        Text(
                          doa.latin,
                          style: const TextStyle(
                            fontSize: 20,
                            fontStyle: FontStyle.italic,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        const SizedBox(
                            height:
                                20), // Adds spacing between artinya and ayat
                        Text(
                          doa.artinya,
                          style: const TextStyle(
                            fontWeight: FontWeight.w100,
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
          },
        ),
      ),
    );
  }
}
