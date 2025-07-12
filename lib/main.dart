// lib/main.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'data/repositories/auth_repository_impl.dart';
import 'domain/repositories/auth_repository.dart';
import 'domain/usecases/auth_usecases.dart';
import 'presentation/providers/login_provider.dart';
import 'presentation/providers/register_provider.dart';
import 'presentation/screens/home_screen.dart';
import 'presentation/screens/login_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // =================== Dependency Injection ===================
  final AuthRepository authRepository = AuthRepositoryImpl();
  final loginUseCase = LoginUseCase(authRepository);
  final logoutUseCase = LogoutUseCase(authRepository);
  final getTokenUseCase = GetTokenUseCase(authRepository);
  final registerUseCase = RegisterUseCase(authRepository);
  final getCurrentUserUseCase = GetCurrentUserUseCase(
    authRepository,
  ); // <-- Buat instance use case baru

  final String? authToken = await getTokenUseCase.call();

  runApp(
    MyApp(
      isLoggedIn: authToken != null,
      loginUseCase: loginUseCase,
      logoutUseCase: logoutUseCase,
      registerUseCase: registerUseCase,
      getCurrentUserUseCase: getCurrentUserUseCase, // <-- Kirim ke MyApp
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  final LoginUseCase loginUseCase;
  final LogoutUseCase logoutUseCase;
  final RegisterUseCase registerUseCase;
  final GetCurrentUserUseCase getCurrentUserUseCase; // <-- Tambah properti baru

  const MyApp({
    super.key,
    required this.isLoggedIn,
    required this.loginUseCase,
    required this.logoutUseCase,
    required this.registerUseCase,
    required this.getCurrentUserUseCase, // <-- Tambah di constructor
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Menyediakan use case agar bisa diakses oleh widget di bawahnya
        Provider<LogoutUseCase>.value(value: logoutUseCase),
        Provider<GetCurrentUserUseCase>.value(
          value: getCurrentUserUseCase,
        ), // <-- Daftarkan use case baru
        // ChangeNotifierProvider untuk state management UI
        ChangeNotifierProvider<LoginProvider>(
          create: (_) => LoginProvider(loginUseCase: loginUseCase),
        ),
        ChangeNotifierProvider<RegisterProvider>(
          create: (_) => RegisterProvider(registerUseCase: registerUseCase),
        ),
      ],
      child: MaterialApp(
        title: 'MTQMN App (SOLID)',
        theme: ThemeData(
          primarySwatch: Colors.teal,
          scaffoldBackgroundColor: Colors.grey[200],
        ),
        debugShowCheckedModeBanner: false,
        home: isLoggedIn ? const HomeScreen() : const LoginScreen(),
      ),
    );
  }
}
