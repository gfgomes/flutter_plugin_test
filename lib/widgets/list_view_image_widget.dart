import 'package:cross_file_image/cross_file_image.dart';
import 'package:flutter/material.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:image_picker/image_picker.dart';

/// A classe `ListViewImageWidget` é um `StatelessWidget` que exibe uma lista de imagens e fornece a funcionalidade de adicionar e remover imagens.
///
/// ## Construtor
///
/// O construtor da classe `ListViewImageWidget` recebe vários parâmetros obrigatórios, incluindo `imageFileList`, `maxImages`, `enableCamera`, `fnAddImage`, `fnRemoveImage` e `fnEnableCamButton`.
///
/// ## Método build
///
/// Este método é responsável por construir a interface do widget. Ele retorna um widget `Column` com vários filhos. O primeiro filho é um botão `ElevatedButton.icon` que permite ao usuário adicionar uma imagem. O segundo filho é um widget `Padding` que exibe o número de imagens selecionadas. O terceiro filho é um widget `SizedBox` que contém um widget `ListView.builder`. O `ListView.builder` constrói uma lista de imagens. Cada imagem é exibida em um widget `Center` com um widget `Padding` e um botão `IconButton`. O botão permite que o usuário exclua a imagem.
///
/// ## Método addImage
///
/// Este método é chamado quando o usuário deseja adicionar uma imagem. Ele chama a função `fnAddImage` e, em seguida, chama o método `checkIfCamButtonIsEnabled`.
///
/// ## Método removeImage
///
/// Este método é chamado quando o usuário deseja remover uma imagem. Ele recebe um `BuildContext` e uma imagem `XFile`. Ele chama a função `fnRemoveImage` com o contexto fornecido e a imagem, e em seguida, chama o método `checkIfCamButtonIsEnabled`.
///
/// ## Método checkIfCamButtonIsEnabled
///
/// Este método verifica se o botão da câmera deve ser habilitado. Ele verifica se o `imageFileList` não é nulo e se o número de imagens no `imageFileList` é menor que o `maxImages`. Se a condição for verdadeira, ele define `enableCamera` como verdadeiro, caso contrário, define como falso. Em seguida, ele chama a função `fnEnableCamButton` com o valor de `enableCamera`.
///
/// A classe `ListViewImageWidget` é um widget reutilizável que pode ser usado para exibir uma lista de imagens e fornecer funcionalidade para adicionar e remover imagens.
class ListViewImageWidget extends StatefulWidget {
  final int maxImages;

  final List<XFile>? imageFileList;
  final Future<void> Function() fnAddImage;
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
    await widget.fnAddImage();
    checkIfCamButtonIsEnabled();
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
    print(
        'saindo do checkIfCamButtonIsEnabled e o valor de enableCamera é $enableCamera');
    //widget.fnEnableCamButton(enableCamera);
  }
}
