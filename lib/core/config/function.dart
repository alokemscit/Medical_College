// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:agmc/core/config/const.dart';
import 'package:agmc/core/entity/entity_age.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';

import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:share/share.dart';
import 'package:uuid/uuid.dart';

import '../../model/model_status.dart';
import 'package:image/image.dart' as img;
import 'package:path/path.dart' as path;

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

Future<File> getImage() async {
  final picker = ImagePicker();
  final pickedImage = await picker.pickImage(source: ImageSource.gallery);
  if (pickedImage != null) {
    // print(pickedImage.mimeType);
    return File(pickedImage.path);
  } else {
    return File(''); // or return File(); for an empty file
  }
}

Future<String> imageFileToBase64(String fileUrl) async {
  if (!kIsWeb) {
    // Read file content directly
    File inputFile = File(fileUrl);
    List<int> fileBytes = inputFile.readAsBytesSync();
    return base64Encode(fileBytes);
  }

  var response = await http.get(Uri.parse(fileUrl));

  if (response.statusCode == 200) {
    // Decode image based on content type
    String? contentType = response.headers['content-type'];

    if (contentType == 'image/webp') {
      // Decode WebP image
      img.Image? webpImage = img.decodeWebP(response.bodyBytes);
      if (webpImage == null) {
        throw Exception('Failed to decode WebP image');
      }

      // Encode the image to PNG to preserve transparency
      List<int> pngBytes = img.encodePng(webpImage);
      return base64Encode(pngBytes);
    }

    // For other image types, simply encode the bytes
    return base64Encode(response.bodyBytes);
  } else {
    throw Exception('Failed to load file');
  }
}

// Future<String> imageFileToBase64(String fileUrl) async {
//   // Fetch the file content using an HTTP request
//   if (!kIsWeb) {
//     File inputFile = File(fileUrl);
//     List<int> fileBytes = inputFile.readAsBytesSync();
//     String base64String = base64Encode(fileBytes);
//     return base64String;
//   }
//   var response = await http.get(Uri.parse(fileUrl));

//   if (response.statusCode == 200) {
//     // Convert the file content to Base64
//     String? contentType = response.headers['content-type'];

//    // print(contentType);
//     if(contentType=='image/webp'){
//     img.Image? webpImage = img.decodeWebP(response.bodyBytes);
//   if (webpImage == null) {
//     throw Exception('Failed to decode WebP image');
//   }

//   // Encode the image to JPEG to ensure compatibility
//   List<int> jpegBytes = img.encodeJpg(webpImage);
//   String base64String = base64Encode(jpegBytes);
//   return base64String;

//     }

//     String base64String = base64Encode(response.bodyBytes);
//     return base64String;
//   } else {
//     throw Exception('Failed to load file');
//   }
// }

Future<String> webpToBase64(String fileUrl) async {
  Uint8List fileBytes;

  if (!kIsWeb) {
    File inputFile = File(fileUrl);
    fileBytes = await inputFile.readAsBytes();
  } else {
    var response = await http.get(Uri.parse(fileUrl));
    if (response.statusCode == 200) {
      fileBytes = response.bodyBytes;
    } else {
      throw Exception('Failed to load file');
    }
  }

  // Decode WebP image
  img.Image? webpImage = img.decodeWebP(fileBytes);
  if (webpImage == null) {
    throw Exception('Failed to decode WebP image');
  }

  // Encode the image to JPEG to ensure compatibility
  List<int> jpegBytes = img.encodeJpg(webpImage);
  String base64String = base64Encode(jpegBytes);

  return base64String;
}

class CustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

Future<ModelStatus> getStatusWithDialog(
  List<dynamic> jsonData,
  CustomAwesomeDialog dialog,
) async {
  //print(jsonData);
  if (jsonData.isEmpty) {
    dialog
      ..dialogType = DialogType.error
      ..message = "Server error!"
      ..show();
    return ModelStatus(id: "", msg: "Server error", status: "4");
  }
  DialogType dt;
  String msg = '';
  ModelStatus list = jsonData
      .map(
        (e) => ModelStatus.fromJson(e),
      )
      .first;

  dt = DialogType.success;
  if (list.status == "2") {
    dt = DialogType.warning;
  }
  if (list.status == "3") {
    dt = DialogType.error;
  }
  msg = list.msg!;
  if (list.status != "1") {
    dialog
      ..dialogType = dt
      ..message = msg
      ..show();
  }
  return list;
}

