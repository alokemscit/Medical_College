// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:agmc/core/config/const.dart';

import '../../../../model/model_common.dart';
import '../../../../model/model_status.dart';
import '../../diet_category/model/model_diet_master.dart';
import '../../diet_meal_ietm/model/model_meal_item.dart';
import '../model/model_ns_patient_list.dart';

class DietAssignController extends GetxController with MixInController {
  var selectedDiettypeID = ''.obs;
  var selectedWeekID = ''.obs;
  var selectedTimeID = ''.obs;
  var selectedNsID = ''.obs;
  var selectedConfigID = ''.obs;
  
  

  final TextEditingController txt_date = TextEditingController();

  var list_diet_type = <ModelCommon>[].obs;
  var list_week = <ModelCommon>[].obs;
  var list_time = <ModelCommon>[].obs;

  var list_final_list = <_menu>[].obs;
  var list_meal_attributes = <ModelMealItemMaster>[].obs;

  var lis_diet_master = <ModelDietMaster>[].obs;

  var lis_nurse_station = <ModelCommon>[].obs;

  var list_patient = <ModelNsPatientList>[].obs;
  var _list_menu = <_ModelMenuConfig>[].obs;

  var col = <int>[].obs;

  void loadPatient() async {
    list_patient.clear();
    list_final_list.clear();
    _list_menu.clear();
    list_meal_attributes.clear();
    lis_diet_master.clear();
    loader = CustomBusyLoader(context: context);
    dialog = CustomAwesomeDialog(context: context);
    if (selectedDiettypeID.value.isNotEmpty &&
        selectedTimeID.value.isNotEmpty &&
        selectedNsID.value.isNotEmpty) {
      loader.show();
      try {
        var x = await api.createLead([
          {
            "tag": "106",
            "p_timeid": selectedTimeID.value,
            "p_diet_typeid": selectedDiettypeID.value
          }
        ]);
        _list_menu.addAll(x.map((e) => _ModelMenuConfig.fromJson(e)));

        x = await api.createLead([
          {"tag": "107", "p_diet_typeid": selectedDiettypeID.value}
        ]);

        list_meal_attributes
            .addAll(x.map((e) => ModelMealItemMaster.fromJson(e)));

       x = await api.createLead([
          {"tag": "97", "p_type_id": selectedDiettypeID.value}
        ]);
        // print(x);
        lis_diet_master.addAll(x.map((e) => ModelDietMaster.fromJson(e)));



        x = await api.createLead([
          {"tag": "109", "p_ns_id": selectedNsID.value}
        ]);
        list_patient.addAll(x.map((e) => ModelNsPatientList.fromJson(e)));
        list_patient.forEach((e) {
          var menuCopy = _list_menu
              .map((menu) => _ModelMenuConfig.fromMenu(menu))
              .toList();
          list_final_list.add(_menu(
              hcn: e.hcn,
              regid: e.regId,
              name: e.patName,
              bedno: e.bedNo,
              remarks: '',
              dietid: '',
              menu: menuCopy));
        });

        col.clear();
        // hcn,reg,name,bed,rem,
        col.value = [35, 35, 80, 30, 80, 60];
        _list_menu.forEach((e) {
          if (e.sl != null) col.value.add(35);
        });

        loader.close();
      } catch (e) {
        loader.close();
        dialog
          ..dialogType = DialogType.error
          ..message = e.toString()
          ..show();
      }
    }
  }

  @override
  void onInit() async {
    isError.value = false;
    isLoading.value = true;
    api = data_api();
    try {
      var x = await api.createLead([
        {"tag": "96"}
      ]);
      if (x == [] ||
          x.map((e) => ModelStatus.fromJson(e)).first.status == '3') {
        return;
      }
      list_diet_type.addAll(x.map((e) => ModelCommon.fromJson(e)));

      x = await api.createLead([
        {"tag": "103"}
      ]);
      list_week.addAll(x.map((e) => ModelCommon.fromJson(e)));

      x = await api.createLead([
        {"tag": "104"}
      ]);
      list_time.addAll(x.map((e) => ModelCommon.fromJson(e)));

      x = await api.createLead([
        {"tag": "108"}
      ]);
      lis_nurse_station.addAll(x.map((e) => ModelCommon.fromJson(e)));

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      isError.value = true;
      errorMessage.value = e.toString();
    }
    super.onInit();
  }
}

class _menu {
  String? hcn;
  String? regid;
  String? name;
  String? bedno;
  String? remarks;
  String? dietid;
  List<_ModelMenuConfig> menu;
  _menu({
    this.hcn,
    this.regid,
    this.name,
    this.bedno,
    this.remarks,
    this.dietid,
    required this.menu,
  });
}

class _ModelMenuConfig {
  String? id;
  String? name;
  String? sl;
  String? ischk;
  String? val;
  _ModelMenuConfig({this.id, this.name, this.sl, this.ischk, this.val = ''});

  _ModelMenuConfig.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    sl = json['sl'];
    ischk = json['ischk'];
  }

  _ModelMenuConfig.fromMenu(_ModelMenuConfig abc)
      : id = abc.id,
        val = abc.val,
        name = abc.name,
        sl = abc.sl,
        ischk = abc.ischk;
}
