import 'package:flutter/services.dart';

class NativeApiService {
  static const platform = MethodChannel('com.example.native/api');

  static Future<String?> loginUser({
    required String email,
    required String password,
    required String deviceType,
  }) async {
    try {
      final String? result = await platform.invokeMethod('login', {
        'email': email,
        'password': password,
        'device_token': '12345678',
        'device_type': deviceType,
      });
      return result;
    } on PlatformException catch (e) {
      print("Platform error: ${e.message}");
      return null;
    }
  }
}
