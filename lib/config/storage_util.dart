import 'package:shared_preferences/shared_preferences.dart';

class Pref {
  factory Pref() => _instance;

  Pref._();

  static final Pref _instance = Pref._();

  static String recentKeyword = 'rct_kwd';

  late SharedPreferences storage;

  Future<void> initStorage() async {
    storage = await SharedPreferences.getInstance();
  }
}
