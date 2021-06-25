import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class AuthService {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  AuthService(this._auth);

  Stream<User> get authStateChanges => _auth.authStateChanges();
  // Giriş
  Future<User> signIn(String email, String password) async {
    var user = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    return user.user;
  }

  // Çıkış
  signOut() async {
    return await _auth.signOut();
  }

  // Kayıt

  Future<User> createPerson(
      String username, String email, String password) async {
    var user = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);

    await _firestore.collection("users").doc(user.user.uid).set({
      'userName': username,
      'email': email,
      "favorite_movies": []
    });

    return user.user;
  }
}
