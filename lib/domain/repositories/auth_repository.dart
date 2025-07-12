// lib/domain/repositories/auth_repository.dart

import 'package:firebase_auth/firebase_auth.dart'; // <-- Import User dari Firebase

// Ini adalah 'kontrak' atau interface.
abstract class AuthRepository {
  Future<void> login(String email, String password);
  Future<void> register(String name, String email, String password);
  Future<void> logout();
  Future<String?> getToken();
  Future<User?> getCurrentUser(); // <-- METODE BARU
}
