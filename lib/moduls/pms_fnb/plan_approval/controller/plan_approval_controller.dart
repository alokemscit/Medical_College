import 'package:agmc/core/config/const.dart';
import 'package:agmc/core/shared/user_data.dart';
import 'package:agmc/model/model_common.dart';

class PlanApprovalController extends GetxController with MixInController {
  var list_type = <ModelCommon>[].obs;
  var selecTedTypeId = ''.obs;

  @override
  void onInit() async {
    isLoading.value = true;
    api = data_api();
    user.value = await getUserInfo();
    if (user.value.eMPID == null) {
      errorMessage.value = 'Re-loging requird!';
      isError.value = true;
      isLoading.value = false;
      return;
    }
    list_type.addAll([
      ModelCommon(id: "1", name: "Pending"),
      ModelCommon(id: "2", name: "Approved"),
      ModelCommon(id: "3", name: "Canceled")
    ]);
    isLoading.value = false;
    super.onInit();
  }
}
