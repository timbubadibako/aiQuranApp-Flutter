// lib/data/datasources/auth_local_datasource.dart

import 'package:hive_flutter/hive_flutter.dart';

// Interface untuk data source lokal
abstract class AuthLocalDataSource {
  Future<void> saveToken(String token);
  Future<void> deleteToken();
  String? getToken();
}

// Implementasi konkret menggunakan Hive
class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final Box userBox;

  AuthLocalDataSourceImpl(this.userBox);

  @override
  Future<void> deleteToken() async {
    await userBox.delete('authToken');
  }

  @override
  String? getToken() {
    return userBox.get('authToken');
  }

  @override
  Future<void> saveToken(String token) async {
    await userBox.put('authToken', token);
  }
}
