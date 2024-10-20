import 'dart:convert';
import 'dart:html' as html;
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;




class PDFWebView extends StatefulWidget {
  const PDFWebView({super.key});

    @override
    _PDFWebViewState createState() => _PDFWebViewState();
}

class _PDFWebViewState extends State<PDFWebView> {
    String pdfBase64 = '';

    @override
    void initState() {
        super.initState();
        _loadPDF();
    }

    Future<void> _loadPDF() async {
        final ByteData data = await rootBundle.load('assets/mypdf.pdf');
        final List<int> bytes = data.buffer.asUint8List();
        setState(() {
            pdfBase64 = base64Encode(bytes);
        });
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: const Text('PDF WebView'),
            ),
            body: Center(
                child: pdfBase64.isNotEmpty
                    ? const SizedBox(
                        width: 600,
                        height: 400,
                        child: HtmlElementView(
                            viewType: 'pdf-web-view',
                        ),
                    )
                    : const CircularProgressIndicator(),
            ),
        );
    }

    @override
    void didChangeDependencies() {
        super.didChangeDependencies();
        // Inject the PDF content into the web view
        if (pdfBase64.isNotEmpty) {
            final iframe = html.IFrameElement()
                ..src = 'data:application/pdf;base64,$pdfBase64'
                ..style.border = 'none'
                ..width = '100%'
                ..height = '100%';
            html.querySelector('#pdf-container')?.children.clear();
            html.querySelector('#pdf-container')?.append(iframe);
        }
    }
}
