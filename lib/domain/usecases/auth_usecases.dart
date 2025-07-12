// lib/domain/usecases/auth_usecases.dart
import 'package:firebase_auth/firebase_auth.dart';
import '../repositories/auth_repository.dart';

// ... (LoginUseCase, LogoutUseCase, GetTokenUseCase, RegisterUseCase tetap sama) ...
class LoginUseCase {
  final AuthRepository repository;
  LoginUseCase(this.repository);
  Future<void> call(String email, String password) =>
      repository.login(email, password);
}

class LogoutUseCase {
  final AuthRepository repository;
  LogoutUseCase(this.repository);
  Future<void> call() => repository.logout();
}

class GetTokenUseCase {
  final AuthRepository repository;
  GetTokenUseCase(this.repository);
  Future<String?> call() => repository.getToken();
}

class RegisterUseCase {
  final AuthRepository repository;
  RegisterUseCase(this.repository);
  Future<void> call(String name, String email, String password) =>
      repository.register(name, email, password);
}

// KELAS BARU
class GetCurrentUserUseCase {
  final AuthRepository repository;

  GetCurrentUserUseCase(this.repository);

  Future<User?> call() {
    return repository.getCurrentUser();
  }
}
