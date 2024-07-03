 

import 'package:agmc/core/config/const.dart';
import 'package:agmc/model/model_status.dart';

import '../model/model_package_master.dart';

class HealthPackageMasterController extends GetxController
    with MixInController {
  var editID = ''.obs;
  var list_package_master = <ModelPackageMaster>[].obs;
  var list_package_temp = <ModelPackageMaster>[].obs;
  final TextEditingController txt_name = TextEditingController();
  final TextEditingController txt_speci = TextEditingController();
  final TextEditingController txt_rate = TextEditingController();
  final TextEditingController txt_acc_rate = TextEditingController();
  final TextEditingController txt_search = TextEditingController();

  void save() async {
    dialog = CustomAwesomeDialog(context: context);
    loader = CustomBusyLoader(context: context);
    loader.show();
    if (txt_name.text.isEmpty) {
      loader.close();
      dialog
        ..dialogType = DialogType.warning
        ..message = 'Package name required!'
        ..show();
      return;
    }
    if (txt_speci.text.isEmpty) {
      loader.close();
      dialog
        ..dialogType = DialogType.warning
        ..message = 'Package specification required!'
        ..show();
      return;
    }
    if (txt_rate.text.isEmpty) {
      loader.close();
      dialog
        ..dialogType = DialogType.warning
        ..message = 'Package actual rate required!'
        ..show();
      return;
    }
    if (txt_acc_rate.text.isEmpty) {
      loader.close();
      dialog
        ..dialogType = DialogType.warning
        ..message = 'Package discounted rate required!'
        ..show();
      return;
    }

    try {
      //p_id in int, p_name in varchar2, p_desc in varchar2,p_rate in int, p_acc_rate in int,  p_sl in int
      var x = await api.createLead([
        {
          "tag": "122",
          "p_id": editID.value == '' ? "0" : editID.value,
          "p_name": txt_name.text,
          "p_desc": txt_speci.text,
          "p_rate": txt_rate.text,
          "p_acc_rate": txt_acc_rate.text,
          "p_sl": "0"
        }
      ]);
      loader.close();
      ModelStatus st = await getStatusWithDialog(x, dialog);
      if (st.status == '1') {
        if (editID.value.isNotEmpty) {
          list_package_master.removeWhere((e) => e.id == editID.value);
        }
        list_package_master.add(ModelPackageMaster(
            id: st.id,
            name: txt_name.text,
            des: txt_speci.text,
            rate: double.parse(txt_rate.text),
            accRate: double.parse(txt_acc_rate.text)));
        undo();
        list_package_temp.clear();
        list_package_temp.addAll(list_package_master);
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

  void edit(ModelPackageMaster e) {
    editID.value = e.id!;
    txt_name.text = e.name!;
    txt_speci.text = e.des!;
    txt_rate.text = e.rate!.toString();
    txt_acc_rate.text = e.accRate!.toString();
  }

  void undo() {
    editID.value = '';
    txt_name.text = '';
    txt_speci.text = '';
    txt_rate.text = '';
    txt_acc_rate.text = '';
  }

  void search() {
    list_package_temp.clear();
    list_package_temp.addAll(list_package_master.where((e) =>
        e.name!.toUpperCase().contains(txt_search.text.toUpperCase()) ||
        e.des!.toUpperCase().contains(txt_search.text.toUpperCase()) ||
        e.rate!.toString().toUpperCase().contains(txt_search.text.toUpperCase()) ||
         e.accRate!.toString().toUpperCase().contains(txt_search.text.toUpperCase())
        ));
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
