// ignore_for_file: file_names

import 'package:chat_app/pages/auth/loginPage.dart';
import 'package:chat_app/pages/auth/singupPage.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;

  @override
  //verifica se esta logado
  Widget build(BuildContext context) => isLogin
      ? LoginPage(
          onClickedSignUp: toggle,
        )
      : SingUp(onClikedSignIn: toggle);

  // muda a pagina quando for clocado em uma das 2 opções
  void toggle() => setState(() => isLogin = !isLogin);
}
