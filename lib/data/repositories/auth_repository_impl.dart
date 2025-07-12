// lib/data/repositories/auth_repository_impl.dart

import 'package:firebase_auth/firebase_auth.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth _firebaseAuth;

  AuthRepositoryImpl({FirebaseAuth? firebaseAuth})
    : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  // ... (kode login, register, logout tetap sama) ...

  @override
  Future<String?> getToken() async {
    return _firebaseAuth.currentUser?.uid;
  }

  @override
  Future<void> login(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'invalid-credential') {
        throw Exception('Email atau password salah.');
      } else {
        throw Exception('Terjadi kesalahan: ${e.message}');
      }
    } catch (e) {
      throw Exception('Terjadi kesalahan yang tidak diketahui.');
    }
  }

  @override
  Future<void> register(String name, String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      await userCredential.user?.updateDisplayName(name);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw Exception('Password yang diberikan terlalu lemah.');
      } else if (e.code == 'email-already-in-use') {
        throw Exception('Akun dengan email ini sudah terdaftar.');
      } else {
        throw Exception('Terjadi kesalahan: ${e.message}');
      }
    } catch (e) {
      throw Exception('Terjadi kesalahan yang tidak diketahui.');
    }
  }

  @override
  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }

  // PERBAIKAN UTAMA DI SINI
  @override
  Future<User?> getCurrentUser() async {
    final user = _firebaseAuth.currentUser;
    // Penting: Muat ulang data pengguna untuk mendapatkan info profil terbaru,
    // terutama displayName yang mungkin belum tersedia setelah pendaftaran.
    await user?.reload();
    // Kembalikan objek user yang sudah di-refresh
    return _firebaseAuth.currentUser;
  }
}
