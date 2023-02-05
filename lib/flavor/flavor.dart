import 'package:pushup_bro/model/enum/environment.dart';
import 'package:pushup_bro/model/flavor_config.dart';

class Flavor {
  static FlavorConfig _config = _Configs.debugConstants;

  static void setEnvironment(Environment env) {
    switch (env) {
      case Environment.dev:
        _config = _Configs.debugConstants;
        break;
      case Environment.prod:
        _config = _Configs.prodConstants;
        break;
    }
  }

  static String get getCurrentEnvironment {
    return _config.flavor;
  }
}

class _Configs {
  static final FlavorConfig debugConstants = FlavorConfig('dev');
  static final FlavorConfig prodConstants = FlavorConfig('prod');
}
