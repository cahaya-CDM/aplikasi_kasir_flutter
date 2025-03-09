import 'package:flutter/material.dart';
import 'package:pl1_kasir/main/login.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RegistrasiPage extends StatefulWidget {
  const RegistrasiPage({super.key});

  @override
  State<RegistrasiPage> createState() => _RegistrasiPageState();
}

class _RegistrasiPageState extends State<RegistrasiPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  bool _isObscure = true;
  final supabase = Supabase.instance.client;
  bool _isSwitched = false;
  final _focusNode = FocusNode();
  final _focusUser = FocusNode();
  final _focusPass = FocusNode();

  Future<void> signUp() async {
    await supabase.from('users').insert({
      'email': emailController.text,
      'username': usernameController.text,
      'password': passwordController.text,
    }).then((value) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
    });
  }

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {});
    });
    _focusUser.addListener(() {
      setState(() {});
    });
    _focusPass.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _focusUser.dispose();
    _focusPass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: DecoratedBox(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('img/background.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 100),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50),
              topRight: Radius.circular(50),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 50, left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Getting started',
                      style: TextStyle(
                        fontSize: 25,
                        fontFamily: 'Roboto',
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Create an account to continue',
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'Roboto',
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 35, left: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            shape: CircleBorder(),
                            padding: EdgeInsets.all(0),
                            backgroundColor: Colors.white),
                        child: ClipOval(
                          child: Image.asset(
                            'img/google.png',
                            width: 35,
                            height: 35,
                            fit: BoxFit.cover,
                          ),
                        )),
                    ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            shape: CircleBorder(),
                            padding: EdgeInsets.all(0),
                            backgroundColor: Colors.white),
                        child: ClipOval(
                          child: Image.asset(
                            'img/facebook.png',
                            width: 35,
                            height: 35,
                            fit: BoxFit.cover,
                          ),
                        )),
                    ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            shape: CircleBorder(),
                            padding: EdgeInsets.all(0),
                            backgroundColor: Colors.white),
                        child: ClipOval(
                          child: Image.asset(
                            'img/twitter.png',
                            width: 35,
                            height: 35,
                            fit: BoxFit.cover,
                          ),
                        ))
                  ],
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: emailController,
                        style: TextStyle(fontWeight: FontWeight.bold),
                        focusNode: _focusNode,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                              borderSide: BorderSide(color: Colors.grey)),
                          prefixIcon: Icon(Icons.email),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                            borderSide: BorderSide(
                                color: _focusNode.hasFocus
                                    ? Colors.yellowAccent
                                    : Colors.grey),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: usernameController,
                        style: TextStyle(fontWeight: FontWeight.bold),
                        focusNode: _focusUser,
                        decoration: InputDecoration(
                          labelText: 'Username',
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                              borderSide: BorderSide(color: Colors.grey)),
                          prefixIcon: Icon(Icons.person),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                            borderSide: BorderSide(
                                color: _focusUser.hasFocus
                                    ? Colors.yellowAccent
                                    : Colors.grey),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: passwordController,
                        focusNode: _focusPass,
                        style: TextStyle(fontWeight: FontWeight.bold),
                        obscureText: _isObscure,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isObscure
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            },
                          ),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                              borderSide: BorderSide(color: Colors.grey)),
                          prefixIcon: Icon(Icons.key),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                            borderSide: BorderSide(
                                color: _focusPass.hasFocus
                                    ? Colors.yellowAccent
                                    : Colors.grey),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 15),
                    child: Text(
                      'Reminder me next time',
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20, top: 15),
                    child: Switch(
                        activeColor: Colors.yellowAccent,
                        thumbColor: WidgetStateProperty.all(Colors.white),
                        value: _isSwitched,
                        onChanged: (bool value) {
                          setState(() {
                            _isSwitched = value;
                          });
                        }),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 30, right: 30),
                child: ElevatedButton(
                  onPressed: () {
                    signUp();
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.yellowAccent,
                      minimumSize: Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50))),
                  child: Text(
                    'SIGN UP',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        fontFamily: 'Roboto'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
