import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
// import 'package:carousel_slider/carousel_slider.dart';

class DescriptionScreen extends StatelessWidget {
  String description;
  int phoneNumber;
  String email;
  String petNames;
  String sex;
  String type;
  String address;
  String breed;
  String url;
  String age;
  DescriptionScreen(
      {this.description,
      this.petNames,
      this.sex,
      this.address,
      this.breed,
      this.url,
      this.age});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 5,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    alignment: Alignment.center,
                    // color: Colors.green[200],
                    // child: CarouselSlider(
                    //   options: CarouselOptions(),
                    //   items: imgList
                    //       .map(
                    //         (item) => Container(
                    //           child: Center(
                    //             child: Image.asset(item, fit: BoxFit.cover),
                    //           ),
                    //         ),
                    //       )
                    //       .toList(),
                    // ),
                    child: PhotoView(
                        imageProvider: NetworkImage(url),
                      customSize: MediaQuery.of(context).size,
                      backgroundDecoration: BoxDecoration(color: Colors.white),
                    ),
                  ),
                  Positioned(
                    top: 15,
                    left: 15,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CircleAvatar(
                            child: Image.asset('images/unknown_account.jpg'),
                            radius: 35.0,
                          ),
                          Text(
                            ' Anuj Pandey \n Owner',
                            style: TextStyle(
                              fontSize: 18.0,
                            ),
                          ),
                          SizedBox(
                            width: 65.0,
                          ),
                          Text(
                            '10 June, 2021',
                            style: TextStyle(
                              fontSize: 18.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Container(
                          child: Text(
                            description,
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
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
