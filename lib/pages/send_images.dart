import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_fadein/flutter_fadein.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_class_api_consumer/helper_widgets_and_functions/expandable_fab.dart';
import 'package:smart_class_api_consumer/services/student_report.dart';

class SendImages extends StatefulWidget {
  const SendImages({Key? key}) : super(key: key);

  @override
  _SendImagesState createState() => _SendImagesState();
}

class _SendImagesState extends State<SendImages> {
  List <XFile>? _imageFileList;

  set _imageFile(XFile? value) {
    _imageFileList = value == null ? null : [value];
  }

  dynamic _pickImageError;

  final ImagePicker _picker = ImagePicker();
  List <String> imagePaths = [];
  //static const _actionTitles = ['Upload Photo(s)', 'Take a Photo'];

  void _onImageButtonPressed(ImageSource source, {bool isMultiImage = false}) async {
    if(isMultiImage) {
      try {
        final pickedFileList = await _picker.pickMultiImage();
        setState(() {
          _imageFileList = pickedFileList;
          for (var element in _imageFileList!) {
            imagePaths.add(element.path);
          }
        });
      } catch (e) {
        setState(() {
          _pickImageError = e;
          print(_pickImageError);
        });
      }
    } else {
      try {
        final pickedFile = await _picker.pickImage(source: source);
        setState(() {
          _imageFile = pickedFile;
          imagePaths.add(pickedFile!.path);
        });
      } catch (e) {
        setState(() {
          _pickImageError = e;
          print(_pickImageError);
        });
      }
    }
  }

  // void _showAction(BuildContext context, int index) {
  //   showDialog<void>(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         content: Text(_actionTitles[index]),
  //         actions: [
  //           TextButton(
  //             onPressed: () => Navigator.of(context).pop(),
  //             child: const Text('CLOSE'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  // Created my own grid building widget function to avoid overpopulating the main function with code.
  Widget imageTemplate(images) {
    return GridView.builder(
      itemCount: images.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (BuildContext context, int index) {
        return Container(
          child: FadeIn(
              duration: Duration(milliseconds: 500),
              curve: Curves.easeIn,
              child: Image.file(File(images[index]), fit: BoxFit.cover,)
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan[50],
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.cyan[50],
        title: Text(
          'Send Images',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 20,
            color: Colors.black,
            letterSpacing: 1.0,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              //padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.teal[100],
              ),
              child: imagePaths.length == 0
                ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'No images added yet!',
                      style: TextStyle(
                        fontSize: 30,
                      ),
                      textAlign: TextAlign.center,
                    )
                  ]
                )
                  : imageTemplate(imagePaths)
              ),
          ),
        ],
      ),
      floatingActionButton: ExpandableFab(
        distance: 112.0,
        children: [
          ActionButton(
            onPressed: () => _onImageButtonPressed(ImageSource.gallery, isMultiImage: true),
            icon: const Icon(Icons.photo_library),
          ),
          ActionButton(
            onPressed: () => _onImageButtonPressed(ImageSource.camera),
            icon: const Icon(Icons.add_a_photo),
          ),
          ActionButton(
            onPressed: () async {
              if (imagePaths.length == 0){
                final snackBar = SnackBar(
                  content: Text("Add some images first!"),
                  duration: Duration(seconds: 2, milliseconds: 500),
                  action: SnackBarAction(
                    label: "Close",
                    onPressed: (){},
                  ),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              } else {
                // Iterate through our images and upload each one and catch any errors that occur
                var counter = 0;
                for (var image in _imageFileList!)
                {
                  try
                  {
                    final uploadResult = await uploadImage(image);
                    if (uploadResult == "CREATED") {
                      setState(() {
                        counter++;
                        print(uploadResult);
                        final snackBar = SnackBar(
                          content: Text("$counter out of ${imagePaths.length} sent!"),
                          duration: Duration(seconds: 2),
                          action: SnackBarAction(
                            label: 'Close',
                            onPressed: (){},
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      });
                    }else {
                      final snackBar = SnackBar(
                        content: Text("Response: $uploadResult"),
                        duration: Duration(seconds: 4, milliseconds: 500),
                        action: SnackBarAction(
                          label: 'Close',
                          onPressed: (){},
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  }
                  catch(e){
                    // Catch any other errors regarding other types of exceptions
                    print("Caught error: $e");
                    final snackBar = SnackBar(
                      content: Text("Failed to send images!"),
                      duration: Duration(seconds: 2, milliseconds: 500),
                      action: SnackBarAction(
                        label: 'Close',
                        onPressed: (){},
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    break; // If we catch any errors during any point of upload we break out
                  }
                }
              }
            },
            icon: const Icon(Icons.upload),
          )
        ],
      ),
    );
  }
}
