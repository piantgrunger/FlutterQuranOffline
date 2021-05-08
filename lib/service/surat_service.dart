import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;


Future<String> loadSuratAsset() async {
  return await rootBundle.loadString('assets/quran.json');
}
