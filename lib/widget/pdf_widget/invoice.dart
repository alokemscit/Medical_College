import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';

import '../../core/config/function.dart';
import 'api/pdf_api.dart';
import 'package:universal_html/html.dart' as html;
import 'package:pdf/widgets.dart' as p;

class PdfInvoiceApi {
  static Future<void> savePdfAndLaunch(Uint8List bytes) async {
    final blob = html.Blob([bytes]);
    final url = html.Url.createObjectUrlFromBlob(blob);

    // Open the PDF in a new tab
    html.window.open(url, "_blank");

    // Cleanup
    html.Url.revokeObjectUrl(url);
    // final directory = await getTemporaryDirectory();
    // final path = '${directory.path}/example.pdf';
    // final pdfFile = await File(path).writeAsBytes(bytes);

    // // Open the PDF file in a new tab
    // final url = pdfFile.uri.toString();
    // html.AnchorElement(href: url)
    //   ..setAttribute("download", "example.pdf")
    //   ..setAttribute("target", "_blank")
    //   ..style.display = 'none'
    //   ..click();
  }

  static Future<Uint8List> convertPdfToBytes(Document pdf) async {
    // Save the PDF document as bytes
    return await pdf.save();
  }

  static Future<Document> getpdf() async {
//final font = await PdfGoogleFonts.nunitoExtraLight();

    var data = await rootBundle.load("assets/fonts/muli/Muli.ttf");
    var myFont = Font.ttf(data);
    var myStyle = TextStyle(font: myFont);
    final pdf = p.Document();
    //final pdf = Document(pageMode : PdfPageMode.fullscreen);

// Define the maximum number of pages per section

    List<p.Widget> widgets = [];
    widgets.add(p.Text("Aloke", style: myStyle));
    widgets.add(
      p.SizedBox(height: 700),
    );
    widgets.add(p.Text("Alokesaadad", style: myStyle));

    pdf.addPage(p.MultiPage(
        maxPages: 2000,
        pageFormat: PdfPageFormat.a4,
        build: (context) => widgets,
        footer: (context) => p.Table(children: [
              TableRow(children: [
                p.Text("Aloke", style: myStyle),
                p.Text("Aloke", style: myStyle)
              ]),
              // TableRow(children: [
              //   p.Text("Aloke",style: myStyle)
              // ]),

              // p.BarcodeWidget(
              //   height: 20,
              //   width: 100,
              //         textStyle: myStyle,
              //         barcode: Barcode.qrCode(),
              //         data: "12131413",
              //       ),
            ])

        // Column(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: [
        //     p.SizedBox(height: 1 * PdfPageFormat.cm),
        //     p.Row(
        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //       children: [
        //         // buildSupplierAddress(invoice.supplier),
        //         Container(
        //           height: 50,
        //           width: 50,
        //           child: BarcodeWidget(
        //             textStyle: myStyle,
        //             barcode: Barcode.qrCode(),
        //             data: "12131413",
        //           ),
        //         ),
        //       ],
        //     ),
        //     p.SizedBox(height: 1 * PdfPageFormat.cm),
        //     p.Row(
        //       crossAxisAlignment: CrossAxisAlignment.end,
        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //       children: [
        //         //buildCustomerAddress(invoice.customer),
        //         //buildInvoiceInfo(invoice.info),
        //       ],
        //     ),
        //   ],
        // ),

        ));
    return pdf;
  }

