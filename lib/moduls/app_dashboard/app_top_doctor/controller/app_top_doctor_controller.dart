import 'package:agmc/core/config/const.dart';
import 'package:agmc/widget/custom_snakbar.dart';

import '../../../../model/model_status.dart';
import '../../app_doc_profile_setup/model/model_doctor_master.dart';

class AppTopDoctorListController extends GetxController with MixInController {
  var list_doctor_master = <ModelDoctorMobMaster>[].obs;
  var list_doctor_temp = <ModelDoctorMobMaster>[].obs;
  var list_doctor_top = <ModelDoctorMobMaster>[].obs;
  final TextEditingController txt_search = TextEditingController();

  void setRemoveTop(ModelDoctorMobMaster e, int is_add) async {
    loader = CustomBusyLoader(context: context);
    dialog = CustomAwesomeDialog(context: context);
    loader.show();
    try {
      var x = await api.createLead([
        {"tag": "119", "doc_id": e.docId, "is_add": is_add}
      ]);
      loader.close();
      ModelStatus s = await getStatusWithDialog(x, dialog);
      if (s.status == '1') {
        if (is_add == 0) {
          list_doctor_top.removeWhere((f) => f.docId == e.docId);
          list_doctor_master.add(e);
          list_doctor_temp.clear();
          list_doctor_temp.addAll(list_doctor_master);
        } else {
          list_doctor_master.removeWhere((f) => f.docId == e.docId);
          list_doctor_temp.clear();
          list_doctor_temp.addAll(list_doctor_master);
          list_doctor_top.add(e);
        }
      }
    } catch (e) {
      loader.close();
      CustomSnackbar(
          context: context, message: e.toString(), type: MsgType.error);
    }
  }

  void search() {
    list_doctor_temp.clear();
    list_doctor_temp.addAll(list_doctor_master.where((e) =>
        e.docId == txt_search.text ||
        e.docName!.toUpperCase().contains(txt_search.text.toUpperCase())));
  }

  @override
  void onInit() async {
    isLoading.value = true;
    api = data_api();
    try {
      var x = await api.createLead([
        {"tag": "120", "is_top": "0"}
      ]);
      if (x != [] ||
          x.map((e) => ModelStatus.fromJson(e)).first.status != '3') {
        list_doctor_master
            .addAll(x.map((e) => ModelDoctorMobMaster.fromJson(e)));
        list_doctor_temp.addAll(list_doctor_master);
      }

      x = await api.createLead([
        {"tag": "120", "is_top": "1"}
      ]);
      if (x != [] ||
          x.map((e) => ModelStatus.fromJson(e)).first.status != '3') {
        list_doctor_top.addAll(x.map((e) => ModelDoctorMobMaster.fromJson(e)));
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
