import 'package:flutter/material.dart';
import 'package:flutter_plugin_test/widgets/core_dialogs_widgets.dart';
import 'package:flutter_plugin_test/widgets/list_view_image_widget.dart';
import 'package:image_picker/image_picker.dart';

class ListViewImageWidgetPage extends StatefulWidget {
  const ListViewImageWidgetPage({super.key});

  @override
  State<ListViewImageWidgetPage> createState() =>
      _ListViewImageWidgetPageState();
}

class _ListViewImageWidgetPageState extends State<ListViewImageWidgetPage> {
  List<XFile>? imageFileList = [];
  int maxImages = 5;
  //File _image;
  //ImagePicker picker = ImagePicker();

  //bool enableCamera = true;

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

  Future<void> addImage(XFile image) async {
    setState(() {
      imageFileList!.add(image);
    });
  }

  Future<void> removeImage(BuildContext context, XFile image) async {
    //enableCamButton();
    await showConfirmationDialog(context,
            content: "Deseja remover esta imagem?")
        .then((optionSelected) {
      if (optionSelected) {
        setState(() {
          imageFileList!.remove(image);
        });
      }
    });
  }
}
