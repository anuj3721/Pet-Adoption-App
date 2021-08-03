import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:photo_view/photo_view.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';
// import 'package:carousel_slider/carousel_slider.dart';

class DescriptionScreen extends StatefulWidget {
  String description;
  int phoneNumber;
  String petNames;
  String sex;
  String address;
  String breed;
  String url;
  String age;
  String city;
  String email;
  String type;
  String userID;
  String petID;
  String userName;
  Timestamp timestamp;

  DescriptionScreen({
    this.description,
    this.petNames,
    this.sex,
    this.address,
    this.breed,
    this.url,
    this.age,
    this.city,
    this.phoneNumber,
    this.userID,
    this.petID,
    this.userName,
    this.timestamp,
  });

  @override
  _DescriptionScreenState createState() => _DescriptionScreenState();
}

class _DescriptionScreenState extends State<DescriptionScreen> {
  bool isSaved = false;
  String deletionID;
  CollectionReference _reference;

  void checkIfSaved() async {
    await _reference.get().then((QuerySnapshot snapshot) => {
          snapshot.docs.forEach((doc) {
            if (doc['Pet ID'] == widget.petID) {
              isSaved = true;
              deletionID = doc.id;
              print(deletionID);
            }
          })
        });
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.petID);
    _reference = FirebaseFirestore.instance
        .collection('User Data')
        .doc(widget.userID)
        .collection('Favorite Pets');

    checkIfSaved();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Positioned.fill(
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 60, horizontal: 30),
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: PhotoView(
                              imageProvider: NetworkImage(widget.url),
                              customSize: MediaQuery.of(context).size,
                              backgroundDecoration:
                                  BoxDecoration(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.white,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 100,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: 20,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  backgroundImage:
                                      AssetImage('images/unknown_account.jpg'),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.userName,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17),
                                    ),
                                    Text(
                                      'Owner',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                                Expanded(child: Container()),
                                Text(
                                  DateFormat.yMMMd()
                                      .format(widget.timestamp.toDate()),
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: 20,
                            ),
                            child: Text(
                              widget.description,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 17,
                                height: 1.7,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 110,
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      blurRadius: 30,
                      offset: Offset(0, 10),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.petNames,
                          style: TextStyle(
                            //   color: fadedBlack,
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              widget.sex,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(width: 10.0),
                            Icon(
                              widget.sex == 'female'
                                  ? FontAwesomeIcons.venus
                                  : FontAwesomeIcons.mars,
                              size: 20,
                              color: Colors.black54,
                            ),
                          ],
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.breed,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          widget.age,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.location_pin,
                          size: 18,
                          color: Colors.blueGrey,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          widget.address + ', ' + widget.city,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 30),
                      decoration: BoxDecoration(
                        // color: Colors.blue,
                        color: Color(0xFF416D6C),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.25),
                            blurRadius: 10,
                            offset: Offset(0, 10),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.favorite,
                          size: 27,
                          color: isSaved ? Colors.red : Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            if (!isSaved) {
                              _reference.add({
                                'Pet ID': widget.petID,
                              });
                              checkIfSaved();
                            } else {
                              _reference.doc(deletionID).delete();
                              checkIfSaved();
                            }
                            isSaved = !isSaved;
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                          // color: Colors.blue,
                          color: Color(0xFF416D6C),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.25),
                              blurRadius: 30,
                              offset: Offset(0, 10),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        //    color: Colors.blueAccent,
                        margin: EdgeInsets.only(right: 50),
                        child: Row(
                          children: [
                            Text(
                              ' Contact',
                              style:
                                  TextStyle(fontSize: 25, color: Colors.white),
                            ),
                            SizedBox(width: 10),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(0.0),
                                  child: ElevatedButton(
                                    child: Icon(
                                      Icons.message,
                                      size: 20,
                                      color: Colors.white,
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      shape: CircleBorder(),
                                      primary: Colors.yellow.shade700,
                                      onPrimary: Colors.red,
                                    ),
                                    onPressed: () async {
                                      await canLaunch(
                                              'sms:+91${widget.phoneNumber}')
                                          ? await launch(
                                              'sms:+91${widget.phoneNumber}')
                                          : throw 'Could not launch';
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(0.0),
                                  child: ElevatedButton(
                                    child: Icon(
                                      Icons.call,
                                      size: 20,
                                      color: Colors.white,
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      shape: CircleBorder(),
                                      primary: Colors.green,
                                      onPrimary: Colors.red,
                                    ),
                                    onPressed: () async {
                                      print(widget.phoneNumber);
                                      await canLaunch(
                                              'tel:+91${widget.phoneNumber}')
                                          ? await launch(
                                              'tel:+91${widget.phoneNumber}')
                                          : throw 'Could not launch';
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// final List<Widget> imageSliders = imgList
//     .map(
//       (item) => Container(
//         child: Container(
//           margin: EdgeInsets.all(5.0),
//           child: ClipRRect(
//             borderRadius: BorderRadius.all(Radius.circular(5.0)),
//             child: Stack(
//               children: <Widget>[
//                 Image.asset(item, fit: BoxFit.cover),
//                 Positioned(
//                   bottom: 0.0,
//                   left: 0.0,
//                   right: 0.0,
//                   child: Container(
//                     decoration: BoxDecoration(
//                       gradient: LinearGradient(
//                         colors: [
//                           Color.fromARGB(200, 0, 0, 0),
//                           Color.fromARGB(0, 0, 0, 0)
//                         ],
//                         begin: Alignment.bottomCenter,
//                         end: Alignment.topCenter,
//                       ),
//                     ),
//                     padding:
//                         EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
//                     child: Text(
//                       'No. ${imgList.indexOf(item)} image',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 20.0,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     )
//     .toList();
