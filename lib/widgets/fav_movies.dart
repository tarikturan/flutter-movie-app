import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movieapp/bloc/get_upcoming_movies_bloc.dart';
import 'package:movieapp/bloc/search_movies_bloc.dart';
import 'package:movieapp/model/movie.dart';
import 'package:movieapp/model/movie_response.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:movieapp/screens/detail_screen.dart';
import 'package:movieapp/services/db.dart';
import 'package:movieapp/services/state_data.dart';
import 'package:movieapp/style/theme.dart' as Style;
import 'package:provider/provider.dart';

class FavoriteMovies extends StatefulWidget {
  @override
  _FavoriteMoviesState createState() => _FavoriteMoviesState();
}

class _FavoriteMoviesState extends State<FavoriteMovies> {
  var stream = upcomingMoviesBloc.subject.stream;
  DatabaseService _databaseService = DatabaseService();

  @override
  void initState() {
    super.initState();
    upcomingMoviesBloc.getUpcomingMovies();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<StateData>(context).getFavoriteMovies();

    List<Movie> movies = Provider.of<StateData>(context).favoriteMovies;
    return _buildUpcomingMoviesWidget(movies);
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
            valueColor: new AlwaysStoppedAnimation<Color>(Style.Colors.secondColor),
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

  Widget _buildUpcomingMoviesWidget(List<Movie> movies) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.count(
          padding: EdgeInsets.all(0),
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
          childAspectRatio: 0.48,
          primary: false,
          crossAxisCount: 3,
          children: movies.map((movie) {
            return Column(
              children: <Widget>[
                movie.poster == null
                    ? FocusedMenuHolder(
                        menuWidth: 200.0,
                        onPressed: () {},
                        openWithTap: true,
                        menuItems: [
                          FocusedMenuItem(
                              title: Text("Detaylı incele"),
                              trailingIcon: Icon(Icons.open_in_new),
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => MovieDetailScreen(movie: movie)));
                              }),
                          FocusedMenuItem(title: Text("Favorilerden kaldır"), trailingIcon: Icon(Icons.remove), onPressed: () {})
                        ],
                        child: Container(
                          width: 120.0,
                          height: 180.0,
                          decoration: BoxDecoration(
                              color: Style.Colors.secondColor,
                              borderRadius: BorderRadius.all(Radius.circular(2.0)),
                              shape: BoxShape.rectangle),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                EvaIcons.filmOutline,
                                color: Colors.white,
                                size: 50.0,
                              )
                            ],
                          ),
                        ),
                      )
                    : FocusedMenuHolder(
                        menuWidth: 200.0,
                        onPressed: () {},
                        openWithTap: true,
                        menuItems: [
                          FocusedMenuItem(
                              title: Text("Detaylı incele"),
                              trailingIcon: Icon(Icons.open_in_new),
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => MovieDetailScreen(movie: movie)));
                              }),
                          FocusedMenuItem(
                            title: Text("Favorilerden kaldır2"),
                            trailingIcon: Icon(Icons.delete),
                            onPressed: () async {
                              await _databaseService.removeFromFavorite(movie.id.toString());
                              
                              
                            },
                            //print( Provider.of<StateData>(context).favoriteMovies);
                          )
                        ],
                        child: Container(
                          width: 120.0,
                          height: 180.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(2.0)),
                              shape: BoxShape.rectangle,
                              image: DecorationImage(
                                  image: NetworkImage("https://image.tmdb.org/t/p/w200/" + movie.poster), fit: BoxFit.cover)),
                        ),
                      ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  width: 100.0,
                  child: Text(
                    movie.title,
                    maxLines: 2,
                    style: TextStyle(height: 1.4, color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11.0),
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Row(
                  children: <Widget>[
                    Text(
                      movie.rating.toString(),
                      style: TextStyle(color: Colors.white, fontSize: 10.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    RatingBar.builder(
                      itemSize: 8.0,
                      initialRating: movie.rating / 2,
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
            );
          }).toList(),
        ),
      ),
    );
  }

  //Function removeMovieFromFavorites = { _databaseService.removeFromFavorite()}
}
