
import 'package:htmltopdfwidgets/htmltopdfwidgets.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/services.dart' show  rootBundle;

import '../../../widget/pdf_widget/invoice.dart';

mixin MyPdfUIMixin {
  void showPDF(
      String body, pw.MemoryImage image_footer, dynamic controller) async {
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
          return header(controller);
        },
        footer: (context) {
          return footer(image_footer, controller);
        },
        build: (context) => widgets,
      ),
    );
    PdfInvoiceApi.openPdFromFile(pdf);
  }

  pw.Widget header(dynamic controller) => pw.Padding(
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
                  pw.Padding(
                      padding: const pw.EdgeInsets.all(8),
                      child: pw.SizedBox(height: 40, width: 160)),
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
                                _headerRow("Adm No : ",
                                    controller.selected_mrr.value.regId ?? ''),
                                pw.SizedBox(height: 2),
                                _headerRow("Gender  : ",
                                    controller.selected_mrr.value.psex ?? ''),
                                pw.SizedBox(height: 2),
                                _headerRow("Bed No  : ",
                                    controller.selected_mrr.value.bedno ?? ''),
                                pw.SizedBox(height: 2),
                              ])
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

  pw.TableRow _footerRow(
          String cap1, String value1, String cap2, String value2) =>
      pw.TableRow(
          verticalAlignment: pw.TableCellVerticalAlignment.middle,
          children: [
            pw.Row(children: [
              pw.Text(cap1,
                  style:
                      pw.TextStyle(fontSize: 9, fontWeight: FontWeight.bold)),
              pw.SizedBox(width: 8),
              pw.Text(value1,
                  style:
                      pw.TextStyle(fontSize: 9, fontWeight: FontWeight.normal)),
            ]),
            pw.Row(mainAxisAlignment: pw.MainAxisAlignment.end, children: [
              pw.Text(cap2,
                  style:
                      pw.TextStyle(fontSize: 9, fontWeight: FontWeight.bold)),
              pw.SizedBox(width: 8),
              pw.Text(value2,
                  style:
                      pw.TextStyle(fontSize: 9, fontWeight: FontWeight.normal)),
            ])
          ]);

  pw.Widget footer(pw.MemoryImage image_footer,
          dynamic controller) =>
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
              _footerRow(
                  "Verify By      : ",
                  controller.selected_mrr.value.verifyBy ?? '',
                  "Finalized By : ",
                  controller.selected_mrr.value.finalizedBy ?? ''),
              pw.TableRow(children: [pw.Container(height: 2)]),
              _footerRow(
                  "Verify Date   : ",
                  controller.selected_mrr.value.verifyDate ?? '',
                  "Finalized Date : ",
                  '      ${controller.selected_mrr.value.finalizedDate ?? ''}'),
            ])),
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
                  pw.Text("115/7/A Distillery Road, Gendaria, Dhaka-1204",
                      style: pw.TextStyle(
                          fontSize: 6, fontWeight: FontWeight.bold)),
                  pw.SizedBox(width: 8),
                  // pw.Text("10/08/24 ",style: pw.TextStyle(fontSize: 11,fontWeight:FontWeight.normal))
                ]),
                pw.Row(mainAxisAlignment: pw.MainAxisAlignment.end, children: [
                  pw.Text("Email:info@agh.com,admin@agh.com ",
                      style: pw.TextStyle(
                          fontSize: 6, fontWeight: FontWeight.bold)),
                  pw.SizedBox(width: 8),
                  pw.Text("Web: www.agh.com,www.citygroupbd.com",
                      style: pw.TextStyle(
                          fontSize: 5.5, fontWeight: FontWeight.normal))
                ])
              ]),
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
                pw.Row(mainAxisAlignment: pw.MainAxisAlignment.end, children: [
                  pw.SizedBox(width: 8),
                  pw.Image(image_footer, height: 8, width: 60),
                ])
              ])
        ])
      ]);
}
