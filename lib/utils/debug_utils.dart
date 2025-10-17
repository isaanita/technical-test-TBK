import 'package:shared_preferences/shared_preferences.dart';

class DebugUtils {
  /// Print semua SharedPreferences yang ada
  static Future<void> printLocalStorage() async {
    final prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys();

    if (keys.isEmpty) {
      print('SharedPreferences kosong');
      return;
    }

    print('--- SharedPreferences Data ---');
    for (var key in keys) {
      final value = prefs.get(key);
      print('$key : $value');
    }
    print('-----------------------------');
  }
}
