import 'package:flutter/material.dart';
import 'package:pl1_kasir/main/login.dart';


class DrawerMenu extends StatefulWidget {
  const DrawerMenu({super.key});

  @override
  State<DrawerMenu> createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  
  final List<Map<String, String>> users = [
    {'email': 'user1@example.com', 'username': 'user1'},
    {'email': 'user2@example.com', 'username': 'user2'},
  ];

  void signOut() {
    // Add your sign out logic here
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const Login()),
    );
  }

  // Login({required this.email, required this.username});
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      children: <Widget>[
        DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.yellowAccent,
          ),
          child: ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: ListTile(
                      leading: const Icon(Icons.account_circle, size: 50,),
                      title: Text(user['email'] ?? '', style: TextStyle(fontSize: 18.5, fontWeight: FontWeight.bold, fontFamily: 'Roboto'),),
                      subtitle: Text(user['username'] ?? '', style: TextStyle(fontSize: 15, fontFamily: 'Roboto'),),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        ListTile(
          title: const Text('Kasir'),
          onTap: () {
            Navigator.pushNamed(context, '/kasir');
          },
        ),
        ListTile(
          title: const Text('Registrasi'),
          onTap: () {
            Navigator.pushNamed(context, '/registrasi');
          },
        ),
        ListTile(
          title: const Text('Admin'),
          onTap: () {
            Navigator.pushNamed(context, '/admin');
          },
        ),
        ListTile(
          leading: const Icon(Icons.logout),
          title: const Text('SignOut'),
          onTap: () {
            signOut();
          },
        )
      ],
    ));
  }
}