  static Future<File> generatePdf(body, footer) async {
    final pdf = Document();

    pdf.addPage(MultiPage(
      build: (context) => [Text("Aloke", style: const TextStyle())],
      footer: (context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 1 * PdfPageFormat.cm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // buildSupplierAddress(invoice.supplier),
              Container(
                height: 50,
                width: 50,
                child: BarcodeWidget(
                  barcode: Barcode.qrCode(),
                  data: "12131413",
                ),
              ),
            ],
          ),
          SizedBox(height: 1 * PdfPageFormat.cm),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //buildCustomerAddress(invoice.customer),
              //buildInvoiceInfo(invoice.info),
            ],
          ),
        ],
      ),
    ));

    return PdfApi.saveDocument(name: 'voucher_invoice.pdf', pdf: pdf);
  }

  static void openPdf(String base64) {
    final div = html.window.document.getElementById('pdf-container');
    if (div != null) {
      //print('object');
      final html.NodeValidatorBuilder htmValidator =
          html.NodeValidatorBuilder()
            ..allowElement('iframe', attributes: ['src', 'width', 'height']);

      div.setInnerHtml(
          '<iframe src= "$base64" width="100%" height="100%"></iframe>',
          validator: htmValidator);
      //  print(div.innerHtml);
      final bb = html.window.document.getElementById('triggerPdfViewer');
      if (bb != null) {
        //print('object');
        bb.dispatchEvent(html.MouseEvent('click'));
      }
    }
  }

  static void openPdfRemote(String urls,
      [String title = 'Report Viewer']) async {
    final bytesData = await fetchPdfBytes(urls);
    String base64Data = base64Encode(bytesData);
    String dataUri = 'data:application/pdf;base64,$base64Data';
//report-title
    final h4 = html.window.document.getElementById('report-title');
    if (h4 != null) {
      h4.setInnerHtml(title);
    }
    final div = html.window.document.getElementById('pdf-container');
    if (div != null) {
      //print('object');
      final html.NodeValidatorBuilder htmValidator =
          html.NodeValidatorBuilder()
            ..allowElement('iframe', attributes: ['src', 'width', 'height']);

      div.setInnerHtml(
          '<iframe src= "$dataUri" width="100%" height="100%"></iframe>',
          validator: htmValidator);
      //  print(div.innerHtml);
      final bb = html.window.document.getElementById('triggerPdfViewer');
      if (bb != null) {
        //print('object');
        bb.dispatchEvent(html.MouseEvent('click'));
      }
    }
  }

  static void openPdfBase64(String base64Data,
      [String title = 'Report Viewer', Function()? fun]) async {
    // final bytesData = await fetchPdfBytes(urls);
    //  String base64Data = base64Encode(bytesData);
    String dataUri = 'data:application/pdf;base64,$base64Data';
    // print(dataUri);
//report-title
    final h4 = html.window.document.getElementById('report-title');
    if (h4 != null) {
      h4.setInnerHtml(title);
    }
    final div = html.window.document.getElementById('pdf-container');
    if (div != null) {
      //print('object');
      final html.NodeValidatorBuilder htmValidator =
          html.NodeValidatorBuilder()
            ..allowElement('iframe', attributes: ['src', 'width', 'height']);

      div.setInnerHtml(
          '<iframe src= "$dataUri" width="100%" height="100%"></iframe>',
          validator: htmValidator);
      //  print(div.innerHtml);
      final bb = html.window.document.getElementById('triggerPdfViewer');
      if (bb != null) {
        //print('object');
        bb.dispatchEvent(html.MouseEvent('click'));
        if (fun != null) {
          fun();
        }
      }
    }
  }

  static void openPdFromFile(Document pdfFile,
      [String title = 'Report Viewer', Function()? fun]) async {
    // final bytesData = await fetchPdfBytes(urls);
    final bytes = await PdfInvoiceApi.convertPdfToBytes(pdfFile);
    String base64Data = base64Encode(bytes);
    String dataUri = 'data:application/pdf;base64,$base64Data';
//report-title
    final h4 = html.window.document.getElementById('report-title');
    if (h4 != null) {
      h4.setInnerHtml(title);
    }
    final div = html.window.document.getElementById('pdf-container');
    if (div != null) {
      //print('object');
      final html.NodeValidatorBuilder htmValidator =
          html.NodeValidatorBuilder()
            ..allowElement('iframe', attributes: ['src', 'width', 'height']);

      div.setInnerHtml(
          '<iframe src= "$dataUri" width="100%" height="100%"></iframe>',
          validator: htmValidator);
      //  print(div.innerHtml);
      final bb = html.window.document.getElementById('triggerPdfViewer');
      if (bb != null) {
        //print('object');
        bb.dispatchEvent(html.MouseEvent('click'));
        if (fun != null) {
          fun();
        }
      }else{
        if (fun != null) {
          fun();
        }
      }
    }else{
      if (fun != null) {
          fun();
        }
    }
  }

  static Future<void> generatePDF(
      Widget header, List<Widget> body, Widget footer,
      [bool isLandScape = false]) async {
    final pdf = Document();

    PdfPageFormat pageFormat = isLandScape
        ? const PdfPageFormat(297 * PdfPageFormat.mm, 210 * PdfPageFormat.mm)
        : const PdfPageFormat(210 * PdfPageFormat.mm, 297 * PdfPageFormat.mm);
    pdf.addPage(
      MultiPage(
          orientation: isLandScape
              ? PageOrientation.landscape
              : PageOrientation.portrait,
          pageFormat: pageFormat,
          header: (context) => header,
          build: (context) => body,
          footer: (context) => footer),
    );
    final bytes = await pdf.save();
    final base64 = base64Encode(bytes);
    PdfInvoiceApi.openPdfBase64(base64);
  }
}




// static Widget buildHeader(Invoice invoice) => Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         SizedBox(height: 1 * PdfPageFormat.cm),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             buildSupplierAddress(invoice.supplier),
//             Container(
//               height: 50,
//               width: 50,
//               child: BarcodeWidget(
//                 barcode: Barcode.qrCode(),
//                 data: invoice.info.number,
//               ),
//             ),
//           ],
//         ),
//         SizedBox(height: 1 * PdfPageFormat.cm),
//         Row(
//           crossAxisAlignment: CrossAxisAlignment.end,
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             buildCustomerAddress(invoice.customer),
//             buildInvoiceInfo(invoice.info),
//           ],
//         ),
//       ],
//     );

// static Widget buildCustomerAddress(Customer customer) => Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(customer.name, style: TextStyle(fontWeight: FontWeight.bold)),
//         Text(customer.address),
//       ],
//     );

