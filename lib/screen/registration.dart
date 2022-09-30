import 'package:chat/screen/chat.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../constants.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Registration extends StatefulWidget {
  static const id = 'registration';
  const Registration({Key? key}) : super(key: key);

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  late String email;
  late String pass;
  bool load = false;
  String error = '';
  final _auth = FirebaseAuth.instance;

  Widget x = LoadingAnimationWidget.twistingDots(
    leftDotColor: Color.fromARGB(255, 255, 255, 255),
    rightDotColor: const Color(0xFFEA3799),
    size: 50,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: const Text("Sign Up")),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              "Create A New Account",
              style: textStyleHeading,
              textAlign: TextAlign.center,
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "We are happy to see you. You can continue to registration to comunication each other ",
                textAlign: TextAlign.center,
                style: textStylePara,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.emailAddress,
                decoration:
                    inputDecoration.copyWith(label: const Text("Email")),
                onChanged: (String value) {
                  email = value;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                textAlign: TextAlign.center,
                decoration:
                    inputDecoration.copyWith(label: const Text("Password")),
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
                      await _auth.createUserWithEmailAndPassword(
                          email: email, password: pass);

                      Navigator.pushNamed(context, ChatScreen.id);
                      setState(() {
                        load = false;
                      });
                    } catch (e) {
                      error = e.toString();
                      print(e);
                    }
                  },
                  child: load == true
                      ? x
                      : const Text(
                          "Sign Up",
                          style: buttonStyle,
                        ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(error),
            ),
          ]),
    );
  }
}
