import 'package:cross_file_image/cross_file_image.dart';
import 'package:flutter/material.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:image_picker/image_picker.dart';

/// Widget de lista horizontal de imagens que permite adicionar e remover imagens.
///
/// A classe [ListViewHorizontalImageWidget] é responsável por exibir uma lista de imagens
/// e permitir a adição e remoção de imagens. Ela utiliza um [ListView.builder]
/// para renderizar as imagens e um [ ElevatedButton.icon] para adicionar novas
/// imagens.
///
/// A lista de imagens é armazenada em uma lista de [XFile] chamada [imageFileList].
/// Ao adicionar uma nova imagem, ela é adicionada à lista. Ao remover uma
/// imagem, ela é removida da lista.
///
/// A classe também possui um método chamado [picker.pickImage] do componente image picker que é responsável
/// por abrir o seletor de imagens do dispositivo e retornar a imagem selecionada
/// como um [XFile].
///
/// A classe utiliza o pacote [image_picker] para abrir o seletor de imagens.
///
/// Parâmetros:
///   - [imageFileList]: Lista de imagens[List<XFile>?] a serem exibidas e manipuladas.
///   - [maxImages]: Número máximo de imagens [int] permitidas na lista.
///   - [fnAddImage]: Função assíncrona para adicionar uma imagem à lista.
///   - [fnRemoveImage]: Função assíncrona para remover uma imagem da lista.
///
/// Comunicação com widget pai:
/// A comunicação da lista de imagens do widiget pair com a lista interna é feita pelas funções [fnAddImage] e [fnRemoveImage] que devem passadas
/// como parametros no construtor, elas também devem chamar setstate para renderizar as auterações do widget.
///
/// Dependências:
///   - [image_picker]: Para abrir o seletor de imagens [flutter pub add image_picker].
///  - [full_screen_image]: Para mostrar a imagem em tela cheia ao ser clicada[flutter pub add full_screen_image].
///  - [cross_file_image]: Para converter um [XFile] em uma imagem[flutter pub add cross_file_image].
///
class ListViewHorizontalImageWidget extends StatefulWidget {
  final int maxImages;

  final List<XFile>? imageFileList;
  final Future<void> Function(XFile xFile) fnAddImage;
  final Future<void> Function(BuildContext context, XFile xFile) fnRemoveImage;

  const ListViewHorizontalImageWidget({
    super.key,
    required this.imageFileList,
    required this.maxImages,
    required this.fnAddImage,
    required this.fnRemoveImage,
  });

  @override
  State<ListViewHorizontalImageWidget> createState() =>
      _ListViewHorizontalImageWidgetState();
}

class _ListViewHorizontalImageWidgetState
    extends State<ListViewHorizontalImageWidget> {
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
