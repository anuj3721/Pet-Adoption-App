import 'package:flutter/material.dart';
import 'package:pet_adoption_app/components/petcardnew.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pet_adoption_app/screens/descriptionScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:pet_adoption_app/components/indianCities.dart';

class CatScreen extends StatefulWidget {
  @override
  _CatScreenState createState() => new _CatScreenState();
}

class _CatScreenState extends State<CatScreen> {
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
  List<String> age = [];
  List<String> url = [];
  List<String> city = [];
  String _selectedCityValue;

  void cityCallback(newCityValue) {
    print(newCityValue);
    setState(() {
      _selectedCityValue = newCityValue;
      description.clear();
      phoneNumber.clear();
      email.clear();
      petNames.clear();
      sex.clear();
      type.clear();
      address.clear();
      breed.clear();
      url.clear();
      age.clear();
      city.clear();
      getData();
    });
  }

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
              if (_selectedCityValue == null) {
                if (doc['Type'] == 'Cat') {
                  petNames.add(doc['Pet Name']);
                  sex.add(doc['Sex']);
                  type.add(doc['Type']);
                  address.add(doc['Address']);
                  breed.add(doc['Breed']);
                  age.add(doc['Age']);
                  email.add(doc['Email']);
                  phoneNumber.add(doc['Phone Number']);
                  description.add(doc['Description']);
                  url.add(doc['url']);
                  city.add(doc['City']);
                }
              } else {
                if (doc['Type'] == 'Cat' &&
                    doc['City'].contains(_selectedCityValue)) {
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
                  city.add(doc['City']);
                }
              }
            });
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: new Scaffold(
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
                  Expanded(
                    flex: 1,
                    child: IconButton(
                      icon: Icon(Icons.menu),
                      onPressed: () {
                        _scaffoldKey.currentState.openDrawer();
                      },
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: CitySearchDropdown(
                      callback: cityCallback,
                      selectedCity: _selectedCityValue,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: CircleAvatar(
                      child: Image.asset('images/unknown_account.jpg'),
                    ),
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
                              : GestureDetector(
                                  child: PetCardNew(
                                    petName: petNames[index],
                                    breed: breed[index],
                                    gender: sex[index],
                                    imagePath: url[index],
                                    age: age[index],
                                    city: city[index],
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DescriptionScreen(
                                          petNames: petNames[index],
                                          address: address[index],
                                          breed: breed[index],
                                          sex: sex[index],
                                          url: url[index],
                                          description: description[index],
                                          age: age[index],
                                          city: city[index],
                                        ),
                                      ),
                                    );
                                  },
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

//Searchable City Drop Down

class CitySearchDropdown extends StatelessWidget {
  final String selectedCity;
  final Function callback;
  CitySearchDropdown({this.callback, this.selectedCity});

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
          value: selectedCity,
          hint: "Choose your city",
          searchHint: "Choose your city",
          onChanged: callback,
          isExpanded: true,
        ),
      ),
    );
  }
}
