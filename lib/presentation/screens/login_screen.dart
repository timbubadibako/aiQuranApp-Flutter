// lib/presentation/screens/login_screen.dart

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/login_provider.dart';
import 'home_screen.dart';
import 'register_screen.dart'; // Import halaman register

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    // Definisikan palet warna
    const Color primaryColor = Color(0xFF0D9488);
    const Color inputBackgroundColor = Color(0xFFF1F5F9); // slate-100
    const Color listInputColor = Color(0xFFE2E8F0);
    const Color textPrimaryColor = Color(0xFF475569);
    const Color textInputColor = Color(0xFF94A3B8);
    const Color textButtonPrimaryColor = Color(0xFFFFFFFF);
    const Color slate50Color = Color(0xFFF8FAFC); // Warna latar belakang baru

    return Scaffold(
      backgroundColor: slate50Color, // Latar belakang utama
      body: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
            // PERUBAHAN: Menambahkan drop shadow
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                spreadRadius: 0,
                blurRadius: 10,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisSize:
                  MainAxisSize.min, // Membuat sheet hanya setinggi kontennya
              children: [
                const SizedBox(height: 12),
                // PERUBAHAN: Menambahkan handle slider
                Container(
                  width: 40,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(height: 20), // Jarak dari atas sheet
                const Text(
                  "Selamat Datang Kembali!",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                const Text(
                  "Masuk untuk melanjutkan kebiasaan baikmu",
                  style: TextStyle(fontSize: 14, color: textPrimaryColor),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 36),

                // Input Email
                TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: "Email atau Nama Pengguna",
                    hintStyle: const TextStyle(
                      fontSize: 12,
                      color: textInputColor,
                    ),
                    filled: true,
                    fillColor: inputBackgroundColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Input Password
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Password",
                    hintStyle: const TextStyle(
                      fontSize: 12,
                      color: textInputColor,
                    ),
                    filled: true,
                    fillColor: inputBackgroundColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Tombol Masuk
                Consumer<LoginProvider>(
                  builder: (context, provider, child) {
                    return SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed:
                            provider.isLoading
                                ? null
                                : () async {
                                  final success = await provider.login(
                                    emailController.text,
                                    passwordController.text,
                                  );
                                  if (success && context.mounted) {
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                        builder:
                                            (context) => const HomeScreen(),
                                      ),
                                    );
                                  } else if (provider.errorMessage != null &&
                                      context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(provider.errorMessage!),
                                      ),
                                    );
                                  }
                                },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          foregroundColor: textButtonPrimaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child:
                            provider.isLoading
                                ? const CircularProgressIndicator(
                                  color: textButtonPrimaryColor,
                                )
                                : const Text("Masuk"),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 24),

                // Pemisah
                Row(
                  children: [
                    const Expanded(child: Divider()),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        "Atau Masuk dengan",
                        style: TextStyle(color: Colors.grey[600], fontSize: 12),
                      ),
                    ),
                    const Expanded(child: Divider()),
                  ],
                ),
                const SizedBox(height: 24),

                // Tombol Google & Email
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 36,
                        child: OutlinedButton(
                          onPressed: () {}, // TODO: Implement Google Sign-In
                          style: OutlinedButton.styleFrom(
                            backgroundColor: listInputColor,
                            side: BorderSide.none,
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            "Google",
                            style: TextStyle(
                              color: textPrimaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: SizedBox(
                        height: 36,
                        child: OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            backgroundColor: listInputColor,
                            side: BorderSide.none,
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            "Email",
                            style: TextStyle(
                              color: textPrimaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Link Daftar
                RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      color: textPrimaryColor,
                      fontSize: 14,
                    ),
                    children: [
                      const TextSpan(text: "Belum Punya Akun? "),
                      TextSpan(
                        text: "Daftar disini",
                        style: const TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                        // PERUBAHAN: Navigasi ke halaman register
                        recognizer:
                            TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder:
                                        (context) => const RegisterScreen(),
                                  ),
                                );
                              },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 36), // Jarak di bagian bawah tetap
              ],
            ),
          ),
        ),
      ),
    );
  }
}
