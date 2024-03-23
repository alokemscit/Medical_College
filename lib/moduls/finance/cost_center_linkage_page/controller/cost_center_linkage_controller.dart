import 'package:agmc/core/config/const.dart';
import 'package:agmc/core/config/const_widget.dart';
import 'package:agmc/moduls/finance/cost_center_page/model/model_costcenter_master.dart';

import '../../../../core/shared/user_data.dart';
import '../../../../model/model_status.dart';
import '../../ledger_master_page/model/model_ledger_master.dart';
import '../model/model_gl_with_cc_master.dart';
 
 
class CostCenterLinkageController extends GetxController with MixInController{
 var ledger_list = <ModelLedgerMaster>[].obs;
  
  final TextEditingController txt_search = TextEditingController();

  //var is_cc = false.obs;
  //var is_sl = false.obs;

  var cc_list_main = <ModelCostcenterMaster>[].obs;
  var cc_list_temp = <ModelCostcenterMaster>[].obs;
  var cc_list_search = <ModelCostcenterMaster>[].obs;

  var link_list_main = <ModelGlCCLinkageMaster>[].obs;
  var link_list_temp = <ModelGlCCLinkageMaster>[].obs;

  var selectedLedger = ModelLedgerMaster().obs;
  var isSlLoading = false.obs;
void add(ModelCostcenterMaster e){
dialog = CustomAwesomeDialog(context: context);
    loader = CustomBusyLoader(context: context);
    loader.show();
    //p_cid in int,p_slid in int, p_glid in int, is_add in int, p_user in int
    try {
      api.createLead([
        {
          "tag": "79",
          "p_cid": user.value.comID,
          "p_ccid": e.iD,
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

        dialog
          ..dialogType = DialogType.success
          ..message = s.msg!
          ..show();

        link_list_main.add(ModelGlCCLinkageMaster(
            gLCode: selectedLedger.value.cODE,
            gLID: selectedLedger.value.iD,
            gLNAME: selectedLedger.value.nAME,
            cCCode: e.cODE,
            cCID: e.iD,
            cCNAME: e.nAME));
        link_list_temp.clear();
        link_list_temp.addAll(link_list_main);
        cc_list_temp.removeWhere((element) => element.iD == e.iD);
        cc_list_search.clear();
        cc_list_search.addAll(cc_list_temp);
      });
    } catch (e) {
      loader.close();
      dialog
        ..dialogType = DialogType.error
        ..message = e.toString()
        ..show();
    }

}
  void search(){
      cc_list_temp.clear();
    cc_list_temp.addAll(cc_list_search.where((p0) =>
        p0.nAME!.toUpperCase().contains(txt_search.text.toUpperCase()) ||
        p0.cODE!.toUpperCase().contains(txt_search.text.toUpperCase())));
  }
  void deleteCC(ModelGlCCLinkageMaster e){
dialog = CustomAwesomeDialog(context: context);
    loader = CustomBusyLoader(context: context);
    loader.show();
    try {
      api.createLead([
        {
          "tag": "79",
          "p_cid": user.value.comID,
          "p_ccid": e.cCID,
          "p_glid": e.gLID,
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

        dialog
          ..dialogType = DialogType.success
          ..message = s.msg!
          ..show();
          link_list_main.removeWhere(
        (element) => element.gLID == e.gLID && element.cCID == e.cCID);
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

  void loadCC(ModelLedgerMaster e){
 isSlLoading.value = true;
    cc_list_temp.clear();

    var y = RxList<ModelCostcenterMaster>.from(cc_list_main);
    link_list_main.where((p0) => p0.gLID == e.iD).forEach((e1) {
      //print(e1.sLID!);
      y.removeWhere((element) => element.iD == e1.cCID);
    });

    cc_list_temp.addAll(y);
    cc_list_search.clear();
    cc_list_search.addAll(cc_list_temp);
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
      if (user.value == null) {
        isError.value = true;
        isLoading.value = false;
        errorMessage.value = "User re-login required!";
        return;
      }
      //print(user.value.comID);

      var x = await api.createLead([
        {"tag": "70", "p_cid": user.value.comID}
      ]);
     // print(x);
      ledger_list.addAll(x.map((e) => ModelLedgerMaster.fromJson(e)));

      var y = await api.createLead([
        {"tag": "74", "p_cid": user.value.comID}
      ]);
      cc_list_main.addAll(y.map((e) => ModelCostcenterMaster.fromJson(e)));
       //print(y);
      var z = await api.createLead([
        {"tag": "78", "p_cid": user.value.comID}
      ]);
      link_list_main.addAll(z.map((e) => ModelGlCCLinkageMaster.fromJson(e)));
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