import 'package:flutter/material.dart';
import 'package:movieapp/style/theme.dart' as Style;

class OutlineBtn extends StatefulWidget {
  final String btnText;
  OutlineBtn({this.btnText});

  @override
  _OutlineBtnState createState() => _OutlineBtnState();
}

class _OutlineBtnState extends State<OutlineBtn> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
            color: Style.Colors.mainColor,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(50)),
      padding: EdgeInsets.all(20),
      child: Center(
        child: Text(
          widget.btnText,
          style: TextStyle(
            color: Style.Colors.mainColor,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
