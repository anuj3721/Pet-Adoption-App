import 'package:flutter/material.dart';
import 'dart:math';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PetCardNew extends StatelessWidget {
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
                child: Image.asset('images/dog0.png'),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'This is Bruno',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
