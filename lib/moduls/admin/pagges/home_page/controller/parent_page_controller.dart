// ignore_for_file: unnecessary_overrides, use_build_context_synchronously

import 'package:agmc/core/config/const.dart';

import 'package:agmc/core/entity/company.dart';
import 'package:agmc/core/shared/custom_list.dart';
import 'package:agmc/model/model_common.dart';
import 'package:agmc/moduls/admin/pagges/home_page/shared/model_menu_list.dart';
import 'package:agmc/moduls/admin/pagges/login_page/login_page.dart';
import 'package:agmc/moduls/admin/pagges/login_page/notifires/aughtprovider.dart';
import 'package:agmc/core/shared/user_data.dart';

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
  var module_list_temp = <ModelModuleList>[].obs;
  var list_user_model = <ModelCommon>[].obs;
  Rx<Company> company = Company(id: '', name: '', logo: '').obs;

  var empId = ''.obs;
  var empName = ''.obs;
  var empDesig = ''.obs;
  var img_string = ''.obs;
  var com_list = <Company>[].obs;

  @override
  void onInit() async {
    api = data_api();
    super.onInit();
    isLoading.value = true;
    module_list_temp.addAll(await get_module());
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
    // print((user.value.comID));
    com_list.addAll((get_company_list())
        .where((element) => element.id == user.value.comID));
    company.value = com_list.first;
    empId.value = user.value.eMPID!;
    empName.value = user.value.eMPNAME!;
    empDesig.value = user.value.dSGNAME!;
    img_string.value = user.value.iMAGE!;

    try {
      var x = await api.createLead([
        {"tag": "138", "p_empid": user.value.eMPID}
      ]);
       isLoading.value = false;
      if (checkJson(x)) {
        list_user_model.addAll(x.map((e) => ModelCommon.fromJson(e)));
        for (var f in module_list_temp) {
          if(_isAccess(f.id!)) {
            module_list.add(f);
          }
        }
      }
    } catch (e) {
      isLoading.value = false;
      isError.value = true;
      errorMessage.value = e.toString();
    }

   
  }

  bool _isAccess(String id) {
    if (list_user_model.where((e) => e.id == id).isNotEmpty) {
      return true;
    }
    return false;
  }
}
