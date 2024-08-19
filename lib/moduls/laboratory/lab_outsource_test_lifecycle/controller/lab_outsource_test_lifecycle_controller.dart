import 'dart:convert';

import 'package:agmc/core/config/const.dart';
import 'package:agmc/core/shared/user_data.dart';
import 'package:intl/intl.dart';

import '../../lab_outsource_result_entry/model/lab_model_outsource_result.dart';
import '../../lab_outsource_result_entry/model/lab_model_outsource_test_data.dart';
import '../../share_widget/lab_share_mixin.dart';
import '../../share_widget/lab_share_widget.dart';

class LabOutsourceTestLifecycleController extends GetxController
    with MixInController, MyPdfUIMixin {
  final TextEditingController txt_fdate = TextEditingController();
  final TextEditingController txt_tdate = TextEditingController();
  final TextEditingController txt_search = TextEditingController();
  var isShowFilter = false.obs;
  var selectedRadioValue = 1.obs;
  var print_date = ''.obs;

  var list_test_data_master = <ModelOutSourceTestData>[].obs;
  var list_test_data_temp = <ModelOutSourceTestData>[].obs;
  var list_result = <ModelOutSourceResult>[].obs;

  var selected_mrr = ModelOutSourceTestData().obs;

  void printPreview(ModelOutSourceTestData a) async {
    selected_mrr.value = ModelOutSourceTestData();

    selected_mrr.value = a;
    loader = CustomBusyLoader(context: context);
    loader.show();
    try {
      var x = await api.createLead([
        {
          "tag": "40",
          "p_mr_id": a.mrId,
          "p_sample_id": a.sampleId,
          "p_test_id": a.testId
        }
      ], 'getdata_drs');
      // print({
      //   "tag": "40",
      //   "p_mr_id": a.mrId,
      //   "p_sample_id": a.sampleId,
      //   "p_test_id": a.testId
      // });
      //  print(x);
      if (checkJson(x)) {
        //print(x);
        list_result.clear();
        list_result.addAll(x.map((e) => ModelOutSourceResult.fromJson(e)));
        if (list_result.isNotEmpty) {
          ModelOutSourceResult s = list_result.first;
          var r = jsonDecode(s.delta!);
          var k1 = await lab_widget().getHtmlFromDelta(r);
          // String formattedDate =
          //     DateFormat('dd/MM/yyyy hh:mm A').format(DateTime.now());
          // print_date.value = formattedDate;

          showPDF2(k1, a, () {
            loader.close();
          });
        } else {
          loader.close();
        }
      } else {
        loader.close();
      }
    } catch (e) {
      loader.close();
    }
  }

  void showData() async {
    loader = CustomBusyLoader(context: context);
    dialog = CustomAwesomeDialog(context: context);
    loader.show();
    list_test_data_temp.clear();
    list_test_data_master.clear();
    try {
      //print({"tag": "42", "fdete": txt_fdate.text, "tdate": txt_tdate.text});
      var x = await api.createLead([
        {"tag": "42", "fdete": txt_fdate.text, "tdate": txt_tdate.text}
      ], 'getdata_drs');
      // print(x);
      loader.close();
      if (checkJson(x)) {
        list_test_data_master
            .addAll(x.map((e) => ModelOutSourceTestData.fromJson(e)));
        list_test_data_temp.addAll(list_test_data_master);
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
    api = data_api();
    isLoading.value = true;
    user.value = await getUserInfo();
    if (user.value.eMPID == null) {
      isLoading.value = false;
      isError.value = true;
      errorMessage.value = 'Re-Login required!';
      return;
    }
    String formattedDate = DateFormat('dd/MM/yyyy')
        .format(DateTime.now().subtract(const Duration(days: 30)));
    txt_fdate.text = formattedDate;
    formattedDate = DateFormat('dd/MM/yyyy').format(DateTime.now());
    txt_tdate.text = formattedDate;

    try {
      //print({"tag": "42", "fdete": txt_fdate.text, "tdate": txt_tdate.text});
      var x = await api.createLead([
        {"tag": "42", "fdete": txt_fdate.text, "tdate": txt_tdate.text}
      ], 'getdata_drs');
      // print(x);
      isLoading.value = false;
      if (checkJson(x)) {
        list_test_data_master
            .addAll(x.map((e) => ModelOutSourceTestData.fromJson(e)));
        list_test_data_temp.addAll(list_test_data_master);
      }
    } catch (e) {
      isLoading.value = false;
      isError.value = true;
      errorMessage.value = e.toString();
    }

    //print(formattedDate);
  }

  void search() {
    list_test_data_temp.clear();
    list_test_data_temp.addAll(list_test_data_master.where((f) =>
        f.mrId!.toUpperCase().contains(txt_search.text.toUpperCase()) ||
        f.sampleId!.toUpperCase().contains(txt_search.text.toUpperCase()) ||
        f.hcn!.toUpperCase().contains(txt_search.text.toUpperCase()) ||
        f.testName!.toUpperCase().contains(txt_search.text.toUpperCase()) ||
        f.pname!.toUpperCase().contains(txt_search.text.toUpperCase()) ||
        f.sampleId!.toUpperCase().contains(txt_search.text.toUpperCase())));
  }

  void clickRadioButtpn() {
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
  }

  // void showData() async {
  //   // loader = CustomBusyLoader(context: context);
  //   // loader.show();
  //   // await Future.delayed(const Duration(milliseconds: 10));
  //   // if (!isValidDateRange(txt_fdate.text, txt_tdate.text)) {
  //   //   loader.close();
  //   //   dialog
  //   //     ..dialogType = DialogType.error
  //   //     ..message = 'Valid Date Range Required!'
  //   //     ..show();
  //   //   return;
  //   // }
  //   // list_life_cycle_master.clear();
  //   // list_life_cycle_temp.clear();
  //   // // ignore: use_build_context_synchronously
  //   // dialog = CustomAwesomeDialog(context: context);
  //   // try {
  //   //   var x = await api.createLead([
  //   //     {"tag": "37", "fdate": txt_fdate.text, "tdate": txt_tdate.text}
  //   //   ], 'getdata_drs');
  //   //   if (checkJson(x)) {
  //   //     list_life_cycle_master.addAll(x.map((e) => ModelLifeCycle.fromJson(e)));
  //   //     list_life_cycle_temp.addAll(list_life_cycle_master);
  //   //   }
  //   //   // print(x);
  //   //   loader.close();
  //   // } catch (e) {
  //   //   loader.close();
  //   //   dialog
  //   //     ..dialogType = DialogType.error
  //   //     ..message = e.toString()
  //   //     ..show();
  //   // }
  // }
}
