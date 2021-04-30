import 'package:flutter/material.dart';
import 'package:movieapp/style/theme.dart' as Style;

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 25.0, right: 25.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "HAKKINDA",
            style: TextStyle(
                color: Style.Colors.secondColor,
                fontWeight: FontWeight.bold,
                fontSize: 25),
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            "Bu uygulama Dr. Öğretim Üyesi Ahmet Cevahir ÇINAR tarafından yürütülen 3311456 kodlu MOBİL PROGRAMLAMA dersi kapsamında 193311063 numaralı Recep Tarık Turan adlı öğrenci tarafından 30 Nisan 2021 günü yapılmıştır.",
            style: TextStyle(color: Style.Colors.titleColor),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
