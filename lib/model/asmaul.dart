import 'dart:convert';

List<Asmaulhusna> parseAsmaul(String? json) {
  if (json == null) {
    return [];
  }
  final List<dynamic> parsed = jsonDecode(json);
  return parsed.map((json) => Asmaulhusna.fromJson(json)).toList();
}

class Asmaulhusna {
  int urutan;
  String latin;
  String arab;
  String arti;

  Asmaulhusna({
    required this.urutan,
    required this.latin,
    required this.arab,
    required this.arti,
  });

  factory Asmaulhusna.fromJson(Map<String, dynamic> json) => Asmaulhusna(
        urutan: json["urutan"],
        latin: json["latin"],
        arab: json["arab"],
        arti: json["arti"],
      );

  Map<String, dynamic> toJson() => {
        "urutan": urutan,
        "latin": latin,
        "arab": arab,
        "arti": arti,
      };
}
