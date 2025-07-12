// lib/presentation/screens/register_screen.dart

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/register_provider.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final confirmPasswordController = TextEditingController();

    // Definisikan palet warna
    const Color primaryColor = Color(0xFF0D9488);
    const Color inputBackgroundColor = Color(0xFFF1F5F9);
    const Color textPrimaryColor = Color(0xFF475569);
    const Color textInputColor = Color(0xFF94A3B8);
    const Color textButtonPrimaryColor = Color(0xFFFFFFFF);
    const Color slate50Color = Color(0xFFF8FAFC);

    return Scaffold(
      backgroundColor: slate50Color,
      body: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
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
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 12),
                Container(
                  width: 40,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Pendaftaran Akun",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                const Text(
                  "Daftar untuk menyimpan semua progres,\npencapaian, dan target belajarmu.",
                  style: TextStyle(fontSize: 14, color: textPrimaryColor),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 36),

                // Input Fields
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: "Nama Lengkap",
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
                const SizedBox(height: 16),
                TextField(
                  controller: confirmPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Konfirmasi Password",
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

                // Tombol Buat Akun
                Consumer<RegisterProvider>(
                  builder: (context, provider, child) {
                    return SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed:
                            provider.isLoading
                                ? null
                                : () async {
                                  final success = await provider.register(
                                    nameController.text,
                                    emailController.text,
                                    passwordController.text,
                                    confirmPasswordController.text,
                                  );
                                  if (context.mounted) {
                                    if (success) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            "Pendaftaran berhasil! Silakan masuk.",
                                          ),
                                          backgroundColor: Colors.green,
                                        ),
                                      );
                                      Navigator.of(context).pop();
                                    } else if (provider.errorMessage != null) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text(provider.errorMessage!),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                    }
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
                                : const Text("Buat Akun"),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 24),

                // Link Login
                RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      color: textPrimaryColor,
                      fontSize: 14,
                    ),
                    children: [
                      const TextSpan(text: "Sudah Punya Akun? "),
                      TextSpan(
                        text: "Login disini",
                        style: const TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                        recognizer:
                            TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.of(context).pop();
                              },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 48),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
