import 'package:agmc/core/config/const.dart';
import 'package:agmc/core/shared/user_data.dart';

import '../../../../core/shared/custom_list.dart';

class FinDashBoardContrller extends GetxController with MixInController {
  var companyName = ''.obs;

  @override
  void onInit() async {
    isError.value = false;
    isLoading.value = false;
    user.value = await getUserInfo();
    if (user.value.eMPID == '' || user.value.eMPID == null) {
      errorMessage.value = 'Re- Login Required!';
      isError.value = true;
      return;
    }
   companyName.value= get_company_list().where((element) => element.id!.toString() == user.value.comID!)
        .first
        .name!;
    

    super.onInit();
  }
}
