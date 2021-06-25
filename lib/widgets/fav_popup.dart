import 'package:flutter/material.dart';
import 'package:movieapp/services/db.dart';
import 'package:movieapp/style/theme.dart' as Style;

class FavPopUp extends StatefulWidget {
  String movieName;
  String movieId;

  FavPopUp({this.movieName, this.movieId});

  @override
  _FavPopUpState createState() => _FavPopUpState();
}

class _FavPopUpState extends State<FavPopUp> {
  DatabaseService _databaseService = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: <Widget>[
        TextButton(
          onPressed: () async {
            await _databaseService.addToFavorite(widget.movieId);
            await Navigator.pop(context);
          },
          child: const Text(
            'EVET',
            style: TextStyle(
              color: Style.Colors.secondColor,
            ),
          ),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text(
            'HAYIR',
            style: TextStyle(
              color: Style.Colors.secondColor,
            ),
          ),
        ),
      ],
      /*   title: Text(
        "HAKKINDA",
        style: TextStyle(
            color: Style.Colors.secondColor,
            fontWeight: FontWeight.bold,
            fontSize: 25),
      ), */
      content: Text(
        "${widget.movieName} adlı filmi favorilerinize eklemek istediğnize emin misiniz?",
        style: TextStyle(color: Style.Colors.titleColor),
      ),
    );
  }
}
