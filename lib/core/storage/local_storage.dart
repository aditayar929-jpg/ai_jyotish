import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  final SharedPreferences _prefs;

  LocalStorage(this._prefs);

  // Keys
  static const String _kAccessToken = 'access_token';
  static const String _kRefreshToken = 'refresh_token';
  static const String _kUserId = 'user_id';
  static const String _kUserZodiac = 'user_zodiac';
  static const String _kIsFirstLaunch = 'is_first_launch';
  static const String _kIsLoggedIn = 'is_logged_in';
  static const String _kLanguage = 'language';
  static const String _kTheme = 'theme';
  static const String _kNotifications = 'notifications_enabled';
  static const String _kPremium = 'is_premium';

  // Token
  String? get accessToken => _prefs.getString(_kAccessToken);
  String? get refreshToken => _prefs.getString(_kRefreshToken);

  Future<void> saveAccessToken(String token) => _prefs.setString(_kAccessToken, token);
  Future<void> saveRefreshToken(String token) => _prefs.setString(_kRefreshToken, token);

  // User
  String? get userId => _prefs.getString(_kUserId);
  String? get userZodiac => _prefs.getString(_kUserZodiac);

  Future<void> saveUserId(String id) => _prefs.setString(_kUserId, id);
  Future<void> saveUserZodiac(String zodiac) => _prefs.setString(_kUserZodiac, zodiac);

  // Flags
  bool get isFirstLaunch => _prefs.getBool(_kIsFirstLaunch) ?? true;
  bool get isLoggedIn => _prefs.getBool(_kIsLoggedIn) ?? false;
  bool get isPremium => _prefs.getBool(_kPremium) ?? false;

  Future<void> setFirstLaunchDone() => _prefs.setBool(_kIsFirstLaunch, false);
  Future<void> setLoggedIn(bool value) => _prefs.setBool(_kIsLoggedIn, value);
  Future<void> setPremium(bool value) => _prefs.setBool(_kPremium, value);

  // Preferences
  String get language => _prefs.getString(_kLanguage) ?? 'en';
  bool get notificationsEnabled => _prefs.getBool(_kNotifications) ?? true;

  Future<void> saveLanguage(String lang) => _prefs.setString(_kLanguage, lang);
  Future<void> setNotifications(bool value) => _prefs.setBool(_kNotifications, value);

  // Clear
  Future<void> clearAll() async {
    await _prefs.clear();
  }
}
