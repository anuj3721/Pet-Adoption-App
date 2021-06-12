import 'package:flutter/material.dart';
import 'dart:math';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PetCardNew extends StatelessWidget {
  String petId;
  String petName = '';
  String breed = '';
  String age = '';
  String distance = '';
  String gender = '';
  String imagePath = '';

  PetCardNew({
    this.petId,
    this.petName,
    this.breed,
    this.age = '4',
    this.distance = '5',
    this.gender,
    this.imagePath,
  });

  final colors = [
    Colors.blueGrey[200],
    Colors.green[200],
    Colors.pink[100],
    Colors.brown[200],
    Colors.lightBlue[200],
  ];

  Random _random = new Random();

  @override
  Widget build(BuildContext context) {
    final randomColor = colors[_random.nextInt(colors.length)];
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0), color: randomColor),
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      width: double.infinity,
      height: 240.0,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
              child: Material(
                elevation: 10.0,
                child: Image.network(imagePath),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        petName,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
                      Icon(
                        gender == 'Male'
                            ? FontAwesomeIcons.mars
                            : FontAwesomeIcons.venus,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                    ],
                  ),
                ),
                Text(
                  breed,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
                Text(
                  age + " Years",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.location_pin,
                      size: 16.0,
                      color: Colors.white,
                    ),
                    Text(
                      ' Distance: ' + distance + ' Km',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
