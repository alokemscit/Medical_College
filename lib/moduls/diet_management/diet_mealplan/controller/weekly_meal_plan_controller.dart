// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:agmc/core/config/const.dart';

import '../../../../model/model_common.dart';
import '../../../../model/model_status.dart';
import '../../diet_category/model/model_diet_master.dart';
import '../../diet_meal_ietm/model/model_meal_item.dart';
import '../model/model_meal_plan_config.dart';

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
  //var list_meal_item = <ModelMealItemMaster>[].obs;

  var list_meal_attributes = <ModelMealItemMaster>[].obs;
  var list_plan_configured = <ModelPlanConfiguedData>[].obs;

  var list_final_list = <_menu>[].obs;

  var col = <int>[].obs;

  void loadData() async {
    selectedConfigID.value = '';
    loader = CustomBusyLoader(context: context);
    dialog = CustomAwesomeDialog(context: context);
    list_final_list.clear();
    //list_meal_item.clear();
    _list_menu.clear();
    lis_diet_master.clear();
    list_meal_attributes.clear();
    list_plan_configured.clear();

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
         

        // x = await api.createLead([
        //   {"tag": "102", "p_typeid": selectedDiettypeID.value}
        // ]);
        // print(x);

        // list_meal_item.addAll(x.map((e) => ModelMealItemMaster.fromJson(e)));

        x = await api.createLead([
          {"tag": "97", "p_type_id": selectedDiettypeID.value}
        ]);
        // print(x);
        lis_diet_master.addAll(x.map((e) => ModelDietMaster.fromJson(e)));

        x = await api.createLead([
          {"tag": "12"}
        ], "getdata_ipd");
        // print(x);
        list_plan_configured.addAll(x
            .map((e) => ModelPlanConfiguedData.fromJson(e))
            .where((f) =>
                f.dietTypeId == selectedDiettypeID.value &&
                f.dayId == selectedWeekID.value &&
                f.timeId == selectedTimeID.value));

        for (var e in lis_diet_master) {
          var menuCopy = _list_menu
              .map((menu) => _ModelMenuConfig.fromMenu(menu))
              .toList();
          //String? id;
          //String? name;
          //String? sl;
          // String? ischk;
          // String? val;
          // menuCopy.insert(0,_ModelMenuConfig(name: ' ', sl:'',id: '0',ischk: '0',val: ''));

          list_final_list.add(_menu(id: e.id, menu: menuCopy, name: e.name));
        }

        list_final_list.forEach((f) {
          try {
            for (var menu in f.menu!) {
              //if (menu.sl == sl) {
              var k = getItemID(selectedDiettypeID.value, selectedWeekID.value,
                  selectedTimeID.value, menu.id!, menu.sl!, f.id!);
              menu.val = k;
              //}
            }

            //   var menuItem = list_final_list.firstWhere((e) => e.id == id);
            // var k = getItemID(selectedDiettypeID.value, selectedWeekID.value,
            //     selectedTimeID.value, f.id!);

            // f.menu!.first.val = k;
          } catch (e) {}
        });

        list_final_list.refresh();

        // print(list_final_list.length);
        col.clear();
        col.value = [10, 100];
        for (var e in _list_menu) {
          col.value.add(40);
        }
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

  String getItemID(String dietTypeId, String dayID, String timeID,
      String menuID, String sl, String mealID) {
    var x = list_plan_configured.where((e) =>
        e.dayId == dayID &&
        e.dietTypeId == dietTypeId &&
        e.timeId == timeID &&
        e.menuId == menuID &&
        e.sl == sl &&
        e.mealId == mealID);
    if (x.isNotEmpty) {
      print(x.first.itemId);
      return x.first.itemId ?? '';
    } else {
      return '';
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
    dialog = CustomAwesomeDialog(context: context);
    loader = CustomBusyLoader(context: context);
    String s = '';
    for (var e in list_final_list) {
      //  print('Diet ID : ${e.id} Diedt name: ${e.name}');
      for (var action in e.menu!) {
        if ((action.val ?? '0') != '0'  && (action.id??'')!=''  ) {
          s += '${e.id!},${action.id!},${action.val!};';
          print(
              '${action.id} Name ${action.name} sl ${action.sl} val ${action.val}');
        }
      }
    }
    if (isCheckCondition(s == '', dialog, 'No menu configured to save data!'))
      return;
    try {
      print({
        "tag": "11",
        "p_diet_type": selectedDiettypeID.value,
        "p_day_id": selectedWeekID.value,
        "p_time_id": selectedTimeID.value,
        "p_str": s
      });

      //p_diet_type in int, p_day_id in int,p_time_id in int, p_str
      ModelStatus st = await commonSaveUpdate(
          api,
          loader,
          dialog,
          [
            {
              "tag": "11",
              "p_diet_type": selectedDiettypeID.value,
              "p_day_id": selectedWeekID.value,
              "p_time_id": selectedTimeID.value,
              "p_str": s
            },
          ],
          'getdata_ipd');
      if (st.status == '1') {
        dialog
          ..dialogType = DialogType.success
          ..message = st.msg!
          ..show();
      }
    } catch (e) {
      // loader.close();
      dialog
        ..dialogType = DialogType.error
        ..message = e.toString()
        ..show();
    }
    //print(s);
  }

  void updateMenuItem(String id, String sl, String newValue) {
    var menuItem = list_final_list.firstWhere((e) => e.id == id);
    for (var menu in menuItem.menu!) {
      if (menu.sl == sl) {
        menu.val = newValue;
      }
    }
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
  _ModelMenuConfig({this.name, this.id, this.ischk, this.sl, this.val});

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
