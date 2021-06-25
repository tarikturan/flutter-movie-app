import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:movieapp/model/movie.dart';
import 'package:movieapp/repository/repository.dart';

class StateData extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final MovieRepository _repository = MovieRepository();
  List<Movie> favoriteMovies = [];
  List<Movie> favoritePersons = [];
  String userName = "";

  getFavoriteMovies() async {
    List<Movie> favMovies = [];

    var document = await _firestore.collection("users").doc(_auth.currentUser.uid).get();
    var favIds = document.get('favorite_movies');
    for (var movieId in favIds) {
      Movie movie = await _repository.getMovieById(int.parse(movieId));
      favMovies.add(movie);
    }

    favoriteMovies = favMovies;
  }

  getUSerName() async {
    var doc = await FirebaseFirestore.instance.collection("users").doc("${FirebaseAuth.instance.currentUser.uid}").get();
    userName = doc.get("userName");
    
  }


  removeMovieFromFavorites(Movie movie) {
    favoriteMovies.remove(movie);
  }
}
