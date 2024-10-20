import 'package:agmc/core/config/const.dart';

import '../../../../core/shared/user_data.dart';
import '../../voucher_entry_page/model/model_voucher_type.dart';

class FinVoucherApprovalController extends GetxController with MixInController {
  final TextEditingController txt_fdate = TextEditingController();
  final TextEditingController txt_tdate = TextEditingController();

  var selectedvoucherType = ''.obs;

  var list_vtype = <ModelVoucherType>[].obs;
  @override
  void onInit() async {
    api = data_api();
    isLoading.value = true;
    user.value = await getUserInfo();
    if (user.value.eMPID == null) {
      isLoading.value = false;
      isError.value = true;
      errorMessage.value = 'Re-Login required!';
      return;
    }
    try {
      var x = await api.createLead([
        {
          "tag": "80",
        }
      ]);
      isLoading.value = false;
      if (checkJson(x)) {
        list_vtype.addAll(x.map((e) => ModelVoucherType.fromJson(e)));
      }
    } catch (e) {
      isLoading.value = false;
      isError.value = true;
      errorMessage.value = e.toString();
    }

    super.onInit();
  }
}
