class Tafsir {
    int id;
    int surah;
    int ayat;
    String tafsir;

    Tafsir({
        required this.id,
        required this.surah,
        required this.ayat,
        required this.tafsir,
    });

    factory Tafsir.fromJson(Map<String, dynamic> json) => Tafsir(
        id: json["id"],
        surah: json["surah"],
        ayat: json["ayat"],
        tafsir: json["tafsir"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "surah": surah,
        "ayat": ayat,
        "tafsir": tafsir,
    };
}