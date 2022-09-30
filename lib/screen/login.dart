import 'package:chat/screen/chat.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Login extends StatefulWidget {
  static const id = 'login';
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  Widget x = LoadingAnimationWidget.twistingDots(
    leftDotColor: Color.fromARGB(255, 255, 255, 255),
    rightDotColor: const Color(0xFFEA3799),
    size: 50,
  );

  final _auth = FirebaseAuth.instance;
  late String email;
  late String pass;
  bool load = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: const Text("Log In")),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Welcome Back",
              style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor),
              textAlign: TextAlign.center,
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "We are happy to see you. You can continue to login to comunication each other ",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                textAlign: TextAlign.center,
                decoration: inputDecoration.copyWith(
                  label: Text("Email"),
                ),
                onChanged: (String value) {
                  email = value;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                textAlign: TextAlign.center,
                decoration: inputDecoration.copyWith(label: Text("Password")),
                obscureText: true,
                onChanged: (String value) {
                  pass = value;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Material(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).primaryColor,
                child: MaterialButton(
                  onPressed: () async {
                    try {
                      setState(() {
                        load = true;
                      });
                      await _auth.signInWithEmailAndPassword(
                          email: email, password: pass);

                      Navigator.pushNamed(context, ChatScreen.id);

                        setState(() {
                        load = false;
                      });
                    } catch (e) {
                      print(e);
                    }
                  },
                  child: load == true
                      ? x
                      : const Text(
                          "Sign In",
                          style: TextStyle(fontSize: 18.0, color: Colors.white),
                        ),
                ),
              ),
            )
          ]),
    );
  }
}
