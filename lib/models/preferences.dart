import 'package:shared_preferences/shared_preferences.dart';

void addStringToSF(String cle, String value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(cle, value);
}

void addBoolToSF(String cle, bool value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool(cle, value);
}

void addDoubleToSF(String cle, double value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setDouble(cle, value);
}

void addIntToSF(String cle, int value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setInt(cle, value);
}
