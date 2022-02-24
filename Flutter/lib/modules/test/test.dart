import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  File? imageFile;

  var base64Imageteam;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> _showSelectionDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text("From where do you want to take the photo?"),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    GestureDetector(
                      child: Text("Gallery"),
                      onTap: () {
                        _getFromGallery();
                        Navigator.pop(context);
                      },
                    ),
                    Padding(padding: EdgeInsets.all(8.0)),
                    GestureDetector(
                      child: Text("Camera"),
                      onTap: () {
                        _getFromCamera();
                        Navigator.pop(context);
                      },
                    ),
                    Padding(padding: EdgeInsets.all(8.0)),
                    GestureDetector(
                      child: Text("File"),
                      onTap: () {
                        _getFromFile();
                        Navigator.pop(context);
                      },
                    )
                  ],
                ),
              ));
        });
  }

  /// Get from gallery
  _getFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
        print("imageFile----------------------------->$imageFile");

        List<int> imageBytes = imageFile!.readAsBytesSync();
        base64Imageteam = base64Encode(imageBytes);
        print(base64Imageteam);
        // updatimge(base64Image, id);
      });
    }
  }

  /// Get from File
  _getFromFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      imageFile = File(result.files.single.path!);

      print("File----------------------------->$imageFile");

      List<int> fileBytes = imageFile!.readAsBytesSync();
      base64Imageteam = base64Encode(fileBytes);
      print(base64Imageteam);
      print(imageFile!.path);
    } else {
      // User canceled the picker
    }
  }

  /// Get from Camera
  _getFromCamera() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
        // print("imageFile----------------------------->$imageFile");
        // List<int> imageBytes = imageFile.readAsBytesSync();
        // print("dddd$imageBytes");
        // base64Image = base64UrlEncode(imageBytes);
        List<int> imageBytes = imageFile!.readAsBytesSync();
        base64Imageteam = base64Encode(imageBytes);
        print(base64Imageteam);

        // updatimge(base64Image, id);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
