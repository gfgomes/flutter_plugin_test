import 'package:cross_file_image/cross_file_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plugin_test/widgets/list_view_image_widget.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:image_picker/image_picker.dart';

class ListViewImageWidgetPage extends StatefulWidget {
  ListViewImageWidgetPage({super.key});

  @override
  State<ListViewImageWidgetPage> createState() =>
      _ListViewImageWidgetPageState();
}

class _ListViewImageWidgetPageState extends State<ListViewImageWidgetPage> {
  List<XFile>? imageFileList = [];

  //File _image;
  ImagePicker picker = ImagePicker();

  bool enableCamera = true;

  int maxImages = 5;

  bool get isCamEnable {
    if (imageFileList != null && imageFileList!.length < maxImages) return true;
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My App'),
      ),
      body: ListViewImageWidget(
          imageFileList: imageFileList,
          maxImages: maxImages,
          enableCamera: enableCamera,
          fnAddImage: addImage,
          fnRemoveImage: removeImage,
          fnEnableCamButton: enableCamButton),
    );
  }

  enableCamButton() {
    if (isCamEnable) {
      enableCamera = true;
    } else {
      enableCamera = false;
    }
  }

  Future<void> addImage() async {
    if (imageFileList != null && imageFileList!.length < maxImages) {
      XFile? image = await picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 100,
        maxHeight: 1000,
        maxWidth: 1000,
      );

      if (image != null) {
        imageFileList!.add(image);
        enableCamButton();
        setState(() {});
      }
    }
  }

  void removeImage(XFile xFile) {
    imageFileList!.remove(xFile);
    enableCamButton();
    setState(() {});
  }
}
