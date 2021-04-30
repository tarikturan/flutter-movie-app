import 'package:flutter/material.dart';
import 'package:movieapp/model/movie_response.dart';
import 'package:movieapp/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class UpcomingMoviesBloc {
  final MovieRepository _repository = MovieRepository();
  final BehaviorSubject<MovieResponse> _subject =
      BehaviorSubject<MovieResponse>();

  getUpcomingMovies() async {
    MovieResponse response = await _repository.getUpcomingMovies();
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<MovieResponse> get subject => _subject;
}

final upcomingMoviesBloc = UpcomingMoviesBloc();
