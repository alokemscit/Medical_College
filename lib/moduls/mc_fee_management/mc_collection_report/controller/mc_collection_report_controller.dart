// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:agmc/core/config/const.dart';
 
import 'package:agmc/core/shared/user_data.dart';
import 'package:agmc/model/model_common.dart';
import 'package:agmc/widget/custom_pdf_generatoe.dart';
 
import 'package:intl/intl.dart';

import '../../mc_account_enrollment/model/mc_model_trans_details.dart';
import '../../mc_fee_collection/shared_widget/mv_transaction_report.dart';
import '../model/mc_model_trans_data_all.dart';

class McCollectionReportController extends GetxController with MixInController {
  var list_fee_type = <ModelCommon>[].obs;
  var list_trans_master = <ModelTransDataAllMC>[].obs;
  var list_trans_temp = <ModelTransDataAllMC>[].obs;
  var cmb_fee_typeID = ''.obs;
  final TextEditingController txt_fdate = TextEditingController();
  final TextEditingController txt_tdate = TextEditingController();
  final TextEditingController txt_search = TextEditingController();
  var list_trans_details = <MadelTransactionDetails>[].obs;

  @override
  void onInit() async {
    isLoading.value = true;
    user.value = await getUserInfo();
    if (user.value.eMPID == null) {
      isLoading.value = false;
      isError.value = true;
      errorMessage.value = 'Re-Login Required!';
      return;
    }
    image.value = await pwLoadImageWidget(user.value.comID!);
    font.value = await CustomLoadFont(appFontPathRoboto);

    try {
      var x = await api.createLead([
        {"tag": "1", "p_cid": user.value.comID}
      ], 'getdata_mc');
      if (checkJson(x)) {
        list_fee_type.addAll(x.map((e) => ModelCommon.fromJson(e)));
        list_fee_type.insert(0, ModelCommon(id: "0", name: "All"));
      }
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      isError.value = true;
      errorMessage.value = e.toString();
    }
    super.onInit();
  }

  void search() {
    list_trans_temp.clear();
    list_trans_temp.addAll(list_trans_master.where((f) =>
        f.stNo!.toUpperCase().contains(txt_search.text.toUpperCase()) ||
        f.sesName!.toUpperCase().contains(txt_search.text.toUpperCase()) ||
        f.roll!.toUpperCase().contains(txt_search.text.toUpperCase()) ||
        f.trnsNo!.toUpperCase().contains(txt_search.text.toUpperCase()) ||
        f.tillDate!.toUpperCase().contains(txt_search.text.toUpperCase()) ||
        f.feeTypeBname!.toUpperCase().contains(txt_search.text.toUpperCase()) ||
        f.cr!
            .toString()
            .toUpperCase()
            .contains(txt_search.text.toUpperCase()) ||
        f.trnsDetails!.toUpperCase().contains(txt_search.text.toUpperCase())));
  }

  void showTransReport(String id) async {
    list_trans_details.clear();
    loader.show();
    try {
      var x = await api.createLead([
        {"tag": "8", "p_tid": id}
      ], 'getdata_mc');

      // loader.close();
      if (checkJson(x)) {
        list_trans_details
            .addAll(x.map((e) => MadelTransactionDetails.fromJson(e)));
        if (list_trans_details.isNotEmpty) {
          Future.delayed(const Duration(milliseconds: 1), () {
            pwReportTransaction(
              font: font.value,
              image: image.value,
              list: list_trans_details,
              onComlpete: () {
                loader.close();
              },
            ).showReport();
          });
        }
      }
    } catch (e) {
      loader.close();
      dialog
        ..dialogType = DialogType.error
        ..message = e.toString()
        ..show();
    }
  }

  void showData() async {
    list_trans_master.clear();
    list_trans_temp.clear();
    if (isCheckCondition(
        cmb_fee_typeID.value == '', dialog, 'Please select transaction type!'))
      return;
    if (isCheckCondition(!(isValidDateRange(txt_fdate.text, txt_tdate.text)),
        dialog, 'Invalid date range!')) return;
    loader.show();
    try {
      var x = await api.createLead([
        {
          "tag": "11",
          "p_feetypeid": cmb_fee_typeID.value,
          "fdate": txt_fdate.text,
          "tdate": txt_tdate.text
        }
      ], 'getdata_mc');
      // print(x);
      if (checkJson(x)) {
        list_trans_master.addAll(x.map((e) => ModelTransDataAllMC.fromJson(e)));
        list_trans_temp.addAll(list_trans_master);
      }
      loader.close();
    } catch (e) {
      loader.close();
      dialog
        ..dialogType = DialogType.error
        ..message = e.toString()
        ..show();
    }
  }

  void printTable() async {
    loader.show();
    Future.delayed(const Duration(milliseconds: 100), () {
      DateFormat("dd/MM/yyyy").format(DateTime.now());
      CustomPDFGenerator(
        font: font.value,
        header: [
          pwLogo(image.value!),
          pwText2Col(
              font.value,
              'Colletion Type :',
              list_fee_type
                  .where((e) => e.id == cmb_fee_typeID.value)
                  .first
                  .name!,
              "Date Range :",
                 '${txt_fdate.text}  to  ${txt_tdate.text}' ),
           
        ],
        footer: [
          pwTextOne(font.value, "Printed By :", user.value.eMPNAME!,9,pwMainAxisAlignmentStart )
        ],
        body: [
          pwGenerateTable([30,15,60,30,40,30], [
          pwTableColumnHeader('St. ID', font.value),
          pwTableColumnHeader('Roll', font.value,pwAligmentCenter),
          pwTableColumnHeader('Name', font.value),
          pwTableColumnHeader('Date', font.value),
          pwTableColumnHeader('Trns. Type', font.value),
          pwTableColumnHeader('Amount', font.value,pwAligmentRight),
          ], 
          [
            ...list_trans_master.map((f)=>pwTableRow([
              pwTableCell(f.stNo!, font.value,pwAligmentLeft,8),
              pwTableCell(f.roll!, font.value,pwAligmentCenter,8),
              pwTableCell(f.stName!, font.value,pwAligmentLeft,8),
              pwTableCell(f.tillDate!, font.value,pwAligmentLeft,8),
              pwTableCell(f.feeTypeBname!, font.value,pwAligmentLeft,8),
              pwTableCell((f.cr??0).toString(), font.value,pwAligmentRight,8),
            ])),
            pwTableRow([pwSizedBox(),pwSizedBox(),pwSizedBox(),pwSizedBox(),pwTableCell('Grand Total', font.value,pwAligmentRight,10),
             pwTableCell( list_trans_master.fold(0.0,(initialValue, combine)=>initialValue+combine.cr!).toString(),font.value,pwAligmentRight,10)
            ],pwBoxDecorationFooter)
          ]
          )
        ],
        fun: () {
          loader.close();
        },
      ).ShowReport();
    });
    //PdfInvoiceApi.generatePDF(header, body, footer)
  }
}
