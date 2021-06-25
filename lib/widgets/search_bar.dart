import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:movieapp/screens/detail_screen.dart';
import 'package:movieapp/services/db.dart';
import '../bloc/search_movies_bloc.dart';
import '../model/movie.dart';
import '../model/movie_response.dart';
import 'package:movieapp/style/theme.dart' as Style;

class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  var stream = searchMoviesBloc.subject.stream;
  DatabaseService _databaseService = DatabaseService();

  @override
  void initState() {
    super.initState();
    searchMoviesBloc.getRandomRecommendations();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MovieResponse>(
      stream: stream,
      builder: (context, AsyncSnapshot<MovieResponse> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.error != null && snapshot.data.error.length > 0) {
            return _buildErrorWidget(snapshot.data.error);
          }
          return _buildFloatingSearchBar(snapshot.data);
        } else if (snapshot.hasError) {
          return _buildErrorWidget(snapshot.error);
        } else {
          return _buildLoadingWidget();
        }
      },
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
        Text(
          "Yeniden deneyiniz.",
          style: TextStyle(color: Colors.white, fontSize: 16.0),
        ),
        SizedBox(
          height: 25.0,
        ),
        IconButton(
            icon: Icon(
              EvaIcons.refresh,
              color: Style.Colors.secondColor,
            ),
            onPressed: () {
              setState(() {
                searchMoviesBloc.getRandomRecommendations();
              });
            })
      ],
    ));
    //     child: Column(
    //   mainAxisAlignment: MainAxisAlignment.center,
    //   children: [
    //     Text("Error occured: $error"),
    //   ],
    // ));
  }

  Widget _buildFloatingSearchBar(MovieResponse data) {
    List<Movie> movies = data.movies;
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return FloatingSearchBar(
      hint: 'Film ara...',
      scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
      transitionDuration: const Duration(milliseconds: 800),
      transitionCurve: Curves.easeInOut,
      physics: const BouncingScrollPhysics(),
      axisAlignment: isPortrait ? 0.0 : -1.0,
      openAxisAlignment: 0.0,
      width: isPortrait ? 600 : 500,
      debounceDelay: const Duration(milliseconds: 500),

      onQueryChanged: (query) {
        setState(() {
          query.length != 0 ? searchMoviesBloc.searchMovies(query) : null;
        });
      },
      // Specify a custom transition to be used for
      // animating between opened and closed stated.
      transition: CircularFloatingSearchBarTransition(),
      actions: [
        FloatingSearchBarAction(
          showIfOpened: false,
          child: CircularButton(
            icon: const Icon(EvaIcons.film),
            onPressed: () {},
          ),
        ),
        FloatingSearchBarAction.searchToClear(
          showIfClosed: false,
        ),
      ],
      builder: (context, transition) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Material(
            color: Colors.white,
            elevation: 4.0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: movies.take(10).map((movie) {
                return Container(
                    child: Draggable(
                      feedback: Icon(Icons.favorite,color: Colors.red,),
                        onDragStarted: () async {
                          await _databaseService.addToFavorite(movie.id.toString());
                        },
                  child: GestureDetector(
                    /* onHorizontalDragStart: (DragStartDetails details) {
                      print("Beni kaydırdılar");
                    }, */
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => MovieDetailScreen(movie: movie)));
                    },
                    child: Row(
                      children: [
                        movie.poster == null
                            ? Container(
                                margin: EdgeInsets.all(3.0),
                                width: 60.0,
                                height: 90.0,
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
                              )
                            : Container(
                                margin: EdgeInsets.all(3.0),
                                width: 60.0,
                                height: 90.0,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(2.0)),
                                    shape: BoxShape.rectangle,
                                    image: DecorationImage(
                                        image: NetworkImage("https://image.tmdb.org/t/p/w200/" + movie.poster), fit: BoxFit.cover)),
                              ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              movie.title.length > 30 ? '${movie.title.substring(0, 30)}...' : movie.title,
                              style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Row(
                              children: [
                                Icon(
                                  EvaIcons.star,
                                  size: 16.0,
                                  color: Style.Colors.secondColor,
                                ),
                                Text(movie.rating.toString())
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ));
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
