import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:pet_adoption_app/components/indianCities.dart';
import 'package:pet_adoption_app/screens/homepage.dart';
import 'package:pet_adoption_app/screens/imageCapture.dart';
import 'package:pet_adoption_app/screens/loginORregister.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:searchable_dropdown/searchable_dropdown.dart';

String _sex;
String _type;
String _petName;
String _breed;
String _description;
String _address;
String _phoneNumber;
String _age;
String _ageUnit;
String _selectedCityValue;
String _ownerName;

class PostScreen extends StatefulWidget {
  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  CollectionReference _reference;
  FirebaseAuth _auth;
  bool isLoading = false;
  String imageUrl;
  bool isUploaded = false;
  final _formKey = GlobalKey<FormState>();
  CollectionReference _users;

  void getOwnerName() async {
    await _users
        .get()
        .then((QuerySnapshot snapshot) => snapshot.docs.forEach((doc) {
              if (doc['Email'] == _auth.currentUser.email) {
                _ownerName = doc['Name'];
                print(_ownerName);
              }
            }));
  }

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
    getOwnerName();
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
                    TypeDropDown(),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: TextFormField(
                        onTap: () {
                          FocusScopeNode currentFocus = FocusScope.of(context);
                          if (!currentFocus.hasPrimaryFocus) {
                            currentFocus.unfocus();
                          }
                        },
                        onChanged: (value) {
                          _petName = value;
                          print(_petName);
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
                        onChanged: (value) {
                          _breed = value;
                          print(_breed);
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
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.0),
                            child: TextFormField(
                              onChanged: (value) {
                                _age = value;
                                print(_age);
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
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Expanded(
                          child: AgeDropDown(),
                        ),
                      ],
                    ),
                    SexDropDown(),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: TextFormField(
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        onTap: () {
                          FocusScopeNode currentFocus = FocusScope.of(context);
                          if (!currentFocus.hasPrimaryFocus) {
                            currentFocus.unfocus();
                          }
                        },
                        onChanged: (value) {
                          _description = value;
                          print(_description);
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
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        onTap: () {
                          FocusScopeNode currentFocus = FocusScope.of(context);
                          if (!currentFocus.hasPrimaryFocus) {
                            currentFocus.unfocus();
                          }
                        },
                        onChanged: (value) {
                          _address = value;
                          print(_address);
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
                        onTap: () {
                          FocusScopeNode currentFocus = FocusScope.of(context);
                          if (!currentFocus.hasPrimaryFocus) {
                            currentFocus.unfocus();
                          }
                        },
                        onChanged: (value) {
                          _phoneNumber = value;
                          print(_phoneNumber);
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
                    CitySearchDropdown(),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: TextButton(
                        onPressed: () async {
                          var result;
                          if (!isUploaded) {
                            result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ImageCapture(),
                              ),
                            );
                          } else if (isUploaded) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Image already uploaded',
                                    textAlign: TextAlign.center),
                                backgroundColor: Theme.of(context).errorColor,
                              ),
                            );
                          }
                          setState(() {
                            if (imageUrl == null) imageUrl = result;
                            isUploaded = true;
                          });
                        },
                        child: !isUploaded
                            ? Text(
                                'Upload Image',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20.0),
                              )
                            : ListTile(
                                title: Text(
                                  'Uploaded',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20.0),
                                ),
                                trailing:
                                    Icon(Icons.check_circle_outline_rounded),
                              ),
                        style: TextButton.styleFrom(
                          minimumSize: Size(double.infinity, 50.0),
                          backgroundColor:
                              isUploaded ? Colors.green : Colors.blue,
                          elevation: 10.0,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: TextButton(
                        onPressed: () {
                          // Validate returns true if the form is valid, or false otherwise.
                          if (_formKey.currentState.validate()) {
                            setState(() {
                              isLoading = true;
                            });
                            _reference.add({
                              'Address': _address,
                              'Breed': _breed,
                              'Description': _description,
                              'Email': _auth.currentUser.email,
                              'Pet Name': _petName,
                              'Phone Number': int.parse(_phoneNumber),
                              'Sex': _sex,
                              'Type': _type,
                              'url': imageUrl,
                              'Age': _age + ' ' + _ageUnit,
                              'City': _selectedCityValue,
                              'timestamp':
                                  Timestamp.fromDate(DateTime.now()).toDate(),
                              'Owner': _ownerName,
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
            value: _sex,
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

//Type Drop Down

class TypeDropDown extends StatefulWidget {
  @override
  State<TypeDropDown> createState() => _TypeDropDownState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _TypeDropDownState extends State<TypeDropDown> {
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
            value: _type,
            style: TextStyle(color: Colors.white),
            iconEnabledColor: Colors.black,
            items: <String>[
              'Dog',
              'Cat',
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
              "Choose the Pet type",
              style: TextStyle(
                color: Colors.teal.shade900,
                fontSize: 14,
              ),
            ),
            onChanged: (String value) {
              setState(() {
                _type = value;
                print(_type);
              });
            },
          ),
        ),
      ),
    );
  }
}

//Age Drop Down

class AgeDropDown extends StatefulWidget {
  @override
  State<AgeDropDown> createState() => _AgeDropDownState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _AgeDropDownState extends State<AgeDropDown> {
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
          right: BorderSide(color: Colors.grey),
        ),
      ),
      child: Center(
        child: DropdownButtonHideUnderline(
          child: DropdownButtonFormField<String>(
            isExpanded: true,
            focusColor: Colors.white,
            value: _ageUnit,
            style: TextStyle(color: Colors.white),
            iconEnabledColor: Colors.black,
            items: <String>[
              'Weeks',
              'Months',
              'Years',
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
              "Unit",
              style: TextStyle(
                color: Colors.teal.shade900,
                fontSize: 14,
              ),
            ),
            onChanged: (String value) {
              setState(() {
                _ageUnit = value;
                print(_ageUnit);
              });
            },
          ),
        ),
      ),
    );
  }
}

//Searchable City Drop Down

class CitySearchDropdown extends StatefulWidget {
  @override
  _CitySearchDropdownState createState() => _CitySearchDropdownState();
}

class _CitySearchDropdownState extends State<CitySearchDropdown> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.0,
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      margin: EdgeInsets.symmetric(vertical: 10.0),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border(
          top: BorderSide(color: Colors.grey),
          left: BorderSide(color: Colors.grey),
          bottom: BorderSide(color: Colors.grey),
          right: BorderSide(color: Colors.grey),
        ),
      ),
      child: Center(
        child: SearchableDropdown.single(
          items: Cities()
              .returnCities()
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          value: _selectedCityValue,
          hint: "Choose your city",
          searchHint: "Choose your city",
          onChanged: (value) {
            setState(() {
              _selectedCityValue = value;
              print(_selectedCityValue);
            });
          },
          isExpanded: true,
        ),
      ),
    );
  }
}
