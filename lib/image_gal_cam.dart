import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageFromGalCam extends StatefulWidget {
  const ImageFromGalCam({Key? key}) : super(key: key);

  @override
  State<ImageFromGalCam> createState() => _ImageFromGalCamState();
}

class _ImageFromGalCamState extends State<ImageFromGalCam> {
  var _image;
  var imagePicker;

  @override
  void initState() {
    super.initState();
    imagePicker = new ImagePicker();
  }

  List<XFile>? imageFileList = [];
  void selectImages() async {
    final List<XFile>? selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages!.isNotEmpty) {
      imageFileList!.addAll(selectedImages);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Image Picker"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            MaterialButton(
              color: Colors.blue,
              onPressed: () async {
                XFile image = await imagePicker.pickImage(
                  source: ImageSource.gallery,
                  imageQuality: 50,
                );
                setState(() {
                  _image = File(image.path);
                });
              },
              child: Text('GALLERY'),
            ),
            MaterialButton(
              color: Colors.blue,
              onPressed: () async {
                XFile image = await imagePicker.pickImage(
                    source: ImageSource.camera,
                    imageQuality: 50,
                    preferredCameraDevice: CameraDevice.front);
                setState(() {
                  _image = File(image.path);
                });
              },
              child: Text('CAMERA'),
            ),
            MaterialButton(
              color: Colors.blue,
              onPressed: () {
                selectImages();
              },
              child: Text('Select Multiple Images'),
            ),
            Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(color: Colors.grey[200]),
              child: _image != null
                  ? Image.file(
                      _image,
                      width: 200.0,
                      height: 200.0,
                      fit: BoxFit.fitHeight,
                    )
                  : Text("Pick an image from gallery or click"),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                    itemCount: imageFileList!.length,
                    // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    //     crossAxisCount: 3),
                    itemBuilder: (BuildContext context, int index) {
                      return Image.file(
                        File(imageFileList![index].path),
                        height: 200,
                        width: 200,
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
