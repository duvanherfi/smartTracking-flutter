import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesV2 {
  late SharedPreferences _prefs;
  final String _sessionToken = "token";
  static const String _baseUrl = "base_url";

  static const String _baseUrlRoutes = "base_url_routes";
  final String _appTheme = 'app_theme';
  final String _appIsHidden = 'app_is_hidden';
  final String _isDarkModeEnable = 'dark_mode_enable';

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<String?> getToken() async {
    _prefs = await SharedPreferences.getInstance();
    return _prefs.getString(_sessionToken)?.isEmpty == true
        ? null
        : _prefs.getString(_sessionToken);
  }

  Future<bool> setToken(String? token) async {
    return _prefs.setString(_sessionToken, token ?? '');
  }

  Future<bool> removeToken() async {
    return _prefs.remove(_sessionToken);
  }

  static Future<bool> setApiBaseUrl(String baseUrl) async {
    return (await SharedPreferences.getInstance()).setString(_baseUrl, baseUrl);
  }

  static Future<String?> getApiBaseUrl() async {
    return (await SharedPreferences.getInstance()).getString(_baseUrl);
  }

  static Future<bool> setApiBaseUrlRoutes(String baseUrl) async {
    return (await SharedPreferences.getInstance())
        .setString(_baseUrlRoutes, baseUrl);
  }

  static Future<String?> getApiBaseUrlRoutes() async {
    return (await SharedPreferences.getInstance()).getString(_baseUrlRoutes);
  }

  Future<void> clearData() async {
    await _prefs.clear();
  }

  Future<void> reload() async {
    await _prefs.reload();
  }

  Future<bool> setAppIsHidden(bool isHidden) async {
    return _prefs.setBool(_appIsHidden, isHidden);
  }

  Future<bool> getAppIsHidden() async {
    await init();
    await _prefs.reload();
    return _prefs.getBool(_appIsHidden) ?? false;
  }

  Future<bool> setIsDarkModeEnabled(bool isDark) async {
    return _prefs.setBool(_isDarkModeEnable, isDark);
  }

  Future<bool?> getIsDarkModeEnabled() async {
    await reload();
    return _prefs.getBool(_isDarkModeEnable) ?? false;
  }

  Future<bool> setCurrentAppTheme(String theme) async {
    return _prefs.setString(_appTheme, theme);
  }

  String? getCurrentAppTheme() {
    return _prefs.getString(_appTheme);
  }
}
