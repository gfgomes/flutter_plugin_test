import 'package:flutter/material.dart';

/// O parâmetro [context] é obrigatório e representa o contexto de construção do widget que chama essa função.
///
/// O parâmetro [title] é opcional e tem o valor padrão "Atenção!". Ele representa o título do diálogo.
///
/// O parâmetro [content] é opcional e tem o valor padrão "Você realmente deseja executar essa operação?". Ele representa o conteúdo do diálogo.
///
/// O parâmetro [affirmativeOption] é opcional e tem o valor padrão "Confirmar". Ele representa o texto do botão afirmativo.
///
/// O parâmetro [negativeOption] é opcional e tem o valor padrão "Cancelar". Ele representa o texto do botão negativo.
///
///O parâmetro [affirmativeOtionColor] é opcional e tem o valor padrão `Colors.green`. Ele representa a cor do botão afirmativo.
///
/*
showConfirmationDialog(
        context,
        content: "Deseja remover esta imagem?",
        affirmativeOtionColor: Colors.red,
        affirmativeOption: 'Remover',
      ).then((optionSelected) {
        if (optionSelected) {
          se true, faz alguma coisa
        } 
        else{
          se false, faz outra coisa
        }
      });
    }
 */
Future<dynamic> showConfirmationDialog(
  BuildContext context, {
  String title = "Atenção!",
  String content = "Você realmente deseja executar essa operação?",
  String affirmativeOption = "Confirmar",
  String negativeOption = "Cancelar",
  Color affirmativeOtionColor = Colors.green,
}) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(title: Text(title), content: Text(content), actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context, false);
          },
          child: Text(negativeOption),
        ),
        TextButton(
            onPressed: () {
              Navigator.pop(context, true);
            },
            child: Text(
              affirmativeOption.toUpperCase(),
              style: TextStyle(
                  color: affirmativeOtionColor, fontWeight: FontWeight.bold),
            )),
      ]);
    },
  );
}
