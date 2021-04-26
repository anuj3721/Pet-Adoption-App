import 'package:flutter/material.dart';
import 'package:pet_adoption_app/components/petcard.dart';
import 'package:pet_adoption_app/components/petcardnew.dart';

class DogScreen extends StatefulWidget {
  @override
  _DogScreenState createState() => new _DogScreenState();
}

class _DogScreenState extends State<DogScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: new Scaffold(
        drawer: Drawer(),
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
                  Text(
                    'Location\nDelhi, India',
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.teal,
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
                  child: Column(
                    children: <Widget>[
                      PetCardNew(
                        imagePath: 'images/dog0.png',
                        petName: 'Bruno',
                        breed: 'German Shepherd',
                        age: '7',
                        distance: '5',
                        gender: 'male',
                      ),
                      PetCardNew(
                        imagePath: 'images/sampleDog.jpg',
                        petName: 'Bruno',
                        breed: 'German Shepherd',
                        age: '7',
                        distance: '5',
                        gender: 'male',
                      ),
                      PetCardNew(
                        imagePath: 'images/dog0.png',
                        petName: 'Bruno',
                        breed: 'German Shepherd',
                        age: '7',
                        distance: '5',
                        gender: 'male',
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
