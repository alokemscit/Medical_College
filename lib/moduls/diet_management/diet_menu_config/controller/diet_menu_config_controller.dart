// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:agmc/core/config/const.dart';

import '../../../../model/model_common.dart';
import '../../../../model/model_status.dart';

class DietMenuConfigController extends GetxController with MixInController {
  var list_diet_type = <ModelCommon>[].obs;
  var list_week = <ModelCommon>[].obs;
  var list_time = <ModelCommon>[].obs;
  var _list_time = <ModelCommon>[].obs;

  var cmb_diet_type = ''.obs;
  var selected_dietTypeID = ''.obs;
  var selected_dietTypeName = ''.obs;

  var list_meale_type = <_ModelMenuConfig>[].obs;
  //var list_meale_type_temp = <ModelMealTypeMaster>[].obs;

  var list_menu = <_menu>[].obs;

  void Saveupdate() async {
    dialog = CustomAwesomeDialog(context: context);
    loader = CustomBusyLoader(context: context);
    loader.show();
    try {
      String s = '';
      var i = 1;
      list_menu.where((el) => el.val == true).forEach((e) {
        s += '$i,${e.id};';
        i++;
      });
      // print(s);
      //p_diet_typeid in int,p_time_id in int, p_str
      var x = await api.createLead([
        {
          "tag": "10",
          "p_diet_typeid": cmb_diet_type.value,
          "p_time_id": selected_dietTypeID.value,
          "p_str": s
        }
      ],'getdata_ipd');
      loader.close();
      ModelStatus st = await getStatusWithDialog(x, dialog);
      if (st.status == "1") {
        dialog
          ..dialogType = DialogType.success
          ..message = st.msg!
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

  void inedxChange(_menu e) {
    var x = list_menu.indexOf(e);
    if (x > 0) {
      list_menu.remove(e);
      list_menu.insert(x - 1, e);
    }
  }

  void updateList(String id, bool v) {
    var item = list_menu.firstWhere((el) => el.id == id);
    item.val = v;
    list_menu.refresh();
  }

  void loadMealType() async {
   
    list_menu.clear();
    list_meale_type.clear();

    loader = CustomBusyLoader(context: context);
    loader.show();
    dialog = CustomAwesomeDialog(context: context);
    try {
      var x = await api.createLead([
        {
          "tag": "9",
          "p_timeid": selected_dietTypeID.value,
          "p_diet_typeid": cmb_diet_type.value
        }
      ], 'getdata_ipd');

      if (checkJson(x)) {
        list_meale_type.addAll(x.map((e) => _ModelMenuConfig.fromJson(e)));

        for (var element in list_meale_type) {
          list_menu.add(_menu(
              id: element.id,
              name: element.name,
              val: element.ischk == '1' ? true : false));
        }
      }
      loader.close();
      // print(x);
    } catch (e) {
      loader.close();
      dialog
        ..dialogType = DialogType.error
        ..message = e.toString()
        ..show();
    }
  }

  void setTimeSlot() {
     selected_dietTypeID.value='';
   selected_dietTypeName.value = '';
    //  print('obtest-112');
    list_time.clear();
    if (cmb_diet_type.value != '') {
      list_time.addAll(_list_time);
    }
  }

  @override
  void onInit() async {
      
    isError.value = false;
    isLoading.value = true;
    api = data_api();
    try {
      var x = await api.createLead([
        {"tag": "1"}
      ], 'getdata_ipd');
      if (checkJson(x)) {
        list_diet_type.addAll(x.map((e) => ModelCommon.fromJson(e)));
      }
      // x = await api.createLead([
      //   {"tag": "103"}
      // ]);
      // list_week.addAll(x.map((e) => ModelCommon.fromJson(e)));

      x = await api.createLead([
        {"tag": "8"}
      ], 'getdata_ipd');
      if (checkJson(x)) {
        _list_time.addAll(x.map((e) => ModelCommon.fromJson(e)));
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

class _menu {
  String? id;
  String? name;
  bool? val;
  _menu({
    this.id,
    this.name,
    this.val,
  });
}

class _ModelMenuConfig {
  String? id;
  String? name;
  String? sl;
  String? ischk;

  _ModelMenuConfig({this.name});

  _ModelMenuConfig.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    sl = json['sl'];
    ischk = json['ischk'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['sl'] = sl;
    data['ischk'] = ischk;
    return data;
  }
}
