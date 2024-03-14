// ignore_for_file: non_constant_identifier_names

import 'package:agmc/core/config/const.dart';

Widget CustomButton(
 @required IconData icon,
  @required String caption,
  @required Function onClick,[Color textColor=appColorGrayLight,Color iconColor=appColorGrayLight,Color buttonColor=appColorIndigoA100]) =>
    MouseRegion(
       cursor: SystemMouseCursors.click,
      child: InkWell(
         borderRadius: BorderRadius.circular(12),
         mouseCursor:MouseCursor.defer,
         splashColor:buttonColor.withBlue(100),
         //hoverColor: buttonColor.withOpacity(2),
        onTap: () {
          onClick();
          //Get.to(() => const MainPage());
          // Get.delete<DefaultPageController>();
          // controller.gotoMainPage();
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: buttonColor,
              boxShadow: [
                BoxShadow(
                    spreadRadius: 3,
                    blurRadius: 1,
                    color: Colors.black.withOpacity(0.05))
              ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              caption.text
                  .fontFamily(appFontMuli)
                  .color(textColor).sm
                  .fontWeight(FontWeight.w400)
                  .make(),
              14.widthBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  
                  Padding(
                    padding: const EdgeInsets.all(0),
                    child: Icon(
                      icon,
                      size: 14,
                      color: iconColor,
                    ),
                  ),
                  //4.widthBox,
                ],
              )
            ],
          ),
        ),
      ),
    );
