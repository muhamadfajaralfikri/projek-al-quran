import 'dart:convert';

List<Nasai> parseNasai(String? json) {
  if (json == null || json.isEmpty) return [];

  final decodedJson = jsonDecode(json);

  // Periksa apakah data adalah list atau objek JSON
  if (decodedJson is Map<String, dynamic>) {
    // Jika objek, coba akses dengan key tertentu, misalnya 'data'
    final List<dynamic>? dataList = decodedJson['data'];
    if (dataList != null) {
      return dataList.map((json) => Nasai.fromJson(json)).toList();
    }
  } else if (decodedJson is List<dynamic>) {
    return decodedJson.map((json) => Nasai.fromJson(json)).toList();
  }
  return [];
}

class Nasai {
  String name;
  String slug;
  List<Item> items;

  Nasai({
    required this.name,
    required this.slug,
    required this.items,
  });

  factory Nasai.fromJson(Map<String, dynamic> json) => Nasai(
        name: json['name'],
        slug: json['slug'],
        items: (json['items'] as List<dynamic>)
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
