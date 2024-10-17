import 'dart:convert';

 
import 'package:htmltopdfwidgets/htmltopdfwidgets.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/services.dart' show rootBundle;
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';

import '../../../widget/pdf_widget/invoice.dart';
import '../lab_outsource_result_entry/model/lab_model_outsource_test_data.dart';

mixin MyPdfUIMixin {
  void showPDF_1(dynamic pdfFile, dynamic controller) async {
    // var body = k1;
    final pdfBytes = pdfFile;
    // await pdfFile.readAsBytes();
    final pdf = pw.Document();
    // final pdf = body;
    final fontData =
        await rootBundle.load('assets/fonts/openSans/OpenSans-Regular.ttf');
    final fontData1 =
        await rootBundle.load('assets/fonts/openSans/OpenSans-Bold.ttf');
    var font = pw.Font.ttf(fontData);
    List<Font> lfont = [];
    lfont.add(font);
    font = pw.Font.ttf(fontData1);
    // final widgets = await HTMLToPdf().convert(body, fontFallback: lfont);
    lfont.add(font);

    //await for (var page in Printing.raster(pdfBytes, dpi: 100)) {
    //final image = pw.MemoryImage(await page.toPng());
    await for (var page in Printing.raster(pdfBytes, dpi: 120)) {
      final image = pw.MemoryImage(await page.toPng());
      pdf.addPage(
        pw.Page(
          margin: pw.EdgeInsets.zero,
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return pw.Stack(children: [
              pw.Image(image),
              pw.Positioned(
                  top: 4,
                  left: 4,
                  right: 4,
                  child: header2(controller.selected_mrr.value))
            ]);
          },
        ),
      );
    }
    // }

    // // print(widgets.toString());
    // pdf.addPage(
    //   pw.MultiPage(
    //     pageFormat: PdfPageFormat.a4,
    //     margin: const pw.EdgeInsets.only(left: 8, right: 8, bottom: 52, top: 8),
    //     header: (pw.Context context) {
    //       return header(controller, isFinal);
    //     },
    //     footer: (context) {
    //       return footer(controller);
    //     },
    //     build: (context) => [],
    //   ),
    // );

    PdfInvoiceApi.openPdFromFile(pdf, 'Report', () {});
  }

  void showPDF(String body, dynamic controller,
      [Function()? fun, bool isFinal = false]) async {
    // var body = k1;

    final pdf = pw.Document();
    final fontData =
        await rootBundle.load('assets/fonts/openSans/OpenSans-Regular.ttf');
    final fontData1 =
        await rootBundle.load('assets/fonts/openSans/OpenSans-Bold.ttf');
    var font = pw.Font.ttf(fontData);
    List<Font> lfont = [];
    lfont.add(font);
    font = pw.Font.ttf(fontData1);
    final widgets = await HTMLToPdf().convert(body, fontFallback: lfont);
    lfont.add(font);
    lfont.add( await PdfGoogleFonts.robotoBlack());
    lfont.add( await PdfGoogleFonts.latoBlack());
    // print(widgets.toString());
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.only(left: 8, right: 8, bottom: 52, top: 8),
        header: (pw.Context context) {
          return header(controller, isFinal);
        },
        footer: (context) {
          return footer(controller);
        },
        build: (context) => widgets,
      ),
    );

    PdfInvoiceApi.openPdFromFile(pdf, 'Report', () {
      if (fun != null) {
        fun();
      }
    });
  }

  void showPDF2(String body, ModelOutSourceTestData data,
      [Function()? fun, bool isFinal = false]) async {
    // var body = k1;

    final pdf = pw.Document();
    final fontData =
        await rootBundle.load('assets/fonts/openSans/OpenSans-Regular.ttf');
    final fontData1 =
        await rootBundle.load('assets/fonts/openSans/OpenSans-Bold.ttf');
    var font = pw.Font.ttf(fontData);
    List<Font> lfont = [];
    lfont.add(font);
    font = pw.Font.ttf(fontData1);
    final widgets = await HTMLToPdf().convert(body, fontFallback: lfont);
    lfont.add(font);

    // print(widgets.toString());
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.only(left: 8, right: 8, bottom: 52, top: 8),
        header: (pw.Context context) {
          return header2(data, isFinal);
        },
        footer: (context) {
          return footer2(data);
        },
        build: (context) => widgets,
      ),
    );

    PdfInvoiceApi.openPdFromFile(pdf, 'Report', () {
      if (fun != null) {
        fun();
      }
    });
  }

  pw.Widget header2(ModelOutSourceTestData data, [bool isFinal = false]) =>
      pw.Padding(
          padding: const pw.EdgeInsets.only(bottom: 2),
          child: pw.Table(
              border: pw.TableBorder.all(
                  width: 0.4, color: const PdfColor.fromInt(0xFF30384D)),
              columnWidths: {
                0: const pw.FixedColumnWidth(40.0),
                1: const pw.FixedColumnWidth(60.0), // Third column width
              },
              children: [
                pw.TableRow(
                    verticalAlignment: pw.TableCellVerticalAlignment.middle,
                    children: [
                      pw.Column(children: [
                        pw.Padding(
                            padding: const pw.EdgeInsets.all(8),
                            child: pw.SizedBox(
                              height: 40,
                              width: 160,
                            )),
                        pw.Padding(
                            padding: const EdgeInsets.all(8),
                            child: pw.Text(data.reportDept ?? ' ',
                                style: pw.TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14)))
                      ]),
                      //pw.Image(image_header, height: 40, width: 160)),
                      pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Align(
                              alignment: pw.Alignment.topLeft,
                              child: pw.Table(columnWidths: {
                                0: const pw.FixedColumnWidth(60.0),
                                1: const pw.FixedColumnWidth(40.0),
                              }, children: [
                                pw.TableRow(children: [
                                  pw.Column(children: [
                                    _headerRow("Name  : ", data.pname ?? ''),
                                    pw.SizedBox(height: 2),
                                    _headerRow("Age     : ", data.age ?? ''),
                                    pw.SizedBox(height: 2),
                                    _headerRow(
                                        "Dept    : ", data.department ?? ''),
                                    pw.SizedBox(height: 2),
                                    _headerRow("Unit     : ", data.unit ?? ''),
                                    pw.SizedBox(height: 2),
                                    _headerRow("Ref By : ", data.docName ?? ''),
                                    pw.SizedBox(height: 2),
                                  ]),
                                  pw.Column(children: [
                                    _headerRow("MR No   : ", data.mrId ?? ''),
                                    pw.SizedBox(height: 2),
                                    _headerRow("HCN       : ", data.hcn ?? ''),
                                    pw.SizedBox(height: 2),
                                    _headerRow(
                                        "Adm No : ",
                                        (data.regId ?? '') == '0'
                                            ? ''
                                            : (data.regId ?? '')),
                                    pw.SizedBox(height: 2),
                                    _headerRow("Gender  : ", data.psex ?? ''),
                                    pw.SizedBox(height: 2),
                                    _headerRow("Bed No  : ", data.bedno ?? ''),
                                    pw.SizedBox(height: 2),
                                  ])
                                ]),
                                pw.TableRow(children: [
                                  data.finalizedBy != ' '
                                      ? SizedBox()
                                      : pw.Padding(
                                          padding:
                                              const pw.EdgeInsets.symmetric(
                                                  vertical: 4),
                                          child: pw.Center(
                                              child: pw.Text(
                                                  'The report is not finalized!',
                                                  style: const pw.TextStyle(
                                                      color: PdfColor.fromInt(
                                                          0xFFF00606)))),
                                        ),
                                ])
                              ])))
                    ]),
              ]));

  pw.Widget footer2(
    ModelOutSourceTestData data, [
    bool isPrintTime = true,
  ]) {
    String formattedDate =
        DateFormat('dd/MM/yyyy hh:mm a').format(DateTime.now());

    return pw.Column(children: [
      pw.Table(children: [
        pw.TableRow(children: [
          pw.Container(
            height: 0.8,
            color: const PdfColor.fromInt(0xFF30384D),
          ),
        ]),
        pw.TableRow(children: [
          pw.Container(
              child: pw.Table(children: [
            _footerRow("Verify By : ", '( Electronic Signature )',
                "Finalized By : ", '( Electronic Signature )'),
          ])),
        ]),
        pw.TableRow(children: [pw.Container(height: 2)]),
        pw.TableRow(
            verticalAlignment: pw.TableCellVerticalAlignment.middle,
            children: [
              pw.Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Row(children: [
                      pw.Text(data.verifyByName ?? ' ',
                          style: pw.TextStyle(
                              fontSize: 9, fontWeight: FontWeight.normal)),
                      pw.SizedBox(width: 8),
                      pw.Text(data.verifyDate ?? ' ',
                          style: pw.TextStyle(
                              fontSize: 9, fontWeight: FontWeight.normal))
                    ]),
                    pw.Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                      pw.Text(data.finalizedByName ?? ' ',
                          style: pw.TextStyle(
                              fontSize: 9, fontWeight: FontWeight.normal)),
                      pw.SizedBox(width: 8),
                      pw.Text(data.finalizedDate ?? ' ',
                          style: pw.TextStyle(
                              fontSize: 9, fontWeight: FontWeight.normal))
                    ]),
                  ]),
            ]),
        pw.TableRow(children: [pw.Container(height: 2)]),
        pw.TableRow(
            verticalAlignment: pw.TableCellVerticalAlignment.middle,
            children: [
              pw.Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(data.vDegree ?? ' ',
                        style: pw.TextStyle(
                            fontSize: 9, fontWeight: FontWeight.normal)),
                    pw.Text(data.fDegree ?? ' ',
                        style: pw.TextStyle(
                            fontSize: 9, fontWeight: FontWeight.normal)),
                  ]),
            ]),
        pw.TableRow(children: [pw.Container(height: 2)]),
        pw.TableRow(
            verticalAlignment: pw.TableCellVerticalAlignment.middle,
            children: [
              pw.Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(data.vDesig ?? ' ',
                        style: pw.TextStyle(
                            fontSize: 9, fontWeight: FontWeight.normal)),
                    pw.Text(data.fDesig ?? ' ',
                        style: pw.TextStyle(
                            fontSize: 9, fontWeight: FontWeight.normal)),
                  ]),
            ]),
        pw.TableRow(children: [
          pw.Container(
            height: 0.5,
            color: const PdfColor.fromInt(0xFF30384D),
          ),
        ]),
      ]),
      pw.Table(children: [
        pw.TableRow(children: [pw.Container(height: 2)]),
        pw.TableRow(
            verticalAlignment: pw.TableCellVerticalAlignment.middle,
            children: [
              pw.Row(children: [
                pw.Text("Powered by :",
                    style:
                        pw.TextStyle(fontSize: 6, fontWeight: FontWeight.bold)),
                pw.SizedBox(width: 8),
                pw.Text("AAH, IT-Software Team",
                    style: pw.TextStyle(
                        fontSize: 5.5, fontWeight: FontWeight.bold))
              ]),
              !isPrintTime
                  ? pw.SizedBox()
                  : pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.end,
                      children: [
                          pw.Text('Print Date : ',
                              style: pw.TextStyle(
                                  fontSize: 5.5, fontWeight: FontWeight.bold)),
                          pw.SizedBox(width: 4),
                          pw.Text(formattedDate,
                              style: pw.TextStyle(
                                  fontSize: 5.5, fontWeight: FontWeight.normal))
                          //   pw.Image(image_footer, height: 8, width: 60),
                        ])
            ])
      ])
    ]);
  }

  pw.Widget header(dynamic controller, [bool isFinal = false]) => pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 2),
      child: pw.Table(
          border: pw.TableBorder.all(
              width: 0.4, color: const PdfColor.fromInt(0xFF30384D)),
          columnWidths: {
            0: const pw.FixedColumnWidth(40.0),
            1: const pw.FixedColumnWidth(60.0), // Third column width
          },
          children: [
            pw.TableRow(
                verticalAlignment: pw.TableCellVerticalAlignment.middle,
                children: [
                  pw.Column(children: [
                    pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.SizedBox(
                          height: 40,
                          width: 160,
                        )),
                    pw.Padding(
                        padding: const EdgeInsets.all(8),
                        child: pw.Text(
                            controller.selected_mrr.value.reportDept ?? ' ',
                            style: pw.TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14)))
                  ]),
                  //pw.Image(image_header, height: 40, width: 160)),
                  pw.Padding(
                      padding: const pw.EdgeInsets.all(8),
                      child: pw.Align(
                          alignment: pw.Alignment.topLeft,
                          child: pw.Table(columnWidths: {
                            0: const pw.FixedColumnWidth(60.0),
                            1: const pw.FixedColumnWidth(40.0),
                          }, children: [
                            pw.TableRow(children: [
                              pw.Column(children: [
                                _headerRow("Name  : ",
                                    controller.selected_mrr.value.pname ?? ''),
                                pw.SizedBox(height: 2),
                                _headerRow("Age     : ",
                                    controller.selected_mrr.value.age ?? ''),
                                pw.SizedBox(height: 2),
                                _headerRow(
                                    "Dept    : ",
                                    controller.selected_mrr.value.department ??
                                        ''),
                                pw.SizedBox(height: 2),
                                _headerRow("Unit     : ",
                                    controller.selected_mrr.value.unit ?? ''),
                                pw.SizedBox(height: 2),
                                _headerRow(
                                    "Ref By : ",
                                    controller.selected_mrr.value.docName ??
                                        ''),
                                pw.SizedBox(height: 2),
                              ]),
                              pw.Column(children: [
                                _headerRow("MR No   : ",
                                    controller.selected_mrr.value.mrId ?? ''),
                                pw.SizedBox(height: 2),
                                _headerRow("HCN       : ",
                                    controller.selected_mrr.value.hcn ?? ''),
                                pw.SizedBox(height: 2),
                                _headerRow(
                                    "Adm No : ",
                                    (controller.selected_mrr.value.regId ??
                                                '') ==
                                            '0'
                                        ? ''
                                        : (controller
                                                .selected_mrr.value.regId ??
                                            '')),
                                pw.SizedBox(height: 2),
                                _headerRow("Gender  : ",
                                    controller.selected_mrr.value.psex ?? ''),
                                pw.SizedBox(height: 2),
                                _headerRow("Bed No  : ",
                                    controller.selected_mrr.value.bedno ?? ''),
                                pw.SizedBox(height: 2),
                              ])
                            ]),
                            pw.TableRow(children: [
                              isFinal
                                  ? SizedBox()
                                  : pw.Padding(
                                      padding: const pw.EdgeInsets.symmetric(
                                          vertical: 4),
                                      child: pw.Center(
                                          child: pw.Text(
                                              'The report is not finalized!',
                                              style: const pw.TextStyle(
                                                  color: PdfColor.fromInt(
                                                      0xFFF00606)))),
                                    ),
                            ])
                          ])))
                ]),
          ]));

  pw.Widget _headerRow(String caption, String value) =>
      pw.Row(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
        pw.Text(caption,
            style: pw.TextStyle(fontSize: 9, fontWeight: FontWeight.bold)),
        pw.Text(value,
            style: pw.TextStyle(fontSize: 9, fontWeight: FontWeight.normal))
      ]);

  pw.TableRow _footerRow(String cap1, String value1, String cap2, String value2,
          [bool isSpace = true]) =>
      pw.TableRow(
          verticalAlignment: pw.TableCellVerticalAlignment.middle,
          children: [
            pw.Row(children: [
              pw.Text(cap1,
                  style:
                      pw.TextStyle(fontSize: 9, fontWeight: FontWeight.bold)),
              pw.SizedBox(width: isSpace ? 8 : 0),
              pw.Text(value1,
                  style:
                      pw.TextStyle(fontSize: 9, fontWeight: FontWeight.normal)),
            ]),
            pw.Row(mainAxisAlignment: pw.MainAxisAlignment.end, children: [
              pw.Text(cap2,
                  style:
                      pw.TextStyle(fontSize: 9, fontWeight: FontWeight.bold)),
              pw.SizedBox(width: isSpace ? 8 : 0),
              pw.Text(value2,
                  style:
                      pw.TextStyle(fontSize: 9, fontWeight: FontWeight.normal)),
            ])
          ]);

  pw.Widget footer(
    dynamic controller, [
    bool isPrintTime = true,
  ]) =>
      pw.Column(children: [
        pw.Table(children: [
          pw.TableRow(children: [
            pw.Container(
              height: 0.8,
              color: const PdfColor.fromInt(0xFF30384D),
            ),
          ]),
          pw.TableRow(children: [
            pw.Container(
                child: pw.Table(children: [
              _footerRow("Verify By : ", '( Electronic Signature )',
                  "Finalized By : ", '( Electronic Signature )'),
            ])),
          ]),
          pw.TableRow(children: [pw.Container(height: 2)]),
          pw.TableRow(
              verticalAlignment: pw.TableCellVerticalAlignment.middle,
              children: [
                pw.Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Row(children: [
                        pw.Text(
                            controller.selected_mrr.value.verifyByName ?? ' ',
                            style: pw.TextStyle(
                                fontSize: 9, fontWeight: FontWeight.normal)),
                        pw.SizedBox(width: 8),
                        pw.Text(controller.selected_mrr.value.verifyDate ?? ' ',
                            style: pw.TextStyle(
                                fontSize: 9, fontWeight: FontWeight.normal))
                      ]),
                      pw.Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            pw.Text(
                                controller.selected_mrr.value.finalizedByName ??
                                    ' ',
                                style: pw.TextStyle(
                                    fontSize: 9,
                                    fontWeight: FontWeight.normal)),
                            pw.SizedBox(width: 8),
                            pw.Text(
                                controller.selected_mrr.value.finalizedDate ??
                                    ' ',
                                style: pw.TextStyle(
                                    fontSize: 9, fontWeight: FontWeight.normal))
                          ]),
                    ]),
              ]),
          pw.TableRow(children: [pw.Container(height: 2)]),
          pw.TableRow(
              verticalAlignment: pw.TableCellVerticalAlignment.middle,
              children: [
                pw.Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text(controller.selected_mrr.value.vDegree ?? ' ',
                          style: pw.TextStyle(
                              fontSize: 9, fontWeight: FontWeight.normal)),
                      pw.Text(controller.selected_mrr.value.fDegree ?? ' ',
                          style: pw.TextStyle(
                              fontSize: 9, fontWeight: FontWeight.normal)),
                    ]),
              ]),
          pw.TableRow(children: [pw.Container(height: 2)]),
          pw.TableRow(
              verticalAlignment: pw.TableCellVerticalAlignment.middle,
              children: [
                pw.Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text(controller.selected_mrr.value.vDesig ?? ' ',
                          style: pw.TextStyle(
                              fontSize: 9, fontWeight: FontWeight.normal)),
                      pw.Text(controller.selected_mrr.value.fDesig ?? ' ',
                          style: pw.TextStyle(
                              fontSize: 9, fontWeight: FontWeight.normal)),
                    ]),
              ]),
          pw.TableRow(children: [
            pw.Container(
              height: 0.5,
              color: const PdfColor.fromInt(0xFF30384D),
            ),
          ]),
        ]),
        pw.Table(children: [
          pw.TableRow(children: [pw.Container(height: 2)]),
          pw.TableRow(
              verticalAlignment: pw.TableCellVerticalAlignment.middle,
              children: [
                pw.Row(children: [
                  pw.Text("Powered by :",
                      style: pw.TextStyle(
                          fontSize: 6, fontWeight: FontWeight.bold)),
                  pw.SizedBox(width: 8),
                  pw.Text("AAH, IT-Software Team",
                      style: pw.TextStyle(
                          fontSize: 5.5, fontWeight: FontWeight.bold))
                ]),
                !isPrintTime
                    ? pw.SizedBox()
                    : pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.end,
                        children: [
                            pw.Text('Print Date : ',
                                style: pw.TextStyle(
                                    fontSize: 5.5,
                                    fontWeight: FontWeight.bold)),
                            pw.SizedBox(width: 4),
                            pw.Text(controller.print_date.value,
                                style: pw.TextStyle(
                                    fontSize: 5.5,
                                    fontWeight: FontWeight.normal))
                            //   pw.Image(image_footer, height: 8, width: 60),
                          ])
              ])
        ])
      ]);

  Future<String> generatePdfAndConvertToBase64(
      String body, dynamic controller) async {
    // Create a PDF document
    final pdf = pw.Document();

    // Load the fonts
    final fontData =
        await rootBundle.load('assets/fonts/openSans/OpenSans-Regular.ttf');
    final fontData1 =
        await rootBundle.load('assets/fonts/openSans/OpenSans-Bold.ttf');

    // Convert font data to PDF fonts
    var font = pw.Font.ttf(fontData);
    List<pw.Font> lfont = [];
    lfont.add(font);
    font = pw.Font.ttf(fontData1);
    lfont.add(font);

    // Convert HTML to PDF widgets (assuming HTMLToPdf() is a custom method)
    final widgets = await HTMLToPdf().convert(body, fontFallback: lfont);

    // Add a page to the PDF document
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.only(left: 8, right: 8, bottom: 52, top: 8),
        header: (pw.Context context) {
          return header(controller);
        },
        footer: (context) {
          return footer(controller, false);
        },
        build: (context) => widgets,
      ),
    );

    // Convert the PDF to a byte array
    final pdfBytes = await pdf.save();

    // Convert the byte array to a base64 string
    String base64String = base64Encode(pdfBytes);

    return base64String;
  }
}
