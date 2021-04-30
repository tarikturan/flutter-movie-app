import 'package:flutter/material.dart';
import 'package:movieapp/model/movie_response.dart';
import 'package:movieapp/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class SearchMoviesBloc {
  final MovieRepository _repository = MovieRepository();
  final BehaviorSubject<MovieResponse> _subject =
      BehaviorSubject<MovieResponse>();

  searchMovies([String query]) async {
    MovieResponse response = await _repository.searchMovies(query);
    _subject.sink.add(response);
  }

  getRandomRecommendations() async {
    MovieResponse response = await _repository.getRandomRecommendations();
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<MovieResponse> get subject => _subject;
}

final searchMoviesBloc = SearchMoviesBloc();
