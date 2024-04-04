import 'dart:io';
import 'dart:typed_data';


import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

import 'package:pdf/widgets.dart';
import 'dart:html' as html;
import 'package:pdf/widgets.dart' as pw;

class PdfApi {



static Future<File> saveDocument({
  required String name,
  required Document pdf,
}) async {
  final bytes = await pdf.save();

  // Save file to browser's download location
  final blob = html.Blob([bytes]);
  final url = html.Url.createObjectUrlFromBlob(blob);
  final anchor = html.AnchorElement(href: url)
    ..setAttribute("download", name);
  html.document.body!.children.add(anchor);

  // Simulate click to trigger download
  anchor.click();

  // Cleanup
  html.Url.revokeObjectUrl(url);

  return File(name); // Just return a File object for consistency
}

// static Future<void> openFile(File file) async {
//   // For web, there's no need to open files since they are downloaded directly by the browser
//   // You might want to provide feedback to the user that the file has been downloaded
// }

  // static Future<File> saveDocument({
  //   required String name,
  //   required Document pdf,
  // }) async {
  //   final bytes = await pdf.save();

  //   final dir = await getApplicationDocumentsDirectory();
  //   final file = File('${dir.path}/$name');

  //   await file.writeAsBytes(bytes);

  //   return file;
  // }

  static Future openFile(File file) async {
    // final url = file.path;

    // await OpenFile.open(url);
    final blob = html.Blob([file.readAsBytesSync()]);
  final url = html.Url.createObjectUrlFromBlob(blob);

  final iframe = html.IFrameElement()
    ..src = url
    ..style.border = 'none'
    ..style.width = '100%'
    ..style.height = '100%';

  final div = html.DivElement()
    ..style.width = '100%'
    ..style.height = '100%'
    ..style.position = 'fixed'
    ..style.top = '0'
    ..style.left = '0'
    ..style.zIndex = '9999'
    ..style.background = '#fff'
    ..append(iframe);

  html.document.body!.children.add(div);

  // Cleanup
  html.window.onMessage.listen((event) {
    if (event.data == 'close_pdf') {
      div.remove();
      html.Url.revokeObjectUrl(url);
    }
  });
  }
}