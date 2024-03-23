import 'package:agmc/core/config/const.dart';
import 'package:agmc/core/config/const_widget.dart';
import 'package:agmc/moduls/finance/voucher_entry_page/model/model_voucher_type.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

import '../../../../core/entity/entity_common.dart';
import '../../../../core/shared/user_data.dart';
import '../../cost_center_linkage_page/data/voucher_data.dart';
import '../../cost_center_linkage_page/model/model_gl_with_cc_master.dart';
import '../../ledger_master_page/model/model_ledger_master.dart';
import '../../sub_ledger_linkage_page/model/model_gl_sl_linkage_master.dart';

class VoucherEntryController extends GetxController with MixInController {
  final TextEditingController txt_amount = TextEditingController();
  final TextEditingController txt_narration = TextEditingController();

  final TextEditingController txt_ledgerSearch = TextEditingController();
  final TextEditingController txt_SubLedgerSearch = TextEditingController();
  final TextEditingController txt_CostCenterSearch = TextEditingController();

  var list_vtype = <ModelVoucherType>[].obs;
  var list_dr_cr = <EntityCommon>[].obs;
  var ledger_list = <ModelLedgerMaster>[].obs;
  var ledger_temp = <ModelLedgerMaster>[].obs;
  var ledger_search = <ModelLedgerMaster>[].obs;
  var sl_list_main = <ModelGlSlLinkageMaster>[].obs;
  var sl_list_temp = <ModelGlSlLinkageMaster>[].obs;
  var sl_list_search = <ModelGlSlLinkageMaster>[].obs;

  var cc_list_main = <ModelGlCCLinkageMaster>[].obs;
  var cc_list_temp = <ModelGlCCLinkageMaster>[].obs;
  var cc_list_search = <ModelGlCCLinkageMaster>[].obs;

  var list_voucher = <VoucherData>[].obs;

  var voucherTypeID = ''.obs;
  var selectedDrCr = ''.obs;
  var selectedLedgerID = ''.obs;
  var selectedSubLedgerID = ''.obs;
  var selectedCostCenterID = ''.obs;

  var isSearchEnabled = false.obs;
  var isSearchLedger = false.obs;
  var isSearchSubLedger = false.obs;
  var isSearchCostCenter = false.obs;

  var isAutoApprove = false.obs;

  var isAddEnable = false.obs;

  void setIsAddEnable() async {
    isAddEnable.value = false;
    if (selectedDrCr.value != '' &&
        selectedLedgerID.value != '' &&
        txt_amount.text != '') {
      ModelLedgerMaster s =
          ledger_list.where((p0) => p0.iD == selectedLedgerID.value).first;

      //  print('s.isCC: ${s.isCC}');

      bool b = true;
      // print('sl' + s.isSL!);
      if (s.isSL!.toString().trim() == '1') {
        // print('sl' + s.isSL!);
        if (selectedSubLedgerID.value.toString().trim() == '') {
          b = false;
        }
      }

      // print('s.isCC: ${s.isCC}');
      // print('selectedCostCenterID.value: ${selectedCostCenterID.value}');

      // print('cc' + s.isSL!);
      if (s.isCC!.toString().trim() == '1') {
        // print('cc' + s.isSL!);
        if (selectedCostCenterID.value.toString().trim() == '') {
          b = false;
          // print(b);
        }
      }

      isAddEnable.value = b;
    }
  }

  void addVoucher() {
    dialog = CustomAwesomeDialog(context: context);
    loader = CustomBusyLoader(context: context);
    if (selectedDrCr.value == '') {
      dialog
        ..dialogType = DialogType.warning
        ..message = 'Please select Voucher Type!'
        ..show();
      return;
    }

    if (selectedLedgerID.value == '') {
      dialog
        ..dialogType = DialogType.warning
        ..message = 'Please select Ledger!'
        ..show();
      return;
    }

    if (txt_amount.text == '') {
      dialog
        ..dialogType = DialogType.warning
        ..message = 'Valid amount required!'
        ..show();
      return;
    }

    list_voucher.add(VoucherData(
        iD: generateUniqueId(),
        amount: txt_amount.text,
        bilByBill: '',
        costCenterID: selectedCostCenterID.value,
        costCenterName: selectedCostCenterID.value.isEmpty
            ? ''
            : cc_list_main
                .where((p0) => p0.cCID == selectedCostCenterID.value)
                .first
                .cCNAME,
        drcrID: selectedDrCr.value,
        drcrName:
            list_dr_cr.where((p0) => p0.id == selectedDrCr.value).first.name,
        ledgerID: selectedLedgerID.value,
        ledgerName: ledger_list
            .where((p0) => p0.iD == selectedLedgerID.value)
            .first
            .nAME,
        narration: txt_narration.text,
        subLdgerID: selectedSubLedgerID.value,
        subLedgerName: selectedSubLedgerID.value.isEmpty
            ? ''
            : sl_list_main
                .where((p0) => p0.sLID == selectedSubLedgerID.value)
                .first
                .sLNAME));

    selectedLedgerID.value = '';
    selectedDrCr.value = '';
    selectedCostCenterID.value = '';
    selectedSubLedgerID.value = '';
    txt_amount.text = '';
    txt_narration.text = '';
    var amt = (list_voucher
            .where((p0) => p0.drcrID == 'dr')
            .sum((p0) => double.parse(p0.amount!)) -
        list_voucher
            .where((p0) => p0.drcrID == 'cr')
            .sum((p0) => double.parse(p0.amount!)));

    if (amt > 0) {
      selectedDrCr.value = 'cr';
      txt_amount.text = amt.toString();
    } else if (amt != 0) {
      selectedDrCr.value = 'dr';
      txt_amount.text = amt.abs().toString();
    }
    sl_list_temp.clear();
    cc_list_temp.clear();
  }

  
  

