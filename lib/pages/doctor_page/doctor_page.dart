import 'package:asgar_ali_hospital/constant/const.dart';
import 'package:asgar_ali_hospital/custom_widget/custom_cached_network_image.dart';
import 'package:asgar_ali_hospital/custom_widget/custom_search_box.dart';
import 'package:asgar_ali_hospital/pages/appointment_page/appointment_page.dart';
import 'package:asgar_ali_hospital/pages/doctor_page/doctor_page_controller/doctor_page_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class DoctorPage extends StatelessWidget {
  const DoctorPage({super.key});

  @override
  Widget build(BuildContext context) {
    DoctorPageController controller = Get.put(DoctorPageController());
    controller.context = context;
    return Column(
      children: [
        Row(
          children: [
            Expanded(
                child: CustomSearchBox(
                    height: 38,
                    borderRadious: 8,
                    caption: "Search Doctor",
                    controller: controller.txt_search,
                    onChange: (v) {
                      controller.search();
                    })),
          ],
        ),
        Obx(
          () => controller.isLoading.value
              ? const Expanded(
                  child: Center(
                    child: CupertinoActivityIndicator(),
                  ),
                )
              : Expanded(
                  child: Column(
                    children: [
                      4.heightBox,
                      _department_list(controller),
                      24.heightBox,
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          itemCount: controller.list_doctor_master_temp.length,
                          itemBuilder: (context, index) {
                            print(controller
                                .list_doctor_master_temp[index].iMAGE);
                            return Container(
                              padding: const EdgeInsets.all(4),
                              height: 150,
                              margin: const EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(8)),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 2,
                                        spreadRadius: 1,
                                        color:
                                            appColorGrayDark.withOpacity(0.2)),
                                  ]),
                              child: Row(
                                children: [
                                  Hero(
                                    tag: controller
                                        .list_doctor_master_temp[index].dOCID!,
                                    child: CustomCachedNetworkImageSquareShape(
                                      img: controller
                                          .list_doctor_master_temp[index]
                                          .iMAGE!,
                                      height: 140,
                                      width: 110,
                                      errorIconSize: 50,
                                    ),
                                  ),
                                  6.widthBox,
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        12.heightBox,
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            controller
                                                .list_doctor_master_temp[index]
                                                .dOCTORNAME!,
                                            overflow: TextOverflow.ellipsis,
                                            style: customTextStyle.copyWith(
                                                fontSize: 16,
                                                color: appColorLogoDeep,
                                                fontWeight: FontWeight.w800),
                                          ),
                                        ),
                                        _degree(
                                            controller
                                                .list_doctor_master_temp[index]
                                                .uNIT,
                                            Colors.black87,
                                            13),
                                        _degree(
                                            controller
                                                .list_doctor_master_temp[index]
                                                .dEGREE1,
                                            appColorGrayDark,
                                            12),
                                        _degree(
                                            controller
                                                .list_doctor_master_temp[index]
                                                .dEGREE2,
                                            appColorGrayDark),
                                        _degree(
                                            controller
                                                .list_doctor_master_temp[index]
                                                .dEGREE3,
                                            appColorGrayDark),
                                        const Spacer(),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 12,
                                                      vertical: 6),
                                              decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(4),
                                                    bottomLeft:
                                                        Radius.circular(4)),
                                                color: Colors.green,
                                              ),
                                              child: Text(
                                                "Profile Details",
                                                style: customTextStyle.copyWith(
                                                    color: Colors.white,
                                                    fontSize: 11.5,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            1.widthBox,
                                            Expanded(
                                              child: InkWell(
                                                 onTap: () {
                                                    if (controller
                                                            .list_doctor_master_temp[
                                                                index]
                                                            .iSONLINE ==
                                                        "0") {
                                                      return;
                                                    }
                                                    controller
                                                        .doctorMaster = controller
                                                            .list_doctor_master_temp[
                                                        index];
                                                    print(controller
                                                        .list_doctor_master_temp[
                                                            index]
                                                        .dOCID);
                                                    Navigator.push(context,
                                                        MaterialPageRoute(
                                                            builder: (context) {
                                                      return const DoctorAppointment();
                                                    }));
                                                  },
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                          horizontal: 12,
                                                          vertical: 6),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                            topRight:
                                                                Radius.circular(
                                                                    4),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    4)),
                                                    color: controller
                                                                .list_doctor_master_temp[
                                                                    index]
                                                                .iSONLINE !=
                                                            "0"
                                                        ? appColorLogoDeep
                                                        : appColorGrayLight,
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      controller
                                                                  .list_doctor_master_temp[
                                                                      index]
                                                                  .iSONLINE !=
                                                              "0"
                                                          ? "Appointment"
                                                          : "Not Available",
                                                      style: customTextStyle.copyWith(
                                                          color: controller
                                                                      .list_doctor_master_temp[
                                                                          index]
                                                                      .iSONLINE !=
                                                                  "0"
                                                              ? Colors.white
                                                              : Colors.red
                                                                  .withOpacity(
                                                                      0.5),
                                                          fontSize: 11.5,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            4.widthBox,
                                          ],
                                        ),
                                        4.heightBox,
                                      ],
                                      // color: Colors.grey,
                                    ),
                                  )
                                ],
                              ),
                              // height: 80,
                              // width: 200,
                              // color: Colors.amber,
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
        )
      ],
    );
  }
}

_degree(String? degree, Color fontColor, [double fontSize = 11.5]) =>
    degree == null
        ? const SizedBox()
        : Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(right: 4),
              child: Text(
                degree,
                overflow: TextOverflow.ellipsis,
                style: customTextStyle.copyWith(
                    fontSize: fontSize,
                    color: fontColor,
                    fontWeight: FontWeight.w500),
              ),
            ),
          );

_department_list(DoctorPageController controller) => SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Wrap(
        children: [
          for (var i = 0; i < controller.list_docunit.length; i++)
            Padding(
              padding: const EdgeInsets.only(right: 6),
              child: InkWell(
                onTap: () {
                  controller.selectedUnit.value =
                      controller.list_docunit[i].NITID!;
                  controller.unitClick();
                },
                child: Row(
                  children: [
                    Container(
                      height: 12,
                      width: 1,
                      color: appColorLogoDeep,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      margin: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 4),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadiusDirectional.circular(4),
                          color: controller.selectedUnit.value !=
                                  controller.list_docunit[i].NITID
                              ? Colors.white
                              : appColorLogo,
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 4,
                                spreadRadius: 0.5,
                                color: appColorGrayDark.withOpacity(0.1))
                          ]),
                      //height: 42,
                      // width: 110,
                      child: Center(
                        child: Text(
                          controller.list_docunit[i].NITTITLE!,
                          style: customTextStyle.copyWith(
                              color: controller.selectedUnit.value !=
                                      controller.list_docunit[i].NITID
                                  ? appColorGrayDark
                                  : Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
