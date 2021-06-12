import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:async';
import 'package:image_cropper/image_cropper.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class ImageCapture extends StatefulWidget {
  @override
  _ImageCaptureState createState() => _ImageCaptureState();
}

class _ImageCaptureState extends State<ImageCapture> {
  File _imageFile;
  Future<String> imageUrl;
  bool isLoading = false;

  Future<void> _pickImage(ImageSource source) async {
    PickedFile selected = await ImagePicker().getImage(source: source);
    setState(() {
      _imageFile = File(selected.path);
    });
  }

  Future<void> _cropImage() async {
    File cropped = await ImageCropper.cropImage(
      sourcePath: _imageFile.path,
    );

    setState(() {
      _imageFile = cropped ?? _imageFile;
    });
  }

  void clear() {
    setState(() {
      _imageFile = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      progressIndicator: CircularProgressIndicator(),
      child: Scaffold(
        bottomNavigationBar: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.photo_camera),
                onPressed: () => _pickImage(ImageSource.camera),
              ),
              IconButton(
                icon: Icon(Icons.photo_library),
                onPressed: () => _pickImage(ImageSource.gallery),
              ),
            ],
          ),
        ),
        body: Column(
          children: <Widget>[
            if (_imageFile != null) ...[
              Flexible(child: Image.file(_imageFile)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  TextButton(
                    child: Icon(Icons.crop),
                    onPressed: _cropImage,
                  ),
                  TextButton(
                    child: Icon(Icons.refresh),
                    onPressed: clear,
                  ),
                ],
              ),
              //  Uploader(_imageFile),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                child: ElevatedButton(
                  child: Text(
                    'Upload Image',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20.0),
                  ),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.lightBlue),
                  ),
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });
                    final FirebaseStorage _storage = FirebaseStorage.instance;
                    var task = await _storage
                        .ref()
                        .child('images/${DateTime.now()}')
                        .putFile(_imageFile);
                    var downloadUrl = task.ref.getDownloadURL();
                    setState(() {
                      imageUrl = downloadUrl;
                      isLoading = false;
                      Navigator.pop(context, imageUrl);
                    });
                  },
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
// class Uploader extends StatefulWidget {
//   var file;
//   Uploader(this.file);
//   @override
//   _UploaderState createState() => _UploaderState();
// }
//
// class _UploaderState extends State<Uploader> {
//   final FirebaseStorage _storage = FirebaseStorage.instance;
//
//   UploadTask _uploadTask;
//   var imageUrl,url;
//   double progressPercent;
//
//   void _startUpload() async{
//
//     String filePath = 'images/${DateTime.now()}.png';
//
//     setState(() {
//       _uploadTask = _storage.ref().child(filePath).putFile(widget.file);
//     });
//     imageUrl = await (await _uploadTask).ref.getDownloadURL();
//     url = imageUrl.toString();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if (_uploadTask != null) {
//       return StreamBuilder<TaskSnapshot>(
//           stream: _uploadTask.snapshotEvents,
//           builder: (_, snapshot) {
//             progressPercent = snapshot != null
//                 ? snapshot.data.bytesTransferred / snapshot.data.totalBytes
//                 : 0;
//             return Row(
//               //  crossAxisAlignment: CrossAxisAlignment.stretch,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 // // Progress bar
//                 // LinearProgressIndicator(value: progressPercent),
//                 // Text(
//                 //     '${(progressPercent * 100).toStringAsFixed(2)} % '
//                 // ),
//                 CircularPercentIndicator(
//                   radius: 60.0,
//                   lineWidth: 4.0,
//                   percent: progressPercent,
//                   center: Text("${(progressPercent * 100).toStringAsFixed(0)} % ",style: TextStyle(fontSize: 16.0),),
//                   progressColor: Colors.green,
//                 ),
//                 SizedBox(width: 15.0),
//                 Text('Uploaded'),
//               ],
//             );
//           });
//     }
//     else {
//       return FlatButton.icon(
//         label: Text('Upload'),
//         icon: Icon(Icons.cloud_upload),
//         onPressed: _startUpload,
//       );
//     }
//   }
// }
