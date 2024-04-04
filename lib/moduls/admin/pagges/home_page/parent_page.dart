 

import 'package:agmc/core/config/const.dart';

import 'package:agmc/moduls/admin/pagges/home_page/controller/parent_page_controller.dart';

import 'package:agmc/moduls/admin/pagges/home_page/widget/parent_page_module_list_widget.dart';
 

import 'package:agmc/widget/custom_widget_list.dart';
import 'package:flutter/cupertino.dart';

 

class ParentPage extends StatelessWidget {
  const ParentPage({super.key});

  @override
  Widget build(BuildContext context) {
    ParentPageController controller = Get.put(ParentPageController(context));
    controller.context = context;
    // Get.reset();
    // Get.deleteAll();
    return Scaffold(
        backgroundColor: kWebBackgroundColor,
        body: Obx(() => controller.isLoading.value
            ? const Center(child: CupertinoActivityIndicator())
            : Stack(
                children: [
                  _bodyBackground(),
                  SizedBox(
                    width: double.infinity,
                    height: 130,
                    child: _headerPart(controller, context),
                  ),
                  _contectPart(controller),
                ],
              )));
  }
}

_contectPart(ParentPageController controller) => Positioned.fill(
    top: 150,
    child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
        ),
        child: ParentMainModuleListWidget(
          list: controller.module_list,
        )));

_bodyBackground() => Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 58, 56, 56).withOpacity(0.035),
        image: const DecorationImage(
            image: AssetImage("assets/Backgrounds/Spline.png"),
            fit: BoxFit.cover,
            opacity: 0.051,
            colorFilter: ColorFilter.srgbToLinearGamma()),
      ),
    );

_headerPart(ParentPageController controller, BuildContext context) =>   Column(
  children: [
    Padding(
            padding: const EdgeInsets.only(left: 14, right: 24, top: 4),
            child: _headerContent(controller, context),
           
        ),
        const Spacer(),
        Divider(
          height:1,
          color: appColorLogo.withOpacity(0.1),
        )
  ],
);

_headerContent(ParentPageController controller, BuildContext context) => Row(
      // mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: context.width < 650 ? const SizedBox() : 
          
          headerAppLogo(
                            controller.company.value.logo!,
                            controller.company.value.id == "1"
                                ? 110
                                : controller.company.value.id == "2"
                                    ? 170
                                    : 280)
          
          ,
        ),
        user_login_details(controller.user.value, () {
          controller.logOut();
        })
      ],
    );
