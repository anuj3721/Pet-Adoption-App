import 'package:flutter/material.dart';
import 'package:pet_adoption_app/screens/homepage.dart';
import 'package:pet_adoption_app/screens/registration.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginOrRegister extends StatefulWidget {
  @override
  _LoginOrRegisterState createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  FirebaseAuth _auth;
  String email;
  String password;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _auth = FirebaseAuth.instance;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              onChanged: (value) {
                email = value;
                print(email);
              },
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: 'Enter your email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            TextField(
              onChanged: (value) {
                password = value;
                print(password);
              },
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Enter your password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            MaterialButton(
              height: 50.0,
              onPressed: () {
                try {
                  var user = _auth.signInWithEmailAndPassword(
                      email: email, password: password);
                  if (user != null) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
                  }
                } catch (e) {
                  print(e);
                }
              },
              child: Text(
                'LOGIN',
                style: TextStyle(color: Colors.white),
              ),
              elevation: 10.0,
              color: Colors.blue,
            ),
            SizedBox(
              height: 40.0,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RegistrationPage()));
              },
              child: Text(
                'Register Here',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 15.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
