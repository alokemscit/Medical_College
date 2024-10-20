// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:agmc/core/config/const.dart';
import 'package:agmc/model/model_common.dart';
import 'package:agmc/model/model_status.dart';
import 'package:agmc/widget/custom_snakbar.dart';
import 'package:equatable/equatable.dart';

import '../../lab_pathogen_group/model/model_path_resistance.dart';
import '../model/lab_model_test_config.dart';

class BiofirePanelController extends GetxController with MixInController {
  var isShowPopup = false.obs;
  var selectdTestMain = ModelCommon().obs;
  var list_test_main_master = <ModelCommon>[].obs;
  var list_test_main_temp = <ModelCommon>[].obs;
  final TextEditingController txt_search_test = TextEditingController();

  var list_PathRes_Group = <ModelPathResis>[].obs;
  var list_PathRes_temp = <ModelPathResis>[].obs;
  var popUpHeaderName = ''.obs;
  var selectedGroupForAttr = _group().obs;

  var list_temp_group_added = <_group>[].obs;
  //var list_temp_attr_added = <_attributes>[].obs;

  var list_attr_mastr = <_attrMaster>[].obs;
  var list_attr_mastr_temp = <_attrMaster>[].obs;

  var list_attr_for_added = <_attrMaster>[].obs;

  var list_test_config_data = <ModelTestConfig>[].obs;

  void load_config_data(ModelCommon f) async {
    loader = CustomBusyLoader(context: context);
    loader.show();
    dialog = CustomAwesomeDialog(context: context);
    list_attr_mastr_temp.clear();
    list_temp_group_added.clear();
    list_attr_for_added.clear();
    list_test_config_data.clear();
    try {
      var x = await api.createLead([
        {"tag": "27", "p_testid": f.id}
      ], "getdata_drs");
      loader.close();
      if (checkJson(x)) {
        list_test_config_data.addAll(x.map((e) => ModelTestConfig.fromJson(e)));
        List<_group> y = <_group>[];
        List<_attrMaster> atr = <_attrMaster>[];
        for (var f in list_test_config_data) {
          y.add(_group(id: f.grpId, name: f.grpName));
          atr.add(_attrMaster(gid: f.grpId, id: f.atrId, name: f.atrName));
        }
        list_temp_group_added.addAll(y.toSet().toList());
        list_attr_for_added.addAll(atr.toSet().toList());
      }
    } catch (e) {
      loader.close();
      dialog
        ..dialogType = DialogType.error
        ..message = e.toString()
        ..show();
    }

    selectdTestMain.value = f;
  }

