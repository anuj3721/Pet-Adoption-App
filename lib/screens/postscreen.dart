import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pet_adoption_app/screens/imageCapture.dart';
// import 'dart:io';
// import 'package:image_picker/image_picker.dart';
//import 'package:firebase_storage/firebase_storage.dart';
// import 'package:pet_adoption_app/screens/dogscreen.dart';
// import 'package:pet_adoption_app/screens/loginORregister.dart';
// import 'dart:async';
// import 'package:image_cropper/image_cropper.dart';
// import 'package:percent_indicator/percent_indicator.dart';


class PostScreen extends StatefulWidget {
  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   if (FirebaseAuth.instance.currentUser == null) {
  //     Timer.run(() {
  //       Navigator.push(context,
  //           MaterialPageRoute(builder: (context) => LoginOrRegister()));
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return ImageCapture();
  }
}