import 'package:flutter_secure_storage/flutter_secure_storage.dart';

//----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
// ACCESS AND REFRESH TOKEN
//----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

class Tokens {
  static String? _refreshToken;
  static String? _accessToken;

  static String? get accessToken => _accessToken;

  static Future<String?> get refreshToken async {
    if (_refreshToken != null) return _refreshToken;
    final storage = FlutterSecureStorage();
    _refreshToken = await storage.read(key: "refreshToken");
    return _refreshToken;
  }

  static Future<void> save({
    required String accessToken,
    required String refreshToken,
  }) async {
    _refreshToken = refreshToken;
    _accessToken = accessToken;
    final storage = FlutterSecureStorage();
    await storage.write(key: "refreshToken", value: refreshToken);
  }

  static clear() async {
    _refreshToken = null;
    _accessToken = null;
    final storage = FlutterSecureStorage();
    await storage.delete(key: "refreshToken");
  }
}

//----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
// SINGLE TOKEN
//----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

// class Tokens {
//   static String? _token;

//   static Future<String?> get token async {
//     if (_token != null) return _token;
//     final storage = FlutterSecureStorage();
//     _token = await storage.read(key: "refreshToken");
//     return _token;
//   }

//   static save({
//     required String accessToken,
//     required String refreshToken,
//   }) async {
//     _token = refreshToken;

//     final storage = FlutterSecureStorage();
//     await storage.write(key: "refreshToken", value: refreshToken);
//   }

//   static clear() async {
//     _token = null;
//     final storage = FlutterSecureStorage();
//     await storage.delete(key: "refreshToken");
//   }
// }
