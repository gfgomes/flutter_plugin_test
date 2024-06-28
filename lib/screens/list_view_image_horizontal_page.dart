import 'package:flutter/material.dart';
import 'package:flutter_plugin_test/widgets/core_dialogs_widgets.dart';
import 'package:flutter_plugin_test/widgets/list_view_image_horizontal_widget.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My App'),
      ),
      body: Column(
        children: [
          ListViewHorizontalImageWidget(
            imageFileList: imageFileList,
            maxImages: maxImages,
            fnAddImage: addImage,
            fnRemoveImage: removeImage,
          ),
          ElevatedButton(
              onPressed: () => saveImages(), child: Text('Salvar imagens'))
        ],
      ),
    );
  }

  /// Adds an image to the `imageFileList`.
  ///
  /// The `image` parameter is the `XFile` object representing the image to be added.
  ///
  /// This function updates the state by adding the `image` to the `imageFileList`.
  ///
  /// Returns a `Future<void>` indicating the completion of the operation.
  Future<void> addImage(XFile image) async {
    setState(() {
      imageFileList!.add(image);
    });
  }

  /// Removes an image from the `imageFileList`.
  ///
  /// The `context` parameter is the `BuildContext` object representing the current state of the widget tree.
  /// The `image` parameter is the `XFile` object representing the image to be removed.
  ///
  /// This function displays a confirmation dialog to the user asking if they want to remove the image.
  /// If the user confirms, the image is removed from the `imageFileList` and the state is updated.
  ///
  /// Returns a `Future<void>` indicating the completion of the operation.
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

  /// Saves the images in the `imageFileList` to the device.
  saveImages() {
    if (imageFileList != null) {
      print('imageFileList: ${imageFileList!.length}');
    } else {
      print('imageFileList é null');
    }
  }
}
