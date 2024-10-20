import 'package:agmc/core/config/const_widget.dart';
import 'package:agmc/model/model_status.dart';
import 'package:agmc/moduls/finance/sub_ledger_linkage_page/model/model_gl_sl_linkage_master.dart';
import 'package:agmc/widget/custom_snakbar.dart';

import '../../../../core/config/const.dart';
import '../../../../core/shared/user_data.dart';

import '../../ledger_master_page/model/model_ledger_master.dart';
import '../../sub_ledger_master/model/model_subledger_master.dart';

class SubLedgerLinkageController extends GetxController with MixInController {
  var ledger_list = <ModelLedgerMaster>[].obs;

  final TextEditingController txt_search = TextEditingController();

  //var is_cc = false.obs;
  //var is_sl = false.obs;

  var sl_list_main = <ModelSubledgerMaster>[].obs;
  var sl_list_temp = <ModelSubledgerMaster>[].obs;
  var sl_list_search = <ModelSubledgerMaster>[].obs;

  var link_list_main = <ModelGlSlLinkageMaster>[].obs;
  var link_list_temp = <ModelGlSlLinkageMaster>[].obs;

  var selectedLedger = ModelLedgerMaster().obs;
  var isSlLoading = false.obs;

  void search() {
    sl_list_temp.clear();
    sl_list_temp.addAll(sl_list_search.where((p0) =>
        p0.nAME!.toUpperCase().contains(txt_search.text.toUpperCase()) ||
        p0.cODE!.toUpperCase().contains(txt_search.text.toUpperCase())));
  }

  void deleteSL(ModelGlSlLinkageMaster e11) async {
    dialog = CustomAwesomeDialog(context: context);
    loader = CustomBusyLoader(context: context);
    loader.show();
    try {
      api.createLead([
        {
          "tag": "77",
          "p_cid": user.value.comID,
          "p_slid": e11.sLID,
          "p_glid": e11.gLID,
          "is_add": "0",
          "p_user": user.value.eMPID
        }
      ]).then((value) {
        loader.close();
        if (value == []) {
          dialog
            ..dialogType = DialogType.error
            ..message = "Network error!"
            ..show();
          return;
        }
        ModelStatus s = value.map((e) => ModelStatus.fromJson(e)).first;
        if (s.status != '1') {
          dialog
            ..dialogType = DialogType.error
            ..message = s.msg!
            ..show();
          return;
        }

        // dialog
        //   ..dialogType = DialogType.success
        //   ..message = s.msg!
        //   ..show();
        CustomSnackbar(
            context: context, message: s.msg!, type: MsgType.success);

        link_list_main.removeWhere(
            (element) => element.gLID == e11.gLID && element.sLID == e11.sLID);
        link_list_temp.clear();
        link_list_temp.addAll(link_list_main);

        selectedLedger.value = ModelLedgerMaster();
      });
    } catch (e) {
      loader.close();
      dialog
        ..dialogType = DialogType.error
        ..message = e.toString()
        ..show();
    }
  }

  void add(ModelSubledgerMaster e) async {
    dialog = CustomAwesomeDialog(context: context);
    loader = CustomBusyLoader(context: context);
    loader.show();
    //p_cid in int,p_slid in int, p_glid in int, is_add in int, p_user in int
    try {
      api.createLead([
        {
          "tag": "77",
          "p_cid": user.value.comID,
          "p_slid": e.iD,
          "p_glid": selectedLedger.value.iD,
          "is_add": "1",
          "p_user": user.value.eMPID
        }
      ]).then((value) {
        loader.close();
        if (value == []) {
          dialog
            ..dialogType = DialogType.error
            ..message = "Network error!"
            ..show();
          return;
        }
        ModelStatus s = value.map((e) => ModelStatus.fromJson(e)).first;
        if (s.status != '1') {
          dialog
            ..dialogType = DialogType.error
            ..message = s.msg!
            ..show();
          return;
        }

        // dialog
        //   ..dialogType = DialogType.success
        //   ..message = s.msg!
        //   ..show();
         CustomSnackbar(
            context: context, message: s.msg!, type: MsgType.success);

        link_list_main.add(ModelGlSlLinkageMaster(
            gLCode: selectedLedger.value.cODE,
            gLID: selectedLedger.value.iD,
            gLNAME: selectedLedger.value.nAME,
            sLCode: e.cODE,
            sLID: e.iD,
            sLNAME: e.nAME));
        link_list_temp.clear();
        link_list_temp.addAll(link_list_main);
        sl_list_temp.removeWhere((element) => element.iD == e.iD);
        sl_list_search.clear();
        sl_list_search.addAll(sl_list_temp);
      });
    } catch (e) {
      loader.close();
      dialog
        ..dialogType = DialogType.error
        ..message = e.toString()
        ..show();
    }
  }

  void loadSubLedger(ModelLedgerMaster e) {
    isSlLoading.value = true;
    sl_list_temp.clear();

    var y = RxList<ModelSubledgerMaster>.from(sl_list_main);
    link_list_main.where((p0) => p0.gLID == e.iD).forEach((e1) {
      //print(e1.sLID!);
      y.removeWhere((element) => element.iD == e1.sLID);
    });

    sl_list_temp.addAll(y);
    sl_list_search.clear();
    sl_list_search.addAll(sl_list_temp);
    selectedLedger.value = e;
    isSlLoading.value = false;
  }

  @override
  void onInit() async {
    isLoading.value = true;
    isError.value = false;
    api = data_api();
    try {
      user.value = await getUserInfo();
      //print(user.value.comID);

      var x = await api.createLead([
        {"tag": "70", "p_cid": user.value.comID}
      ]);
      print(x);
      ledger_list.addAll(x.map((e) => ModelLedgerMaster.fromJson(e)));

      var y = await api.createLead([
        {"tag": "72", "p_cid": user.value.comID}
      ]);
      sl_list_main.addAll(y.map((e) => ModelSubledgerMaster.fromJson(e)));
      // print(y);
      var z = await api.createLead([
        {"tag": "76", "p_cid": user.value.comID}
      ]);
      link_list_main.addAll(z.map((e) => ModelGlSlLinkageMaster.fromJson(e)));
      link_list_temp.addAll(link_list_main);
      // print(z);
      //  sl_list_temp.addAll(sl_list_main);

      isLoading.value = false;
    } catch (e) {
      isError.value = true;
      isLoading.value = false;
      errorMessage.value = e.toString();
    }
    super.onInit();
  }
}
