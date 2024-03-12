// ignore_for_file: non_constant_identifier_names

import 'package:agmc/config/colors.dart';
import 'package:agmc/config/const_string.dart';
import 'package:flutter/material.dart';

TextStyle customTextStyle = const TextStyle(
  color: Colors.black, fontFamily: appFontMuli,
  fontSize: 14,
  fontWeight: FontWeight.bold, //height:0.6
);

BoxDecoration CustomBoxDecorationTopRounded = const BoxDecoration(
    color: appColorPista, //.withOpacity(0.8),
    // color: Color.fromARGB(255, 252, 251, 251),
    borderRadius: BorderRadius.only(
        topLeft: Radius.circular(8), topRight: Radius.circular(8)),
    boxShadow: [
      BoxShadow(
        color: Colors.white,
        blurRadius: 15.1,
        spreadRadius: 3.1,
      )
    ]);

    TextStyle customTextStyleDefault = const TextStyle(
    fontFamily: appFontMuli, fontSize: 9, fontWeight: FontWeight.w400);





    
ButtonStyle customButtonStyle = ButtonStyle(
    foregroundColor:
        MaterialStateProperty.all<Color>(Colors.white), // Set button text color
    backgroundColor: MaterialStateProperty.all<Color>(appColorBlue),
    textStyle: MaterialStateProperty.all<TextStyle>(
      const TextStyle(
          fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.white),
    ));

BoxDecoration customBoxDecoration = BoxDecoration(
  // color: appColorBlue.withOpacity(0.05),
  borderRadius:
      const BorderRadius.all(Radius.circular(12)), // Uncomment this line
  border: Border.all(
      color: appColorBlue,
      width: 0.108,
      strokeAlign: BorderSide.strokeAlignCenter),
  boxShadow: [
    BoxShadow(
      color: appColorBlue.withOpacity(0.0085),
      spreadRadius: 0.1,
      blurRadius: 5.2,
      offset: const Offset(0, 1),
    ),
    BoxShadow(
      color: appColorBlue.withOpacity(0.0085),
      spreadRadius: 0.2,
      blurRadius: 3.2,
      offset: const Offset(1, 0),
    ),
  ],
);

 
// Widget headerCloseButton() => const Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         SizedBox(
//           height: 55,
//         ),
//         CustomAppBarCloseButton(),
//       ],
//     );
 
TableBorder CustomTableBorder() =>
    TableBorder.all(width: 0.5, color: const Color.fromARGB(255, 89, 92, 92));

 
CustomTableCell(String text,
        [TextStyle style =
            const TextStyle(fontSize: 12, fontWeight: FontWeight.w400)]) =>
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: Text(
        text,
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
      ),
    );

 
Decoration CustomTableHeaderRowDecoration() => BoxDecoration(
        color: kBgDarkColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(8),
        ),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 3)
        ]);
