import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfilePage extends StatefulWidget {
  String username;
  ProfilePage({this.username});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  FirebaseAuth _auth;
  String updatedPassword;
  String previousPassword;
  bool _showPassword1 = false;
  bool _showPassword2 = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _auth = FirebaseAuth.instance;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'User Profile',
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              physics: BouncingScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 6,
                  ),
                  Flexible(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10.0),
                      child: Material(
                        elevation: 10.0,
                        child: ListTile(
                          leading: Icon(Icons.email),
                          shape: Border(
                            top: BorderSide(style: BorderStyle.solid),
                            bottom: BorderSide(style: BorderStyle.solid),
                            left: BorderSide(style: BorderStyle.solid),
                            right: BorderSide(style: BorderStyle.solid),
                          ),
                          title: Text('Email: ' + _auth.currentUser.email),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10.0),
                      child: Material(
                        elevation: 10.0,
                        child: ListTile(
                          leading: Icon(Icons.person_rounded),
                          shape: Border(
                            top: BorderSide(style: BorderStyle.solid),
                            bottom: BorderSide(style: BorderStyle.solid),
                            left: BorderSide(style: BorderStyle.solid),
                            right: BorderSide(style: BorderStyle.solid),
                          ),
                          title: Text('Username: ' + widget.username),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10.0),
                      child: Material(
                        elevation: 10.0,
                        child: TextFormField(
                          onChanged: (value) {
                            previousPassword = value;
                            print(previousPassword);
                          },
                          obscureText: !this._showPassword2,
                          decoration: InputDecoration(
                            prefixIcon: Padding(
                              padding: EdgeInsets.only(left: 18.0, right: 30.0),
                              child: Icon(Icons.vpn_key),
                            ),
                            suffixIcon: Padding(
                              padding: EdgeInsets.only(right: 18.0),
                              child: IconButton(
                                icon: Icon(
                                  Icons.remove_red_eye,
                                  color: this._showPassword2
                                      ? Colors.blue
                                      : Colors.grey,
                                ),
                                onPressed: () {
                                  setState(() => this._showPassword2 =
                                      !this._showPassword2);
                                },
                              ),
                            ),
                            hintText: 'Enter previous password',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(style: BorderStyle.solid),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10.0),
                      child: Material(
                        elevation: 10.0,
                        child: TextFormField(
                          onChanged: (value) {
                            updatedPassword = value;
                            print(updatedPassword);
                          },
                          obscureText: !this._showPassword1,
                          decoration: InputDecoration(
                            prefixIcon: Padding(
                              padding: EdgeInsets.only(left: 18.0, right: 30.0),
                              child: Icon(Icons.vpn_key),
                            ),
                            suffixIcon: Padding(
                              padding: EdgeInsets.only(right: 18.0),
                              child: IconButton(
                                icon: Icon(
                                  Icons.remove_red_eye,
                                  color: this._showPassword1
                                      ? Colors.blue
                                      : Colors.grey,
                                ),
                                onPressed: () {
                                  setState(() => this._showPassword1 =
                                      !this._showPassword1);
                                },
                              ),
                            ),
                            hintText: 'Enter new password',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(style: BorderStyle.solid),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: TextButton(
                      onPressed: () async {
                        if (updatedPassword != null &&
                            updatedPassword.length >= 6 &&
                            _auth.currentUser != null &&
                            previousPassword.length >= 6 &&
                            previousPassword != null) {
                          AuthCredential _credentials =
                              EmailAuthProvider.credential(
                                  email: _auth.currentUser.email,
                                  password: previousPassword);
                          await _auth.currentUser
                              .reauthenticateWithCredential(_credentials);
                          await _auth.currentUser
                              .updatePassword(updatedPassword);
                          final snackBar = SnackBar(
                              content: Text('Your password has been updated!'));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      },
                      child: Text('SAVE'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
