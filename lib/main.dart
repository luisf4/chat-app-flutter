// ignore_for_file: prefer_const_constructors, must_be_immutable, curly_braces_in_flow_control_structures, avoid_unnecessary_containers
// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool passwordInvisible = true;

  @override
  void initState() {
    super.initState();

    emailController.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.amber,
        textTheme: TextTheme(
          headline1: TextStyle(color: Colors.red),
          headline2: TextStyle(color: Colors.red),
          bodyText2: TextStyle(color: Colors.red),
          subtitle1: TextStyle(color: Colors.red),
        ),
      ),
      home: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/background.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Container(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 160,
                    ),
                    Text(
                      "Welcome :D",
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.amber,
                      ),
                    ),
                    Text(
                      "Register you account !",
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.amber,
                      ),
                    ),
                    SizedBox(
                      height: 100,
                    ),
                    TextField(
                      style: TextStyle(color: Colors.amber),
                      controller: emailController,
                      decoration: InputDecoration(
                        hintText: 'example@example.com',
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.mail),
                        suffixIcon: emailController.text.isEmpty
                            ? Container(
                                width: 0,
                              )
                            : IconButton(
                                icon: Icon(Icons.close),
                                onPressed: () => emailController.clear(),
                              ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.done,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      style: TextStyle(color: Colors.amber),
                      controller: passwordController,
                      decoration: InputDecoration(
                        hintText: 'password',
                        labelText: 'Password',
                        suffixIcon: IconButton(
                          icon: passwordInvisible
                              ? Icon(Icons.visibility_off)
                              : Icon(Icons.visibility),
                          onPressed: () => setState(
                              () => passwordInvisible = !passwordInvisible),
                        ),
                      ),
                      obscureText: passwordInvisible,
                    ),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          child: Text('data'),
                        ),
                        SizedBox(
                          child: ElevatedButton(
                            onPressed: () {},
                            child: Text('data'),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
