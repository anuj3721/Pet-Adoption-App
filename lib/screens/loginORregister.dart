import 'package:flutter/material.dart';
import 'package:pet_adoption_app/screens/registration.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginOrRegister extends StatefulWidget {
  @override
  _LoginOrRegisterState createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  FirebaseAuth _auth;

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
              onPressed: () {},
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
