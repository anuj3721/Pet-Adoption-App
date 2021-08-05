import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:pet_adoption_app/screens/homepage.dart';
import 'package:pet_adoption_app/screens/loginORregister.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

String _sex;

class EditScreen extends StatefulWidget {

  String sex;
  String type;
  String breed;
  String description;
  String address;
  String phoneNumber;
  String age;
  String ageUnit;
  String city;
  String ownerName;
  String petIDs;
  String url;
  Timestamp timestamps;
  String petNames;

  EditScreen({
  this.description,
  this.phoneNumber,
  this.petNames,
  this.sex,
  this.type,
  this.address,
  this.breed,
  this.url,
  this.age,
  this.city,
  this.petIDs,
  this.timestamps,
  });

  @override
  _EditScreenState createState() => _EditScreenState(
  );
}

class _EditScreenState extends State<EditScreen> {
  CollectionReference _reference;
  FirebaseAuth _auth;
  bool isLoading = false;
  String imageUrl;
  bool isUploaded = false;
  final _formKey = GlobalKey<FormState>();
  CollectionReference _users;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _auth = FirebaseAuth.instance;
    _reference = FirebaseFirestore.instance.collection('Pet Data');
    _users = FirebaseFirestore.instance.collection('User Data');
    if (_auth.currentUser == null) {
      Timer.run(() {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => LoginOrRegister()));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ModalProgressHUD(
          inAsyncCall: isLoading,
          child: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 30.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Material(
                      elevation: 10.0,
                      child: Container(
                        alignment: Alignment.center,
                        height: 50.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          color: Colors.teal,
                        ),
                        width: double.infinity,
                        child: Text(
                          'Pet Details',
                          style: TextStyle(color: Colors.white, fontSize: 20.0),
                        ),
                      ),
                    ),
                    // TypeDropDown(),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: TextFormField(
                        initialValue: widget.petNames,
                        onChanged: (value) {
                          widget.petNames = value;
                          print(widget.petNames);
                        },
                        decoration: InputDecoration(
                            labelText: 'Enter Pet Name',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0))),
                        // The validator receives the text that the user has entered.
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: TextFormField(
                        initialValue: widget.breed,
                        onChanged: (value) {
                          widget.breed = value;
                          print(widget.breed);
                        },
                        decoration: InputDecoration(
                            labelText: 'Breed',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0))),
                        // The validator receives the text that the user has entered.
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: TextFormField(
                        initialValue: widget.age,
                        onChanged: (value) {
                          widget.age = value;
                          print(widget.age);
                        },
                        decoration: InputDecoration(
                            labelText: 'Age',
                            border: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.circular(10.0))),
                        // The validator receives the text that the user has entered.
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: TextFormField(
                        initialValue: widget.city,
                        onChanged: (value) {
                          widget.city = value;
                          print(widget.city);
                        },
                        decoration: InputDecoration(
                            labelText: 'City',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0))),
                        // The validator receives the text that the user has entered.
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                    ),
                    SexDropDown(sex: widget.sex),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: TextFormField(
                        initialValue: widget.description,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        onChanged: (value) {
                          widget.description = value;
                          print(widget.description);
                        },
                        decoration: InputDecoration(
                            labelText: 'Description',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0))),
                        // The validator receives the text that the user has entered.
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                    ),
                    Material(
                      elevation: 10.0,
                      child: Container(
                        alignment: Alignment.center,
                        height: 50.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          color: Colors.teal,
                        ),
                        width: double.infinity,
                        child: Text(
                          'Owner Details',
                          style: TextStyle(color: Colors.white, fontSize: 20.0),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: TextFormField(
                        initialValue: widget.address,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        onChanged: (value) {
                          widget.address = value;
                          print(widget.address);
                        },
                        decoration: InputDecoration(
                            labelText: 'Address',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0))),
                        // The validator receives the text that the user has entered.
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: TextFormField(
                        initialValue: widget.phoneNumber,
                        onChanged: (value) {
                          widget.phoneNumber = value;
                          print(widget.phoneNumber);
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            labelText: 'Phone Number',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0))),
                        // The validator receives the text that the user has entered.
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          if (value.length != 10) {
                            return 'Enter 10 digit phone number';
                          }
                          return null;
                        },
                      ),
                    ),
                    // CitySearchDropdown(),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: TextFormField(
                        initialValue: widget.city,
                        onChanged: (value) {
                          widget.city = value;
                          print(widget.city);
                        },
                        decoration: InputDecoration(
                            labelText: 'City',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0))),
                        // The validator receives the text that the user has entered.
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                    ),
                    // Padding(
                    //   padding: EdgeInsets.symmetric(vertical: 10.0),
                    //   child: TextButton(
                    //     onPressed: () async {
                    //       var result;
                    //       if (!isUploaded) {
                    //         result = await Navigator.push(
                    //           context,
                    //           MaterialPageRoute(
                    //             builder: (context) => ImageCapture(),
                    //           ),
                    //         );
                    //       } else if (isUploaded) {
                    //         ScaffoldMessenger.of(context).showSnackBar(
                    //           SnackBar(
                    //             content: Text('Image already uploaded',
                    //                 textAlign: TextAlign.center),
                    //             backgroundColor: Theme.of(context).errorColor,
                    //           ),
                    //         );
                    //       }
                    //       setState(() {
                    //         if (imageUrl == null) imageUrl = result;
                    //         isUploaded = true;
                    //       });
                    //     },
                    //     child: !isUploaded
                    //         ? Text(
                    //       'Upload Image',
                    //       style: TextStyle(
                    //           color: Colors.white, fontSize: 20.0),
                    //     )
                    //         : ListTile(
                    //       title: Text(
                    //         'Uploaded',
                    //         style: TextStyle(
                    //             color: Colors.white, fontSize: 20.0),
                    //       ),
                    //       trailing:
                    //       Icon(Icons.check_circle_outline_rounded),
                    //     ),
                    //     style: TextButton.styleFrom(
                    //       minimumSize: Size(double.infinity, 50.0),
                    //       backgroundColor:
                    //       isUploaded ? Colors.green : Colors.blue,
                    //       elevation: 10.0,
                    //     ),
                    //   ),
                    // ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: TextButton(
                        onPressed: () {
                          print('submit pressed');
                          // Validate returns true if the form is valid, or false otherwise.
                          if (_formKey.currentState.validate()) {
                            setState(() {
                              isLoading = true;
                            });
                            _reference.doc(widget.petIDs).update({
                              'Address': widget.address,
                              'Breed': widget.breed,
                              'Description': widget.description,
                              'Email': _auth.currentUser.email,
                              'Pet Name': widget.petNames,
                              'Phone Number': int.parse(widget.phoneNumber),
                              'Sex': (_sex == null) ? widget.sex : _sex,
                              // 'Type': _type,
                              // 'url': imageUrl,
                              'Age': widget.age,
                              'City': widget.city,
                              'timestamp': Timestamp.fromDate(DateTime.now()).toDate(),
                              // 'Owner': widget.ownerName,
                            });
                            setState(() {
                              isLoading = false;
                              isUploaded = false;
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage()),
                              );
                            });
                          }
                        },
                        child: Text(
                          'Submit',
                          style: TextStyle(color: Colors.white, fontSize: 20.0),
                        ),
                        style: TextButton.styleFrom(
                          minimumSize: Size(double.infinity, 50.0),
                          backgroundColor: Colors.blue,
                          elevation: 10.0,
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
  bool isValidEmail() {
    return RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}

//Sex Drop Down

class SexDropDown extends StatefulWidget {
  String sex;
  SexDropDown({this.sex});
  @override
  State<SexDropDown> createState() => _SexDropDownState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _SexDropDownState extends State<SexDropDown> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.0,
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      margin: EdgeInsets.symmetric(vertical: 10.0),
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border(
              top: BorderSide(color: Colors.grey),
              left: BorderSide(color: Colors.grey),
              bottom: BorderSide(color: Colors.grey),
              right: BorderSide(color: Colors.grey))),
      child: Center(
        child: DropdownButtonHideUnderline(
          child: DropdownButtonFormField<String>(
            isExpanded: true,
            focusColor: Colors.white,
            value: (_sex == null) ? widget.sex : _sex,
            style: TextStyle(color: Colors.white),
            iconEnabledColor: Colors.black,
            items: <String>[
              'Male',
              'Female',
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: TextStyle(color: Colors.black),
                ),
              );
            }).toList(),
            hint: Text(
              "Choose the Pet gender",
              style: TextStyle(
                color: Colors.teal.shade900,
                fontSize: 14,
              ),
            ),
            onChanged: (String value) {
              setState(() {
                _sex = value;
                print(_sex);
              });
            },
          ),
        ),
      ),
    );
  }
}