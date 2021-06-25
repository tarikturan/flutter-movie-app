import 'package:flutter/material.dart';
import 'package:movieapp/widgets/fav_movies.dart';
import 'package:movieapp/widgets/search_bar.dart';
import 'package:movieapp/style/theme.dart' as Style;
import 'package:movieapp/widgets/upcoming_movies.dart';

class FavoriteMoviesScreen extends StatefulWidget {
  @override
  _FavoriteMoviesScreenState createState() => _FavoriteMoviesScreenState();
}

class _FavoriteMoviesScreenState extends State<FavoriteMoviesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Favori Filmlerim"),backgroundColor: Style.Colors.secondColor,),
      backgroundColor: Style.Colors.mainColor,
      resizeToAvoidBottomInset: false,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              FavoriteMovies()
            ],
          ),
          
        ],
      ),
    );
  }
}
