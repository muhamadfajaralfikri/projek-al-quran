import 'dart:convert';

List<Nabi> parseNabi(String? json) {
  if (json == null) {
    return [];
  }
  final List<dynamic> parsed = jsonDecode(json);
  return parsed.map((json) => Nabi.fromJson(json)).toList();
}

class Nabi {
  String nomor;
  String name;
  String thnKelahiran;
  int usia;
  String description;
  String tmp;
  String imageUrl;
  String iconUrl;

  Nabi({
    required this.nomor,
    required this.name,
    required this.thnKelahiran,
    required this.usia,
    required this.description,
    required this.tmp,
    required this.imageUrl,
    required this.iconUrl,
  });

  factory Nabi.fromJson(Map<String, dynamic> json) => Nabi(
        nomor: json["nomor"],
        name: json["name"],
        thnKelahiran: json["thn_kelahiran"],
        usia: json["usia"],
        description: json["description"],
        tmp: json["tmp"],
        imageUrl: json["image_url"],
        iconUrl: json["icon_url"],
      );

  Map<String, dynamic> toJson() => {
        "nomor": nomor,
        "name": name,
        "thn_kelahiran": thnKelahiran,
        "usia": usia,
        "description": description,
        "tmp": tmp,
        "image_url": imageUrl,
        "icon_url": iconUrl,
      };
}
