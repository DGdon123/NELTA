import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final dbClientProvider = Provider<DbClient>((ref) {
  return DbClient();
});

class DbClient {
  removeData({required String dbKey}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(dbKey);
  }

  setData({required String dbKey, required String value}) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(dbKey, value);
  }

  getData({required var dbKey}) async {
    final prefs = await SharedPreferences.getInstance();
    final result = prefs.getString(dbKey);
    return result ?? "";
  }

  reset() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