// static Widget buildInvoiceInfo(InvoiceInfo info) {
//   final paymentTerms = '${info.dueDate.difference(info.date).inDays} days';
//   final titles = <String>[
//     'Invoice Number:',
//     'Invoice Date:',
//     'Payment Terms:',
//     'Due Date:'
//   ];
//   final data = <String>[
//     info.number,
//     Utils.formatDate(info.date),
//     paymentTerms,
//     Utils.formatDate(info.dueDate),
//   ];

//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: List.generate(titles.length, (index) {
//       final title = titles[index];
//       final value = data[index];

//       return buildText(title: title, value: value, width: 200);
//     }),
//   );
// }

// static Widget buildSupplierAddress(Supplier supplier) => Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(supplier.name, style: TextStyle(fontWeight: FontWeight.bold)),
//         SizedBox(height: 1 * PdfPageFormat.mm),
//         Text(supplier.address),
//       ],
//     );

// static Widget buildTitle(Invoice invoice) => Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'INVOICE',
//           style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//         ),
//         SizedBox(height: 0.8 * PdfPageFormat.cm),
//         Text(invoice.info.description),
//         SizedBox(height: 0.8 * PdfPageFormat.cm),
//       ],
//     );

// static Widget buildInvoice(Invoice invoice) {
//   final headers = [
//     'Description',
//     'Date',
//     'Quantity',
//     'Unit Price',
//     'VAT',
//     'Total'
//   ];
//   final data = invoice.items.map((item) {
//     final total = item.unitPrice * item.quantity * (1 + item.vat);

//     return [
//       item.description,
//       Utils.formatDate(item.date),
//       '${item.quantity}',
//       '\$ ${item.unitPrice}',
//       '${item.vat} %',
//       '\$ ${total.toStringAsFixed(2)}',
//     ];
//   }).toList();

//   return Table.fromTextArray(
//     headers: headers,
//     data: data,
//     border: null,
//     headerStyle: TextStyle(fontWeight: FontWeight.bold),
//     headerDecoration: BoxDecoration(color: PdfColors.grey300),
//     cellHeight: 30,
//     cellAlignments: {
//       0: Alignment.centerLeft,
//       1: Alignment.centerRight,
//       2: Alignment.centerRight,
//       3: Alignment.centerRight,
//       4: Alignment.centerRight,
//       5: Alignment.centerRight,
//     },
//   );
// }

// static Widget buildTotal(Invoice invoice) {
//   final netTotal = invoice.items
//       .map((item) => item.unitPrice * item.quantity)
//       .reduce((item1, item2) => item1 + item2);
//   final vatPercent = invoice.items.first.vat;
//   final vat = netTotal * vatPercent;
//   final total = netTotal + vat;

//   return Container(
//     alignment: Alignment.centerRight,
//     child: Row(
//       children: [
//         Spacer(flex: 6),
//         Expanded(
//           flex: 4,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               buildText(
//                 title: 'Net total',
//                 value: Utils.formatPrice(netTotal),
//                 unite: true,
//               ),
//               buildText(
//                 title: 'Vat ${vatPercent * 100} %',
//                 value: Utils.formatPrice(vat),
//                 unite: true,
//               ),
//               Divider(),
//               buildText(
//                 title: 'Total amount due',
//                 titleStyle: TextStyle(
//                   fontSize: 14,
//                   fontWeight: FontWeight.bold,
//                 ),
//                 value: Utils.formatPrice(total),
//                 unite: true,
//               ),
//               SizedBox(height: 2 * PdfPageFormat.mm),
//               Container(height: 1, color: PdfColors.grey400),
//               SizedBox(height: 0.5 * PdfPageFormat.mm),
//               Container(height: 1, color: PdfColors.grey400),
//             ],
//           ),
//         ),
//       ],
//     ),
//   );
// }

//   static Widget buildFooter(Invoice invoice) => Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Divider(),
//           SizedBox(height: 2 * PdfPageFormat.mm),
//           buildSimpleText(title: 'Address', value: invoice.supplier.address),
//           SizedBox(height: 1 * PdfPageFormat.mm),
//           buildSimpleText(title: 'Paypal', value: invoice.supplier.paymentInfo),
//         ],
//       );

//   static buildSimpleText({
//     required String title,
//     required String value,
//   }) {
//     final style = TextStyle(fontWeight: FontWeight.bold);

//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       crossAxisAlignment: pw.CrossAxisAlignment.end,
//       children: [
//         Text(title, style: style),
//         SizedBox(width: 2 * PdfPageFormat.mm),
//         Text(value),
//       ],
//     );
//   }

//   static buildText({
//     required String title,
//     required String value,
//     double width = double.infinity,
//     TextStyle? titleStyle,
//     bool unite = false,
//   }) {
//     final style = titleStyle ?? TextStyle(fontWeight: FontWeight.bold);

//     return Container(
//       width: width,
//       child: Row(
//         children: [
//           Expanded(child: Text(title, style: style)),
//           Text(value, style: unite ? style : null),
//         ],
//       ),
//     );
//   }
// }
