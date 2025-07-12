// lib/presentation/providers/login_provider.dart

import 'package:flutter/material.dart';
import '../../domain/usecases/auth_usecases.dart';

class LoginProvider extends ChangeNotifier {
  final LoginUseCase loginUseCase;

  LoginProvider({required this.loginUseCase});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> login(String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await loginUseCase.call(email, password);
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
