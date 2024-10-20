import 'package:agmc/core/config/const.dart';
import 'package:agmc/widget/custom_snakbar.dart';

import '../../../../core/shared/user_data.dart';
import '../../../../model/model_common.dart';
import '../../../../model/model_status.dart';
import '../model/model_meal_item.dart';
import '../model/model_meal_type.dart';

class DietItemsController extends GetxController with MixInController {
  var selectedDMealTypeID = ''.obs;
  var selectedDMealTypeName = ''.obs;

  var selectedDietCategoryID = ''.obs;
  var editMeaalTypeID = ''.obs;

  var editItemId = ''.obs;

  var list_diet_category = <ModelCommon>[].obs;
  var list_meale_type = <ModelMealTypeMaster>[].obs;
  var list_meale_type_temp = <ModelMealTypeMaster>[].obs;

  var list_meal_item = <ModelMealItemMaster>[].obs;
  var list_meal_item_temp = <ModelMealItemMaster>[].obs;

  TextEditingController txt_mmeal_type = TextEditingController();
  TextEditingController txt_mmeal_type_search = TextEditingController();

  TextEditingController txt_mmeal_item = TextEditingController();
  TextEditingController txt_mmeal_item_search = TextEditingController();

  void loadMealItem() async {
    dialog = CustomAwesomeDialog(context: context);
    loader = CustomBusyLoader(context: context);
    loader.show();
    try {
      var x = await api.createLead([
        {"tag": "5", "p_typeid": selectedDMealTypeID.value}
      ], 'getdata_ipd');

      list_meal_item.clear();
      if (checkJson(x)) {
        list_meal_item.addAll(x.map((e) => ModelMealItemMaster.fromJson(e)));
        list_meal_item_temp.clear();
        list_meal_item_temp.addAll(list_meal_item);
      }
      loader.close();
      // print(x);
      // list_meal_item.forEach((e) => print(e.id! +' '+e.mealTypename!+' '+e.name!));
    } catch (e) {
      loader.close();
      dialog
        ..dialogType = DialogType.error
        ..message = e.toString()
        ..show();
    }
  }

  void saveUpdateItem() async {
    dialog = CustomAwesomeDialog(context: context);
    loader = CustomBusyLoader(context: context);
    loader.show();
    if (txt_mmeal_item.text == '') {
      loader.close();
      dialog
        ..dialogType = DialogType.warning
        ..message = 'Item name required!'
        ..show();
      return;
    }
    try {
      //p_id in int, p_type_id in int, p_name
      var x = await api.createLead([
        {
          "tag": "6",
          "p_id": editItemId.value == '' ? "0" : editItemId.value,
          "p_type_id": selectedDMealTypeID.value,
          "p_name": txt_mmeal_item.text
        }
      ],'getdata_ipd');

      loader.close();
      ModelStatus s = await getStatusWithDialog(x, dialog);
      if (s.status == '1') {
        // ignore: use_build_context_synchronously
        CustomSnackbar(context: context, message: s.msg!);
        // dialog
        //   ..dialogType = DialogType.success
        //   ..message = s.msg!
        //   ..show();
        list_meal_item.removeWhere((e) => e.id == s.id);
        list_meal_item.insert(
            0,
            ModelMealItemMaster(
                dietTypeid: selectedDietCategoryID.value,
                id: s.id,
                mealTypeid: selectedDMealTypeID.value,
                name: txt_mmeal_item.text,
                mealTypename: list_meale_type
                    .where((e) => e.id == selectedDMealTypeID.value)
                    .first
                    .name));
        editItemId.value = '';
        txt_mmeal_item.text = '';
        list_meal_item_temp.clear();
        list_meal_item_temp.addAll(list_meal_item);
      }
    } catch (e) {
      loader.close();
      dialog
        ..dialogType = DialogType.error
        ..message = e.toString()
        ..show();
    }
  }

  void mealtypeSearch() {
    list_meale_type_temp.clear();
    list_meale_type_temp.addAll(list_meale_type.where((e) => e.name!
        .toUpperCase()
        .contains(txt_mmeal_type_search.text.toUpperCase())));
  }

  void loadMealType() async {
    list_meale_type.clear();
    list_meale_type_temp.clear();
    loader = CustomBusyLoader(context: context);
    loader.show();
    dialog = CustomAwesomeDialog(context: context);
    try {
      var x = await api.createLead([
        {"tag": "4", "p_type_id": selectedDietCategoryID.value}
      ], 'getdata_ipd');
      if (checkJson(x)) {
        list_meale_type.addAll(x.map((e) => ModelMealTypeMaster.fromJson(e)));
        list_meale_type_temp.addAll(list_meale_type);
      }
      loader.close();
      selectedDMealTypeID.value = '';
      selectedDMealTypeName.value = '';
    } catch (e) {
      loader.close();
      dialog
        ..dialogType = DialogType.error
        ..message = e.toString()
        ..show();
    }
  }

  void saveUpdateMealType() async {
    dialog = CustomAwesomeDialog(context: context);
    loader = CustomBusyLoader(context: context);
    loader.show();
    if (selectedDietCategoryID.value == '') {
      loader.close();
      dialog
        ..dialogType = DialogType.warning
        ..message = 'Please Select Diet Type'
        ..show();
      return;
    }
    if (txt_mmeal_type.text == '') {
      loader.close();
      dialog
        ..dialogType = DialogType.warning
        ..message = 'Meal type name required!'
        ..show();
      return;
    }
    var t = list_meale_type
        .where(
            (e) => e.name!.toUpperCase() == txt_mmeal_type.text.toUpperCase())
        .length;
    if (t > 0) {
      loader.close();
      dialog
        ..dialogType = DialogType.warning
        ..message = 'This name already exists!'
        ..show();
      return;
    }

    try {
      //p_id in int, p_type_id in int, p_name
      var x = await api.createLead([
        {
          "tag": "7",
          "p_id": editMeaalTypeID.value == '' ? '0' : editMeaalTypeID.value,
          "p_type_id": selectedDietCategoryID.value,
          "p_name": txt_mmeal_type.text
        }
      ],'getdata_ipd');
      loader.close();
      ModelStatus s = await getStatusWithDialog(x, dialog);
      if (s.status == '1') {
        // ignore: use_build_context_synchronously
        CustomSnackbar(context: context, message: s.msg!);
        // dialog
        //   ..dialogType = DialogType.success
        //   ..message = s.msg!
        //   ..show();

        list_meale_type.removeWhere((e) => e.id == s.id);
        list_meale_type.insert(
            0,
            ModelMealTypeMaster(
                dietTypeid: selectedDietCategoryID.value,
                dietTypename: '',
                id: s.id,
                name: txt_mmeal_type.text));
        txt_mmeal_type.text = '';
        editMeaalTypeID.value = '';
        list_meale_type_temp.clear();
        list_meale_type_temp.addAll(list_meale_type);
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
    list_diet_category.clear();
    isError.value = false;
    isLoading.value = true;
    api = data_api();
    user.value = await getUserInfo();
    if (user.value.eMPID == null) {
      isLoading.value = false;
      isError.value = true;
      errorMessage.value = 'Re-login required';
      return;
    }
    try {
      var x = await api.createLead([
        {"tag": "1"}
      ], 'getdata_ipd');
      //print(x);
      if (checkJson(x)) {
        //print('object');
        list_diet_category.addAll(x.map((e) => ModelCommon.fromJson(e)));
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
