import 'package:shared_preferences/shared_preferences.dart';

class SettingsRepository {
  static const String _confirmDeletePrefsKey = 'confirm_delete';

  final _prefsFuture = SharedPreferences.getInstance();
}
