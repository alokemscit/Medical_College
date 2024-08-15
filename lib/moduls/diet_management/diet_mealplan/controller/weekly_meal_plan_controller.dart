// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:agmc/core/config/const.dart';
 

import '../../../../model/model_common.dart';
import '../../../../model/model_status.dart';
import '../../diet_category/model/model_diet_master.dart';
import '../../diet_meal_ietm/model/model_meal_item.dart';

class WeeklyMealPlanController extends GetxController with MixInController {
  var selectedDiettypeID = ''.obs;
  var selectedWeekID = ''.obs;
  var selectedTimeID = ''.obs;
  var selectedConfigID = ''.obs;
  var list_diet_type = <ModelCommon>[].obs;
  var list_week = <ModelCommon>[].obs;
  var list_time = <ModelCommon>[].obs;
  var _list_menu = <_ModelMenuConfig>[].obs;
  var lis_diet_master = <ModelDietMaster>[].obs;
  var list_meal_item = <ModelMealItemMaster>[].obs;

  var list_meal_attributes = <ModelMealItemMaster>[].obs;

  var list_final_list = <_menu>[].obs;

  var col = <int>[].obs;

  void loadData() async {
    selectedConfigID.value = '';
    loader = CustomBusyLoader(context: context);
    dialog = CustomAwesomeDialog(context: context);
    list_final_list.clear();
    list_meal_item.clear();
    _list_menu.clear();
    lis_diet_master.clear();
    list_meal_attributes.clear();

    if (selectedDiettypeID.value.isNotEmpty &&
        selectedTimeID.value.isNotEmpty &&
        selectedWeekID.value.isNotEmpty) {
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
          {"tag": "102", "p_typeid": selectedDiettypeID.value}
        ]);
        print(x);

        list_meal_item.addAll(x.map((e) => ModelMealItemMaster.fromJson(e)));

        x = await api.createLead([
          {"tag": "97", "p_type_id": selectedDiettypeID.value}
        ]);
        // print(x);
        lis_diet_master.addAll(x.map((e) => ModelDietMaster.fromJson(e)));

        lis_diet_master.forEach((e) {
          var menuCopy =
              _list_menu.map((menu) => _ModelMenuConfig.fromMenu(menu)).toList();

          list_final_list.add(_menu(id: e.id, menu: menuCopy, name: e.name));
        });
        print(list_final_list.length);
        col.clear();
        col.value = [10, 100];
        _list_menu.forEach((e) {
          col.value.add(40);
        });
        x = await api.createLead([
          {"tag": "107", "p_diet_typeid": selectedDiettypeID.value}
        ]);
        list_meal_attributes
            .addAll(x.map((e) => ModelMealItemMaster.fromJson(e)));
        //p_diet_typeid
      //  print(col);
        loader.close();
      } catch (e) {
        loader.close();
        dialog
          ..dialogType = DialogType.error
          ..message = e.toString()
          ..show();
      }

      //loader.close();
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

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      isError.value = true;
      errorMessage.value = e.toString();
    }
    super.onInit();
  }

  void savePlan() async {
    list_final_list.forEach((e) {
      print('Diet ID : ${e.id} Diedt name: ${e.name}');
      e.menu!.forEach((action) {
        if (action.val != null)
          print(
              '${action.id} Name ${action.name} sl ${action.sl} val ${action.val}');
      });
    });
  }

  void updateMenuItem(String id, String sl, String newValue) {
    var menuItem = list_final_list.firstWhere((e) => e.id == id);
    menuItem.menu!.forEach((menu) {
      if (menu.sl == sl) {
        menu.val = newValue;
      }
    });
    list_final_list.refresh(); // Refresh the list to update the UI
  }
}

class _menu {
  String? id;
  String? name;
  List<_ModelMenuConfig>? menu;
  _menu({
    this.id,
    this.name,
    this.menu,
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
