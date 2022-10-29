import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class KeyStorage {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  void write(String key, String? value) async {
    await _storage.write(
      key: key,
      value: value,
      iOptions: const IOSOptions(),
      aOptions: const AndroidOptions(
        encryptedSharedPreferences: true,
        // sharedPreferencesName: 'Test2',
        // preferencesKeyPrefix: 'Test'
      ),
    );
  }

  Future<String?> read(String key) async {
    return await _storage.read(
      key: key,
      iOptions: const IOSOptions(),
      aOptions: const AndroidOptions(
        encryptedSharedPreferences: true,
        // sharedPreferencesName: 'Test2',
        // preferencesKeyPrefix: 'Test'
      ),
    );
  }
}