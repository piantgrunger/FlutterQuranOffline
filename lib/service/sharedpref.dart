import 'package:shared_preferences/shared_preferences.dart';

void addDefaultValueToSharedPreferences() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  await sharedPreferences.setDouble('fontsize', 20.0);
}

Future<double> getFontSize() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  return sharedPreferences.getDouble('fontsize');
}

Future<void> updateFontSize(double updatedSize) async {
  final sharedPreferences = await SharedPreferences.getInstance();
  return await sharedPreferences.setDouble('fontsize', updatedSize);
}