  void save() async {
    dialog = CustomAwesomeDialog(context: context);
    loader = CustomBusyLoader(context: context);
    loader.show();
    try {
      var s = '';
      int i = 0, j = 0;

      for (var a in list_temp_group_added) {
        i++;
        var y = list_attr_for_added.where((f) => f.gid == a.id);
        j = 0;
        for (var b in y) {
          j++;
          s += '${a.id!},$i,${b.id!},$j;';
        }
      }
      // print(s);
//p_testid in varchar2,p_str
      loader.close();
      var x = await api.createLead([
        {"tag": "26", "p_testid": selectdTestMain.value.id, "p_str": s}
      ], 'getdata_drs');
      ModelStatus st = await getStatusWithDialog(x, dialog);
      if (st.status == '1') {
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

  void delete_Attr(_attrMaster f) {
    list_attr_for_added.removeWhere((e) => e.id == f.id && e.gid == f.gid);
  }

  void attr_inedxChange(_attrMaster e) {
    var x = list_attr_for_added.indexOf(e);
    if (x > 0) {
      list_attr_for_added.remove(e);
      list_attr_for_added.insert(x - 1, e);
    }
  }

  void group_inedxChange(_group e) {
    var x = list_temp_group_added.indexOf(e);
    if (x > 0) {
      list_temp_group_added.remove(e);
      list_temp_group_added.insert(x - 1, e);
    }
  }

  void add_attribute(_attrMaster f) {
    if (list_attr_for_added
        .where((e) => e.id == f.id && e.gid == f.gid)
        .isNotEmpty) {
      //print('object');
      CustomSnackbar(
          context: context,
          message: 'Ths Attribute Already Exists',
          type: MsgType.warning);
      return;
    }

    list_attr_for_added.add(f);
  }

  void undo_attr_panel() {
    selectedGroupForAttr.value = _group();
  }

  void show_attr_for_add(_group f) {
    list_attr_mastr_temp.clear();
    list_attr_mastr_temp.addAll(list_attr_mastr.where((e) => e.gid == f.id));
    selectedGroupForAttr.value = f;
  }

  void delete_temp(_group f) {
    list_temp_group_added.removeWhere((e) => e.id == f.id);
    list_attr_for_added.removeWhere((e) => e.gid == f.id);
    selectedGroupForAttr.value = _group();
    //list_temp_attr_added.removeWhere((e) => e.pid == f.id);
  }

  void add_tempGroup(ModelPathResis f) {
    if (list_temp_group_added.where((e) => e.id == f.id).isNotEmpty) {
      //print('object');
      CustomSnackbar(
          context: context,
          message: 'Ths Group Already Exists',
          type: MsgType.warning);
      return;
    }
    list_temp_group_added.add(_group(id: f.id, name: f.name!));
  }

  void popUpDataGenerate(String id) {
    popUpHeaderName.value =
        id == '1' ? 'Pathogen Group List' : 'Resistance Group List';
    list_PathRes_temp.clear();
    list_PathRes_temp.addAll(list_PathRes_Group.where((e) => e.prId == id));
    isShowPopup.value = true;
  }

  // list_resistance = <ModelPathResis>[].obs;

  var isShowTestlist = true.obs;

  void search_test() {
    list_test_main_temp.clear();
    list_test_main_temp.addAll(list_test_main_master.where((f) =>
        f.name!.toUpperCase().contains(txt_search_test.text.toUpperCase())));
  }

  void undo_panel() {
    selectdTestMain.value = ModelCommon();
  }

  @override
  void onInit() async {
    api = data_api();
    isLoading.value = true;
    try {
      var x = await api.createLead([
        {"tag": "25"}
      ], 'getdata_drs');
      isLoading.value = false;
      if (checkJson(x)) {
        list_test_main_master.addAll(x.map((e) => ModelCommon.fromJson(e)));
        list_test_main_temp.addAll(list_test_main_master);
      }

      x = await api.createLead([
        {"tag": "20"}
      ], 'getdata_drs');
      // print(x);
      if (checkJson(x)) {
        list_PathRes_Group.addAll(x.map((e) => ModelPathResis.fromJson(e)));
        // list_Pathogen.addAll(list_PathRes_Group.where((e) => e.prId == '1'));
        // list_resistance.addAll(list_PathRes_Group.where((e) => e.prId == '1'));
      }
      x = await api.createLead([
        {"tag": "23", "p_gid": "0"}
      ], 'getdata_drs');

      if (checkJson(x)) {
        // print(x);

        list_attr_mastr.addAll(x.map((e) => _attrMaster.fromJson(e)));
      }
    } catch (e) {
      isLoading.value = false;
      isError.value = true;
      errorMessage.value = e.toString();
    }
    super.onInit();
  }
}

class _group extends Equatable {
  String? id;
  String? name;
  _group({
    this.id,
    this.name,
  });

  @override
  List<Object?> get props => [id, name];
}

class _attributes {
  String? pid;
  String? id;
  String? name;
  _attributes({
    this.id,
  });
}

class _attrMaster extends Equatable {
  String? id;
  String? name;
  String? gid;

  _attrMaster({this.id, this.name, this.gid});

  _attrMaster.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    name = json['name'];
    gid = json['gid'];
  }

  @override
  List<Object?> get props => [id, name, gid];

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['id'] = this.id;
  //   data['name'] = this.name;
  //   return data;
  // }
}
