import 'dart:convert';

import 'package:latihan/model/ayat.dart';

List<Artikelmodel> parseArticles(String? json) {
  if (json == null) {
    return [];
  }
  final List parsed = jsonDecode(json);
  return parsed.map((json) => Artikelmodel.fromJson(json)).toList();
}

class Artikelmodel {
  int nomor;
  String nama;
  String namaLatin;
  int jumlahAyat;
  TempatTurun tempatTurun;
  String arti;
  String deskripsi;
  String audio;
  List<Ayat>? ayat;

  Artikelmodel({
    required this.nomor,
    required this.nama,
    required this.namaLatin,
    required this.jumlahAyat,
    required this.tempatTurun,
    required this.arti,
    required this.deskripsi,
    required this.audio,
    required this.ayat,
  });

  factory Artikelmodel.fromJson(Map<String, dynamic> json) => Artikelmodel(
      nomor: json["nomor"],
      nama: json["nama"],
      namaLatin: json["nama_latin"],
      jumlahAyat: json["jumlah_ayat"],
      tempatTurun: tempatTurunValues.map[json["tempat_turun"]] ??
          TempatTurun.MEKAH, // Default to MEKAH if not found
      arti: json["arti"],
      deskripsi: json["deskripsi"],
      audio: json["audio"],
      ayat: json.containsKey('ayat')
          ? List<Ayat>.from(json['ayat']!.map((x) => Ayat.fromJson(x)))
          : null // Default to empty list if 'ayat' key is missing
      );

  Map<String, dynamic> toJson() => {
        "nomor": nomor,
        "nama": nama,
        "nama_latin": namaLatin,
        "jumlah_ayat": jumlahAyat,
        "tempat_turun": tempatTurunValues.reverse[tempatTurun],
        "arti": arti,
        "deskripsi": deskripsi,
        "audio": audio,
      };
}

enum TempatTurun { MADINAH, MEKAH }

final tempatTurunValues =
    EnumValues({"madinah": TempatTurun.MADINAH, "mekah": TempatTurun.MEKAH});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
