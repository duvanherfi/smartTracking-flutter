import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:smart_tracking/utils/extensions/string_extensions.dart';

class Config {
  // Local
  bool useLocalConfig = false;

  bool _checkLocalKey(String key) => dotenv.isEveryDefined([key]);

  bool isLocalKeyAvailable(String key) => useLocalConfig && _checkLocalKey(key);

  void initLocal() {
    useLocalConfig =
        dotenv.maybeGet('USE_LOCAL_CONFIG')?.toBoolean() ?? useLocalConfig;

    if (!useLocalConfig) {
      return;
    }
  }
}
