import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pet_adoption_app/components/petcardnew.dart';
import 'package:pet_adoption_app/screens/descriptionScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DogScreen extends StatefulWidget {
  @override
  _DogScreenState createState() => new _DogScreenState();
}

class _DogScreenState extends State<DogScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  FirebaseAuth _auth;
  CollectionReference _pets;
  List<String> description = [];
  List<int> phoneNumber = [];
  List<String> email = [];
  List<String> petNames = [];
  List<String> sex = [];
  List<String> type = [];
  List<String> address = [];
  List<String> breed = [];
  List<String> url = [];
  List<String> age = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _auth = FirebaseAuth.instance;
    _pets = FirebaseFirestore.instance.collection('Pet Data');

    getData();
    setState(() {});
  }

  void getData() async {
    await _pets.get().then((QuerySnapshot querySnapshot) => {
          querySnapshot.docs.forEach((doc) {
            setState(() {
              if (doc['Type'] == 'Dog') {
                petNames.add(doc['Pet Name']);
                sex.add(doc['Sex']);
                type.add(doc['Type']);
                address.add(doc['Address']);
                breed.add(doc['Breed']);
                age.add(doc['Age']);
                email.add(doc['Email']);
                phoneNumber.add(doc['Phone Number']);
                url.add(doc['url']);
                description.add(doc['Description']);
              }
            });
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: Drawer(
          child: ListTile(
            title: Text('LOGOUT'),
            onTap: () {
              if (_auth.currentUser != null) {
                _auth.signOut();
                Navigator.pop(context);
              }
            },
          ),
        ),
        key: _scaffoldKey,
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.menu),
                    onPressed: () {
                      _scaffoldKey.currentState.openDrawer();
                    },
                  ),
                  Column(
                    children: [
                      Text(
                        'Location',
                      ),
                      Text(
                        'Delhi, India',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                  CircleAvatar(
                    child: Image.asset('images/unknown_account.jpg'),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Material(
                elevation: 18,
                shadowColor: Colors.black,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search by breed',
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: <Widget>[
                      // GestureDetector(
                      //   child: PetCardNew(
                      //     imagePath: 'images/dog0.png',
                      //     petName: 'Bruno',
                      //     breed: 'German Shepherd',
                      //     age: '4',
                      //     distance: '5',
                      //     gender: 'Male',
                      //   ),
                      //   onTap: () {
                      //     Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //         builder: (context) => DescriptionScreen(),
                      //       ),
                      //     );
                      //   },
                      // ),
                      // PetCardNew(
                      //   imagePath: 'images/dog4.png',
                      //   petName: 'Bruno',
                      //   breed: 'German Shepherd',
                      //   age: '5',
                      //   distance: '5',
                      //   gender: 'Male',
                      // ),
                      // PetCardNew(
                      //   imagePath: 'images/dog2.png',
                      //   petName: 'Bruno',
                      //   breed: 'German Shepherd',
                      //   age: '4',
                      //   distance: '5',
                      //   gender: 'Male',
                      // ),
                      ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: petNames.length,
                        itemBuilder: (context, index) {
                          return petNames.length == 0
                              ? null
                              : PetCardNew(
                                  petName: petNames[index],
                                  breed: breed[index],
                                  gender: sex[index],
                                  imagePath: url[index],
                                  age: age[index],
                                );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
