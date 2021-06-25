import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movieapp/services/db.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:movieapp/services/state_data.dart';
import 'package:movieapp/style/theme.dart' as Style;
import 'package:movieapp/widgets/auth_widgets/input_with_icon.dart';
import 'package:movieapp/widgets/auth_widgets/primary_button.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class AccounSettingsScreen extends StatefulWidget {
  const AccounSettingsScreen({Key key}) : super(key: key);

  @override
  _AccounSettingsScreenState createState() => _AccounSettingsScreenState();
}

class _AccounSettingsScreenState extends State<AccounSettingsScreen> {
  TextEditingController _displayNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  DatabaseService _databaseService = DatabaseService();
  User user = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _picker = ImagePicker();
  File _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Style.Colors.clrWhite,
      appBar: AppBar(
        title: Text("Hesap Ayarları"),
        backgroundColor: Style.Colors.secondColor,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0, right: 24.0, left: 24.0),
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 32,
            ),
            Center(
              child: GestureDetector(
                onTap: () {
                  _showPicker(context);
                },
                child: CircleAvatar(
                  radius: 55,
                  backgroundColor: Style.Colors.secondColor,
                  child: _image != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.file(
                            _image,
                            width: 100,
                            height: 100,
                            fit: BoxFit.fitHeight,
                          ),
                        )
                      : Container(
                          decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(50)),
                          width: 100,
                          height: 100,
                          child: Icon(
                            Icons.camera_alt,
                            color: Colors.grey[800],
                          ),
                        ),
                ),
              ),
            ),
            SizedBox(
              height: 32,
            ),
            InputWithIcon(
              hint: "Adınız",
              textController: _displayNameController..text = user.displayName,
              obscureText: false,
              icon: Icons.title,
              borderRadius: 8,
            ),
            SizedBox(
              height: 16,
            ),
            InputWithIcon(
              textController: _userNameController..text = Provider.of<StateData>(context).userName,
              obscureText: false,
              icon: Icons.account_circle_outlined,
              borderRadius: 8,
            ),
            SizedBox(
              height: 16,
            ),
            InputWithIcon(
              textController: _emailController..text = user.email,
              obscureText: false,
              icon: Icons.email,
              borderRadius: 8,
            ),
            SizedBox(
              height: 16,
            ),
            PrimaryButton(
              btnText: "Kaydet",
              onPress: () async {
                //_emailController.text != null ? await user.updateEmail(_emailController.text.trim()) : print("object");
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        actions: <Widget>[
                          TextButton(
                            onPressed: () async {
                              _displayNameController.text != null ? await user.updateDisplayName(_displayNameController.text) : null;
                              _emailController.text != null ? await changeEmail(_emailController.text.trim()) : null;
                              await _firestore.collection('users').doc(user.uid).update({'userName': _userNameController.text});
                              Toast.show("Bilgiler başarıyla kaydedildi", context,
                                  gravity: Toast.TOP, duration: 3, backgroundColor: Colors.blue);
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'GÖNDER',
                              style: TextStyle(
                                color: Style.Colors.secondColor,
                              ),
                            ),
                          ),
                        ],
                        content: Container(
                          height: MediaQuery.of(context).size.height * 0.12,
                          child: Column(
                            children: [
                              Text("Kaydetmek için şifrenizi giriniz"),
                              SizedBox(height: 14.0,),
                              TextField(
                                
                                obscureText: true,
                                decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(16.0),
                                borderSide: BorderSide.none
                                ), 
                                filled: true,
                                fillColor: Colors.grey[100],
                                ),
                                controller: _passwordController,
                              )
                            ],
                          ),
                        ),
                      );
                    });
              },
            ),
          ],
        ),
      ),
    );
  }

  _imgFromCamera() async {
    PickedFile image = await _picker.getImage(source: ImageSource.camera, imageQuality: 50);

    setState(() {
      _image = File(image.path);
    });
  }

  _imgFromGallery() async {
    PickedFile image = await _picker.getImage(source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _image = File(image.path);
    });
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  changeEmail(newEmail) async {
    var authCredential = EmailAuthProvider.credential(email: user.email, password: _passwordController.text);

    await user.reauthenticateWithCredential(authCredential).then((value) async {
      await user.updateEmail(newEmail).then((value) {
        print("Email değiştirildi");
      });
    });
    //eturn StyledToast(child: Text("TOAST"), locale: const Locale("tr","TR"));
  }
}
