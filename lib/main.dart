// ignore_for_file: prefer_const_constructors, must_be_immutable, curly_braces_in_flow_control_structures, avoid_unnecessary_containers, use_key_in_widget_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:chat_app/pages/auth/authPage.dart';
import 'package:chat_app/pages/homePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'models/snackbarModel.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: Utils.messengerKey,
      navigatorKey: navigatorKey,
      theme: ThemeData(
        fontFamily: 'Nunito',
        // primarySwatch: Colors.amber,
        // textTheme: TextTheme(
        //   displayLarge: TextStyle(color: Colors.red),
        //   displayMedium: TextStyle(color: Colors.red),
        //   bodyMedium: TextStyle(color: Colors.red),
        //   titleMedium: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
        // ),
      ),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Something rowng "));
          } else if (snapshot.hasData) {
            return HomePage();
          } else {
            return AuthPage();
          }
        },
      ),
    );
  }
}
