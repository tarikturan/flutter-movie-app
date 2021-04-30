import 'package:flutter/material.dart';
import 'package:movieapp/widgets/search_bar.dart';
import 'package:movieapp/style/theme.dart' as Style;
import 'package:movieapp/widgets/upcoming_movies.dart';

class DiscoverScreen extends StatefulWidget {
  @override
  _DiscoverScreenState createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.Colors.mainColor,
      resizeToAvoidBottomInset: false,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 85.0, left: 8.0, right: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 10.0, top: 20.0),
                  child: Text(
                    "YAKLAŞAN FİLMLER",
                    style: TextStyle(
                        color: Style.Colors.titleColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 12.0),
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                UpcomingMovies()
              ],
            ),
          ),
          SearchBar(),
        ],
      ),
    );
  }
}
