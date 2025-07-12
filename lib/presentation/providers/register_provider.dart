// lib/presentation/providers/register_provider.dart

import 'package:flutter/material.dart';
import '../../domain/usecases/auth_usecases.dart';

class RegisterProvider extends ChangeNotifier {
  final RegisterUseCase registerUseCase;

  // Pastikan constructor ini menggunakan 'required'
  RegisterProvider({required this.registerUseCase});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> register(
    String name,
    String email,
    String password,
    String confirmPassword,
  ) async {
    // Validasi sederhana
    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      _errorMessage = "Semua kolom harus diisi.";
      notifyListeners();
      return false;
    }
    if (password != confirmPassword) {
      _errorMessage = "Password dan konfirmasi password tidak cocok.";
      notifyListeners();
      return false;
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await registerUseCase.call(name, email, password);
      _isLoading = false;
      notifyListeners();
      return true; // Sukses
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      _isLoading = false;
      notifyListeners();
      return false; // Gagal
    }
  }
}
