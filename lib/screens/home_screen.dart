import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/screens/discover_screen.dart';
import 'package:movieapp/style/theme.dart' as Style;
import 'package:movieapp/widgets/about.dart';
import 'package:movieapp/widgets/genres.dart';
import 'package:movieapp/widgets/now_playing.dart';
import 'package:movieapp/widgets/persons.dart';
import 'package:movieapp/widgets/top_movies.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  final tabs = [
    DiscoverScreen(),
    ListView(
      children: <Widget>[
        NowPlaying(),
        GenresScreen(),
        PersonsList(),
        TopMovies()
      ],
    ),
    About()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.Colors.mainColor,
      body: tabs[_currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
        index: 1,
        backgroundColor: Style.Colors.mainColor,
        color: Style.Colors.secondColor,
        buttonBackgroundColor: Colors.white,
        animationCurve: Curves.fastLinearToSlowEaseIn,
        height: 50.0,
        items: <Widget>[
          Icon(EvaIcons.search, size: 30),
          Icon(EvaIcons.home, size: 30),
          Icon(EvaIcons.info, size: 30),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
