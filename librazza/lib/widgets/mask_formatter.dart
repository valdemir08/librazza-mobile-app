import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CpfFor {
  final MaskTextInputFormatter cpfFormater = MaskTextInputFormatter(
      mask: "###.###.###-##",
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.eager);
}

final MaskTextInputFormatter cpfFormater = MaskTextInputFormatter(
    mask: "###.###.###-##",
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.eager);

final MaskTextInputFormatter phoneNumberFormater = MaskTextInputFormatter(
    mask: "(##) #####-####",
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.eager);

final MaskTextInputFormatter editionFormater = MaskTextInputFormatter(
    mask: "#ª",
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.eager);

final MaskTextInputFormatter yearFormater = MaskTextInputFormatter(
    mask: "####",
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.eager);