Map<int, TableColumnWidth> CustomColumnWidthGenarator(List<int> columnWidth) {
  final Map<int, TableColumnWidth> columnWidthMap = {};

  for (int i = 0; i < columnWidth.length; i++) {
    columnWidthMap[i] = FlexColumnWidth(columnWidth[i].toDouble());
  }

  return columnWidthMap;
}

const _kDefaultDecoration = BoxDecoration(
  color: kBgDarkColor,
);

CustomTableRow(
  List<String> col, [
  Decoration decoration = _kDefaultDecoration,
]) {
  return TableRow(
    decoration: decoration,
    children: col
        .map((e) => TableCell(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                child: Text(
                  e,
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w600),
                ),
              ),
            ))
        .toList(),
  );
}

CustomTableRowWithWidget(
  List<Widget> col, [
  Decoration decoration = _kDefaultDecoration,
]) {
  return TableRow(
    decoration: decoration,
    children: col
        .map((e) => TableCell(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                child: e,
              ),
            ))
        .toList(),
  );
}

CustomTableEditCell(Function() onTap,
        [IconData icon = Icons.edit, Color iconColor = kWebHeaderColor]) =>
    TableCell(
      verticalAlignment: TableCellVerticalAlignment.middle,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        child: Center(
            child: InkWell(
          onTap: () {
            // print('object');
            onTap();
          },
          child: Icon(
            icon,
            color: iconColor,
            size: 12,
          ),
        )),
      ),
    );

CustomTableCell2(String? text,
        [isCenter = false,
        double fintSize = 12,
        FontWeight fontweight = FontWeight.w400]) =>
    TableCell(
      verticalAlignment: TableCellVerticalAlignment.middle,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        child: isCenter
            ? Center(
                child: Text(
                  text!,
                  style: customTextStyle.copyWith(
                      fontSize: fintSize, fontWeight: fontweight),
                ),
              )
            : Text(
                text!,
                style: customTextStyle.copyWith(
                    fontSize: fintSize, fontWeight: fontweight),
              ),
      ),
    );

Widget CustomTableCellTableBody(String text,
    [double fontSize = 13,
    FontWeight fontWeight = FontWeight.bold,
    AlignmentGeometry? alignment = Alignment.centerLeft,
    EdgeInsets? padding = const EdgeInsets.all(8)]) {
  return Container(
    // decoration: BoxDecoration(
    //border: Border.all(color:Colors.black, width: 0.5)),
    alignment: alignment,
    padding: padding,
    child: Text(
      text,
      style: TextStyle(fontWeight: fontWeight, fontSize: fontSize),
    ),
  );
}

String generateUniqueId() {
  var uuid = const Uuid();
  return uuid.v4();
}

// Fetch PDF file from the remote URL
Future<Uint8List> fetchPdfBytes(String url) async {
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    // Convert response body (PDF content) to a byte array (Uint8List)
    return Uint8List.fromList(response.bodyBytes);
  } else {
    throw Exception('Failed to load PDF: ${response.statusCode}');
  }
}

bool isValidDateRange(String fdate, String tdate) {
  // Define the date format
  DateFormat format = DateFormat('dd/MM/yyyy');

  // Parse the string into a DateTime object
  DateTime fromDate = format.parse(fdate);
  //print(fromDate);

  DateTime toDate = format.parse(tdate);
  // print(toDate);
  if (toDate.isBefore(fromDate)) {
    //print('abcd');
    return false;
  }
  // Duration difference = fromDate.difference(toDate);

  //print(difference);
  return true;
}

bool checkJson(List<dynamic> x) {
  if (x == []) {
    return false;
  }
  var y = x.map((e) => ModelStatus.fromJson(e));
  if (y.isEmpty) {
    return false;
  }
  if (y.first.status == '3') {
    return false;
  }
  return true;
}
