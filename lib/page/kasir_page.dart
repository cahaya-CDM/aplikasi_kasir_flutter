import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pl1_kasir/main/login.dart';

// import 'package:pl1_kasir/page/login_page.dart';
// import '../main/registrasi.dart';

class Kasirpage extends StatefulWidget {
  const Kasirpage({super.key});

  @override
  State<Kasirpage> createState() => _KasirpageState();
}

class _KasirpageState extends State<Kasirpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('img/background.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Stack(
              children: [
                SvgPicture.asset(
                  'img/blob.svg',
                  width: 200,
                  height: 200,
                ),
                Positioned(
                  top: 2,
                  right: 10,
                  child: Image.asset(
                    'img/logo.png',
                    width: 200,
                    height: 200,
                  ),
                ),
              ],
            ),
            const Text(
              'K A S I R',
              style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold),
            ),
            // const SizedBox(height: ),
            Text(
              'Aplikasi Kasir  Sederhana',
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.lightGreen[200],
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 100),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const Login()));
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(70, 70),
                shape: const CircleBorder(),
                backgroundColor: Colors.yellowAccent[700],
              ),
              child: Icon(Icons.keyboard_arrow_right_outlined, size: 40, color: Colors.white,)
            )
          ],
        ),
      ),
    ));
  }
}
