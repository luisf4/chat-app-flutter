// ignore_for_file: file_names

import 'package:firebase_auth/firebase_auth.dart';

// Função de login
Future login(loginEmail, loginPassword) async {
  await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: loginEmail.text.trim(),
    password: loginPassword.text.trim(),
  );
}
