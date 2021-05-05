import 'package:flutter/material.dart';
//import 'package:pet_adoption_app/components/petcard.dart';
import 'package:pet_adoption_app/components/petcardnew.dart';
import 'package:pet_adoption_app/screens/dogDescriptionScreen.dart';

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
                  child: Column(
                    children: <Widget>[
                      GestureDetector(
                        child: PetCardNew(
                          imagePath: 'images/dog0.png',
                          petName: 'Bruno',
                          breed: 'German Shepherd',
                          age: '4',
                          distance: '5',
                          gender: 'male',
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DogDescriptionScreen(),
                            ),
                          );
                        },
                      ),
                      PetCardNew(
                        imagePath: 'images/dog4.png',
                        petName: 'Bruno',
                        breed: 'German Shepherd',
                        age: '5',
                        distance: '5',
                        gender: 'male',
                      ),
                      PetCardNew(
                        imagePath: 'images/dog2.png',
                        petName: 'Bruno',
                        breed: 'German Shepherd',
                        age: '4',
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
