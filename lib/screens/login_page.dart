import 'package:flutter/material.dart';
import 'package:movieapp/screens/home_screen.dart';
import 'package:movieapp/services/auth.dart';
import 'package:movieapp/style/theme.dart' as Style;
import 'package:movieapp/widgets/auth_widgets/input_with_icon.dart';
import 'package:movieapp/widgets/auth_widgets/outline_button.dart';
import 'package:movieapp/widgets/auth_widgets/primary_button.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //AuthService _authService = AuthService();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _userNameController = TextEditingController();

  int _pageState = 0;
  var _backgroundColor = Style.Colors.mainColor;
  var _headingColor = Style.Colors.clrPrimary;

  double windowWidth = 0;
  double windowHeight = 0;

  double _loginYOffset = 0;
  double _loginXOffset = 0;
  double _registerYOffset = 0;
  double _registerHeight = 0;

  double _loginWidth = 0;
  double _loginHeight = 0;
  double _loginOpacity = 1;
  double _headingTop = 80;
  bool _keyboardVisible = false;

  @override
  void initState() {
    super.initState();

    KeyboardVisibilityNotification().addNewListener(
      onChange: (visible) {
        setState(() {
          _keyboardVisible = visible;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    windowWidth = MediaQuery.of(context).size.width;
    windowHeight = MediaQuery.of(context).size.height;

    switch (_pageState) {
      case 0:
        _backgroundColor = Style.Colors.mainColor;
        _headingColor = Colors.white;
        _loginYOffset = windowHeight;
        _registerYOffset = windowHeight;
        _loginXOffset = 0;
        _loginWidth = windowWidth;
        _loginOpacity = 1;
        _headingTop = 80;
        _loginHeight = _keyboardVisible ? windowHeight : windowHeight - 220;
        break;
      case 1:
        _backgroundColor = Style.Colors.secondColor;
        _headingColor = Style.Colors.clrWhite;
        _loginYOffset = _keyboardVisible ? 40 : 220;
        _loginHeight = _keyboardVisible ? windowHeight : windowHeight - 220;
        _registerYOffset = windowHeight;
        _loginXOffset = 0;
        _loginWidth = windowWidth;
        _loginOpacity = 1;
        _headingTop = 70;
        break;
      case 2:
        _backgroundColor = Style.Colors.secondColor;
        _headingColor = Style.Colors.clrWhite;
        _loginYOffset = _keyboardVisible ? 30 : 200;
        _loginHeight = _keyboardVisible ? windowHeight : windowHeight - 240;
        _registerYOffset = _keyboardVisible ? 55 : 220;
        _registerHeight = _keyboardVisible ? windowHeight : windowHeight - 220;
        _loginXOffset = 20;
        _loginWidth = windowWidth - 40;
        _loginOpacity = 0.7;
        _headingTop = 60;
        break;
    }
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        child: Stack(
          children: [
            AnimatedContainer(
              curve: Curves.fastLinearToSlowEaseIn,
              duration: Duration(
                milliseconds: 1000,
              ),
              color: _backgroundColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _pageState = 0;
                      });
                    },
                    child: Container(
                      child: Column(
                        children: [
                          AnimatedContainer(
                            curve: Curves.fastLinearToSlowEaseIn,
                            duration: Duration(milliseconds: 1000),
                            margin: EdgeInsets.only(top: _headingTop),
                            child: Text(
                              'TMDb API',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: _headingColor,
                                fontSize: 28,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(20),
                            padding: EdgeInsets.symmetric(horizontal: 32),
                            child: Text(
                              'Sevdiğiniz filmler hakkında herşeyi öğrenin!',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                                color: _headingColor,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 42,
                    ),
                    child: Center(
                      child: Image.asset('assets/logo.png'),
                    ),
                  ),
                  Container(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          if (_pageState != 0) {
                            _pageState = 0;
                          } else {
                            _pageState = 1;
                          }
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.all(32),
                        padding: EdgeInsets.all(20),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Style.Colors.secondColor,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Center(
                          child: Text(
                            'Başla',
                            style: TextStyle(
                              color: Style.Colors.clrWhite,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            AnimatedContainer(
              padding: EdgeInsets.all(32),
              width: _loginWidth,
              height: _loginHeight,
              curve: Curves.fastLinearToSlowEaseIn,
              duration: Duration(milliseconds: 1000),
              transform: Matrix4.translationValues(_loginXOffset, _loginYOffset, 1),
              decoration: BoxDecoration(
                color: Style.Colors.clrWhite.withOpacity(_loginOpacity),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              child: ListView(
                children: [
                  Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 20),
                        child: Text(
                          'Devam etmek için giriş yapın',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      InputWithIcon(
                        keyboardType: TextInputType.emailAddress,
                        obscureText: false,
                        textController: _emailController,
                        icon: Icons.email,
                        hint: 'E-Mail adresiniz',
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      InputWithIcon(
                        obscureText: true,
                        textController: _passwordController,
                        icon: Icons.vpn_key,
                        hint: 'Şifreniz',
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: [
                      PrimaryButton(
                        onPress: () {
                          context.read<AuthService>().signIn(_emailController.text, _passwordController.text);

                          /*  _authService
                              .signIn(_emailController.text,
                                  _passwordController.text)
                              .then((value) {
                            return Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (contex) => HomeScreen()));
                          }); */
                        },
                        btnText: 'Giriş',
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _pageState = 2;
                          });
                        },
                        child: OutlineBtn(
                          btnText: 'Yeni hesap oluştur',
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            AnimatedContainer(
              height: _registerHeight,
              padding: EdgeInsets.all(32),
              curve: Curves.fastLinearToSlowEaseIn,
              duration: Duration(milliseconds: 1000),
              transform: Matrix4.translationValues(0, _registerYOffset, 1),
              decoration: BoxDecoration(
                color: Style.Colors.clrWhite,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              child: ListView(
                children: [
                  Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 20),
                        child: Text(
                          'Yeni hesap oluştur',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      InputWithIcon(
                        textController: _userNameController,
                        obscureText: false,
                        icon: Icons.email,
                        hint: 'Kullanıcı adınız',
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      InputWithIcon(
                        textController: _emailController,
                        obscureText: false,
                        icon: Icons.email,
                        hint: 'E-Mail adresiniz',
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      InputWithIcon(
                        textController: _passwordController,
                        obscureText: true,
                        icon: Icons.vpn_key,
                        hint: 'Şifreniz',
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: [
                      PrimaryButton(
                        onPress: () {
                          context
                              .read<AuthService>()
                              .createPerson(_userNameController.text, _emailController.text, _passwordController.text)
                              .then((value) {
                                setState(() {
                                  _pageState = 1;

                                });


                              });

                          /* _authService
                              .createPerson(
                                  _userNameController.text,
                                  _emailController.text,
                                  _passwordController.text)
                              .then((value) {
                            setState(() {
                              _pageState = 1;
                            });
                          }); */
                        },
                        btnText: 'Hesap oluştur',
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _pageState = 1;
                          });
                        },
                        child: OutlineBtn(
                          btnText: 'Giriş ekranına dön',
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
