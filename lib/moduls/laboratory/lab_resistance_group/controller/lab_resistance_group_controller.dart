import 'package:agmc/core/config/const.dart';

import '../../../../core/shared/user_data.dart';
import '../../../../model/model_status.dart';

class ResistanceGroupController extends GetxController with MixInController {
  var list_tmp_pathGroup = <_tempPathGroup>[].obs;
  final TextEditingController txt_name = TextEditingController();
  final TextEditingController txt_search = TextEditingController();

  var chk_isnote = false.obs;
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
        s += '2人${f.name!}人0人${f.isNote! ? "1" : "0"}大';
      });
      print(s);
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
        name: txt_name.text, isBMC: false, isNote: chk_isnote.value));
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
    super.onInit();
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
