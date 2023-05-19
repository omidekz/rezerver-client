import 'package:service_manager_client/utils/base_db.dart';
import 'package:shared_preferences/shared_preferences.dart' as sp;

class SharedPreferences {
  static sp.SharedPreferences? _pref;

  SharedPreferences() {
    _initStaticCon();
  }

  static void _initStaticCon() => Future.microtask(
        () async => _pref = await sp.SharedPreferences.getInstance(),
      );

  static sp.SharedPreferences get pref {
    if (_pref == null) {
      _initStaticCon();
    }
    return _pref as sp.SharedPreferences;
  }

  static void setString(String key, String value) {
    Future.microtask(() async => await pref.setString(key, value));
  }

  static Future<String?> getString(String key) async {
    return pref.getString(key);
  }

  static const String authorizationKey = 'ak';
  static const String userTypeKey = 'ut';
  
  static void setJWT(Map<String, String> resp) {
    if (resp.containsKey('token') && resp.containsKey('user_type')) {
      setString(authorizationKey, resp['token'] as String);
      setString(userTypeKey, resp['user_type'] as String);
    }
  }
}
