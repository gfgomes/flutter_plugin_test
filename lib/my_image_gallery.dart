import 'package:cross_file_image/cross_file_image.dart';
import 'package:flutter/material.dart';
import 'package:full_screen_image/full_screen_image.dart';
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

  bool enableCamera = true;

  int maxImages = 5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('My App'),
        ),
        body: Column(
          children: [
            ElevatedButton.icon(
              onPressed: enableCamera ? getImage : null,
              icon: const Icon(Icons.add_a_photo),
              label: const Text('Adcionar imagem'),
            ),
            if (imageFileList != null && imageFileList!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: SizedBox(
                    height: 20,
                    child: Text(
                        'Selecionadas: ${imageFileList!.length} de $maxImages'),
                  ),
                ),
              ),
            SizedBox(
              height: 200,
              child: (imageFileList != null && imageFileList!.isNotEmpty)
                  ? ListView(
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        for (var e in imageFileList!)
                          Center(
                            child: Column(
                              children: [
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      //width: 130,
                                      height: 130,
                                      child: FullScreenWidget(
                                        disposeLevel: DisposeLevel.High,
                                        child: Center(
                                          child: Image(
                                            image: XFileImage(e),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    imageFileList!.remove(e);
                                    enableCamButton();
                                    setState(() {});
                                  },
                                  icon: const Icon(Icons.delete,
                                      color: Colors.red, size: 38),
                                )
                              ],
                            ),
                          )
                      ],
                    )
                  : Container(),
            ),
          ],
        ));
  }

  void getImage() async {
    if (imageFileList != null && imageFileList!.length < maxImages) {
      image = await picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 100,
        maxHeight: 1000,
        maxWidth: 1000,
      );

      if (image != null) {
        imageFileList!.add(image!);
        enableCamButton();
        setState(() {});
      }
    }

    print(image.toString());

    print(imageFileList!.length.toString());
    //List<XFile>? images = await picker.pickMultiImage();
  }

  enableCamButton() {
    if (imageFileList != null && imageFileList!.length < maxImages) {
      enableCamera = true;
    } else {
      enableCamera = false;
    }
    setState(() {});
  }
}
