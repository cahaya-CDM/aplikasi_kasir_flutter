import 'package:flutter/material.dart';
import 'registrasi_page.dart';

void main() {
  runApp(const Registrasi());
}

class Registrasi extends StatelessWidget {
  const Registrasi({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Registrasi',
      home: const LoginPage(),
    );
  }
}