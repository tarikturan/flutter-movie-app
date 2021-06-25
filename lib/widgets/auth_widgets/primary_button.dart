import 'package:flutter/material.dart';

import 'package:movieapp/style/theme.dart' as Style;

class PrimaryButton extends StatefulWidget {
  final String btnText;
  Function onPress;
  TextEditingController emailController;
  TextEditingController passwordController;
  TextEditingController userNameController;

  PrimaryButton(
      {this.btnText,
      this.onPress,
      });

  @override
  _PrimaryButtonState createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPress,
      child: Container(
        decoration: BoxDecoration(
          color: Style.Colors.secondColor,
          borderRadius: BorderRadius.circular(50),
        ),
        padding: EdgeInsets.all(20),
        child: Center(
          child: Text(
            widget.btnText,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

  
}
