import 'package:agmc/core/config/const.dart';

import '../../../../core/shared/user_data.dart';
import '../../../../model/model_status.dart';
import '../../../../widget/pdf_widget/invoice.dart';
import '../model/lab_model_life_cycle.dart';

class LabReportLifeCycleController extends GetxController with MixInController {
  final TextEditingController txt_fdate = TextEditingController();
  final TextEditingController txt_tdate = TextEditingController();
  final TextEditingController txt_search = TextEditingController();
  var selectedRadioValue = 1.obs;
  var isShowFilter = false.obs;

  var list_life_cycle_master = <ModelLifeCycle>[].obs;
  var list_life_cycle_temp = <ModelLifeCycle>[].obs;

  void search() {
    list_life_cycle_temp.clear();
    list_life_cycle_temp.addAll(list_life_cycle_master.where((f) =>
        f.mrId!.toUpperCase().contains(txt_search.text.toUpperCase()) ||
        f.sampleId!.toUpperCase().contains(txt_search.text.toUpperCase()) ||
        f.hcn!.toUpperCase().contains(txt_search.text.toUpperCase()) ||
        f.testName!.toUpperCase().contains(txt_search.text.toUpperCase()) ||
        f.pname!.toUpperCase().contains(txt_search.text.toUpperCase()) ||
        f.sampleId!.toUpperCase().contains(txt_search.text.toUpperCase())));
  }

  void clickRadioButtpn() {
    txt_search.text = '';
    list_life_cycle_temp.clear();
    list_life_cycle_temp.addAll(list_life_cycle_master.where((e) =>
        e.mrType ==
        (selectedRadioValue.value == 1
            ? e.mrType
            : selectedRadioValue.value == 2
                ? 'O'
                : selectedRadioValue.value == 3
                    ? 'I'
                    : 'E')));
    list_life_cycle_temp.refresh();
  }

  void showReport2(String id, bool isPrv) async {
    dialog = CustomAwesomeDialog(context: context);
    loader = CustomBusyLoader(context: context);
    loader.show();
    try {
      // print({
      //   "tag": "38",
      //   "p_result_id": id,
      //   "is_preview": isPrv,
      //   "p_rpt": "rptBIO"
      // });
      var y = await api.createLead([
        {"tag": "38", "p_result_id": id, "is_preview": isPrv?"1":"0", "p_rpt": "rptBIO"}
      ], "get_crystal_drs_report");
      //  var y = await api.createLead([
      //   {"tag": isPrv ? "32" : "38", "p_result_id": id, "p_rpt": "rptBIO"}
      // ], "get_crystal_drs_report");
      // var y = await api.createLead([
      //   {"tag": isPrv ? "32" : "30", "p_resid": id, "p_rpt": "rpt_bio_report"}
      // ], "getssrs_drs_report");
      // print(y);
      if (y == []) {
        loader.close();
        dialog
          ..dialogType = DialogType.error
          ..message = 'Report error'
          ..show();
        return;
      }
      ModelStatus mm = y
          .map(
            (e) => ModelStatus.fromJson(e),
          )
          .first;
      if (mm.status != '1') {
        loader.close();
        dialog
          ..dialogType = DialogType.error
          ..message = mm.msg!
          ..show();
        return;
      }
      loader.close();
      PdfInvoiceApi.openPdfBase64(mm.msg!);
    } catch (e) {
      loader.close();
      dialog
        ..dialogType = DialogType.error
        ..message = e.toString()
        ..show();
    }
  }

  void showData() async {
    loader = CustomBusyLoader(context: context);
    loader.show();
    await Future.delayed(const Duration(milliseconds: 10));
    if (!isValidDateRange(txt_fdate.text, txt_tdate.text)) {
      loader.close();
      dialog
        ..dialogType = DialogType.error
        ..message = 'Valid Date Range Required!'
        ..show();
      return;
    }
    list_life_cycle_master.clear();
    list_life_cycle_temp.clear();
    // ignore: use_build_context_synchronously
    dialog = CustomAwesomeDialog(context: context);
    try {
      var x = await api.createLead([
        {"tag": "37", "fdate": txt_fdate.text, "tdate": txt_tdate.text}
      ], 'getdata_drs');
      if (checkJson(x)) {
        list_life_cycle_master.addAll(x.map((e) => ModelLifeCycle.fromJson(e)));
        list_life_cycle_temp.addAll(list_life_cycle_master);
      }
      // print(x);
      loader.close();
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
    api = data_api();
    isLoading.value = true;
    user.value = await getUserInfo();
    if (user.value.eMPID == null) {
      isLoading.value = false;
      isError.value = true;
      errorMessage.value = 'Re-ligin required!';
      return;
    }
    try {
      var x = await api.createLead([
        {"tag": "37", "fdate": " ", "tdate": " "}
      ], 'getdata_drs');
      if (checkJson(x)) {
        list_life_cycle_master.addAll(x.map((e) => ModelLifeCycle.fromJson(e)));
        list_life_cycle_temp.addAll(list_life_cycle_master);
      }
      // print(x);
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      isError.value = true;
      errorMessage.value = e.toString();
    }

    super.onInit();
  }
}
