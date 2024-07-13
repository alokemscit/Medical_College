import 'package:agmc/core/config/const.dart';

import '../../../../core/shared/user_data.dart';
import '../../../../model/model_common.dart';
import '../../../../model/model_status.dart';
import '../../lab_pathogen_group/model/model_path_resistance.dart';

class RsistenceAttrController extends GetxController with MixInController{
  var list_attr_temp = <_tmpAttr>[].obs;
  final TextEditingController txt_attr_name = TextEditingController();
  final TextEditingController txt_serach = TextEditingController();
  final TextEditingController txt_serach_attr = TextEditingController();
  var selectedPathogen = ModelPathResis().obs;
  var selectedEdit = ModelCommon().obs;

  var list_pathogen_master = <ModelPathResis>[].obs;
  var list_pathogen_temp = <ModelPathResis>[].obs;

  var list_saved_attr_mastr = <ModelCommon>[].obs;
  var list_saved_attr_temp = <ModelCommon>[].obs;

  void searhAttr() {
    list_saved_attr_temp.clear();
    list_saved_attr_temp.addAll(list_saved_attr_mastr.where((f) =>
        f.name!.toUpperCase().contains(txt_serach_attr.text.toUpperCase())));
  }

  void searhGroup() {
    list_pathogen_temp.clear();
    list_pathogen_temp.addAll(list_pathogen_master.where(
        (f) => f.name!.toUpperCase().contains(txt_serach.text.toUpperCase())));
  }

  void edit(ModelCommon f) {
    selectedEdit.value = f;
    txt_attr_name.text = f.name!;
  }

  void undoE() {
    selectedEdit.value = ModelCommon();
    txt_attr_name.text = '';
  }

  void loadAttr() async {
    list_saved_attr_mastr.clear();
    list_saved_attr_temp.clear();
    loader = CustomBusyLoader(context: context);
    loader.show();
    try {
      //   print({"tag": "23", "p_gid": selectedPathogen.value.id});
      var x = await api.createLead([
        {"tag": "23", "p_gid": selectedPathogen.value.id}
      ], 'getdata_drs');
      loader.close();
      if (checkJson(x)) {
        // print(x);

        list_saved_attr_mastr.addAll(x.map((e) => ModelCommon.fromJson(e)));

        list_saved_attr_temp.addAll(list_saved_attr_mastr);
      }
    } catch (e) {
      loader.close();
      dialog
        ..dialogType = DialogType.error
        ..message = e.toString()
        ..show();
    }
  }

  void save() async {
    //大  人
    dialog = CustomAwesomeDialog(context: context);
    loader = CustomBusyLoader(context: context);
    loader.show();
    if (list_attr_temp.isEmpty) {
      loader.close();
      dialog
        ..dialogType = DialogType.warning
        ..message = 'No Attributes found for saving!'
        ..show();
      return;
    }
    var s = '';
    list_attr_temp.forEach((f) {
      s += '${f.name!}人${selectedPathogen.value.id!}大';
    });

    try {
      // print({"tag": "22", "p_gid": selectedPathogen.value.id, "p_str": s});
      //print(s);  p_gid in int,p_str
      var x = await api.createLead([
        {"tag": "22", "p_gid": selectedPathogen.value.id, "p_str": s}
      ], 'getdata_drs');
      loader.close();
      ModelStatus st = await getStatusWithDialog(x, dialog);
      if (st.status == '1') {
        dialog
          ..dialogType = DialogType.success
          ..message = st.msg!
          ..show()
          ..onTap = () async {
            list_attr_temp.clear();
            loadAttr();
          };
      }
    } catch (e) {
      loader.close();
      dialog
        ..dialogType = DialogType.error
        ..message = e.toString()
        ..show();
    }
  }

  void undo() {
    selectedPathogen.value = ModelPathResis();
    list_attr_temp.clear();
    txt_attr_name.text = '';
    selectedEdit.value = ModelCommon();
  }

