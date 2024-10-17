import 'package:asgar_ali_hospital/constant/const.dart';
import 'package:asgar_ali_hospital/custom_widget/custom_textbox.dart';
import 'package:asgar_ali_hospital/pages/login_page/controller/login_page_controller.dart';
import 'package:asgar_ali_hospital/pages/main_home_page/connection_error_page.dart';
import 'package:asgar_ali_hospital/pages/main_home_page/controller/connection_controller.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    LoginPageController controller = Get.put(LoginPageController());
    final ConnectivityService connectivityService =
        Get.find<ConnectivityService>();
    controller.context = context;
    return Obx(() {
      if (!connectivityService.isConnected) {
        //print("fired");
        return const ConnectionErrorPage();
      } else {
        return Scaffold(
          // extendBody: true,
          extendBodyBehindAppBar: true,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Stack(
              children: [
                _topPart(),
                _loginPart(controller),
              ],
            ),
          ),
        );
      }
    });
  }
}

_loginPart(LoginPageController controller) => Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Spacer(),
        Container(
          decoration: CustomBoxDecorationTopRounded.copyWith(
              color: kBgLightColor, border: Border.all(color: appColorPista)),
          padding: const EdgeInsets.all(18),
          child: Column(
            children: [
              //hospitalLogo(),
              const Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Icon(
                    Icons.lock_outline_rounded,
                    color: appColorLogoDeep,
                  ),
                  Text(
                    "Patient Login",
                    style: TextStyle(
                        fontSize: 10,
                        fontFamily: appFontMuli,
                        color: appColorLogoDeep,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
              15.heightBox,
              Row(
                children: [
                  Expanded(
                      child: CustomTextBox(
                          height: 38,
                          borderRadious: 8,
                          isCapitalization: true,
                          maxlength: 11,
                          caption: "HCN",
                          controller: controller.txt_hcn,
                          onChange: (onChange) {})),
                ],
              ),
              8.heightBox,
              Row(
                children: [
                  Expanded(
                      child: CustomTextBox(
                          height: 38,
                          maxlength: 11,
                          borderRadious: 8,
                          caption: "Mobile Number",
                          controller: controller.txt_mobile,
                          onChange: (onChange) {})),
                ],
              ),
              12.heightBox,
              ElevatedButton.icon(
                  onPressed: () {
                    controller.login();
                  },
                  icon: const Icon(Icons.arrow_forward),
                  label: const Text("Continue")),
            ],
          ),
        ),
        const Spacer(),
      ],
    );

_topPart() => Positioned(
    top: 100,
    left: 0,
    right: 0,
    child: Column(
      children: [
        Image.asset(
          "assets/images/logo.png",
          fit: BoxFit.cover,
          height: 80,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 55, vertical: 0),
          child: Text(
              "Please use your HCN & registered mobile number to login ",
              style: TextStyle(
                  color: appColorLogo,
                  fontFamily: appFontMuli,
                  fontSize: 12,
                  fontWeight: FontWeight.normal)),
        ),
      ],
    ));
