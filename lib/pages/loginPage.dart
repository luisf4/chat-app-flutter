// ignore_for_file: unnecessary_import, file_names, prefer_const_constructors

import 'package:chat_app/pages/singupPage.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool passwordInvisible = true;

  @override
  void initState() {
    super.initState();

    _emailController.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.only(left: 25, right: 25),
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 160,
                    ),
                    Text(
                      "Hello again ",
                      style: TextStyle(
                        fontFamily: 'NunitoBold',
                        fontSize: 30,
                        color: Colors.amber,
                      ),
                    ),
                    Text(
                      "Login into your account !",
                      style: TextStyle(
                        fontFamily: 'NunitoBold',
                        fontSize: 30,
                        color: Colors.amber,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextField(
                      style: TextStyle(color: Colors.amber),
                      controller: _emailController,
                      decoration: InputDecoration(
                        hintText: 'example@example.com',
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.mail),
                        suffixIcon: _emailController.text.isEmpty
                            ? Container(
                                width: 0,
                              )
                            : IconButton(
                                icon: Icon(Icons.close),
                                onPressed: () => _emailController.clear(),
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
                      controller: _passwordController,
                      decoration: InputDecoration(
                        hintText: 'Password',
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
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 20, 0, 30),
                      child: Text('Forgot password ?'),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {},
                            child: Text('Login'),
                          ),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SingUp(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey),
                            child: Text('Sing-up'),
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
