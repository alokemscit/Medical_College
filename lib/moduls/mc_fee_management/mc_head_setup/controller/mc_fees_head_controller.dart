// ignore_for_file: library_private_types_in_public_api

import 'package:agmc/core/config/const.dart';
import 'package:agmc/model/model_common.dart';
import 'package:agmc/model/model_status.dart';
import 'package:agmc/widget/custom_snakbar.dart';

import '../model/model_fee_master.dart';

class McFeesHeadMasterController extends GetxController with MixInController {
  var editID = ''.obs;
  var selectedPaymentType = '1'.obs;
  final TextEditingController txt_name = TextEditingController();
  final TextEditingController txt_search = TextEditingController();
  var list_payment_type = <ModelCommon>[].obs;
  var list_fee_master_main = <ModelFeeMaster>[].obs;
  var list_fee_master_temp = <ModelFeeMaster>[].obs;

  void delete(ModelFeeMaster f) async {
    loader = CustomBusyLoader(context: context);
    dialog = CustomAwesomeDialog(context: context);
    loader.show();
    try {
      var x = await api.createLead([
        {
          "tag": "129",
          "p_typeid": f.typeId,
          "p_id": f.id,
          "p_name": f.name,
          "is_delete": "1"
        }
      ]);
      loader.close();
      ModelStatus s = await getStatusWithDialog(x, dialog);
      if (s.status == '1') {
        list_fee_master_main.removeWhere((e) => e.id == f.id);
        list_fee_master_temp.clear();
        list_fee_master_temp.addAll(list_fee_master_main);
        dialog
          ..dialogType = DialogType.success
          ..message = s.msg!
          ..show();
      }
    } catch (e) {
      loader.close();
      dialog
        ..dialogType = DialogType.error
        ..message = e.toString()
        ..show();
    }
  }

  void edit(ModelFeeMaster f) {
    editID.value = f.id!;
    selectedPaymentType.value = f.typeId!;
    txt_name.text = f.name!;
  }

  void undo() {
    editID.value = '';
    selectedPaymentType.value = '1';
    txt_name.text = '';
  }

  void seave() async {
    loader = CustomBusyLoader(context: context);
    dialog = CustomAwesomeDialog(context: context);
    loader.show();

    if (selectedPaymentType.value == '') {
      loader.close();
      dialog
        ..dialogType = DialogType.warning
        ..message = 'Fees type required!'
        ..show();
      return;
    }

    if (txt_name.text.isEmpty) {
      loader.close();
      dialog
        ..dialogType = DialogType.warning
        ..message = 'Fees name required!'
        ..show();
      return;
    }

    try {
      var x = await api.createLead([
        {
          "tag": "129",
          "p_typeid": selectedPaymentType.value,
          "p_id": editID.value == '' ? "0" : editID.value,
          "p_name": txt_name.text,
          "is_delete": "0"
        }
      ]);
      loader.close();
      ModelStatus s = await getStatusWithDialog(x, dialog);
      if (s.status == '1') {
        CustomSnackbar(
            // ignore: use_build_context_synchronously
            context: context,
            message: s.msg!,
            type: MsgType.success);
        if (editID.value != '') {
          list_fee_master_main.removeWhere((e) => e.id == editID.value);
        }
        list_fee_master_main.insert(
            0,
            ModelFeeMaster(
                id: s.id,
                name: txt_name.text,
                typeId: selectedPaymentType.value,
                typeName: list_payment_type
                    .where((f) => f.id == selectedPaymentType.value)
                    .first
                    .name));
        list_fee_master_temp.clear();
        list_fee_master_temp.addAll(list_fee_master_main);

        undo();
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
    api = data_api();
    isLoading.value = true;
    list_payment_type.add(ModelCommon(id: '1', name: "Income"));
    list_payment_type.add(ModelCommon(id: '2', name: "Expense"));
    try {
      var x = await api.createLead([
        {"tag": "130"}
      ]);
      if (x != [] ||
          x.map((e) => ModelStatus.fromJson(e)).first.status != '3') {
        list_fee_master_main.addAll(x.map((e) => ModelFeeMaster.fromJson(e)));
        list_fee_master_temp.addAll(list_fee_master_main);
        //  print(list_fee_master_main.length);
      }
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      isError.value = true;
      errorMessage.value = e.toString();
    }
    super.onInit();
  }
}


