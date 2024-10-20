import 'package:agmc/core/config/const.dart';
import 'package:htmltopdfwidgets/htmltopdfwidgets.dart';

import '../../../../widget/custom_pdf_generatoe.dart';
import '../../mc_account_enrollment/model/mc_model_trans_details.dart';

import 'package:pdf/widgets.dart' as pw;

class pwReportTransaction {
  final List<MadelTransactionDetails> list;
  final Font? font;
  final pw.MemoryImage? image;
  final Function()? onComlpete;

  pwReportTransaction(
      {required this.list,
      required this.font,
      required this.image,
       this.onComlpete});

  Future<void> showReport(
      // List<MadelTransactionDetails> list,
      // Font? font,
      // pw.MemoryImage? image,

      // McFeeCollectionController controller,
      ) async {
    //var font = controller.font.value;
    //var image = image!;
    var first = list.first;
    CustomPDFGenerator(
        font: font,
        header: [
          pwLogo(image!),
         // pw.Image(image!, width: 150, height: 80),
          pwHeight(12),
          pwText2Col(font, 'Transaction no : ', first.trnsNo ?? '',
              'Trans. Date:', first.collDate ?? ''),
          pwHeight(4),
          pwText2Col(font, 'Session : ', first.sesName ?? '', 'Trans Type :',
              first.colltype ?? ''),
          pwHeight(4),
          pwTextOne(font, 'Roll  : ', first.stRoll ?? '', 9,
              pwMainAxisAlignmentStart),
          pwHeight(4),
          pwTextOne(font, 'Name : ', first.stName ?? '', 9,
              pwMainAxisAlignmentStart),
        ],
        footer: [
          pwTextOne(font, 'Collected By  : ', first.collByName ?? '', 9,
              pwMainAxisAlignmentStart),
        ],
        body: [
          pwGenerateTable([
            70,
            30
          ], [
            pwTableCell('Particullers', font, pwAligmentLeft, 12),
            pwTableCell('Amount', font, pwAligmentRight, 12),
          ], [
            ...list.map((f) => pwTableRow(
                    // decoration: pw.BoxDecoration(color: ),
                     [
                      pwTableCell(f.headtypeName ?? '', font),
                      pwTableCell(
                          f.amt.toString(), font, pwAligmentRight),
                    ])),
            pwTableRow(
                
                 [
                  pwTableCell('Total', font, pwAligmentRight, 10),
                  pwTableCell(
                      list
                          .fold(0.00,
                              (previous, current) => previous + current.amt!)
                          .toString(),
                      font,
                      pwAligmentRight,
                      10),
                ],
                  pwBoxDecorationFooter,
                ),
          ]),
          pwHeight(12),
          (list.first.trnsNote ?? ' ') == ' '
              ? pwSizedBox()
              : pwTextOne(font, 'Note : ', list.first.trnsNote ?? '', 12,
                 pwMainAxisAlignmentStart)
        ],
        fun: () {
          if (onComlpete != null) {
            onComlpete!();
          }
        }).ShowReport();
  }
}
