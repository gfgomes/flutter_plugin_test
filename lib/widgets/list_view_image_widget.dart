import 'package:cross_file_image/cross_file_image.dart';
import 'package:flutter/material.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:image_picker/image_picker.dart';

class ListViewImageWidget extends StatefulWidget {
  final int maxImages;

  final List<XFile>? imageFileList;
  final Future<void> Function(XFile xFile) fnAddImage;
  final Future<void> Function(BuildContext context, XFile xFile) fnRemoveImage;

  const ListViewImageWidget({
    super.key,
    required this.imageFileList,
    required this.maxImages,
    required this.fnAddImage,
    required this.fnRemoveImage,
  });

  @override
  State<ListViewImageWidget> createState() => _ListViewImageWidgetState();
}

class _ListViewImageWidgetState extends State<ListViewImageWidget> {
  final ImagePicker picker = ImagePicker();
  bool enableCamera = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton.icon(
          onPressed: enableCamera ? () => addImage() : null,
          icon: const Icon(Icons.add_a_photo),
          label: const Text('Adicionar imagem'),
        ),
        if (widget.imageFileList != null && widget.imageFileList!.isNotEmpty)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: SizedBox(
                height: 20,
                child: Text(
                    'Selecionadas: ${widget.imageFileList!.length} de ${widget.maxImages}'),
              ),
            ),
          ),
        SizedBox(
          height: 200,
          child:
              (widget.imageFileList != null && widget.imageFileList!.isNotEmpty)
                  ? ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.imageFileList!.length,
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
                                          image: XFileImage(
                                              widget.imageFileList![index]),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  removeImage(
                                      context, widget.imageFileList![index]);
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
    if (widget.imageFileList != null &&
        widget.imageFileList!.length < widget.maxImages) {
      XFile? image = await picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 100,
        maxHeight: 1000,
        maxWidth: 1000,
      );

      if (image != null) {
        await widget.fnAddImage(image);
        checkIfCamButtonIsEnabled();
      }
    }
  }

  Future<void> removeImage(BuildContext context, XFile image) async {
    await widget.fnRemoveImage(context, image);
    checkIfCamButtonIsEnabled();
  }

  void checkIfCamButtonIsEnabled() {
    setState(() {
      if (widget.imageFileList != null &&
          widget.imageFileList!.length < widget.maxImages) {
        enableCamera = true;
      } else {
        enableCamera = false;
      }
    });
  }
}
