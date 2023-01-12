// ignore_for_file: unnecessary_import, file_names, prefer_const_constructors
import 'package:chat_app/pages/singupPage.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _emailController = TextEditingController();

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
                      "Recovery your account",
                      style: TextStyle(
                        fontFamily: 'NunitoBold',
                        fontSize: 30,
                        color: Colors.amber,
                      ),
                    ),
                    Text(
                      "Put your email here !",
                      style: TextStyle(
                        fontFamily: 'NunitoBold',
                        fontSize: 20,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextField(
                      style: TextStyle(color: Colors.amber),
                      controller: _emailController,
                      decoration: InputDecoration(
                        hintText: 'exemple@exemple.com',
                        prefixIcon: Icon(Icons.mail),

                        labelText: 'Email',
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Center(
                            child: ElevatedButton(
                              onPressed: () {},
                              child: Text('Send me a email'),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 30,
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
