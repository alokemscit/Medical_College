// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:agmc/core/config/const.dart';
import 'package:agmc/core/shared/user_data.dart';
import 'package:agmc/model/model_status.dart';

import '../model/model_path_resistance.dart';

class PathogenGroupController extends GetxController with MixInController {
  var list_tmp_pathGroup = <_tempPathGroup>[].obs;
  final TextEditingController txt_name = TextEditingController();
  final TextEditingController txt_search = TextEditingController();

  var list_path_res = <ModelPathResis>[].obs;
  var list_path = <ModelPathResis>[].obs;
  var selectedPR = ModelPathResis().obs;

  var chk_isBMI = false.obs;
  var chk_isnote = false.obs;

  void edit(ModelPathResis f) {
    selectedPR.value = f;
    txt_name.text = f.name!;
    chk_isBMI.value = f.bin == '1' ? true : false;
    chk_isnote.value = f.note == '1' ? true : false;
  }

  void undo() {
    selectedPR.value = ModelPathResis();
    txt_name.text = '';
    chk_isBMI.value = false;
    chk_isnote.value =  false;
  }

  void delTemp(_tempPathGroup c) {
    list_tmp_pathGroup.removeWhere((e) => e.name == c.name);
  }

  void save() async {
    dialog = CustomAwesomeDialog(context: context);
    loader = CustomBusyLoader(context: context);
    loader.show();
    try {
      String s = '';
      list_tmp_pathGroup.forEach((f) {
        s += '1人${f.name!}人${f.isBMC! ? "1" : "0"}人${f.isNote! ? "1" : "0"}大';
      });
      //print(s);
//大  人
//  19 p_str in varchar2,p_entryby in varchar2,p_macno in varchar2, p_comid
      var x = await api.createLead([
        {
          "tag": "19",
          "p_str": s,
          "p_entryby": user.value.eMPID,
          "p_macno": "online",
          "p_comid": user.value.comID
        }
      ], "getdata_drs");
      loader.close();
      ModelStatus st = await getStatusWithDialog(x, dialog);
      if (st.status == '1') {
        dialog
          ..dialogType = DialogType.success
          ..message = st.msg!
          ..show()
          ..onTap = () async {
            loader.show();
            var y = await loadData();
            loader.close();
            if (y != []) {
              list_path_res.clear();
              list_path_res.addAll(y);
              list_path.clear();
              list_path.addAll(y);
              list_tmp_pathGroup.clear();
            }
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

  void add() {
    dialog = CustomAwesomeDialog(context: context);
    if (txt_name.text.trim().isEmpty) {
      dialog
        ..dialogType = DialogType.warning
        ..message = 'Pathogen group name required!'
        ..show();
      return;
    }
    if (list_tmp_pathGroup
        .where((e) => e.name!.toUpperCase() == txt_name.text.toUpperCase())
        .isNotEmpty) {
      dialog
        ..dialogType = DialogType.warning
        ..message = 'This Pathogen group name already exists!'
        ..show();
      return;
    }
    list_tmp_pathGroup.add(_tempPathGroup(
        name: txt_name.text, isBMC: chk_isBMI.value, isNote: chk_isnote.value));
    txt_name.text = '';
  }

  @override
  void onInit() async {
    api = data_api();
    user.value = await getUserInfo();
    if (user.value.eMPID == null) {
      isLoading.value = false;
      isError.value = true;
      errorMessage.value = 'Relogin Required';
      return;
    }

    try {
      var y = await loadData();
      // print(y);
      isLoading.close();
      if (y != []) {
        list_path_res.addAll(y);
        list_path.addAll(y);
      }
    } catch (e) {
      isLoading.close();
      isError.value = true;
      errorMessage.value = e.toString();
    }

    // if (y != '') {
    //   isError.value = true;
    //   errorMessage.value = y.toString();
    // }
    // try {
    //   var x = await api.createLead([
    //     {"tag": "20"}
    //   ], 'getdata_drs');
    //   isLoading.value = false;
    //   print(x);
    //   if (x != [] ||
    //       x.map((e) => ModelStatus.fromJson(e)).first.status != '3') {
    //     list_path_res.addAll(x
    //         .map((e) => ModelPathResis.fromJson(e))
    //         .where((f) => f.prId == '1'));
    //     list_path.addAll((list_path_res));
    //   }
    // } catch (e) {
    //   isLoading.value = false;
    //   isError.value = true;
    //   errorMessage.value = e.toString();
    // }
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
            .where((f) => f.prId == '1'));
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

class _tempPathGroup {
  String? name;
  bool? isBMC;
  bool? isNote;
  _tempPathGroup({
    this.name,
    this.isBMC,
    this.isNote,
  });
}
