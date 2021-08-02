import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_fadein/flutter_fadein.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_class_api_consumer/services/student_report.dart';

class SendImages extends StatefulWidget {
  const SendImages({Key? key}) : super(key: key);

  @override
  _SendImagesState createState() => _SendImagesState();
}

class _SendImagesState extends State<SendImages> {

  late XFile imageFile;
  late List <XFile?> images = [];
  final ImagePicker _picker = ImagePicker();
  List <String> imagePaths = [];
  //Future<Album>? _futureAlbum;

  void chooseImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);

    setState(() {
      images.add(pickedFile);
      imageFile = pickedFile!;
      imagePaths.add(imageFile.path);
    });
  }

  // Created my own grid building widget function to avoid overpopulating the main function with code.
  Widget imageTemplate(images) {
    return GridView.builder(
      itemCount: images.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
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
          SizedBox(height: 10),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Container(
                //padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.teal[100],
                  borderRadius: BorderRadius.all(Radius.circular(20)),
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
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton.icon(
                onPressed: () {
                  chooseImage(ImageSource.gallery);
                },
                icon: Icon(
                  Icons.upload_file,
                  color: Colors.white,
                ),
                label: Text(
                  'Add images',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    fontSize: 23,
                    color: Colors.white,
                  ),
                ),
                style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(5)),
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.teal),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.teal),
                        )
                    )
                ),
              ),
              SizedBox(width: 20),
              TextButton.icon(
                onPressed: () async {
                  for (var image in images)
                    {
                      final uploadResult = await uploadImage(image);
                      setState(() {
                        //_futureAlbum = createAlbum('My Test');
                        print(uploadResult);
                        //print(_futureAlbum);
                        //Navigator.pushReplacementNamed(context, '/reports', arguments: _futureAlbum);
                      });
                    }
                },
                icon: Icon(
                  Icons.send,
                  color: Colors.white,
                ),
                label: Text(
                  'Send',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    fontSize: 23,
                    color: Colors.white,
                  ),
                ),
                style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(5)),
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.teal),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.teal),
                        )
                    )
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
