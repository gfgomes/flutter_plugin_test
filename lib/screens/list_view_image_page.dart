import 'package:flutter/material.dart';
import 'package:flutter_plugin_test/widgets/core_dialogs_widgets.dart';
import 'package:flutter_plugin_test/widgets/list_view_image_widget.dart';
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

  //bool enableCamera = true;

  int maxImages = 5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My App'),
      ),
      body: ListViewImageWidget(
        imageFileList: imageFileList,
        maxImages: maxImages,
        fnAddImage: addImage,
        fnRemoveImage: removeImage,
      ),
    );
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
        //enableCamButton();
        setState(() {
          imageFileList!.add(image);
        });
      }
    }
  }

  Future<void> removeImage(BuildContext context, XFile xFile) async {
    //enableCamButton();
    await showConfirmationDialog(context,
            content: "Deseja remover esta imagem?")
        .then((optionSelected) {
      if (optionSelected) {
        setState(() {
          imageFileList!.remove(xFile);
        });
      }
    });
  }
}
