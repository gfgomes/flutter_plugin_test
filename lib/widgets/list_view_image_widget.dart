import 'package:cross_file_image/cross_file_image.dart';
import 'package:flutter/material.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:image_picker/image_picker.dart';

class ListViewImageWidget extends StatelessWidget {
  final ImagePicker picker = ImagePicker();
  final int maxImages;
  final bool enableCamera;
  final List<XFile>? imageFileList;
  final Future<void> Function() fnAddImage;
  final Function(XFile xFile) fnRemoveImage;
  final Function() fnEnableCamButton;

  ListViewImageWidget({
    super.key,
    required this.imageFileList,
    required this.maxImages,
    required this.enableCamera,
    required this.fnAddImage,
    required this.fnRemoveImage,
    required this.fnEnableCamButton,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton.icon(
          onPressed: enableCamera ? () => addImage() : null,
          icon: const Icon(Icons.add_a_photo),
          label: const Text('Adicionar imagem'),
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
              ? ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: imageFileList!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Center(
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
                                      image: XFileImage(imageFileList![index]),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              removeImage(imageFileList![index]);
                            },
                            icon: const Icon(Icons.delete,
                                color: Colors.red, size: 38),
                          )
                        ],
                      ),
                    );
                  },
                )
              : Container(),
        ),
      ],
    );
  }

  addImage() async {
    await fnAddImage();
  }

  void removeImage(XFile image) {
    fnRemoveImage(image);
  }
}