  void delete_attr_temp(_tmpAttr e) {
    list_attr_temp.removeWhere((f) => f.name == e.name);
  }

  void add_Attr_temp() async {
    dialog = CustomAwesomeDialog(context: context);
    loader = CustomBusyLoader(context: context);
    if (txt_attr_name.text.isEmpty) {
      dialog
        ..dialogType = DialogType.warning
        ..message = 'Name Required!'
        ..show();
      return;
    }

    if (selectedEdit.value.id != null) {
      loader.show();
      try {
        var x = await api.createLead([
          {
            "tag": "24",
            "p_id": selectedEdit.value.id,
            "p_name": txt_attr_name.text
          }
        ], 'getdata_drs');
        loader.close();
        ModelStatus st = await getStatusWithDialog(x, dialog);
        if (st.status == '1') {
          dialog
            ..dialogType = DialogType.success
            ..message = st.msg!
            ..show()
            ..onTap = () {
              list_saved_attr_mastr
                  .removeWhere((f) => f.id == selectedEdit.value.id);
              list_saved_attr_mastr.insert(
                  0,
                  ModelCommon(
                      id: selectedEdit.value.id, name: txt_attr_name.text));
              list_saved_attr_temp.clear();
              list_saved_attr_temp.addAll(list_saved_attr_mastr);
              selectedEdit.value = ModelCommon();
              txt_attr_name.text = '';
            };
        }
      } catch (e) {
        loader.close();
        dialog
          ..dialogType = DialogType.error
          ..message = e.toString()
          ..show();
      }
    } else {
      if (list_attr_temp
          .where(
              (f) => f.name!.toUpperCase() == txt_attr_name.text.toUpperCase())
          .isNotEmpty) {
        dialog
          ..dialogType = DialogType.warning
          ..message = '${txt_attr_name.text}  Name already exists!'
          ..show();
        return;
      }
      if(list_saved_attr_mastr.where((e)=>e.name!.toUpperCase()==txt_attr_name.text.toUpperCase()).isNotEmpty){
         dialog
          ..dialogType = DialogType.warning
          ..message = '${txt_attr_name.text} Name already Saved!'
          ..show();
        return;
      }
      list_attr_temp.add(
          _tmpAttr(name: txt_attr_name.text, id: selectedPathogen.value.prId));
      txt_attr_name.text = '';
    }
  }

  @override
  void onInit() async {
    api = data_api();
    isLoading.value = true;
    user.value = await getUserInfo();
    if (user.value.eMPID == null) {
      isLoading.value = false;
      isError.value = true;
      errorMessage.value = 'Relogin required!';
      return;
    }
    try {
      var y = await loadData();
      isLoading.value = false;
      if (y != []) {
        list_pathogen_master.addAll(y);
        list_pathogen_temp.addAll(y);
      }
    } catch (e) {
      isLoading.value = false;
      isError.value = false;
      errorMessage.value = e.toString();
    }

    super.onInit();
  }

  Future<List<ModelPathResis>> loadData() async {
    List<ModelPathResis> list_path_res1 = [];
    try {
      var x = await api.createLead([
        {"tag": "20"}
      ], 'getdata_drs');
      // print(x);
      if (x != [] ||
          x.map((e) => ModelStatus.fromJson(e)).first.status != '3') {
        list_path_res1.addAll(x
            .map((e) => ModelPathResis.fromJson(e))
            .where((f) => f.prId == '2'));
        //  print(x);
        // print(x.map((e) => ModelStatus.fromJson(e)).first.msg);
        return list_path_res1;
      } else {
        // print(
        //     'Failed to load data: ${x.map((e) => ModelStatus.fromJson(e)).first.msg}');
        throw Exception(
            'Failed to load data: ${x.map((e) => ModelStatus.fromJson(e)).first.msg}');
      }
      //return list_path_res1;
    } catch (e) {
      //print(e);
      throw Exception('Failed to load data: $e');
    }
  }
}

class _tmpAttr {
  String? id;
  String? name;
  _tmpAttr({
    this.id,
    this.name,
  });
}
