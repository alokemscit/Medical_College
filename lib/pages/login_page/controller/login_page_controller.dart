import 'dart:convert';
import 'dart:typed_data';

import 'package:asgar_ali_hospital/common_model/model_status.dart';
import 'package:asgar_ali_hospital/constant/const.dart';
import 'package:asgar_ali_hospital/custom_widget/custom_awesome_dialog.dart';
import 'package:asgar_ali_hospital/custom_widget/custom_bysy_loader.dart';
import 'package:asgar_ali_hospital/data/data_api.dart';
import 'package:asgar_ali_hospital/data/data_static_user.dart';
import 'package:asgar_ali_hospital/pages/login_page/auth_provider/auth-provider.dart';
import 'package:asgar_ali_hospital/pages/login_page/model/model_patient_user.dart';
import 'package:asgar_ali_hospital/pages/main_home_page/main_home_page.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

import 'package:get/get.dart';

import 'package:pinput/pinput.dart';

class LoginPageController extends GetxController {
  late data_api api;
  late CustomBusyLoader loader;
  late BuildContext context;
  late CustomAwesomeDialog dialog;
  final TextEditingController txt_hcn = TextEditingController();
  final TextEditingController txt_mobile = TextEditingController();
  late ModelPatitentUser pModel;
  var pin_no = ''.obs;

  login() {
    dialog = CustomAwesomeDialog(context: context);
    loader = CustomBusyLoader(context: context);
    if (txt_hcn.text.length < 11) {
      dialog
        ..message = "Please eneter valid HCN"
        ..dialogType = DialogType.warning
        ..show();
      return;
    }
    if (txt_mobile.text.length < 11) {
      dialog
        ..message = "Please eneter valid moble number"
        ..dialogType = DialogType.warning
        ..show();
      return;
    }
    try {
      loader.show();
      api.createLead([
        {"tag": "10", "hcn": txt_hcn.text, "mob": txt_mobile.text}
      ]).then((value) {
        if (value.isEmpty) {
          loader.close();
          dialog
            ..message = "Please eneter valid HCN and moble number"
            ..dialogType = DialogType.error
            ..show();
          return;
        }
        pModel = value.map((e) => ModelPatitentUser.fromJson(e)).first;

        api.otp([
          {"mob": txt_mobile.text, "hcn": txt_hcn.text}
        ]).then((value) {
          loader.close();
          if (value.isEmpty) {
            //loader.close();
            dialog
              ..message = "OTP sending error!"
              ..dialogType = DialogType.error
              ..show();
            return;
          }

          var status = value.map((e) => ModelStatus.fromJson(e)).first;
          if (status.status != "1") {
            dialog
              ..message = status.msg!
              ..dialogType = DialogType.error
              ..show();
            return;
          }
          pin_no.value = '';
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) {
                return Center(
                  child: Stack(
                    children: [
                      Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Material(
                            color: Colors.transparent,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                              height: 300,
                              width: context.width - 50,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadiusDirectional.circular(8),
                                  color: Colors.grey[100]),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Please enter the secret pin code",
                                    style: TextStyle(
                                        fontFamily: appFontMuli,
                                        fontSize: 18,
                                        color: appColorLogoDeep),
                                  ),
                                  20.heightBox,
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Pinput(
                                              length: 5,
                                              onCompleted: (pin) {
                                                pin_no.value = pin;
                                                 if (pin_no.value.length < 5) {
                                          dialog
                                            ..dialogType = DialogType.warning
                                            ..message = "Invalid pin number!"
                                            ..show();
                                          return;
                                        }
                                        if (pin_no.value != status.id!) {
                                          dialog
                                            ..dialogType = DialogType.warning
                                            ..message = "Invalid pin number!"
                                            ..show();
                                          return;
                                        }
                                        finalLogin();

                                              }),
                                        ),
                                      ),
                                    ],
                                  ),
                                  10.heightBox,
                                  ElevatedButton.icon(
                                      onPressed: () {
                                        if (pin_no.value.length < 5) {
                                          dialog
                                            ..dialogType = DialogType.warning
                                            ..message = "Invalid pin number!"
                                            ..show();
                                          return;
                                        }
                                        if (pin_no.value != status.id!) {
                                          dialog
                                            ..dialogType = DialogType.warning
                                            ..message = "Invalid pin number!"
                                            ..show();
                                          return;
                                        }
                                        finalLogin();

                                        // controller.login();
                                      },
                                      icon: const Icon(Icons.arrow_forward),
                                      label: const Text("Continue")),
                                ],
                              ),
                            ),
                          )),
                      Positioned(
                        right: 0,
                        top: 0,
                        //right: 50,
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              pModel = ModelPatitentUser();
                              Navigator.pop(context);
                            },
                            child: Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius:
                                        BorderRadiusDirectional.circular(50)),
                                child: const Icon(
                                  Icons.close,
                                  color: Colors.white,
                                  size: 18,
                                )),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              });
        });

        // print(value);
      });
    } catch (e) {
      loader.close();
    }
  }

  void finalLogin() {
    DataStaticUser.hcn = pModel.hCN!;
    DataStaticUser.name = pModel.pATNAME!;
    DataStaticUser.mob = txt_mobile.text;
    DataStaticUser.dob = pModel.dOB!;
    try {
      Uint8List bytes = base64Decode(pModel.iMAGE!);

//     // Create an Image widget from the decoded bytes
      DataStaticUser.img = Image.memory(
        bytes,
        fit: BoxFit.cover,
        height: 55, // Adjust the fit property as needed
      );
    } catch (e) {
      print(e);
    }

    AuthProvider().login(pModel.hCN!, pModel.pATNAME, txt_mobile.text,
        pModel.bLOODGRP, pModel.sEX, pModel.dOB, pModel.iMAGE);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const MainHomePagae()),
    );
  }

  @override
  void onInit() {
    api = data_api();
    super.onInit();
  }
}
