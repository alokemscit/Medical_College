// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as wd;

dynamic t_tab(dynamic controller, dynamic col) {
  return wd.Padding(
    padding: const wd.EdgeInsets.all(8),
    child: wd.Table(
      border: tableBorder,
      columnWidths: List.generate(
        col.length,
        (index) => wd.FlexColumnWidth(
            col[index].toDouble()), // Adjust the width as needed
      ).asMap().map((index, columnWidth) => MapEntry(index, columnWidth)),
      children: [
        wd.TableRow(
            decoration: wd.BoxDecoration(
                border: wd.Border.all(
              color: const PdfColor.fromInt(0xFF000000),
            )),
            children: [
              tableCell('Code'),
              tableCell('Particulars'),
              tableCollHeader2Cell(
                  tableCell('Opening'),
                  tableCell('Debit', 13, wd.FontWeight.normal),
                  tableCell('Credit', 13, wd.FontWeight.normal)),
              tableCollHeader2Cell(
                  tableCell('Transaction'),
                  tableCell('Debit', 13, wd.FontWeight.normal),
                  tableCell('Credit', 13, wd.FontWeight.normal)),
              tableCollHeader2Cell(
                  tableCell('Closing'),
                  tableCell('Debit', 13, wd.FontWeight.normal),
                  tableCell('Credit', 13, wd.FontWeight.normal)),
            ]),
      ],
    ),
  );
}

wd.TableBorder tableBorder =
    wd.TableBorder.all(width: 0.5, color: const PdfColor.fromInt(0xFF757575));

class tableCell1 {
  String text;
  double fontSize;
  wd.FontWeight fontWeight; // = wd.FontWeight.bold,
  wd.AlignmentGeometry? alignment; // = wd.Alignment.center,
  wd.EdgeInsets? padding; // = const wd.EdgeInsets.all(8)
  tableCell1(
      {required this.text,
      this.fontSize=14,
      this.fontWeight= wd.FontWeight.bold, //,
      this.alignment = wd.Alignment.center, //,
      this.padding = const wd.EdgeInsets.all(8) //,
      });
}

wd.Widget tableCell(String text,
    [double fontSize = 14,
    wd.FontWeight fontWeight = wd.FontWeight.bold,
    wd.AlignmentGeometry? alignment = wd.Alignment.center,
    wd.EdgeInsets? padding = const wd.EdgeInsets.all(8)]) {
  return wd.Container(
    decoration: wd.BoxDecoration(
        border: wd.Border.all(color: PdfColors.black, width: 0.5)),
    alignment: alignment,
    padding: padding,
    child: wd.Text(
      text,
      style: wd.TextStyle(fontWeight: fontWeight, fontSize: fontSize),
    ),
  );
}

wd.Widget tableCollHeader2Cell(
    wd.Widget headerText, wd.Widget text1, wd.Widget text2) {
  return wd.Container(
      decoration: wd.BoxDecoration(
        border: wd.Border.all(color: PdfColors.black),
      ),
      child: wd.Column(children: [
        headerText,
        wd.Row(
          children: [
            wd.Expanded(
              flex: 6,
              child: text1,
            ),
            wd.Expanded(
              flex: 6,
              child: text2,
            )
          ],
        )
      ]));
}
