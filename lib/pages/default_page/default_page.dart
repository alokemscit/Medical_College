import 'package:asgar_ali_hospital/constant/const.dart';
import 'package:asgar_ali_hospital/pages/default_page/controller/default_page_controller.dart';
import 'package:asgar_ali_hospital/pages/login_page/login_page.dart';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class DefaultPage extends StatelessWidget {
  const DefaultPage({super.key});

  @override
  Widget build(BuildContext context) {
    DefaultPageController controller = Get.put(DefaultPageController());
    controller.context = context;
    return Scaffold(
      body: Stack(
        children: [
          _pageView(controller),
          _loginButton(),
          _continueButton(context, controller),
        ],
      ),
    );
  }
}

_pageView(DefaultPageController controller) => PageView.builder(
      controller: controller.pageController,
      itemCount: controller.imageUrls.length,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        return Image.asset(
          controller.imageUrls[index],
          fit: BoxFit.cover,
        );
      },
    );

_loginButton() => Positioned(
      bottom: 60,
      left: 15,
      child: InkWell(
        onTap: () {
          Get.to(() => const LoginPage(),transition:Transition.downToUp,duration: const Duration(microseconds: 600) );
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: appColorIndigoA100,
              boxShadow: [
                BoxShadow(
                    spreadRadius: 3,
                    blurRadius: 1,
                    color: Colors.black.withOpacity(0.05))
              ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Icon(Icons.lock, size: 16, color: appColorGrayLight),
              6.widthBox,
              "Log In"
                  .text
                  .fontFamily(appFontMuli)
                  .color(appColorGrayLight)
                  .fontWeight(FontWeight.w400)
                  .make(),
              4.widthBox,
            ],
          ),
        ),
      ),
    );

_continueButton(BuildContext context, DefaultPageController controller) =>
    Positioned(
      bottom: 60,
      right: 15,
      child: InkWell(
        onTap: () {
          //Get.to(() => const MainPage());
          // Get.delete<DefaultPageController>();
          controller.gotoMainPage();
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: appColorIndigoA100,
              boxShadow: [
                BoxShadow(
                    spreadRadius: 3,
                    blurRadius: 1,
                    color: Colors.black.withOpacity(0.05))
              ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              "Continue"
                  .text
                  .fontFamily(appFontMuli)
                  .color(appColorGrayLight)
                  .fontWeight(FontWeight.w400)
                  .make(),
              8.widthBox,
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(0),
                    child: Icon(
                      CupertinoIcons.forward,
                      size: 18,
                      color: appColorGrayLight,
                    ),
                  ),
                  //4.widthBox,
                  Padding(
                    padding: EdgeInsets.all(0),
                    child: Icon(
                      CupertinoIcons.chevron_forward,
                      size: 12,
                      color: appColorGrayLight,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
