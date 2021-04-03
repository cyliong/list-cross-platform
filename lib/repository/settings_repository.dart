import 'package:shared_preferences/shared_preferences.dart';

class SettingsRepository {
  static const String _confirmDeletePrefsKey = 'confirm_delete';

  final _prefsFuture = SharedPreferences.getInstance();

  Future<bool> isConfirmDelete() async {
    final prefs = await _prefsFuture;
    return prefs.getBool(_confirmDeletePrefsKey) ?? true;
  }

  Future<void> saveConfirmDelete(bool confirmDelete) async {
    final prefs = await _prefsFuture;
    prefs.setBool(_confirmDeletePrefsKey, confirmDelete);
  }
}
