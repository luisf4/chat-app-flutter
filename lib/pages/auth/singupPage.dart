// ignore_for_file: unnecessary_import, file_names, prefer_const_constructors, use_build_context_synchronously, avoid_print;, avoid_print, unused_import, unused_local_variable
import 'package:chat_app/models/messageModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import '../../models/snackbarModel.dart';

class SingUp extends StatefulWidget {
  //
  final Function() onClikedSignIn;
  //
  const SingUp({
    Key? key,
    required this.onClikedSignIn,
  }) : super(key: key);

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
    _passwordController.addListener(() => setState(() {}));
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
                        color: Colors.blue,
                      ),
                    ),
                    Text(
                      "Make a account !",
                      style: TextStyle(
                        fontFamily: 'NunitoBold',
                        fontSize: 30,
                        // color: Colors.amber,
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
                      // style: TextStyle(color: Colors.amber),
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
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      // style: TextStyle(color: Colors.amber),
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
                      // style: TextStyle(color: Colors.amber),
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
                      padding: const EdgeInsets.fromLTRB(0, 35, 0, 0),
                      child: Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                singupModel(_emailController,
                                    _passwordController, _nameController);
                              },
                              child: Text('Sing-up'),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Center(
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(
                                color: Color.fromARGB(255, 46, 46, 46),
                                fontSize: 15),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      child: Center(
                        child: Expanded(
                          child: RichText(
                            text: TextSpan(
                              style: TextStyle(
                                  color: Color.fromARGB(255, 24, 24, 24),
                                  fontSize: 15),
                              text: "Have a account ? ",
                              children: [
                                TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = widget.onClikedSignIn,
                                  text: "Login",
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

// Função de login
  Future singupModel(loginEmail, loginPassword, loginName) async {
    try {
      showDialog(
        context: context,
        builder: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
      );

      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: loginEmail.text.trim(),
        password: loginPassword.text.trim(),
      );

      final user = User(
          uid: FirebaseAuth.instance.currentUser!.uid.toString(),
          name: loginName.text.trim(),
          email: loginEmail.text.trim());

      await saveUser(user);

      // await Future.delayed(Duration(seconds: 3));
      Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(e.message);
    }
  }
}

// Salvar um novo usuário no banco de dados
Future<void> saveUser(User user) {
  return usersCollection.doc(user.uid).set(user.toMap());
}

// Definir a estrutura do documento de usuário
class User {
  final String uid;
  final String name;
  final String email;

  User({required this.uid, required this.name, required this.email});

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
    };
  }
}
