import 'package:agmc/core/config/const.dart';

import '../shared/user_data.dart';

class BaseController extends GetxController with MixInController {
 // @override
  Future<void> init() async {
    super.onInit();
    isError.value = false;
    isLoading.value = false;
    api = data_api();
    try {
     
      user.value = await getUserInfo();
      // print(user.value.uNAME);
      if (user.value.eMPID == null) {
        isError.value = true;
        isLoading.value = false;
        errorMessage.value = "User re-login required!";
        return;
      }
      isLoading.value = false;
     // isError.value = true;
      //errorMessage.value = 'user relogin required';
     } catch (e) {
       isLoading.value = true;
      isError.value = true;
      errorMessage.value = e.toString();
    }
  }
  @override
  void onClose() {
    // Dispose of the controller when it is no longer needed
    Get.delete<BaseController>();
    super.onClose();
  }
}
