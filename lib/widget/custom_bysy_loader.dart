import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomBusyLoader {
  BuildContext context;
  CustomBusyLoader({required this.context});
  bool b = false;
  Future<void> show() async {
    b = true;
    //print("object");
    return showDialog<void>(
      context: context,
      barrierColor: Colors.black.withOpacity(0.2),
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(
          child: CupertinoActivityIndicator(
            color: Colors.black,
          ),
        );
      },
    );
  }

  void close() {
    if (b) {
      b = false;
      Navigator.pop(context);
    }
  }
}
