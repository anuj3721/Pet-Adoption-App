import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pet_adoption_app/screens/homepage.dart';
import 'package:pet_adoption_app/screens/editScreen.dart';

class ManageDogPostsScreen extends StatefulWidget {
  @override
  _ManageDogPostsState createState() => new _ManageDogPostsState();
}

class _ManageDogPostsState extends State<ManageDogPostsScreen> {

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
  List<String> city = [];
  List<String> petIDs = [];
  List<String> favoritePetIDs = [];
  List<String> usernames = [];
  List<Timestamp> timestamps = [];
  String userID;
  String username;
  // var uid;

  void clearData() {
    setState(() {
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
      petIDs.clear();
      favoritePetIDs.clear();
      usernames.clear();
      timestamps.clear();
    });
  }

  void myPostsCallback() {
    setState(() {
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
      timestamps.clear();
      usernames.clear();
      getMyData();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('Init gets called');
    _auth = FirebaseAuth.instance;
    _pets = FirebaseFirestore.instance.collection('Pet Data');
    //  print(_auth.currentUser.uid);
    //  uid = _auth.currentUser.uid;
    // _favorite = FirebaseFirestore.instance.collection('User Data');
    // if (_auth.currentUser != null) {
    //   getDocumentID();
    // }
     getMyData();
    // getUsernames();
    setState(() {});
  }
  void getMyData() async {
  await _pets.get().then((QuerySnapshot querySnapshot) => {
    querySnapshot.docs.forEach((doc) {
      setState(() {
        //  print(_pets.doc().id);
          if (doc['Email'].contains(_auth.currentUser.email)) {
            petNames.add(doc['Pet Name']);
            sex.add(doc['Sex']);
            petIDs.add(doc.id);
            type.add(doc['Type']);
            address.add(doc['Address']);
            breed.add(doc['Breed']);
            age.add(doc['Age']);
            email.add(doc['Email']);
            phoneNumber.add(doc['Phone Number']);
            url.add(doc['url']);
            description.add(doc['Description']);
            city.add(doc['City']);
            timestamps.add(doc['timestamp']);
        }
      });
    })
  });
  // getUsernames();
  setState(() {});
}

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text('Manage Posts'),
            centerTitle: true,
            leading: IconButton(
              icon: Icon(Icons.arrow_back,size: 26,),
              onPressed: (){
                Navigator.push(context,MaterialPageRoute(builder: (context) => HomePage()));
              },
            ),
          ),
          body: Container(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              physics: BouncingScrollPhysics(),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20,),
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: petNames.length,
                    itemBuilder: (context, index) {
                      return petNames.length == 0
                          ? null
                          : Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Column(
                              children: [
                                ListTile(
                                  title: Text(
                                      petNames[index],
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                  leading: CircleAvatar(
                                    radius: 30.0,
                                    backgroundImage: NetworkImage(url[index]),
                                  ),
                                  trailing: Wrap(
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.edit,
                                          size: 25,
                                        ),
                                        onPressed: ()
                                        {
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => EditScreen(
                                            description: description[index],
                                          phoneNumber: (phoneNumber[index]).toString(),
                                          petNames: petNames[index],
                                          sex: sex[index],
                                          type: type[index],
                                          address: address[index],
                                          breed: breed[index],
                                          url: url[index],
                                          age: age[index],
                                          city: city[index],
                                          petIDs: petIDs[index],
                                          timestamps: timestamps[index],
                                          )));
                                        },
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.delete,
                                          size: 25,
                                        ),
                                        onPressed: ()
                                        {
                                          Widget cancelButton = TextButton(
                                            child: Text("No"),
                                            onPressed:  () {
                                              Navigator.of(context).pop();
                                            },
                                          );
                                          Widget continueButton = TextButton(
                                            child: Text("Yes"),
                                            onPressed:  () {
                                              _pets.doc(petIDs[index]).delete();
                                              Navigator.of(context).pop();
                                              setState(() {
                                                clearData();
                                                getMyData();
                                              });
                                            },
                                          );
                                          // set up the AlertDialog
                                          AlertDialog alert = AlertDialog(
                                            content: Text("Are you sure you want to delete this item?"),
                                            actions: [
                                              cancelButton,
                                              continueButton,
                                            ],
                                          );
                                          // show the dialog
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return alert;
                                            },
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(
                                  height: 15,
                                ),
                              ],
                            ),
                          );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}