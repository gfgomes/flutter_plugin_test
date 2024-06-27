import 'dart:io';
import 'dart:typed_data';

import 'package:cross_file_image/cross_file_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageGalleryWidget extends StatefulWidget {
  ImageGalleryWidget({super.key});

  @override
  State<ImageGalleryWidget> createState() => _ImageGalleryWidgetState();
}

class _ImageGalleryWidgetState extends State<ImageGalleryWidget> {
  List<XFile>? imageFileList = [];

  //File _image;
  ImagePicker picker = ImagePicker();

  XFile? image = null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('My App'),
        ),
        body: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                getImage();
              },
              child: Text('Clique aqui'),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              height: 200,
              child: imageFileList!.isNotEmpty
                  ? ListView(
                      // This next line does the trick.
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        if (image != null)
                          Center(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width: 130,
                                    height: 130,
                                    color: Colors.red,
                                    child: Image(
                                      image: XFileImage(image!),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.delete,
                                      color: Colors.red, size: 38),
                                )
                              ],
                            ),
                          ),
                        Center(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: 130,
                                  height: 130,
                                  color: Colors.green,
                                  //child: Image.memory(bytes, fit: BoxFit.fill,),
                                ),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.delete,
                                    color: Colors.red, size: 38),
                              )
                            ],
                          ),
                        ),
                        Center(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: 130,
                                  height: 130,
                                  color: Colors.yellow,
                                ),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.delete,
                                    color: Colors.red, size: 38),
                              )
                            ],
                          ),
                        ),
                        Center(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: 130,
                                  height: 130,
                                  color: Colors.purple,
                                ),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.delete,
                                    color: Colors.red, size: 38),
                              )
                            ],
                          ),
                        ),
                      ],
                    )
                  : Container(),
            ),
          ],
        ));
  }

  void getImage() async {
    image = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 100,
      maxHeight: 1000,
      maxWidth: 1000,
    );

    if (image != null) {
      setState(() {});
    }

    print(image.toString());
    imageFileList!.add(image!);
    print(imageFileList!.length.toString());
    //List<XFile>? images = await picker.pickMultiImage();
  }
}
