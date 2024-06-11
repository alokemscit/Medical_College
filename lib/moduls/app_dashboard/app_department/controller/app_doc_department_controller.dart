import 'package:agmc/core/config/const.dart';
import 'package:agmc/model/model_common.dart';
import 'package:agmc/model/model_status.dart';

class AppDocDepartmentController extends GetxController with MixInController {
  var editDeptID = ''.obs;
  final TextEditingController txt_name = TextEditingController();
  final TextEditingController txt_search = TextEditingController();
  var list_department = <ModelCommon>[].obs;
  var list_department_main = <ModelCommon>[].obs;

  void saveUpdate() async {
    dialog = CustomAwesomeDialog(context: context);
    loader = CustomBusyLoader(context: context);
    loader.show();
    try {
      var x = await api.createLead([
        {
          "tag": "111",
          "p_id": editDeptID.value == '' ? "0" : editDeptID.value,
          "p_name": txt_name.text
        }
      ]);

      // print({
      //   "tag": "111",
      //   "p_id": editDeptID.value == '' ? "0" : editDeptID.value,
      //   "p_name": txt_name.text
      // });

      //print(x);
      loader.close();
      ModelStatus s = await getStatusWithDialog(x, dialog);
      if (s.status == '1') {
        list_department_main.removeWhere((e) => e.id == editDeptID.value);
        list_department_main.insertT(
            0, ModelCommon(id: s.id, name: txt_name.text));
        list_department.clear();
        list_department.addAll(list_department_main);
        editDeptID.value = '';
        txt_name.text = '';
        dialog
          ..dialogType = DialogType.success
          ..message = s.msg!
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

  void search() {
    list_department.clear();
    list_department.addAll(list_department_main.where(
        (e) => e.name!.toUpperCase().contains(txt_search.text.toUpperCase())));
  }

  @override
  void onInit() async {
    isLoading.value = true;
    api = data_api();
    try {
      var x = await api.createLead([
        {"tag": "110"}
      ]);
      if (x != [] ||
          x.map((e) => ModelStatus.fromJson(e)).first.status != '3') {
        list_department.addAll(x.map((e) => ModelCommon.fromJson(e)));
        list_department_main.addAll(list_department);
      }
      isLoading.value = false;
      // print(list_department.length);
    } catch (e) {
      isError.value = true;
      errorMessage.value = e.toString();
      isLoading.value = false;
    }
    super.onInit();
  }
}
