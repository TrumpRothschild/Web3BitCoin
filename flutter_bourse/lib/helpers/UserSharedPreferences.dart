import 'package:shared_preferences/shared_preferences.dart';

class UserSharedPreferences {
  static SharedPreferences? _preferences;

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setPrivateAddress(String address) async =>
      await _preferences!.setString('address', (address ?? ""));

  static String? getPrivateAddress() => _preferences!.getString('address') ?? "";

  static Future setPrivateLang(String lang) async => await _preferences!.setString('Lang', (lang ?? ""));

  static String? getPrivateLang() => _preferences!.getString('Lang') ?? "";

  static Future setisConnected(bool flag) async =>
      await _preferences!.setBool('isConnected', flag);

  static bool? getisConnected() => _preferences!.getBool('isConnected');

  static Future setPrivateToken(String token) async =>
      await _preferences!.setString('Token', (token ?? ""));

  static Future setUserName(String username) async =>
      await _preferences!.setString('UserName', (username ?? ""));

  static Future setLoginType(int type) async =>
      await _preferences!.setInt('LoginType', (type ?? 0));

  static String? getPrivateToken() => _preferences!.getString('Token') ?? "";

  static String? getUserName() => _preferences!.getString('UserName') ?? "";

  static int? getLoginType() => _preferences!.getInt('LoginType') ?? 0;

  static Future setWsToken(String token) async =>
      await _preferences!.setString('WsToken', token);

  static String? getWsToken() => _preferences!.getString('WsToken');

  static Future setPrivateLanuage(String token) async =>
      await _preferences!.setString('Lanuage', token);

  static String? getPrivateLanuage() => _preferences!.getString('Lanuage');

  static Future setPrivateTypeLanuage(String token) async =>
      await _preferences!.setString('TypeLanuage', token);
  static String? getPrivateTypeLanuage() => _preferences!.getString('TypeLanuage');

  static Future setPrivateAppove(String token) async => await _preferences!.setString('Appove', token);

  static String? getPrivateAppove() => _preferences!.getString('Appove');

  static Future removePrivateAddress() =>  _preferences!.remove('address');
  static Future removePrivateToken() =>  _preferences!.remove('Token');


}
