// ignore_for_file: unnecessary_import, file_names, prefer_const_constructors
import 'package:chat_app/pages/forgotPage.dart';
import 'package:chat_app/pages/loginPage.dart';
import 'package:flutter/material.dart';

class SingUp extends StatefulWidget {
  const SingUp({super.key});

  @override
  State<SingUp> createState() => _SingUpState();
}

class _SingUpState extends State<SingUp> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

 bool _passwordInvisible = true;
  @override
  void initState() {
    super.initState();

    _emailController.addListener(() => setState(() {}));
    _nameController.addListener(() => setState(() {}));
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
                      "Welcome :D",
                      style: TextStyle(
                        fontFamily: 'NunitoBold',
                        fontSize: 30,
                        color: Colors.amber,
                      ),
                    ),
                    Text(
                      "Make a account !",
                      style: TextStyle(
                        fontFamily: 'NunitoBold',
                        fontSize: 30,
                        color: Colors.amber,
                      ),
                    ),
                    Text(
                      "Fill all the filds",
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
                      controller: _nameController,
                      decoration: InputDecoration(
                        hintText: 'Your name here',
                        labelText: 'Name',
                        prefixIcon: Icon(Icons.person),
                        suffixIcon: _nameController.text.isEmpty
                            ? Container(
                                width: 0,
                              )
                            : IconButton(
                                icon: Icon(Icons.close),
                                onPressed: () => _nameController.clear(),
                              ),
                      ),
                      textInputAction: TextInputAction.done,
                    ),                    SizedBox(
                      height: 20,
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
                        prefixIcon: Icon(Icons.lock),

                        suffixIcon: IconButton(
                          icon: _passwordInvisible
                              ? Icon(Icons.visibility_off)
                              : Icon(Icons.visibility),
                          onPressed: () => setState(
                              () => _passwordInvisible = !_passwordInvisible),
                        ),
                      ),
                      obscureText: _passwordInvisible,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 20, 0, 30),
                      child: Text('Forgot password ?'),
                    ),ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ForgotPassword(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey
                            ),
                            child: Text('Forgot password ?'),
                          ),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {},
                            child: Text('Sing-up'),
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
                                  builder: (context) => const LoginPage(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey
                            ),
                            child: Text('Login'),
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