import 'dart:convert';

List<Shalat> parseShalat(String? json) {
  if (json == null) {
    return [];
  }
  final List<dynamic> parsed = jsonDecode(json);
  return parsed.map((json) => Shalat.fromJson(json)).toList();
}

class Shalat {
  String solat;
  int rakaat;
  String niatSendiri;
  String niatMamum;
  String niatImam;
  String latinSendiri;
  String latinMamum;
  String latinImam;
  String artiSendiri;
  String artiMamum;
  String artiImam;

  Shalat({
    required this.solat,
    required this.rakaat,
    required this.niatSendiri,
    required this.niatMamum,
    required this.niatImam,
    required this.latinSendiri,
    required this.latinMamum,
    required this.latinImam,
    required this.artiSendiri,
    required this.artiMamum,
    required this.artiImam,
  });

  factory Shalat.fromJson(Map<String, dynamic> json) => Shalat(
        solat: json["solat"],
        rakaat: json["rakaat"],
        niatSendiri: json["niat sendiri"],
        niatMamum: json["niat mamum"],
        niatImam: json["niat imam"],
        latinSendiri: json["latin sendiri"],
        latinMamum: json["latin mamum"],
        latinImam: json["latin imam"],
        artiSendiri: json["arti sendiri"],
        artiMamum: json["arti mamum"],
        artiImam: json["arti imam"],
      );

  Map<String, dynamic> toJson() => {
        "solat": solat,
        "rakaat": rakaat,
        "niat sendiri": niatSendiri,
        "niat mamum": niatMamum,
        "niat imam": niatImam,
        "latin sendiri": latinSendiri,
        "latin mamum": latinMamum,
        "latin imam": latinImam,
        "arti sendiri": artiSendiri,
        "arti mamum": artiMamum,
        "arti imam": artiImam,
      };
}
