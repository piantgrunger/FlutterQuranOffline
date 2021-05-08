
class Surat {
  final int noSurat;
  final String nama;
  final String namaArab;
  final String arti;
  final int jumlahAyat;

  Surat({
    this.noSurat,
    this.arti,
    this.jumlahAyat,
    this.nama,
    this.namaArab

  });


  String toString() => '$nama - $namaArab';
  factory  Surat.fromJson(Map jsonMap) {
      return Surat(
         noSurat : jsonMap['number_of_surah'].toInt(),
        nama : jsonMap['name'],
        namaArab : jsonMap['name_translations']['ar'],
        arti : jsonMap['name_translations']['id'],
        jumlahAyat : jsonMap['number_of_ayah']
      );
  }
}

