// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:agmc/core/config/const.dart';

import 'package:agmc/core/shared/user_data.dart';
import 'package:agmc/model/model_status.dart';
import 'package:intl/intl.dart';

//import 'package:agmc/widget/pdf_widget/invoice.dart';

//import 'package:htmltopdfwidgets/htmltopdfwidgets.dart';

import 'package:quill_html_editor/quill_html_editor.dart';

import '../../../../widget/custom_snakbar.dart';
import '../../lab_outsource_result_entry/model/lab_model_outsource_result.dart';
import '../../lab_outsource_result_entry/model/lab_model_outsource_test_data.dart';
import '../../share_widget/lab_share_mixin.dart';
import '../../share_widget/lab_share_widget.dart';

class OutSourceResultVerifyController extends GetxController
    with MixInController, MyPdfUIMixin {
  final TextEditingController txt_fdate = TextEditingController();
  final TextEditingController txt_tdate = TextEditingController();
  final TextEditingController txt_search = TextEditingController();

  final QuillEditorController Qcontroller = QuillEditorController();
  var isShowLeftPanel = true.obs;

  var isShowPatientDetails = true.obs;
 var isShowFilterButton = false.obs;
  var list_test_data_master = <ModelOutSourceTestData>[].obs;
  var list_test_data_temp = <ModelOutSourceTestData>[].obs;
  var isShowFilter = false.obs;
  var selectedRadioValue = 1.obs;
  var selected_mrr = ModelOutSourceTestData().obs;
  var list_mrr_master = <lab_mrr>[].obs;
  var list_mrr_master_temp = <lab_mrr>[].obs;
  var list_result = <ModelOutSourceResult>[].obs;
  var print_date = ''.obs;

var isTemplate = false.obs;

  void saveTemplate() async {}

  void retriveTemplate()async{}


  void setMrr(ModelOutSourceTestData a) async {
    loader = CustomBusyLoader(context: context);

    list_result.clear();
    Qcontroller.clear();
    selected_mrr.value = a;
    loader.show();
    try {
      Future.delayed(const Duration(milliseconds: 100), () async {
        var x = await api.createLead([
          {
            "tag": "40",
            "p_mr_id": a.mrId,
            "p_sample_id": a.sampleId,
            "p_test_id": a.testId
          }
        ], 'getdata_drs');
        // print(x);

        if (checkJson(x)) {
          list_result.addAll(x.map((e) => ModelOutSourceResult.fromJson(e)));
          if (list_result.isNotEmpty) {
            ModelOutSourceResult s = list_result.first;
            var r = jsonDecode(s.delta!);
            Future.delayed(const Duration(seconds: 1), () {
              Qcontroller.setDelta(r);
              loader.close();
            });
            // Qcontroller.
            //print(s.delta);
            // Qcontroller.setDelta(r);
          } else {
            loader.close();
          }
        } else {
          loader.close();
        }
      });
    } catch (e) {
      loader.close();
    }
  }

  void undo_panel() {
    selected_mrr.value = ModelOutSourceTestData();
    txt_search.text = '';
    selected_mrr.refresh();
  }

  void search() {
    list_test_data_temp.clear();
    list_test_data_temp.addAll(list_test_data_master.where((e) =>
        e.mrId!.toUpperCase().contains(txt_search.text.toUpperCase()) ||
        e.sampleId!.toUpperCase().contains(txt_search.text.toUpperCase())));
    list_test_data_temp.refresh();
    dataManipulate();
  }

  void clickRadioButtpn() {
    selected_mrr.value = ModelOutSourceTestData();
    txt_search.text = '';
    list_test_data_temp.clear();

    list_test_data_temp.addAll(list_test_data_master.where((e) =>
        e.mrType ==
        (selectedRadioValue.value == 1
            ? e.mrType
            : selectedRadioValue.value == 2
                ? 'O'
                : selectedRadioValue.value == 3
                    ? 'I'
                    : 'E')));
    list_test_data_temp.refresh();
    dataManipulate();
  }

  void dataManipulate() {
    list_mrr_master.clear();
    list_mrr_master_temp.clear();
    var mr = <lab_mrr>[];
    // var sm = <_mrr>[];
    for (var a in list_test_data_temp) {
      mr.add(lab_mrr(id: a.mrId, name: a.mrId));
      // sm.add(_mrr(id: a.mrId, name: a.sampleId));
    }
    list_mrr_master.addAll(mr.toSet().toList());
    list_mrr_master_temp.addAll(list_mrr_master);
  }

  void priview() async {
    loader = CustomBusyLoader(context: context);
    loader.show();
    try {
      Future.delayed(const Duration(milliseconds: 100), () async {
        var k1 =
            await lab_widget().getHtmlText(Qcontroller); //  _getHtmlText();

        String formattedDate =
            DateFormat('dd/MM/yyyy hh:mm a').format(DateTime.now());
        print_date.value = formattedDate;
        //  print(formattedDate);

        showPDF(k1, this, () {
          loader.close();
        });
      });
    } catch (e) {
      loader.close();
    }
  }

  void save() async {
    loader = CustomBusyLoader(context: context);
    dialog = CustomAwesomeDialog(context: context);
    loader.show();
    try {
      Map<dynamic, dynamic> l = await Qcontroller.getDelta();

      var deltaJson = jsonEncode(l);
      var k1 = await lab_widget().getHtmlText(Qcontroller);
//p_result_id in varchar2, p_mr_id in varchar2, p_sample_id in varchar2, p_test_id in varchar2,
// p_delta in nclob,p_html in nclob,p_pdf in blob,p_emp_id in varchar2, p_is_final in int
      // print({
      //   "p_result_id": " ",
      //   "p_mr_id": selected_mrr.value.mrId,
      //   "p_sample_id": selected_mrr.value.sampleId,
      //   "p_test_id": selected_mrr.value.testId,
      //   "p_delta": deltaJson,
      //   "p_html": k1,
      //   "p_pdf": "",
      //   "p_emp_id": user.value.eMPID,
      //   "p_is_final": "0"
      // });
      var x = await api.createLead([
        {
          "p_result_id": selected_mrr.value.resultID,
          "p_mr_id": selected_mrr.value.mrId,
          "p_sample_id": selected_mrr.value.sampleId,
          "p_test_id": selected_mrr.value.testId,
          "p_delta": deltaJson,
          "p_html": k1,
          "p_pdf": "",
          "p_emp_id": user.value.eMPID,
          "p_is_final": "1"
        }
      ], 'outsource_result_save');

      // print(x);
      if (checkJson(x)) {
        var s = x.map((e) => ModelStatus.fromJson(e)).first;
        if (s.status != '1') {
          loader.close();
          CustomSnackbar(
              context: context, message: s.msg!, type: MsgType.error);
          return;
        } else {
          CustomSnackbar(
              context: context, message: s.msg!, type: MsgType.success);

          var x = await api.createLead([
            {"tag": "41", "p_result_id": selected_mrr.value.resultID}
          ], "getdata_drs");
          if (checkJson(x)) {
            list_test_data_master.removeWhere((e) =>
                e.mrId == selected_mrr.value.mrId &&
                e.sampleId == selected_mrr.value.sampleId &&
                e.testId == selected_mrr.value.testId);
            list_test_data_temp.clear();
            list_test_data_temp.addAll(list_test_data_master);
            dataManipulate();
            selected_mrr.value =
                x.map((e) => ModelOutSourceTestData.fromJson(e)).first;
          }

          String formattedDate =
            DateFormat('dd/MM/yyyy hh:mm a').format(DateTime.now());
          print_date.value = formattedDate;
          showPDF(k1, this, () {
            loader.close();
            undo_panel();
          });
          // 
        }
      } else {
        loader.close();
        CustomSnackbar(
            context: context,
            message: 'Error to save data!',
            type: MsgType.error);
      }
    } catch (e) {
      loader.close();
      CustomSnackbar(
          context: context, message: e.toString(), type: MsgType.error);
    }
  }

  void showFilterData() async {
    loader = CustomBusyLoader(context: context);
    dialog = CustomAwesomeDialog(context: context);
    loader.show();
    list_test_data_master.clear();
    list_test_data_temp.clear();
    list_mrr_master.clear();
    list_mrr_master_temp.clear();
    if (!isValidDateRange(txt_fdate.text, txt_tdate.text)) {
      loader.close();
      dialog
        ..dialogType = DialogType.warning
        ..message = 'Valid Date Range Required'
        ..show();
      return;
    }
    try {
      var x = await api.createLead([
        {
          "tag": "39",
          "fdate": txt_fdate.text,
          "tdate": txt_tdate.text,
          "p_type": "V"
        }
      ], 'getdata_drs');
      //print(x);
      loader.close();
      if (checkJson(x)) {
        list_test_data_master
            .addAll(x.map((e) => ModelOutSourceTestData.fromJson(e)));
        list_test_data_temp.addAll(list_test_data_master);
        dataManipulate();
      }
    } catch (e) {
      loader.close();
      dialog
        ..dialogType = DialogType.error
        ..message = e.toString()
        ..show();
    }
  }

  @override
  void onInit() async {
    super.onInit();
    isLoading.value = true;
    user.value = await getUserInfo();
    if (user.value.eMPID == null) {
      isLoading.value = false;
      isError.value = true;
      errorMessage.value = 'Re-Loing Required!';
      return;
    }
    try {
      api = data_api();
      var x = await api.createLead([
        {"tag": "39", "fdate": " ", "tdate": " ", "p_type": "V"}
      ], 'getdata_drs');
      //print(x);
      if (checkJson(x)) {
        list_test_data_master
            .addAll(x.map((e) => ModelOutSourceTestData.fromJson(e)));
        list_test_data_temp.addAll(list_test_data_master);
        dataManipulate();
      }
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      isError.value = true;
      errorMessage.value = e.toString();
    }
  }

  @override
  void onClose() {
    Qcontroller.dispose();
    super.onClose();
  }
}
