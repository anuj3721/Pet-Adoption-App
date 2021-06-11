import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pet_adoption_app/screens/homepage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  CollectionReference _reference;
  final _formKey = GlobalKey<FormState>();
  FirebaseAuth _auth;
  String email;
  String password;
  String name;
  bool _showPassword = false;
  // bool checkError = false;
  String errorMessage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _auth = FirebaseAuth.instance;
    _reference = FirebaseFirestore.instance.collection('User Data');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Flexible(
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      name = value;
                      print(name);
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter your name',
                      prefixIcon: Icon(Icons.edit),
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
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      } else {
                        if (value.isValidEmail()) {
                          return null;
                        } else {
                          return 'This is not a valid email address';
                        }
                      }
                    },
                    onChanged: (value) {
                      email = value;
                      print(email);
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: 'Enter email',
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
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      } else {
                        if (value.length < 6) {
                          return 'Password is too short';
                        }
                      }
                      return null;
                    },
                    onChanged: (value) {
                      password = value;
                      print(password);
                    },
                    obscureText: !this._showPassword,
                    decoration: InputDecoration(
                      hintText: 'Enter password',
                      prefixIcon: Icon(Icons.vpn_key),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.remove_red_eye),
                        color: this._showPassword ? Colors.blue : Colors.grey,
                        onPressed: () {
                          setState(() {
                            this._showPassword = !this._showPassword;
                          });
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
                MaterialButton(
                  height: 50.0,
                  onPressed: () async {
                    try {
                      if (_formKey.currentState.validate()) {
                        var user = await _auth.createUserWithEmailAndPassword(
                            email: email, password: password);
                          _reference.add({
                            'Name': name,
                            'Email': email,
                          });
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(builder: (context) => HomePage()));
                      }
                    } on FirebaseAuthException catch (error) {
                      switch (error.code) {
                        case 'weak-password':
                          setState(() {
                            errorMessage = "The password provided is too weak";
                          });
                          break;
                        case "email-already-in-use":
                          setState(() {
                            errorMessage = "Email is already in use";
                          });
                          break;
                      }
                    }
                    if (errorMessage != null) {
                      // ----------------
                    // Scaffold.of(context).showSnackBar(
                    //     SnackBar(
                    //       content: Text(errorMessage),
                    //       backgroundColor: Theme.of(context).errorColor,
                    //     ),
                    //  );
                      print(errorMessage);
                      setState(() {
                        errorMessage = null;
                      });
                    }
                    else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()));
                    }
                  },
                  child: Text(
                    'REGISTER',
                    style: TextStyle(color: Colors.white),
                  ),
                  elevation: 10.0,
                  color: Colors.blue,
                ),
                // checkError ? Text(errorMessage) : Text(''),
                SizedBox(
                  height: 35.0,
                ),
                Flexible(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Already Registered? Login',
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
    );
  }
}

//Checks for valid email address
extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}
