import 'package:agmc/config/const.dart';
import 'package:agmc/config/data_api.dart';
import 'package:agmc/config/mixin_attr_for_controller.dart';
import 'package:agmc/model/model_status.dart';
import 'package:agmc/moduls/admin/pagges/home_page/parent_page.dart';
import 'package:agmc/moduls/admin/pagges/login_page/model/user_model.dart';
import 'package:agmc/moduls/admin/pagges/login_page/notifires/aughtprovider.dart';
 

import 'package:agmc/widget/custom_awesome_dialog.dart';
import 'package:agmc/widget/custom_bysy_loader.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:get/get.dart';

class LoginConroller extends GetxController with MixInController {
  final TextEditingController txt_empid = TextEditingController();
  final TextEditingController txt_pws = TextEditingController();
  Rx<User_Model> user = User_Model().obs;
  late AuthProvider authProvider;
  void login() async {
    dialog = CustomAwesomeDialog(context: context);
    loader = CustomBusyLoader(context: context);
    if (txt_empid.text.length < 4) {
      dialog
        ..dialogType = DialogType.warning
        ..message = "Please entere valid Emp ID!"
        ..show();
      return;
    }
    if (txt_pws.text.isEmpty) {
      dialog
        ..dialogType = DialogType.warning
        ..message = "Please entere valid Password!"
        ..show();
      return;
    }
    try {
      // print(txt_pws.text);
      loader.show();
      // print("object");
      //await Future.delayed(Duration(seconds: 5));
      api.createLead([
        {
          "tag": "35",
          "p_emp_id": txt_empid.text,
          "p_emp_pws": txt_pws.text,
          "p_token": " "
        }
      ], "userlogin").then((value) {
        loader.close();
       // print(value);
        if (value == []) {
          dialog
            ..dialogType = DialogType.error
            ..message = "Network error!"
            ..show();
          return;
        }

        ModelStatus s = value.map((e) => ModelStatus.fromJson(e)).first;
        if (s.status != "1") {
          dialog
            ..dialogType = DialogType.warning
            ..message = s.msg!
            ..show();
          return;
        }
        user.value = value.map((e) => User_Model.fromJson(e)).first;
        authProvider.login(
            user.value.eMPID!,
            user.value.eMPNAME!,
            user.value.dEPTID!,
            user.value.dEPTNAME!,
            user.value.uID!,
            user.value.uNAME!,
            user.value.dSGID!,
            user.value.dSGNAME!,
            user.value.iMAGE!);

     Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const ParentPage()),
    );
      
      });

      // loader.close();
    } catch (e) {
      loader.close();
      if (txt_empid.text.length < 4) {
        dialog
          ..dialogType = DialogType.warning
          ..message = e.toString()
          ..show();
      }
    }
  }

  @override
  void onInit() {
    api = data_api();
    authProvider = AuthProvider();
    super.onInit();
  }
}
