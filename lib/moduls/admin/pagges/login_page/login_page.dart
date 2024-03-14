// ignore_for_file: non_constant_identifier_names

import 'package:agmc/core/config/const.dart';
import 'package:agmc/core/config/responsive.dart';
import 'package:agmc/moduls/admin/pagges/login_page/controller/login_controller.dart';
import 'package:agmc/widget/custom_dropdown.dart';
import 'package:agmc/widget/custom_textbox.dart';
import 'package:agmc/widget/custom_widget_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  @override
  Widget build(BuildContext context) {
    LoginConroller controller = Get.put(LoginConroller());
    controller.context = context;
    return Scaffold(
      extendBody: true,
      backgroundColor: kWebBackgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: controller.company_list
                  .map((element) => Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: headerAppLogo(
                            element.logo!,
                            element.id == "1"
                                ? 110
                                : element.id == "2"
                                    ? 170
                                    : 280),
                      ))
                  .toList(),
            ),
          ),
          Expanded(
            child: Responsive(
              mobile: Center(child: rightpart(controller)),
              tablet: Center(child: rightpart(controller)),
              desktop: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  leftPanel(),
                  Expanded(flex: 2, child: rightpart(controller))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget leftPanel() => Expanded(
      flex: 3,
      child: Padding(
        padding: const EdgeInsets.only(left: 36, top: 60, bottom: 80),
        child: ColorFiltered(
          colorFilter: ColorFilter.mode(
            appColorLogoDeep.withOpacity(0.5), // Adjust the color and opacity
            BlendMode.srcATop,
          ),
          child: Center(
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(18)),
                image: DecorationImage(
                  image: AssetImage('assets/images/college_front_image.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ),
    );

Widget rightpart(LoginConroller controller) {
  bool b = false;
  return SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Welcome.......!",
            style:
                customTextStyle.copyWith(color: kWebHeaderColor, fontSize: 24),
          ),
          Text(
            "Use your user id & password to Login!",
            style:
                customTextStyle.copyWith(color: kWebHeaderColor, fontSize: 12),
          ),
          const SizedBox(
            height: 12,
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              width: 400,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
              decoration: customBoxDecoration.copyWith(
                  color: appColorPista.withOpacity(0.4)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Login",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        fontStyle: FontStyle.italic,
                        color: kWebHeaderColor),
                  ),
                  12.heightBox,
                  CustomDropDown(
                    labeltext: "Company",
                    width: double.infinity,
                      id: controller.com_id.value,
                      list: controller.company_list
                          .map((element) => DropdownMenuItem<String>(
                              value: element.id, child: Text(element.name!,style: customTextStyle.copyWith(fontSize: 11,fontWeight: FontWeight.w500),)))
                          .toList(),
                      onTap: (v) {
                        controller.com_id.value = v!;
                      }),
                  8.heightBox,
                  CustomTextBox(
                      borderRadious: 8,
                      labelTextColor: Colors.black54,
                      isFilled: true,
                      width: double.infinity,
                      maxlength: 4,
                      caption: "Emp ID",
                      fontColor: Colors.black,
                      controller: controller.txt_empid,
                      onChange: (v) {}),
                  8.heightBox,
                  CustomTextBox(
                      borderRadious: 8,
                      labelTextColor: Colors.black54,
                      width: double.infinity,
                      surfixIconColor: kWebHeaderColor.withOpacity(0.5),
                      maxlength: 15,
                      fontColor: Colors.black,
                      isFilled: true,
                      isPassword: true,
                      caption: "Password",
                      controller: controller.txt_pws,
                      onChange: (v) {}),
                  16.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                appColorLogo), // Set background color
                          ),
                          onPressed: () {
                            if (!b) {
                              b = true;
                              controller.login();
                              Future.delayed(const Duration(seconds: 1), () {
                                b = false;
                              });
                            }
                          },
                          child: Row(
                            children: [
                              Text(
                                "Login",
                                style: customTextStyle.copyWith(
                                    fontSize: 10, color: appColorGrayLight),
                              ),
                              8.widthBox,
                              const Icon(
                                Icons.lock,
                                size: 14,
                                color: appColorGrayLight,
                              )
                            ],
                          )),
                    ],
                  )
                ],
              ),
            ),
          ),
          // const Spacer(
          //   flex: 2,
          // ),
          const SizedBox(
            height: 80,
          ),
        ],
      ),
    ),
  );
}
