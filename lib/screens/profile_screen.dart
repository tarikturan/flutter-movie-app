import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/screens/account_settings_screen.dart';
import 'package:movieapp/screens/favorite_movies.dart';
import 'package:movieapp/services/auth.dart';
import 'package:movieapp/services/state_data.dart';
import 'package:movieapp/style/theme.dart' as Style;
import 'package:movieapp/widgets/about.dart';
import 'package:movieapp/widgets/persons.dart';
import 'package:movieapp/widgets/top_movies.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  User user = FirebaseAuth.instance.currentUser;
  

  
  ProfileScreen({Key key}) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    Provider.of<StateData>(context).getUSerName();
    String userName = Provider.of<StateData>(context).userName;
    Provider.of<StateData>(context).getFavoriteMovies();
    List test = Provider.of<StateData>(context).favoriteMovies;
    print(test.length);
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Style.Colors.mainColor,
      body: Padding(
        padding: EdgeInsets.only(top: 60.0, right: 8.0, left: 8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ClipOval(
                child: Material(
                  color: Colors.transparent,
                  child: Ink.image(
                    image: NetworkImage("https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png"),
                    fit: BoxFit.cover,
                    width: 128,
                    height: 128,
                  ),
                ),
              ),
              SizedBox(
                height: 24.0,
              ),
              Text(
                user.displayName != null ? user.displayName : userName,
                style: TextStyle(color: Colors.white, fontSize: 24.0, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 4.0,
              ),
              Text(
                user.email,
                style: TextStyle(color: Style.Colors.titleColor),
              ),
              SizedBox(
                height: 8.0,
              ),
              Divider(
                thickness: 1,
                indent: size.width * 0.1,
                endIndent: size.width * 0.1,
                color: Style.Colors.secondColor,
              ),
              SizedBox(
                height: 8.0,
              ),
              /*  TopMovies(),
              SizedBox(
                height: 8.0,
              ),
              PersonsList(), */
              Container(
                margin: EdgeInsets.all(4.0),
                decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.all(Radius.circular(8))),
                child: ListTile(
                  tileColor: Colors.transparent,
                  leading: Icon(
                    EvaIcons.film,
                    color: Style.Colors.secondColor,
                  ),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => FavoriteMoviesScreen()));
                  },
                  title: Text(
                    "Favori Filmlerim",
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
                  ),
                ),
              ),
              
              Container(
                margin: EdgeInsets.all(4.0),
                decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.all(Radius.circular(8))),
                child: ListTile(
                  tileColor: Colors.transparent,
                  leading: Icon(
                    EvaIcons.info,
                    color: Style.Colors.secondColor,
                  ),
                  onTap: () async {
                    await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return About();
                        });
                  },
                  title: Text(
                    "Uygulama Hakkında",
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(4.0),
                decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.all(Radius.circular(8))),
                child: ListTile(
                  tileColor: Colors.transparent,
                  leading: Icon(
                    Icons.account_circle,
                    color: Style.Colors.secondColor,
                  ),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => AccounSettingsScreen()));
                  },
                  title: Text(
                    "Hesap Ayarları",
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(4.0),
                decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.all(Radius.circular(8))),
                child: ListTile(
                  tileColor: Colors.transparent,
                  leading: Icon(
                    EvaIcons.logOut,
                    color: Style.Colors.secondColor,
                  ),
                  onTap: () {
                    context.read<AuthService>().signOut();
                    /* _authService.signOut();
                    Navigator.pop(context); */
                  },
                  title: Text(
                    "Çıkış",
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }


  

}

/* class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  //AuthService _authService = AuthService();
  Widget build(BuildContext context) {
    String sehir = Provider.of<StateData>(context).sehir;
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Style.Colors.mainColor,
      body: Padding(
        padding: EdgeInsets.only(top: 60.0, right: 8.0, left: 8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ClipOval(
                child: Material(
                  color: Colors.transparent,
                  child: Ink.image(
                    image: NetworkImage(
                        "https://avatars.githubusercontent.com/u/52034590?v=4"),
                    fit: BoxFit.cover,
                    width: 128,
                    height: 128,
                  ),
                ),
              ),
              SizedBox(
                height: 24.0,
              ),
              Text(
                "Recep Tarık Turan",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.0,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 4.0,
              ),
              Text(
                "retatu@outlook.com",
                style: TextStyle(color: Style.Colors.titleColor),
              ),
              
              SizedBox(
                height: 8.0,
              ),
              Divider(
                thickness: 1,
                indent: size.width * 0.1,
                endIndent: size.width * 0.1,
                color: Style.Colors.secondColor,
              ),
              SizedBox(
                height: 8.0,
              ),
              /*  TopMovies(),
              SizedBox(
                height: 8.0,
              ),
              PersonsList(), */
              Container(
                margin: EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                    color: Colors.white10,
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                child: ListTile(
                  tileColor: Colors.transparent,
                  leading: Icon(
                    EvaIcons.film,
                    color: Style.Colors.secondColor,
                  ),
                  onTap: (){
                   // Navigator.push(context, MaterialPageRoute(builder: (context) => FavoriteMoviesScreen()));
                    
                    },
                  title: Text(
                    sehir,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w300),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                    color: Colors.white10,
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                child: ListTile(
                  onTap: () { 
                    
                    
                    },
                  tileColor: Colors.transparent,
                  
                  leading: Icon(
                    EvaIcons.person,
                    color: Style.Colors.secondColor,
                  ),
                  title: Text(
                    "Favori Oyuncularım",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w300),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                    color: Colors.white10,
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                child: ListTile(
                  tileColor: Colors.transparent,
                  leading: Icon(
                    EvaIcons.info,
                    color: Style.Colors.secondColor,
                  ),
                  onTap: () async {
                    await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return About();
                        });
                  },
                  title: Text(
                    "Uygulama Hakkında",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w300),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                    color: Colors.white10,
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                child: ListTile(
                  tileColor: Colors.transparent,
                  leading: Icon(
                    EvaIcons.logOut,
                    color: Style.Colors.secondColor,
                  ),
                  onTap: () {
                    context.read<AuthService>().signOut();
                    /* _authService.signOut();
                    Navigator.pop(context); */
                  },
                  title: Text(
                    "Çıkış",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w300),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
 */
