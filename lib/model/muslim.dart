import 'dart:convert';

class Muslim {
  String name;
  String slug;
  List<Item> items;

  Muslim({
    required this.name,
    required this.slug,
    required this.items,
  });

  factory Muslim.fromJson(Map<String, dynamic> json) => Muslim(
        name: json['name'],
        slug: json['slug'],
        items: (json['item'] as List<dynamic>)
            .map((item) => Item.fromJson(item))
            .toList(),
      );
}

class Item {
  int number;
  String arab;
  String id;

  Item({
    required this.number,
    required this.arab,
    required this.id,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        number: json['number'],
        arab: json['arab'],
        id: json['id'],
      );
}

List<Muslim> parseMuslim(String json) {
  final decodedJson = jsonDecode(json);
  final List<dynamic> muslimList = decodedJson['data'];

  return muslimList.map((json) => Muslim.fromJson(json)).toList();
}

// Fungsi untuk mencari hadis
List<Muslim> searchHadis(List<Muslim> muslimList, String query) {
  final List<Muslim> matchedMuslims = [];

  for (var muslim in muslimList) {
    // Filter berdasarkan nomor hadis atau teks Arab/terjemahan
    final matchedItems = muslim.items.where((item) {
      final queryLower = query.toLowerCase();
      return item.number.toString().contains(queryLower) ||
          item.arab.toLowerCase().contains(queryLower) ||
          item.id.toLowerCase().contains(queryLower);
    }).toList();

    if (matchedItems.isNotEmpty) {
      matchedMuslims.add(Muslim(
        name: muslim.name,
        slug: muslim.slug,
        items: matchedItems,
      ));
    }
  }
  return matchedMuslims;
}

void main() {
  // Contoh JSON data (Anda bisa mengganti ini dengan data asli)
  String json = '''{
    "name": "Muslim",
    "slug": "muslim",
    "item": [
      {
        "number": 1,
        "arab": "وَهُوَ الْأَثَرُ الْمَشْهُورُ...",
        "id": "Hadis pertama terjemahan..."
      },
      {
        "number": 2,
        "arab": "و حَدَّثَنَا...",
        "id": "Hadis kedua terjemahan..."
      }
    ]
  }''';

  final muslimList = parseMuslim(json);

  // Cari hadis dengan kata kunci
  final query = "hadis pertama"; // Misalnya mencari berdasarkan terjemahan
  final searchResults = searchHadis(muslimList, query);

  // Tampilkan hasil pencarian
  for (var muslim in searchResults) {
    print('Nama: ${muslim.name}');
    for (var item in muslim.items) {
      print('Nomor Hadis: ${item.number}');
      print('Teks Arab: ${item.arab}');
      print('Terjemahan: ${item.id}');
      print('---');
    }
  }
}
