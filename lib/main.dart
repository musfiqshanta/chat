import 'package:chat/screen/chat.dart';
import 'package:chat/screen/login.dart';
import 'package:chat/screen/registration.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screen/wellcome.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final _auth = FirebaseAuth.instance;

    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            primaryColor: Color(0xff341f97),
            appBarTheme: const AppBarTheme(
              backgroundColor: Color(0xff341f97),
            ),
            textTheme:
                const TextTheme(bodyText1: TextStyle(color: Colors.black))),
        initialRoute:
            _auth.currentUser==null? WellcomeScreen.id : ChatScreen.id,
        routes: {
          WellcomeScreen.id: (context) =>
              WellcomeScreen(title: "WellCome To Spark"),
          Registration.id: (context) => const Registration(),
          Login.id: (context) => Login(),
          ChatScreen.id: (context) => ChatScreen()
        });
  }
}
