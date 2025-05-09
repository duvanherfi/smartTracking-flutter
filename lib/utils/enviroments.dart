import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:smart_tracking/utils/app_component.dart';
import 'package:smart_tracking/utils/config.dart';

class Environments {
  static bool get isProduction => baseUrl == production;

  static bool get isBeta =>
      baseUrl.contains('beta') || baseUrl.contains('release');

  static bool get isProductive => isProduction || isBeta;

  static const String production = 'https://smart-tracking-bcc894279cf1.herokuapp.com/api/v1/';

  static String get baseUrl => _envs["base_url"]!;


  static Map<String, String> get envs => Map.unmodifiable(_envs);

  static Map<String, String> _envs = {
    'base_url': 'https://smart-tracking-bcc894279cf1.herokuapp.com/api/v1/',
  };

  static Map<String, dynamic> _json = {};
  static bool _useLocalConfig = false;

  static void initEnvironmentUrls(Map<String, dynamic> json) {
    _json = json;
    _useLocalConfig = locator<Config>().useLocalConfig;
    final Map<String, String> newEnvs = {};
    for (final entry in _envs.entries) {
      newEnvs[entry.key] = _getUrl(key: entry.key);
    }
    _envs = newEnvs;
  }

  static String _getUrl({required String key}) {
    if (!_useLocalConfig) {
      return (_json[key] as String?) ?? _envs[key]!;
    }

    return dotenv.maybeGet(key.toUpperCase()) ??
        (_json[key] as String?) ??
        _envs[key]!;
  }
}
