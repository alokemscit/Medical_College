import 'dart:convert';
import 'dart:typed_data';
import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:pdf/pdf.dart'; import 'package:pdf/widgets.dart' as pw;

Future<void> openPdfInNewWindow(pw.Document pdf) async {
  // Save the PDF document as bytes
  final Uint8List bytes = await pdf.save();
String base64Data = base64Encode(bytes);

  // Create a data URI for the PDF content
  String dataUri = 'data:application/pdf;base64,$base64Data';


   
  // // Open the URL in a new window
   html.window.open(dataUri, '_blank');

 // html.window.open('<iframe src="' + dataUri  + '" frameborder="0" style="border:0; top:0px; left:0px; bottom:0px; right:0px; width:100%; height:100%;" allowfullscreen></iframe>','_blank');
   // win.document.write('<iframe src="' + base64URL  + '" frameborder="0" style="border:0; top:0px; left:0px; bottom:0px; right:0px; width:100%; height:100%;" allowfullscreen></iframe>');


  // // Revoke the URL to release memory
  // html.Url.revokeObjectUrl(url);
}


class PDFViewer extends StatelessWidget {
  final Uint8List pdfBytes;

  const PDFViewer({super.key, required this.pdfBytes});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF Viewer'),
      ),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: PDFView(
            filePath: null, // You can't use filePath in web, so use pdfData instead
            pdfData: pdfBytes, // Pass the PDF bytes
          ),
        ),
      ),
    );
  }
}


class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('PDF Viewer')),
        body: Center(
          child: ElevatedButton(
            onPressed: () async {
              final pdf = pw.Document();
              pdf.addPage(pw.Page(
                build: (context) => pw.Center(
                  child: pw.Text('Hello World!', style: const pw.TextStyle(fontSize: 24)),
                ),
              ));
              await openPdfInNewWindow(pdf);
            },
            child: const Text('Open PDF'),
          ),
        ),
      ),
    );
  }
}
