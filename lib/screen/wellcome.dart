import 'dart:ui';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

import 'login.dart';
import 'registration.dart';

class WellcomeScreen extends StatefulWidget {
  static const id = 'wellcomescreen';
  String title;
  WellcomeScreen({Key? key, required this.title}) : super(key: key);

  @override
  State<WellcomeScreen> createState() => _WellcomeScreenState();
}

class _WellcomeScreenState extends State<WellcomeScreen> {
  @override
  Widget build(BuildContext context) {
    final Shader linearGradient = const LinearGradient(
      colors: <Color>[
        Color.fromARGB(255, 175, 37, 224),
        Color.fromARGB(255, 216, 24, 139)
      ],
    ).createShader(const Rect.fromLTWH(200.0, 100.0, 100.0, 100.0));
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text(widget.title)),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Center(
              child: Text(
            "Wellcome To our Community",
            style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
          )),

          Center(
            child: DefaultTextStyle(
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 38.0,
                //  foreground: Paint()..shader = linearGradient,
                color: Color(0xaa341f97),
              ),
              child: AnimatedTextKit(
                animatedTexts: [
                  WavyAnimatedText('Spark'),
                ],
                isRepeatingAnimation: true,
              ),
            ),
          ),

          // ElevatedButton(onPressed: () {}, child: Text("Log In")),
          // ElevatedButton(onPressed: () {}, child: Text("Registration")),
          Button(
            text: "Log In",
            color: Theme.of(context).primaryColor,
            onpress: () {
              Navigator.pushNamed(context, Login.id);
            },
          ),
          Button(
              color: Color(0xAAB33771),
              text: "Registration",
              onpress: () {
                Navigator.pushNamed(context, Registration.id);
              })
        ],
      ),
    );
  }
}

class Button extends StatelessWidget {
  final Color color;
  final String text;
  final Function() onpress;
  Button(
      {Key? key,
      required this.color,
      required this.text,
      required this.onpress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Material(
        borderRadius: BorderRadius.circular(10),
        color: color,
        elevation: 8.0,
        child: MaterialButton(
          onPressed: onpress,
          child: Text(
            text,
            style: TextStyle(fontSize: 18.0, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
