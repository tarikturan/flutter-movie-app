import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:movieapp/model/movie.dart';
import 'package:movieapp/services/state_data.dart';
import 'package:provider/provider.dart';

class DatabaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //final FirebaseStorage _storage = FirebaseStorage.instance;
  //final Reference ref = _storage.ref().child(path)

  addToFavorite(String movieID) async {
    await _firestore.collection('users').doc(_auth.currentUser.uid).update({
      'favorite_movies': FieldValue.arrayUnion([movieID])
    });
    
  }

  

   Future<Function> removeFromFavorite(String movieId) async {
    await _firestore.collection('users').doc(_auth.currentUser.uid).update({
      'favorite_movies': FieldValue.arrayRemove([movieId])
    });

  }

  updateUser(String displayName, String userName, String email) async {
    _auth.currentUser.updateDisplayName(displayName);
    _auth.currentUser.updateEmail(email);
    await _firestore.collection('users').doc(_auth.currentUser.uid).update({'userName': userName});
  }
}
