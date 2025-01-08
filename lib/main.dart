import 'package:flutter/material.dart';
import 'kasir_page.dart';

void main() {
  runApp(const Kasir());
}

class Kasir extends StatelessWidget {
  const Kasir({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kasir',
      home: const Kasirpage(),
    );
  }
}