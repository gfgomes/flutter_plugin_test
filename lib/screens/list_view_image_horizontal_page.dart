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

  /// Adiciona uma imagem à lista `imageFileList`.
  ///
  /// O parâmetro `image` é o objeto `XFile` representando a imagem a ser adicionada.
  ///
  /// Esta função atualiza o estado adicionando a `image` à `imageFileList`.
  ///
  /// Retorna um `Future<void>` indicando a conclusão da operação.
  Future<void> addImage(XFile image) async {
    setState(() {
      imageFileList!.add(image);
    });
  }

  /// Remove uma imagem da lista `imageFileList`.
  ///
  /// O parâmetro `context` é o objeto `BuildContext` que representa o estado atual da árvore de widgets.
  /// O parâmetro `image` é o objeto `XFile` que representa a imagem a ser removida.
  ///
  /// Esta função exibe uma caixa de diálogo de confirmação para o usuário perguntando se ele deseja remover a imagem.
  /// Se o usuário confirmar, a imagem é removida da `imageFileList` e o estado é atualizado.
  ///
  /// Retorna um `Future<void>` indicando a conclusão da operação.
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

  /// Salva as imagens na `imageFileList` no dispositivo.
  saveImages() {
    if (imageFileList != null) {
      print('imageFileList: ${imageFileList!.length}');
    } else {
      print('imageFileList é null');
    }
  }
}
