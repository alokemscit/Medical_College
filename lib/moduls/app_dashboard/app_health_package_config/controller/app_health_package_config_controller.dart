import 'package:agmc/core/config/const.dart';
import 'package:agmc/widget/custom_snakbar.dart';

import '../../../../model/model_common.dart';
import '../../../../model/model_status.dart';
import '../../app_health_package_master/model/model_package_master.dart';

class HealthPackageConfigController extends GetxController
    with MixInController {
  final TextEditingController txt_searchPackage = TextEditingController();
  final TextEditingController txt_searchAttr = TextEditingController();
  final TextEditingController txt_searchAttr2 = TextEditingController();
  var isShow = false.obs;
  var selectedPackageID = ''.obs;
  var selectedPackageName = ''.obs;

  var list_package_master = <ModelPackageMaster>[].obs;
  var list_package_temp = <ModelPackageMaster>[].obs;

  var list_attr_master = <ModelCommon>[].obs;
  var list_attr_temp = <ModelCommon>[].obs;

  var list_con_data_master = <_modelPackageConfig>[].obs;
  var list_con_data_temp = <_modelPackageConfig>[].obs;

  void saveAttr() async {
    //inedxChange
    dialog = CustomAwesomeDialog(context: context);
    loader = CustomBusyLoader(context: context);
    loader.show();
    var i = 1;
    String s = '';
    list_con_data_temp.forEach((f) {
      s += "${f.aid},$i;";
      i++;
    });
    try {
      var x = await api.createLead([
        {"tag": "128", "p_pid": selectedPackageID.value, "p_str": s}
      ]);
      loader.close();
      ModelStatus st = await getStatusWithDialog(x, dialog);
      if (st.status == '1') {
        dialog
          ..dialogType = DialogType.success
          ..message = st.msg!
          ..show();
        isShow.value = false;
      }
    } catch (e) {
      loader.close();
      dialog
        ..dialogType = DialogType.error
        ..message = e.toString()
        ..show();
    }
    // print(s);
    // p_pid in int,p_str
  }

  // ignore: library_private_types_in_public_api
  void inedxChange(_modelPackageConfig e) {
    var x = list_con_data_temp.indexOf(e);
    if (x > 0) {
      list_con_data_temp.remove(e);
      list_con_data_temp.insert(x - 1, e);
    }
  }

  void searchPopUpAttr() {
    //txt_searchAttr2.clear();
    //txt_searchAttr2.add
    list_attr_temp.clear();
    list_attr_temp.addAll(list_attr_master.where((e) =>
        e.name!.toUpperCase().contains(txt_searchAttr2.text.toUpperCase())));
  }

  void searchPackage() {
    list_package_temp.clear();
    list_package_temp.addAll(list_package_master.where((e) =>
        e.name!.toUpperCase().contains(txt_searchPackage.text.toUpperCase()) ||
        e.des!.toUpperCase().contains(txt_searchPackage.text.toUpperCase()) ||
        e.accRate!
            .toString()
            .toUpperCase()
            .contains(txt_searchPackage.text.toUpperCase()) ||
        e.rate!
            .toString()
            .toUpperCase()
            .contains(txt_searchPackage.text.toUpperCase())));
  }

  void remove(String id, bool b, String pid) async {
    if (!b) {
      list_con_data_temp.removeWhere((e) => e.aid == id);
    } else {
      dialog = CustomAwesomeDialog(context: context);
      loader = CustomBusyLoader(context: context);
      loader.show();
      try {
        var x = await api.createLead([
          {"tag": "127", "p_pid": pid, "p_aid": id}
        ]);

        loader.close();
        ModelStatus s = await getStatusWithDialog(x, dialog);
        if (s.status == "1") {
          CustomSnackbar(
              // ignore: use_build_context_synchronously
              context: context,
              message: s.msg!,
              type: MsgType.success);
          list_con_data_master.removeWhere((e) => e.aid == id && e.pid == pid);
          list_con_data_temp.clear();
          list_con_data_temp.addAll(list_con_data_master);
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

  void add(String pid, String id, String name) {
    dialog = CustomAwesomeDialog(context: context);
    loader = CustomBusyLoader(context: context);
    loader.show();
    var t = list_con_data_temp.where((e) => e.aid == id && e.pid == pid).length;
    if (t > 0) {
      loader.close();
      dialog
        ..dialogType = DialogType.warning
        ..message = 'This attribute already exists!'
        ..show();
    } else {
      loader.close();
      list_con_data_temp
          .add(_modelPackageConfig(pid: pid, aid: id, name: name, sl: ''));
    }
  }

  void loadConData(String pid) async {
    dialog = CustomAwesomeDialog(context: context);
    loader = CustomBusyLoader(context: context);
    loader.show();
    list_con_data_master.clear();
    list_con_data_temp.clear();
    try {
      var x = await api.createLead([
        {"tag": "126", "p_pid": pid}
      ]);
      if (x != [] &&
          x.map((e) => ModelStatus.fromJson(e)).first.status != "3") {
        list_con_data_master
            .addAll(x.map((e) => _modelPackageConfig.fromJson(e)));
        list_con_data_temp.addAll(list_con_data_master);
      }
      print(x);

      loader.close();
    } catch (e) {
      loader.close();
      dialog
        ..dialogType = DialogType.error
        ..message = e.toString()
        ..show();
    }
  }

  void undo() {
    selectedPackageID.value = '';
    selectedPackageName.value = '';
    isShow.value = false;
  }

  @override
  void onInit() async {
    isLoading.value = true;
    api = data_api();
    try {
      var x = await api.createLead([
        {"tag": "123"}
      ]);
      // print(x);
      if (x != [] ||
          x.map((e) => ModelStatus.fromJson(e)).first.status != '3') {
        list_package_master
            .addAll(x.map((e) => ModelPackageMaster.fromJson(e)));
        list_package_temp.addAll(list_package_master);
      }

      x = await api.createLead([
        {"tag": "124"}
      ]);
      // print(x);
      if (x != [] ||
          x.map((e) => ModelStatus.fromJson(e)).first.status != '3') {
        list_attr_master.addAll(x.map((e) => ModelCommon.fromJson(e)));
        list_attr_temp.addAll(list_attr_master);
      }

      isLoading.value = false;
    } catch (e) {
      isError.value = true;
      errorMessage.value = e.toString();
      isLoading.value = false;
    }
    super.onInit();
  }
}

class _modelPackageConfig {
  String? pid;
  String? aid;
  String? name;
  String? sl;

  _modelPackageConfig({this.pid, this.aid, this.name, this.sl});

  _modelPackageConfig.fromJson(Map<String, dynamic> json) {
    pid = json['pid'];
    aid = json['aid'];
    name = json['name'];
    sl = json['sl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pid'] = this.pid;
    data['aid'] = this.aid;
    data['name'] = this.name;
    data['sl'] = this.sl;
    return data;
  }
}
