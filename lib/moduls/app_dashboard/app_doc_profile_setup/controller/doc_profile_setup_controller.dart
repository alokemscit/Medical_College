import 'package:agmc/core/config/const.dart';
 

import '../../../../model/model_common.dart';
import '../../../../model/model_status.dart';

class DoctorProfileSeupController extends GetxController with MixInController {
  var editDocID = ''.obs;
  var selectedDeptID = ''.obs;
  final TextEditingController txt_docid = TextEditingController();
  final TextEditingController txt_name = TextEditingController();
  final TextEditingController txt_designation = TextEditingController();
  final TextEditingController txt_speciality = TextEditingController();
  var list_department = <ModelCommon>[].obs;
 

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