  void deleteSelectedVoucherLedger(VoucherData e) {
    list_voucher.removeWhere((element) => element.iD == e.iD);
  }

  void clearAll() {
    selectedLedgerID.value = '';
    selectedDrCr.value = '';
    selectedCostCenterID.value = '';
    selectedSubLedgerID.value = '';
    txt_amount.text = '';
    txt_narration.text = '';
    list_voucher.clear();
  }

  void searchLedger() {
    ledger_search.clear();
    ledger_search.addAll(ledger_temp.where((p0) =>
        p0.nAME!.toUpperCase().contains(txt_ledgerSearch.text.toUpperCase())));
  }

  void searchSubLedger() {
    //loadSubLedger();
    sl_list_search.clear();
    sl_list_search.addAll(sl_list_temp.where((p0) => p0.sLNAME!
        .toUpperCase()
        .contains(txt_SubLedgerSearch.text.toUpperCase())));
  }

  void searchCostCenter() {
    //loadSubLedger();
    cc_list_search.clear();
    cc_list_search.addAll(cc_list_temp.where((p0) => p0.cCNAME!
        .toUpperCase()
        .contains(txt_SubLedgerSearch.text.toUpperCase())));
  }

  void allSearchClose() {
    isSearchLedger.value = false;
    isSearchSubLedger.value = false;
    isSearchCostCenter.value = false;
    isSearchEnabled.value = false;
  }

  void loadLeadger() {
    clearAll();
    if (voucherTypeID.value == '1') {
      ledger_temp.clear();
      ledger_temp.addAll(ledger_list.where((p0) => p0.iSPARENT == '0'));
      ledger_search.addAll(ledger_temp);
    }
  }

  void loadSubLedger() {
    sl_list_temp.clear();
    sl_list_temp
        .addAll(sl_list_main.where((p0) => p0.gLID == selectedLedgerID.value));
    sl_list_search.addAll(sl_list_temp);

    cc_list_temp.clear();
    cc_list_search.clear();
    cc_list_temp
        .addAll(cc_list_main.where((p0) => p0.gLID == selectedLedgerID.value));
    cc_list_search.addAll(cc_list_temp);
  }

  void loadCostCenter() {
    cc_list_temp.clear();
    cc_list_temp
        .addAll(cc_list_main.where((p0) => p0.gLID == selectedLedgerID.value));
  }

  @override
  void onInit() async {
    isLoading.value = true;
    isError.value = false;
    selectedSubLedgerID.value = '';
    selectedCostCenterID.value = '';
    api = data_api();
    user.value = await getUserInfo();
    if (user == null) {
      isError.value = true;
      errorMessage.value = "Re- Login required";
      isLoading.value = false;
      return;
    }

    try {
      var x = await api.createLead([
        {
          "tag": "80",
        }
      ]);
      list_vtype.addAll(x.map((e) => ModelVoucherType.fromJson(e)));
      list_dr_cr.addAll(await _drcr());

      x = await api.createLead([
        {"tag": "70", "p_cid": user.value.comID}
      ]);
      //  print(x);
      ledger_list.addAll(x.map((e) => ModelLedgerMaster.fromJson(e)));

      var z = await api.createLead([
        {"tag": "76", "p_cid": user.value.comID}
      ]);
      sl_list_main.addAll(z.map((e) => ModelGlSlLinkageMaster.fromJson(e)));
      //sl_list_temp.addAll(sl_list_main);
      z = await api.createLead([
        {"tag": "78", "p_cid": user.value.comID}
      ]);
      cc_list_main.addAll(z.map((e) => ModelGlCCLinkageMaster.fromJson(e)));

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      isError.value = true;
      errorMessage.value = e.toString();
    }
    list_voucher.clear();
    super.onInit();
  }
}

Future<List<EntityCommon>> _drcr() async {
  List<dynamic> data = [
    {"ID": "dr", "NAME": "Debit"},
    {"ID": "cr", "NAME": "Credit"}
  ];
  return data.map((e) => EntityCommon.fromJson(e)).toList();
}
