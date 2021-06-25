import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movieapp/bloc/get_movies_bloc.dart';
import 'package:movieapp/model/movie.dart';
import 'package:movieapp/model/movie_response.dart';
import 'package:movieapp/screens/detail_screen.dart';
import 'package:movieapp/style/theme.dart' as Style;
import 'package:movieapp/widgets/fav_popup.dart';

class TopMovies extends StatefulWidget {
  @override
  _TopMoviesState createState() => _TopMoviesState();
}

class _TopMoviesState extends State<TopMovies> {
  @override
  void initState() {
    super.initState();
    moviesBloc.getMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 10.0, top: 20.0),
          child: Text(
            "En İyi Filmler",
            style: TextStyle(
                color: Style.Colors.titleColor,
                fontWeight: FontWeight.w500,
                fontSize: 12.0),
          ),
        ),
        SizedBox(
          height: 5.0,
        ),
        StreamBuilder<MovieResponse>(
          stream: moviesBloc.subject.stream,
          builder: (context, AsyncSnapshot<MovieResponse> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.error != null &&
                  snapshot.data.error.length > 0) {
                return _buildErrorWidget(snapshot.data.error);
              }
              return _buildTopMoviesWidget(snapshot.data);
            } else if (snapshot.hasError) {
              return _buildErrorWidget(snapshot.error);
            } else {
              return _buildLoadingWidget();
            }
          },
        ),
      ],
    );
  }

  Widget _buildLoadingWidget() {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 25.0,
          width: 25.0,
          child: CircularProgressIndicator(
            valueColor:
                new AlwaysStoppedAnimation<Color>(Style.Colors.secondColor),
            strokeWidth: 4.0,
          ),
        )
      ],
    ));
  }

  Widget _buildErrorWidget(String error) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Error occured: $error"),
      ],
    ));
  }

  Widget _buildTopMoviesWidget(MovieResponse data) {
    List<Movie> movies = data.movies;
    if (movies.length == 0) {
      return Container(
        child: Text("No Movies"),
      );
    } else
      return Container(
        height: 270.0,
        padding: EdgeInsets.only(left: 10.0),
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: movies.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0, right: 10.0),
                child: GestureDetector(
                  onLongPress: () async {
                    await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return FavPopUp(movieName: movies[index].title, movieId: movies[index].id.toString(),);
                        });

                    //await _databaseService.addToFavorite(movies[index].id.toString());
                  },
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                MovieDetailScreen(movie: movies[index])));
                  },
                  child: Column(
                    children: <Widget>[
                      movies[index].poster == null
                          ? Container(
                              width: 120.0,
                              height: 180.0,
                              decoration: BoxDecoration(
                                  color: Style.Colors.secondColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(2.0)),
                                  shape: BoxShape.rectangle),
                              child: Column(
                                children: <Widget>[
                                  Icon(
                                    EvaIcons.filmOutline,
                                    color: Colors.white,
                                    size: 50.0,
                                  )
                                ],
                              ),
                            )
                          : Container(
                              width: 120.0,
                              height: 180.0,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(2.0)),
                                  shape: BoxShape.rectangle,
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          "https://image.tmdb.org/t/p/w200/" +
                                              movies[index].poster),
                                      fit: BoxFit.cover)),
                            ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        width: 100.0,
                        child: Text(
                          movies[index].title,
                          maxLines: 2,
                          style: TextStyle(
                              height: 1.4,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 11.0),
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            movies[index].rating.toString(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 10.0,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          RatingBar.builder(
                            itemSize: 8.0,
                            initialRating: movies[index].rating / 2,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                            itemBuilder: (context, _) => Icon(
                              EvaIcons.star,
                              color: Style.Colors.secondColor,
                            ),
                            onRatingUpdate: (rating) {
                              print(rating);
                            },
                          )
                        ],
                      )
                    ],
                  ),
                ),
              );
            }),
      );
  }
}
