import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;

Future<String> loadAyatAsset(int noSurat) async {
  return await rootBundle.loadString('assets/surah/$noSurat.json');
}
