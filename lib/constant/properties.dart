// ignore_for_file: non_constant_identifier_names, unnecessary_string_interpolations

import 'dart:convert';
import 'dart:io';
import 'package:asgar_ali_hospital/custom_widget/custom_bysy_loader.dart';
import 'package:asgar_ali_hospital/entities/entity_age.dart';
import 'package:flutter/cupertino.dart';
 
import 'package:http/http.dart' as http;
import 'package:asgar_ali_hospital/constant/const.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';

TextStyle customTextStyle = const TextStyle(
  color: Colors.black, fontFamily: appFontMuli,
  fontSize: 14,
  fontWeight: FontWeight.bold, //height:0.6
);

List<String> slider_imageUrls = [
  "assets/images/1.jpg",
  "assets/images/2.jpg",
  "assets/images/3.jpg",
  "assets/images/4.jpg",
  // Add more image URLs here
];

CustomCaptionDecoration(
    [double borderWidth = 0.3, Color borderColor = Colors.black]) {
  return CustomBoxDecorationTopRounded.copyWith(
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(8), topRight: Radius.circular(8)),
      color: appColorGray200,
      border: Border(
          left: BorderSide(
              color: borderColor.withOpacity(0.3), width: borderWidth),
          right: BorderSide(
              color: borderColor.withOpacity(0.3), width: borderWidth),
          bottom: BorderSide(
              color: borderColor.withOpacity(0.3),
              width:
                  borderWidth)) //   .all(color: borderColor.withOpacity(0.3), width: borderWidth)
      );
}

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

hospitalLogo() => Opacity(
      opacity: 0.8,
      child: Image.asset(
        "assets/images/logo.png",
        fit: BoxFit.cover,
        height: 55,
      ),
    );

Future<String> imageFileToBase64(String fileUrl) async {
  // Fetch the file content using an HTTP request
  if (!kIsWeb) {
    File inputFile = File(fileUrl);
    List<int> fileBytes = inputFile.readAsBytesSync();
    String base64String = base64Encode(fileBytes);
    return base64String;
  }
  var response = await http.get(Uri.parse(fileUrl));

  if (response.statusCode == 200) {
    // Convert the file content to Base64
    String base64String = base64Encode(response.bodyBytes);
    return base64String;
  } else {
    throw Exception('Failed to load file');
  }

// Uint8List bytes = base64Decode(base64String);

//     // Create an Image widget from the decoded bytes
//     return Image.memory(
//       bytes,
//       fit: BoxFit.cover, // Adjust the fit property as needed
//     );
}

CustomCupertinoAlertWithYesNo(BuildContext context, Widget title,
    Widget content, void Function() no, void Function() yes,
    [String? noButtonCap, String? yesButtonCap]) {
  showCupertinoDialog(
    context: context,
    builder: (BuildContext context) {
      return CupertinoAlertDialog(
        title: title,
        content: Container(
          // Wrap content in a container to allow for better layout adjustments
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: content,
        ),
        actions: [
          CupertinoDialogAction(
            child: Text(noButtonCap ?? 'No'),
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
              no();
            },
          ),
          CupertinoDialogAction(
            isDefaultAction: true, // Emphasize the primary action
            child: Text(yesButtonCap ?? 'Yes'),
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
              yes();
            },
          ),
        ],
      );
    },
  );
}

TextStyle customTextStyleDefault = const TextStyle(
    fontFamily: appFontMuli, fontSize: 9, fontWeight: FontWeight.w400);

Future<Age> AgeCalculator(DateTime birthDate) async {
  final now = DateTime.now();
  int years = now.year - birthDate.year;
  int months = now.month - birthDate.month;
  int days = now.day - birthDate.day;

  // Check if the birthday has occurred this year
  if (now.month < birthDate.month ||
      (now.month == birthDate.month && now.day < birthDate.day)) {
    years--;
    months += 12;
  }

  // Adjust months and days if days < 0
  if (days < 0) {
    months--;
    days += DateTime(now.year, now.month - 1, 0).day;
  }

  // Adjust years if months < 0
  if (months < 0) {
    years--;
    months += 12;
  }

  return Age(years: years, months: months, days: days);
}

Future<void> savePdf(BuildContext context, String url) async {
  CustomBusyLoader loader = CustomBusyLoader(context: context);
  try {
    loader.show();
    //await Share.share(url);
    final filename = url.substring(url.lastIndexOf("/") + 1);
    final response = await http.get(Uri.parse(url));
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$filename');
    await file.writeAsBytes(response.bodyBytes);
    loader.close();
    await Share.shareFiles(['${file.path}'], text: 'Inv Report');
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('PDF saved')));
  } catch (e) {
    loader.close();
    print(e.toString());
  }
}
