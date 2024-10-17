import 'package:asgar_ali_hospital/constant/const.dart';
import 'package:asgar_ali_hospital/custom_widget/custom_dropdown.dart';
import 'package:asgar_ali_hospital/data/data_static_user.dart';
import 'package:asgar_ali_hospital/pages/prescription_page/controller/prescription_page_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class PrescriptionPage extends StatelessWidget {
  const PrescriptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    PrescriptionPageController controller =
        Get.put(PrescriptionPageController());
    controller.context = context;
    bool isDropdownReady = false;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!isDropdownReady) {
        controller.selectedHCN.value = DataStaticUser.hcn;
        isDropdownReady = true;

        controller.loadPrescription();
      }
    });

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Obx(() => _headerPart(controller)),
      6.heightBox,
      Text(
        "Prescription List:",
        style: customTextStyle.copyWith(
            fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black),
      ),
      8.heightBox,
      Expanded(
          child: Obx(() => 
          controller.isLoadingInv.value?const Center(child: CupertinoActivityIndicator()):
          
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: ListView.builder(
              shrinkWrap :true,
              padding: EdgeInsets.zero,
              itemCount: controller.list_inv_pres_with_hcn.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 3),
                  decoration: BoxDecoration(
                    color:  index.isEven? Colors.white:appColorGrayLight,
                    borderRadius: BorderRadius.circular(0),
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 0.1,
                        spreadRadius: 0,
                        color: appColorGrayDark
                      )
                    ]
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                        Text(
                                    controller.list_inv_pres_with_hcn[index].dT!,
                                    style: customTextStyle.copyWith(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                  8.widthBox,
                                  Expanded(
                                      child: Text(
                                     controller.list_inv_pres_with_hcn[index].dOCNAME!,
                                    style: customTextStyle.copyWith(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black87),
                                    overflow: TextOverflow.ellipsis,
                                  )),
                  
                                        GestureDetector(
                                              onTap: () {
                                                controller.viewPrescription(controller.list_inv_pres_with_hcn[index]);
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
                                                    ),2.widthBox,
                                                  ],
                                                ),
                                              ),
                                            ),
                  
                  
                      
                    ],
                  ),
                );
              },
            ),
          )))
    ]);
  }
}

_headerPart(PrescriptionPageController controller) => controller.isLoading.value
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
                        controller.loadPrescription();
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
