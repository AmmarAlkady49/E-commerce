import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final _storgage = FlutterSecureStorage();

  Future saveSecureData(String key, String value) async {
    return await _storgage.write(key: key, value: value);
  }

  Future readSecureData(String key) async {
    var readSecureData = await _storgage.read(key: key);
    return readSecureData;
  }

  Future deleteSecureData(String key) async {
    var deleteSecureData = await _storgage.delete(key: key);
    return deleteSecureData;
  }
}
