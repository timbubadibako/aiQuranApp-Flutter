// lib/presentation/screens/home_screen.dart

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/usecases/auth_usecases.dart';
import 'login_screen.dart';

// PERUBAHAN: Ubah menjadi StatefulWidget
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _userName;

  @override
  void initState() {
    super.initState();
    // PERBAIKAN: Panggil _loadUserData setelah frame pertama selesai dibangun
    // Ini untuk memastikan 'context' sudah siap untuk mengakses Provider.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadUserData();
    });
  }

  // Fungsi untuk memuat data pengguna
  Future<void> _loadUserData() async {
    // Ambil use case dari Provider
    final getCurrentUserUseCase = Provider.of<GetCurrentUserUseCase>(
      context,
      listen: false,
    );
    final User? user = await getCurrentUserUseCase.call();

    // Perbarui state dengan nama pengguna
    if (user != null && mounted) {
      setState(() {
        _userName = user.displayName ?? "Pengguna";
      });
    }
  }

  Future<void> _logout(BuildContext context) async {
    final logoutUseCase = Provider.of<LogoutUseCase>(context, listen: false);
    await logoutUseCase.call();
    if (context.mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Beranda"),
        backgroundColor: const Color(0xFF0D9488),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _logout(context),
            tooltip: 'Logout',
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Selamat Datang,", style: TextStyle(fontSize: 22)),
            const SizedBox(height: 8),
            // Tampilkan nama pengguna, atau tampilkan loading
            _userName == null
                ? const CircularProgressIndicator()
                : Text(
                  _userName!,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
