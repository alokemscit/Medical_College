
// ignore_for_file: non_constant_identifier_names

import 'package:agmc/core/config/const.dart';

Future<void> CustomDialog(BuildContext context, Widget title,
    Widget bodyContent, void Function() onPress,
    [bool scrollable = true,bool isSaveButton=true]
    ) {
  final GlobalKey buttonKey = GlobalKey();
  bool isButtonDisabled = false;
  void disableButton() {
    isButtonDisabled = true;
    Future.delayed(const Duration(seconds: 1), () {
      // Enable the button after the delay
      if (buttonKey.currentContext != null) {
        isButtonDisabled = false;
      }
    });
  }

  // ignore: no_leading_underscores_for_local_identifiers
  void _onButtonPressed() {
    if (!isButtonDisabled) {
      onPress();
      disableButton();
    }
  }

  return showDialog<void>(
    //barrierColor:Colors.white,
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        actionsPadding:EdgeInsets.zero,
        backgroundColor: Colors.white.withOpacity(0.8),
        surfaceTintColor: Colors.white.withOpacity(0.5),
        scrollable: scrollable,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0))),
        contentPadding: const EdgeInsets.only(top: 5.0),
        // elevation: 0,
        title: Material(
          color: Colors.transparent,
          child: Container(
             decoration: BoxDecoration(
        color: kWebHeaderColor.withOpacity(0.13),
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(8), topRight: Radius.circular(8)),
        //border: Border.all(color: Colors.black38, width: 0.1),
        boxShadow: [
          BoxShadow(
              color: Colors.black38.withOpacity(0.3),
              blurRadius: 1.05,
              spreadRadius: 0.1)
          ],
        ),
            
            
            child: title)
          ), //AppointDialogTitle(data: data,),
        titlePadding: EdgeInsets.zero,
        // contentPadding: const EdgeInsets.all(8),
        content: bodyContent, //AppointmentDialogBody(),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Close'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
         isSaveButton? TextButton(
            key: buttonKey,
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            onPressed: _onButtonPressed,
            child: const Text('Save'),
          ):const SizedBox(),
        ],
      );
    },
  );
}
