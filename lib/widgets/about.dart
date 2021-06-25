import 'package:flutter/material.dart';
import 'package:movieapp/style/theme.dart' as Style;

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'OK'),
          child: const Text(
            'TAMAM',
            style: TextStyle(
              color: Style.Colors.secondColor,
            ),
          ),
        ),
      ],
      title: Text(
        "HAKKINDA",
        style: TextStyle(
            color: Style.Colors.secondColor,
            fontWeight: FontWeight.bold,
            fontSize: 25),
      ),
      content: Text(
        "Bu uygulama Dr. Öğretim Üyesi Ahmet Cevahir ÇINAR tarafından yürütülen 3311456 kodlu MOBİL PROGRAMLAMA dersi kapsamında 193311063 numaralı Recep Tarık Turan adlı öğrenci tarafından 25 Haziran 2021 günü yapılmıştır.",
        style: TextStyle(color: Style.Colors.titleColor),
      ),
    );
  }
}
