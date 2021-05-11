import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pet_adoption_app/screens/loginORregister.dart';
import 'dart:async';

class PostScreen extends StatefulWidget {
  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (FirebaseAuth.instance.currentUser == null) {
      Timer.run(() {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => LoginOrRegister()));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
