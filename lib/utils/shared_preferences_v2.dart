import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesV2 {
  late SharedPreferences _prefs;
  final String _sessionToken = "token";
  static const String _baseUrl = "base_url";
  static const String _vehicleId = "vehicle_id";
  static const String _userName = "user_name";
  static const String _email = "email";
  static const String _userId = "user_id";
  static const String _sessionId = "session_id";

  static const String _baseUrlRoutes = "base_url_routes";
  final String _appTheme = 'app_theme';
  final String _appIsHidden = 'app_is_hidden';
  static const String _pushToken = 'push_token';

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

  Future<String?> getVehicleId() async {
    _prefs = await SharedPreferences.getInstance();
    return _prefs.getString(_vehicleId)?.isEmpty == true
        ? null
        : _prefs.getString(_vehicleId);
  }

  Future<bool> setVehicleId(String? id) async {
    return _prefs.setString(_vehicleId, id ?? '');
  }

  Future<bool> removeVehicleId() async {
    return _prefs.remove(_vehicleId);
  }

  Future<String?> getUserId() async {
    _prefs = await SharedPreferences.getInstance();
    return _prefs.getString(_userId)?.isEmpty == true
        ? null
        : _prefs.getString(_userId);
  }

  Future<bool> setUserId(String? id) async {
    return _prefs.setString(_userId, id ?? '');
  }

  Future<bool> removeUserId() async {
    return _prefs.remove(_userId);
  }

  Future<String?> getSessionId() async {
    _prefs = await SharedPreferences.getInstance();
    return _prefs.getString(_sessionId)?.isEmpty == true
        ? null
        : _prefs.getString(_sessionId);
  }

  Future<bool> setSessionId(String? id) async {
    return _prefs.setString(_sessionId, id ?? '');
  }

  Future<bool> removeSessionId() async {
    return _prefs.remove(_sessionId);
  }

  Future<String?> getUserName() async {
    _prefs = await SharedPreferences.getInstance();
    return _prefs.getString(_userName)?.isEmpty == true
        ? null
        : _prefs.getString(_userName);
  }

  Future<bool> setUserName(String? name) async {
    return _prefs.setString(_userName, name ?? '');
  }

  Future<bool> removeUserName() async {
    return _prefs.remove(_userName);
  }

  Future<String?> getEmail() async {
    _prefs = await SharedPreferences.getInstance();
    return _prefs.getString(_email)?.isEmpty == true
        ? null
        : _prefs.getString(_email);
  }

  Future<bool> setEmail(String? email) async {
    return _prefs.setString(_email, email ?? '');
  }

  Future<bool> removeEmail() async {
    return _prefs.remove(_email);
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

  Future<bool> setCurrentAppTheme(String theme) async {
    return _prefs.setString(_appTheme, theme);
  }

  String? getCurrentAppTheme() {
    return _prefs.getString(_appTheme);
  }

  Future<bool> setPushTokenFirebase(String? token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_pushToken, token ?? '');
  }

  String? getPushTokenFirebase() {
    return _prefs.getString(_pushToken);
  }
}
