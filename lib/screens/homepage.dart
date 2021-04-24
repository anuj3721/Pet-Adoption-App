import "package:flutter/material.dart";
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pet_adoption_app/screens/catscreen.dart';
import 'package:pet_adoption_app/screens/dogscreen.dart';
import 'package:pet_adoption_app/screens/postscreen.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          children: <Widget>[
            DogScreen(),
            PostScreen(),
            CatScreen(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _currentIndex,
        onItemSelected: (index) {
          setState(() => _currentIndex = index);
          _pageController.jumpToPage(index);
        },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
              title: Text('Dogs'), icon: Icon(FontAwesomeIcons.dog)),
          BottomNavyBarItem(title: Text('Post Pet'), icon: Icon(Icons.add)),
          BottomNavyBarItem(
              title: Text('Cats'), icon: Icon(FontAwesomeIcons.cat)),
        ],
      ),
    );
  }
}
