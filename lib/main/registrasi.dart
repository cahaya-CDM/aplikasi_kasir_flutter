import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../page/registrasi_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://xnhqbsyhxvltumsmkypw.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InhuaHFic3loeHZsdHVtc21reXB3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzYzODI4NTgsImV4cCI6MjA1MTk1ODg1OH0.VcB52lpsL9L9h-nYcWkueGqFlNPNp4YqtDLTSAG_6Ak',
  );
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