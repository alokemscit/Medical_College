// ignore_for_file: unrelated_type_equality_checks, no_leading_underscores_for_local_identifiers

import 'package:asgar_ali_hospital/constant/const.dart';

import 'package:asgar_ali_hospital/custom_widget/custom_dropdown.dart';
import 'package:asgar_ali_hospital/custom_widget/custom_panel.dart';
import 'package:asgar_ali_hospital/data/data_static_user.dart';
import 'package:asgar_ali_hospital/pages/lab_report_page/controller/lab_report_page_controller.dart';
import 'package:flutter/cupertino.dart';

import 'package:get/get.dart';

class LabReportPage extends StatelessWidget {
  const LabReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    LabReportPageController controller = Get.put(LabReportPageController());
    controller.context = context;
    bool _isDropdownReady = false;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_isDropdownReady) {
        // Fire your event here after assigning DropdownMenuItems
        controller.selectedHCN.value = DataStaticUser.hcn;
        _isDropdownReady = true;
        //  print("called");
        controller.loadInvestigation();
      }
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(() => _headerPart(controller)),
        6.heightBox,
        Text(
          "Investigation List:",
          style: customTextStyle.copyWith(
              fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black),
        ),
        6.heightBox,
        Expanded(
          child: Obx(
            () => _invPart(controller),
          ),
        )
      ],
    );
  }
}

_invPart(LabReportPageController controller) => controller.isLoadingInv.value
    ? const Center(child: CupertinoActivityIndicator())
    : SingleChildScrollView(
        child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 12),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: appColorGrayDark.withOpacity(0.2),
                blurRadius: 1,
                spreadRadius: .3,
              )
            ]),
        child: Column(
          children: controller.list_inv_list
              .map((element) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: CustomPanel(
                        isExpanded: true,
                        splashColor: kBgDarkColor,
                        title: Row(
                          children: [
                            Text(
                              element.date!,
                              style: customTextStyle.copyWith(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            8.widthBox,
                            Expanded(
                                child: Text(
                              element.docName!,
                              style: customTextStyle.copyWith(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black87),
                              overflow: TextOverflow.ellipsis,
                            )),
                            4.widthBox,
                            Text(
                              element.no!,
                              style: customTextStyle.copyWith(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: appColorIndigoA100),
                            ),
                          ],
                        ),
                        children: controller.list_inv_pres_with_hcn
                            .where((p0) =>
                                p0.dOCID == element.docId &&
                                p0.dT!.trim() == element.date!.trim() &&
                                p0.mRID == element.mrid &&
                                p0.tP == 'opd')
                            .map((e) {
                          // print(e.tDNAME);
                          return e.rID == ''
                              ? const SizedBox()
                              : Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 6, horizontal: 4),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(2),
                                    border: Border.all(
                                        color:
                                            appColorGrayDark.withOpacity(0.6),
                                        width: 0.1),
                                        
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          e.tDNAME!,
                                          style: customTextStyle.copyWith(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w800,
                                              fontFamily: appFontMuli,
                                              color: appColorLogoDeep
                                                  .withGreen(121)),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          controller.viewInvReport(e);
                                          // print(e.rID);
                                          // print(e.rGID);
                                          //print(e.);
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(2),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                    spreadRadius: .3,
                                                    blurRadius: 1,
                                                    color: appColorGrayDark
                                                        .withOpacity(0.2))
                                              ]),
                                          child: Row(
                                            children: [
                                              const Icon(
                                                Icons.picture_as_pdf_outlined,
                                                color: appColorLogoDeep,
                                                size: 12,
                                              ),
                                              2.widthBox,
                                              Text(
                                                "View",
                                                style: customTextStyle.copyWith(
                                                    color: appColorLogoDeep,
                                                    fontSize: 9,
                                                    fontFamily: appFontMuli),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                        }).toList()),
                  ))
              .toList(),
        ),
      ));

_headerPart(LabReportPageController controller) => controller.isLoading.value
    ? const Center(child: CupertinoActivityIndicator())
    : Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: appColorGrayDark.withOpacity(0.3),
                blurRadius: 1,
                spreadRadius: .5,
              )
            ]),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // ClipRRect(
          //   borderRadius: BorderRadius.circular(8),
          //   child: Image.asset("assets/images/lab_inv_banner.png",
          //   fit: BoxFit.fill,
          //    height: 25,width: 35,)),
          Row(
            children: [
              Expanded(
                  child: CustomDropDown(
                      height: 32,
                      borderRadious: 4,
                      labeltext: "Patient's Name",
                      id: controller.selectedHCN.value,
                      list: controller.list_pat_with_hcn
                          .map((element) => DropdownMenuItem<String>(
                              value: element.hCN,
                              child: Text(element.pATNAME!)))
                          .toList(),
                      onTap: (v) {
                        controller.selectedHCN.value = v!;
                        controller.loadInvestigation();
                      })),
            ],
          ),
          6.heightBox,
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 4),
                child: Text(
                  "HCN: ",
                  style: customTextStyle.copyWith(
                      fontSize: 12, fontWeight: FontWeight.w400),
                ),
              ),
              8.widthBox,
              Text(
                controller.selectedHCN.value,
                //controller.list_pat_with_hcn.where((p0) => p0.hCN==controller.selectedHCN).first.pATNAME!,
                style: customTextStyle.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    color: appColorLogoDeep),
              )
            ],
          )
        ]),
      );
