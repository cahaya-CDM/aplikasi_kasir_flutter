import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../page/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://xnhqbsyhxvltumsmkypw.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InhuaHFic3loeHZsdHVtc21reXB3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzYzODI4NTgsImV4cCI6MjA1MTk1ODg1OH0.VcB52lpsL9L9h-nYcWkueGqFlNPNp4YqtDLTSAG_6Ak',
  );
  runApp(const Login());
}

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login',
      home: const LoginPage(),
    );
  }
}