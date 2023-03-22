import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  String? nom, prenom;
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> login(String email, String password) async {
    await auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> logout() async {
    await auth.signOut();
  }

  // Future<void> register(String email, String password) async {
  //   await auth.createUserWithEmailAndPassword(email: email, password: password);
  // }
  Future<void> register(
      String email, String password, String nom, String prenom) async {
    UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email, password: password);
    User? user = userCredential.user;
    if (user != null) {
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set(
          {'email': email, 'password': password, 'nom': nom, 'prenom': prenom});
    }
  }
}
