import 'package:agmc/core/config/const.dart';
import 'package:agmc/model/model_common.dart';

import '../../../../model/model_status.dart';
import '../../../../widget/custom_snakbar.dart';

class AppInvAttrMasterController extends GetxController with MixInController {
  var editID = ''.obs;
  var list_attr_master = <ModelCommon>[].obs;
  var list_attr_temp = <ModelCommon>[].obs;
  final TextEditingController txt_name = TextEditingController();
  final TextEditingController txt_search = TextEditingController();

  void save() async {
    dialog = CustomAwesomeDialog(context: context);
    loader = CustomBusyLoader(context: context);
    loader.show();
    if (txt_name.text.isEmpty) {
      loader.close();
      dialog
        ..dialogType = DialogType.warning
        ..message = 'Attribute name required!'
        ..show();
      return;
    }
    try {
      var x = await api.createLead([
        {
          "tag": "125",
          "p_id": editID.value == '' ? "0" : editID.value,
          "p_name": txt_name.text
        }
      ]);
      loader.close();
      ModelStatus st = await getStatusWithDialog(x, dialog);
      if (st.status == '1') {
        if (editID.value.isNotEmpty) {
          list_attr_master.removeWhere((e) => e.id == editID.value);
        }
        list_attr_master.insert(
            0, ModelCommon(id: st.id!, name: txt_name.text));
        list_attr_temp.clear();
        list_attr_temp.addAll(list_attr_master);
        undo();
        CustomSnackbar(
            context: context, message: st.msg!, type: MsgType.success);
        // dialog
        //   ..dialogType = DialogType.success
        //   ..message = st.msg!
        //   ..show();
      }
    } catch (e) {
      loader.close();
      dialog
        ..dialogType = DialogType.error
        ..message = e.toString()
        ..show();
    }
  }

  void edit(ModelCommon e) {
    editID.value = e.id!;
    txt_name.text = e.name!;
  }

  void undo() {
    editID.value = '';
    txt_name.text = '';
  }

  void search() {
    list_attr_temp.clear();
    list_attr_temp.addAll(list_attr_master.where(
        (e) => e.name!.toUpperCase().contains(txt_name.text.toUpperCase())));
  }

  @override
  void onInit() async {
    isLoading.value = true;
    api = data_api();
    try {
      var x = await api.createLead([
        {"tag": "124"}
      ]);
      // print(x);
      if (x != [] ||
          x.map((e) => ModelStatus.fromJson(e)).first.status != '3') {
        list_attr_master.addAll(x.map((e) => ModelCommon.fromJson(e)));
        list_attr_temp.addAll(list_attr_master);
      }

      //  print(doc_list.length);
      // print(list_department.length);
      isLoading.value = false;
    } catch (e) {
      isError.value = true;
      errorMessage.value = e.toString();
      isLoading.value = false;
    }
    super.onInit();
  }
}
