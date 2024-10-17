import 'package:htmltopdfwidgets/htmltopdfwidgets.dart';
import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart' as pw;

import '../core/config/function.dart';
import 'pdf_widget/api/pdf_api.dart';

class CustomPDFGenerator {
  //final List<ModelPReqMaster> list;
  // final ModelUser user;
  //CustomBusyLoader loader;
  final Font? font;
  final List<pw.Widget> header;
  final List<pw.Widget> footer;
  final List<pw.Widget> body;
  final void Function() fun;
  final PageOrientation? orientation;
  CustomPDFGenerator(
      {required this.font,
      required this.header,
      required this.footer,
      required this.body,
      void Function()? fun,
      this.orientation=PageOrientation.portrait
      })
      : fun = fun ?? (() {});

  String getDate() {
    return DateFormat('dd/MM/yyyy hh:mm a').format(DateTime.now());
  }

  pw.Widget _header() => pw.Column(children: [
        pw.Column(
            // mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: header //[

            ),
        pw.SizedBox(height: 15),
        pw.Divider(height: 2),
        pw.SizedBox(height: 15),
      ]);
  pw.Widget _footer() => pw.Column(children: [
        pw.Divider(height: 2),
        pw.SizedBox(height: 4),
        pw.Column(children: footer),
        pw.Row(mainAxisAlignment: pw.MainAxisAlignment.end, children: [
          pwTextCaption('Printed Date', font, 8),
          pw.SizedBox(width: 8),
          pwTextCaption(getDate(), font, 7.5)
        ]),
        pw.SizedBox(height: 4),
      ]);

  void ShowReport() async {
    PdfApi.showPDFformWidget(body, _header(), _footer(), () {
      //oader.close();
      fun();
        },'Report',const pw.EdgeInsets.symmetric(vertical: 4, horizontal: 6),orientation);
  }
}
