import 'package:flutter/material.dart';
import 'package:movieapp/style/theme.dart' as Style;

class InputWithIcon extends StatefulWidget {
  final IconData icon;
  final String hint;
  final TextEditingController textController;
  final bool obscureText;
  final TextInputType keyboardType;
  final double borderRadius; 
  InputWithIcon({this.icon,this.borderRadius, this.hint,this.textController,this.obscureText,this.keyboardType});

  @override
  _InputWithIconState createState() => _InputWithIconState();
}

class _InputWithIconState extends State<InputWithIcon> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
            color: Style.Colors.clrBorderInput,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(widget.borderRadius != null ? widget.borderRadius: 50)),
      child: Row(
        children: [
          Container(
            width: 60,
            child: Icon(
              widget.icon,
              size: 20,
              color: Style.Colors.clrIcon,
            ),
          ),
          Expanded(
              child: TextField(
                
                keyboardType:widget.keyboardType,
                obscureText: widget.obscureText,
                controller: widget.textController,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 20),
              border: InputBorder.none,
              hintText: widget.hint,
            ),
          ))
        ],
      ),
    );
  }
}
