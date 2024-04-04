import 'package:agmc/core/config/const.dart';

enum MsgType {
  error,
  warning,
  success

  // Add other message types here if needed
}

class CustomSnackbar {
  final BuildContext context;
  final String message;
  final MsgType type;
  
  CustomSnackbar(
      {required this.context,
      required this.message,
      this.type = MsgType.success,
      }) {
    //Size size = MediaQuery.of(context).size;
    showCustomSnackbar();
  }

  void showCustomSnackbar() {
    //Size size = MediaQuery.of(context).size;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: type.name == "error"
            ? Colors.red
            : type.name == "warning"
                ? Colors.yellow
                :appColorBlue,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(
            bottom: context.height - 120,
            left: context.width<700 ? context.width -100:  context.width * .4,
            right: context.width<700 ? context.width -100:  context.width * .4,),
        content: Center(
          child: Text(message,
              style: TextStyle(
                  color: type.name == "warning"
                      ? const Color.fromARGB(255, 32, 2, 201)
                      : Colors.white)),
        ),
        duration: const Duration(seconds: 2),
        
      ),
    );
  }
}