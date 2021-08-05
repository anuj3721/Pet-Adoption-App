import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:pet_adoption_app/screens/homepage.dart';
import 'package:pet_adoption_app/screens/registration.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginOrRegister extends StatefulWidget {
  @override
  _LoginOrRegisterState createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  final _formKey = GlobalKey<FormState>();
  FirebaseAuth _auth;
  String email;
  String password;
  bool _showPassword = false;
  String _errorMessage;
  bool isLoading = false;
  int count = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _auth = FirebaseAuth.instance;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
     //   Navigator.of(context).popUntil((route) => route.isFirst);
     //    Navigator.popUntil(context, (route) {
     //      return count++ == 2;
     //    });
       // Navigator.push(context,MaterialPageRoute(builder: (context)=> HomePage()));
        return Future.value(true);
      },
      child: SafeArea(
        child: Scaffold(
          body: ModalProgressHUD(
            inAsyncCall: isLoading,
            progressIndicator: CircularProgressIndicator(),
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Flexible(
                      child: TextFormField(
                        textAlignVertical: TextAlignVertical.bottom,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          } else {
                            if (value.isValidLoginEmail()) {
                              return null;
                            } else {
                              return 'This is not a valid email address';
                            }
                          }
                        },
                        onTap: (){
                          FocusScopeNode currentFocus = FocusScope.of(context);
                          if (!currentFocus.hasPrimaryFocus) {
                            currentFocus.unfocus();
                          }
                        },
                        onChanged: (value) {
                          email = value;
                          print(email);
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: 'Enter your email',
                          prefixIcon: Icon(Icons.email),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Flexible(
                      child: TextFormField(
                        textAlignVertical: TextAlignVertical.bottom,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        onTap: (){
                          FocusScopeNode currentFocus = FocusScope.of(context);
                          if (!currentFocus.hasPrimaryFocus) {
                            currentFocus.unfocus();
                          }
                        },
                        onChanged: (value) {
                          password = value;
                          print(password);
                        },
                        obscureText: !this._showPassword,
                        decoration: InputDecoration(
                          hintText: 'Enter your password',
                          prefixIcon: Icon(Icons.vpn_key),
                          suffixIcon: IconButton(
                            icon: Icon(
                              Icons.remove_red_eye,
                              color: this._showPassword ? Colors.blue : Colors.grey,
                            ),
                            onPressed: () {
                              setState(
                                  () => this._showPassword = !this._showPassword);
                            },
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Flexible(
                      child: MaterialButton(
                        height: 50.0,
                        onPressed: () async {
                          try {
                            if (_formKey.currentState.validate()) {
                              setState(() {
                                isLoading = true;
                              });
                              print(email);
                              print(password);
                              var user = await _auth.signInWithEmailAndPassword(
                                  email: email, password: password);
                            }
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'user-not-found' ||
                                e.code == 'wrong-password') {
                              _errorMessage = 'Invalid email or password';
                            } else {
                              _errorMessage = e.message;
                            }
                          }
                          if (_errorMessage != null) {
                            setState(() {
                              isLoading = false;
                            });
                            print(_errorMessage);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(_errorMessage,
                                    textAlign: TextAlign.center),
                                backgroundColor: Theme.of(context).errorColor,
                              ),
                            );
                            setState(() {
                              _errorMessage = null;
                            });
                          } else if (_formKey.currentState.validate()) {
                            setState(() {
                              isLoading = false;
                            });
                            FocusScopeNode currentFocus = FocusScope.of(context);
                            if (!currentFocus.hasPrimaryFocus) {
                              currentFocus.unfocus();
                            }
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage()));
                          }
                        },
                        child: Text(
                          'LOGIN',
                          style: TextStyle(color: Colors.white),
                        ),
                        elevation: 10.0,
                        color: Colors.blue,
                      ),
                    ),
                    SizedBox(
                      height: 35.0,
                    ),
                    Flexible(
                      child: GestureDetector(
                        onTap: () {
                          FocusScopeNode currentFocus = FocusScope.of(context);
                          if (!currentFocus.hasPrimaryFocus) {
                            currentFocus.unfocus();
                          }
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegistrationPage()));
                        },
                        child: Text(
                          'Don\'t have an account? Sign Up',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.green, fontSize: 15.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

//Checks for valid email address
extension EmailValidator on String {
  bool isValidLoginEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}
