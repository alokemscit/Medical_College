import 'package:agmc/core/config/const.dart';
import 'package:agmc/core/shared/user_data.dart';
import 'package:agmc/model/model_common.dart';
import 'package:agmc/model/model_status.dart';

import '../model/model_diet_master.dart';

class DietCategoryController extends GetxController with MixInController {
  var selectedID = ''.obs;
  var selectedName = ''.obs;
  var editDietTypeID = ''.obs;
  var editDietID = ''.obs;
  var lis_diet_type = <ModelCommon>[].obs;
  var lis_diet_type_temp = <ModelCommon>[].obs;
  final TextEditingController txt_name = TextEditingController();
  final TextEditingController txt_cat_name = TextEditingController();

  var lis_diet_master = <ModelDietMaster>[].obs;
  var lis_diet_master_temp = <ModelDietMaster>[].obs;

  @override
  void onInit() async {
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
        {"tag": "96"}
      ]);
      if (x == [] ||
          x.map((e) => ModelStatus.fromJson(e)).first.status == '3') {
        return;
      }
      lis_diet_type.addAll(x.map((e) => ModelCommon.fromJson(e)));
      lis_diet_type_temp.addAll((lis_diet_type));

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      isError.value = true;
      errorMessage.value = e.toString();
    }

    super.onInit();
  }

  void loadDietMaster() async {
    lis_diet_master.clear();
    lis_diet_master_temp.clear();
    loader = CustomBusyLoader(context: context);
    loader.show();
    try {
      //print({"tag": "97", "p_type_id": selectedID.value});
      var x = await api.createLead([
        {"tag": "97", "p_type_id": selectedID.value}
      ]);
      // print(x);
      lis_diet_master.addAll(x.map((e) => ModelDietMaster.fromJson(e)));
      lis_diet_master_temp.addAll(lis_diet_master);

      loader.close();
    } catch (e) {
      loader.close();
    }
  }

  void saveCategory() async {
    dialog = CustomAwesomeDialog(context: context);
    loader = CustomBusyLoader(context: context);
    loader.show();

    if (txt_cat_name.text.isEmpty) {
      loader.close();
      dialog
        ..dialogType = DialogType.warning
        ..message = 'Diet name required!'
        ..show();
      return;
    }

    //print(selectedID.value + txt_cat_name.text + editDietTypeID.value);

    // return;

    var t = lis_diet_master
        .where((e) =>
            e.typeId == selectedID.value &&
            e.name == txt_cat_name.text &&
            editDietID.value == '')
        .length;
    if (t > 0) {
      loader.close();
      dialog
        ..dialogType = DialogType.warning
        ..message = 'Diet name already exists!'
        ..show();
      return;
    }

    //print(editDietID.value);

  //  loader.close();

   // return;

    try {
      var x = await api.createLead([
        {
          "tag": "98",
          "p_id": editDietID.value == '' ? '0' : editDietID.value,
          "p_type_id": selectedID.value,
          "p_name": txt_cat_name.text
        }
      ]);
      //print(x);
      loader.close();

      ModelStatus s = await getStatusWithDialog(x, dialog);

      if (s.status == '1') {
        dialog
          ..dialogType = DialogType.success
          ..message = s.msg!
          ..show();
        lis_diet_master.removeWhere((e) => e.id == s.id);
        lis_diet_master.insert(
            0,
            ModelDietMaster(
                id: s.id,
                typeId: selectedID.value,
                typeName: selectedName.value,
                name: txt_cat_name.text));
        lis_diet_master_temp.clear();
        lis_diet_master_temp.addAll(lis_diet_master);
        txt_cat_name.text = '';
      }
    } catch (e) {
      loader.close();
      dialog
        ..dialogType = DialogType.error
        ..message = e.toString()
        ..show();
    }
  }
}
