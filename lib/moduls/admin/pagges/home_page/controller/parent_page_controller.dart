// ignore_for_file: unnecessary_overrides, use_build_context_synchronously

import 'package:agmc/config/const.dart';
import 'package:agmc/config/mixin_attr_for_controller.dart';
import 'package:agmc/moduls/admin/pagges/home_page/model/model_menu_list.dart';
import 'package:agmc/moduls/admin/pagges/login_page/login_page.dart';
import 'package:agmc/moduls/admin/pagges/login_page/notifires/aughtprovider.dart';
import 'package:agmc/shared/user_data.dart';
import 'package:agmc/widget/custom_awesome_dialog.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:get/get.dart';

class ParentPageController extends GetxController with MixInController {
  ParentPageController(BuildContext context) {
    context = context;
  }

  void logOut() async {
    await AuthProvider().logout();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
    Get.deleteAll();
  }

  var module_list = <ModelModuleList>[].obs;

  var empId = ''.obs;
  var empName = ''.obs;
  var empDesig = ''.obs;
  var img_string = ''.obs;
  @override
  void onInit() async {
    super.onInit();
    isLoading.value = true;
    module_list.addAll(await get_module());
    user.value = await getUserInfo();
    if (user.value.eMPID == null) {
      dialog = CustomAwesomeDialog(context: context);
      dialog
        ..dialogType = DialogType.error
        ..message = "You have to re-login"
        ..show()
        ..onTap = () {
          AuthProvider().logout();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginPage()),
          );
        };
      isLoading.value = false;
    }

    empId.value = user.value.eMPID!;
    empName.value = user.value.eMPNAME!;
    empDesig.value = user.value.dSGNAME!;
    img_string.value = user.value.iMAGE!;
    isLoading.value = false;
  }
}
