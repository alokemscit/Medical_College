
 
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

class CustomAwesomeDialog {
  CustomAwesomeDialog({
    required this.context,
    this.dialogType = DialogType.info,
    this.message = '',
    this.onTap,
  });

  DialogType dialogType;
  String message;
  void Function()? onTap;
  BuildContext context;

  void show() {
    bool b = true;
    AwesomeDialog(
      width: 400,
      context: context,
      isDense: false,
      dialogType: dialogType,
      animType: AnimType.bottomSlide,
      dismissOnTouchOutside: true,
      dismissOnBackKeyPress: false,
      title: dialogType.name,
      desc: message,
      btnOkOnPress: () {
        if (b) {
          b = false;
          onTap?.call();
          Future.delayed(const Duration(seconds: 2)).then((value) => b=false);
          // Use onTap function if provided
        }
      },
      btnOkText: 'OK',
    ).show();
  }
}
