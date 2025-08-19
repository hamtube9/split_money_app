import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:split_money/models/user/user.dart';

class SharedPrefKeys {
  SharedPrefKeys._();

  static const String token = 'token';
  static const String firstRun = 'first_run';
  static const String user = 'user';
}

class SharedPreferencesService {
  static late SharedPreferencesService _instance;
  static late SharedPreferences _preferences;
  static late FlutterSecureStorage _secureStorage;

  SharedPreferencesService._internal();

  static Future<SharedPreferencesService> get instance async {
    _instance = SharedPreferencesService._internal();
    _preferences = await SharedPreferences.getInstance();
    _secureStorage = const FlutterSecureStorage();
    return _instance;
  }

  void checkFirstRun() async {
    if (_preferences.getBool(SharedPrefKeys.firstRun) ?? true) {
      await _secureStorage.deleteAll();
      _preferences.setBool(SharedPrefKeys.firstRun, false);
    }
  }

  // Set token
  Future<void> setToken(String token) async =>
      await _secureStorage.write(key: SharedPrefKeys.token, value: token);

  // Get token
  Future<String?> get token => _secureStorage.read(key: SharedPrefKeys.token);

  Future<void> setUser(User user) async =>
      await _secureStorage.write(key: SharedPrefKeys.user, value: user.toRawJson());

  Future<User?> get user async => User.fromRawJson( await _secureStorage.read(key: SharedPrefKeys.user) ?? "");

  Future<void> logOut() async {
    await Future.wait([_secureStorage.delete(key: SharedPrefKeys.token)]);
  }
}
