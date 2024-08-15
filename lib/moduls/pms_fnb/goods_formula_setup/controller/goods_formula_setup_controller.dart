// ignore_for_file: non_constant_identifier_names

import 'package:agmc/core/config/const.dart';
import 'package:agmc/model/model_status.dart';

import '../../../../core/shared/user_data.dart';
import '../model/model_finished_goods_master.dart';
import '../model/model_formulated_item.dart';
import '../model/model_raw_materials_master.dart';

class GoodsFormulaSetupController extends GetxController with MixInController {
  var list_item = <ModelFinishedGoodsList>[].obs;
  var list_item_temp = <ModelFinishedGoodsList>[].obs;
  var list_raw_material = <ModelRawMaterialsList>[].obs;
  var list_raw_material_temp = <ModelRawMaterialsList>[].obs;
  var list_entry_item = <_tempItem>[].obs;

  var list_formulated_item = <ModelFormulatedItem>[].obs;
  //var list_formulated_item_temp = <ModelFormulatedItem>[].obs;

  final TextEditingController txt_qty = TextEditingController();
  var rawmaterialId = ''.obs;
  var isSearch = false.obs;

  final TextEditingController txt_search_goods = TextEditingController();
  final TextEditingController txt_search_rawMaterials = TextEditingController();
  final selectedID = ''.obs;
  final FocusNode focusNode1 = FocusNode();



  void setupItem() {
    list_entry_item.clear();
    var x = list_formulated_item.where((p0) => p0.fOODID == selectedID.value);
    list_entry_item.addAll(x.map((element) => _tempItem(
        id: element.iTEMID!,
        name: element.iTEMNAME!,
        unit: element.uNITNAME!,
        qty: element.qTY!.toString())));
  }

  void save() async {
    dialog = CustomAwesomeDialog(context: context);
    loader = CustomBusyLoader(context: context);
    if (list_entry_item.isEmpty) {
      dialog
        ..dialogType = DialogType.warning
        ..message = 'No Raw Material selectd for this formula!'
        ..show();
      return;
    }
    if (selectedID.value == '') {
      dialog
        ..dialogType = DialogType.warning
        ..message = 'No Finished Goods Selected'
        ..show();
      return;
    }
    loader.show();
    var s = '';
    list_entry_item.forEach((element) {
      s += '${element.id},${element.qty};';
    });
    try {
      var x = await api.createLead([
        {"tag": "92", "v_goodsid": selectedID.value, "v_string": s}
      ]);

      loader.close();
      ModelStatus st = await getStatusWithDialog(x, dialog);
      if (st.status == '1') {
        dialog
          ..dialogType = DialogType.success
          ..message = st.msg!
          ..show()
          ..onTap = () {
            list_entry_item.clear();
            selectedID.value = '';
          };
      }

      // loader.close();
    } catch (e) {
      loader.close();
      dialog
        ..dialogType = DialogType.error
        ..message = e.toString()
        ..show();
    }
  }

  void serarchRawMaterial() {
    list_raw_material_temp.clear();
    list_raw_material_temp.addAll(list_raw_material.where((p0) => p0.nAME!
        .toUpperCase()
        .contains(txt_search_rawMaterials.text.toUpperCase())));
  }




  void addItem() {
    dialog = CustomAwesomeDialog(context: context);
    //loader = CustomBusyLoader(context: context);
    if (rawmaterialId.value == '') {
      dialog
        ..dialogType = DialogType.warning
        ..message = 'Pleaase Select Raw Material'
        ..show();
      return;
    }
    if (txt_qty.text.trim() == '') {
      dialog
        ..dialogType = DialogType.warning
        ..message = 'Please eneter valid quantity'
        ..show();
      return;
    }

    if (list_entry_item
        .where((p0) => p0.id == rawmaterialId.value)
        .toList()
        .isNotEmpty) {
      dialog
        ..dialogType = DialogType.warning
        ..message = 'This raw material alraedy exists!'
        ..show();
      return;
    }

    list_entry_item.add(_tempItem(
        id: rawmaterialId.value,
        name: list_raw_material
            .where((p0) => p0.iTEMID == rawmaterialId.value)
            .first
            .nAME!,
        unit: list_raw_material
            .where((p0) => p0.iTEMID == rawmaterialId.value)
            .first
            .uNAME!,
        qty: txt_qty.text));
    rawmaterialId.value = '';
    txt_qty.text = '';
    txt_search_rawMaterials.text = '';
    list_raw_material_temp.clear();
    list_raw_material_temp.addAll(list_raw_material);
  }

  void deleteItem(String id) {
    list_entry_item.removeWhere((element) => element.id == id);
  }

  void searchProduct() {
    list_item_temp.clear();
    list_item_temp.addAll(list_item.where((p0) =>
        p0.fOODNAME!
            .toUpperCase()
            .contains(txt_search_goods.text.toUpperCase()) ||
        p0.fOODID!
            .toUpperCase()
            .contains(txt_search_goods.text.toUpperCase())));
  }

  @override
  void onInit() async {
    // await super.init();
    isLoading.value = true;

    api = data_api();
    user.value = await getUserInfo();
    if (user.value.eMPID == null) {
      isError.value = true;
      errorMessage.value = 'Re-Login Required';
      isLoading.value = false;
      return;
    }

    try {
      var x = await api.createLead([
        {"tag": "90"}
      ]);
      list_item.addAll(x.map((e) => ModelFinishedGoodsList.fromJson(e)));
      list_item_temp.addAll(list_item);

      x = await api.createLead([
        {"tag": "91"}
      ]);
      list_raw_material.addAll(x.map((e) => ModelRawMaterialsList.fromJson(e)));
      list_raw_material_temp.addAll(list_raw_material);
      // print(list_item.length);
      //print(x);

//list_formulated_item
      x = await api.createLead([
        {"tag": "93"}
      ]);
      list_formulated_item
          .addAll(x.map((e) => ModelFormulatedItem.fromJson(e)));

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      isError.value = true;
      errorMessage.value = e.toString();
    }
    super.onInit();
  }

  @override
  void onClose() {
    list_entry_item.close();
    list_item.close();
    list_item_temp.close();
    list_raw_material.close();
    list_raw_material_temp.close();
    txt_qty.dispose();
    txt_search_goods.dispose();
    txt_search_rawMaterials.dispose();
    super.onClose();
  }
}

class _tempItem {
  final String id;
  final String name;
  final String unit;
  final String qty;

  _tempItem(
      {required this.id,
      required this.name,
      required this.unit,
      required this.qty});
}
