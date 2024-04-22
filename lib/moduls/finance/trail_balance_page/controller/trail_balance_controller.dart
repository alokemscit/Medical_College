import 'package:agmc/core/config/const.dart';
import 'package:agmc/core/config/const_widget.dart';

import '../../../../core/shared/user_data.dart';
import '../model/model_trail_balance.dart';

class TarailBalanceController extends GetxController with MixInController {
  final TextEditingController txt_fromDate = TextEditingController();
  final TextEditingController txt_toDate = TextEditingController();
  var list_traing_balance = <ModelTralBalance>[].obs;

  void showData() {
    //print('object');
    dialog = CustomAwesomeDialog(context: context);
    loader = CustomBusyLoader(context: context);
    if (txt_fromDate.text == '') {
      dialog
        ..dialogType = DialogType.warning
        ..message = 'Valid from date required'
        ..show();
      return;
    }
    if (txt_toDate.text == '') {
      dialog
        ..dialogType = DialogType.warning
        ..message = 'Valid to date required'
        ..show();
      return;
    }
   //  bool b = isValidDateRange(txt_fromDate.text, txt_toDate.text);
    if (!isValidDateRange(txt_fromDate.text, txt_toDate.text)) {
      dialog
        ..dialogType = DialogType.warning
        ..message = 'From Date and To Date are not a valid date range!'
        ..show();
      return;
    }

    //loader.show();

    //loader.close();
  }

  @override
  void onInit() async {
    super.onInit();
    isLoading.value = true;
    isError.value = false;

    api = data_api();
    user.value = await getUserInfo();
    if (user == null) {
      isError.value = true;
      errorMessage.value = "Re- Login required";
      isLoading.value = false;
      return;
    }

    isLoading.value = false;
  }
}
