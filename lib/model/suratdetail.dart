class SuratDetail {
  final String noSurat;
  final String ayat;
  final String ayatArab;
  final String terjemahan;
  final String tafsir;
  final String recitation;

  SuratDetail(
      {this.noSurat,
      this.ayat,
      this.tafsir,
      this.terjemahan,
      this.ayatArab,
      this.recitation});

  String toString() => '$ayatArab - $terjemahan';

  factory SuratDetail.fromJson(Map jsonMap, String index, String noSurat) {
    var recAyah = noSurat.padLeft(3, '0') + index.padLeft(3, '0');
    return SuratDetail(
        noSurat: noSurat,
        ayat: index,
        ayatArab: jsonMap['text'][index],
        terjemahan: jsonMap['translations']['id']['text'][index],
        tafsir: jsonMap['tafsir']['id']['kemenag']['text'][index],
        recitation:
            'https://www.everyayah.com/data/Abdurrahmaan_As-Sudais_192kbps/${recAyah}.mp3');
  }
}
