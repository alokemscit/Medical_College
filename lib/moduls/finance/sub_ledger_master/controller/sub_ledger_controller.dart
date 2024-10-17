import 'package:agmc/core/config/const.dart';

 
import 'package:agmc/core/shared/user_data.dart';
import 'package:agmc/model/model_status.dart';
import 'package:agmc/moduls/finance/sub_ledger_master/model/model_subledger_master.dart';
import '../../../../core/config/const_widget.dart';

class SubLedgerController extends GetxController with MixInController {
  var list_subledger_main = <ModelSubledgerMaster>[].obs;
  var list_subledger_temp = <ModelSubledgerMaster>[].obs;

  var isBillByBill = false.obs;
  var editId = ''.obs;
  final TextEditingController txt_code = TextEditingController();
  final TextEditingController txt_name = TextEditingController();
  final TextEditingController txt_desc = TextEditingController();
  final TextEditingController txt_search = TextEditingController();

  void search() {
    var x = list_subledger_main
        .where((p0) =>
            p0.nAME!.toUpperCase().contains(txt_search.text.toUpperCase()) ||
            p0.cODE!.toUpperCase().contains(txt_search.text.toUpperCase()) ||
            p0.dESCRIPTION!
                .toUpperCase()
                .contains(txt_search.text.toUpperCase()))
        .toList();
    list_subledger_temp.clear();
    list_subledger_temp.addAll(x);
  }

  void save() async {
    dialog = CustomAwesomeDialog(context: context);
    loader = CustomBusyLoader(context: context);
    try {
      if (txt_name.text == '') {
        dialog
          ..dialogType = DialogType.warning
          ..message = "Please enter valid sub leadeger name!"
          ..show();
        return;
      }

      loader.show();

      var x = await api.createLead([
        {
          "tag": "73",
          "p_cid": user.value.comID,
          "p_id": editId.value == '' ? "0" : editId.value,
          "p_name": txt_name.text,
          "p_desc": txt_desc.text,
          "p_code": txt_code.text,
          "p_is_bill_by_bill": isBillByBill.value ? "1" : "0",
          "v_user": user.value.eMPID
        }
      ]);
      loader.close();
      // print(x);
      if (x == []) {
        dialog
          ..dialogType = DialogType.error
          ..message = 'Data save error'
          ..show();
        return;
      }

      ModelStatus s1 = await getStatusWithDialog(x, dialog);
      if (s1.status == '1') {
        dialog
          ..dialogType = DialogType.success
          ..message = s1.msg!
          ..show();
        list_subledger_main.removeWhere((e) => e.iD == editId.value);
        list_subledger_main.insert(
            0,
            ModelSubledgerMaster(
                iD: s1.id,
                nAME: txt_name.text,
                cODE: s1.extra,
                dESCRIPTION: txt_desc.text,
                iSBILLBYBILL: isBillByBill.value ? "1" : "0"));
        list_subledger_temp.clear();
        list_subledger_temp.addAll(list_subledger_main);
        editId.value = '';
        txt_search.text = '';
        txt_name.text = '';
        txt_code.text = '';
        txt_desc.text = '';
        isBillByBill.value = false;
      }
    } catch (e) {
      loader.close();
      dialog
        ..dialogType = DialogType.error
        ..message = e.toString()
        ..show();
    }
  }

  void undo() async {
    editId.value = '';
    txt_search.text = '';
    txt_name.text = '';
    txt_code.text = '';
    txt_desc.text = '';
    isBillByBill.value = false;
    list_subledger_temp.clear();
    list_subledger_temp.addAll(list_subledger_main);
  }

  void edit(ModelSubledgerMaster e) {
    editId.value = e.iD!;
    txt_name.text = e.nAME!;
    txt_code.text = e.cODE!;
    txt_desc.text = e.dESCRIPTION == null ? '' : e.dESCRIPTION!;
    isBillByBill.value = e.iSBILLBYBILL == '1' ? true : false;
  }

  @override
  void onInit() async {
    api = data_api();
    user.value = await getUserInfo();

    try {
      var x = await api.createLead([
        {"tag": "72", "p_cid": user.value.comID}
      ]);
      list_subledger_main
          .addAll(x.map((e) => ModelSubledgerMaster.fromJson(e)));
      list_subledger_temp.addAll(list_subledger_main);

      print(x);
    } catch (e) {}

    super.onInit();
  }
}
