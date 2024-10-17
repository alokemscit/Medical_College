import 'package:asgar_ali_hospital/constant/const.dart';
import 'package:asgar_ali_hospital/custom_widget/custom_accordian/accordian_header.dart';
import 'package:asgar_ali_hospital/custom_widget/custom_cached_network_image.dart';
import 'package:asgar_ali_hospital/custom_widget/custom_dropdown.dart';
import 'package:asgar_ali_hospital/custom_widget/custom_textbox.dart';
import 'package:asgar_ali_hospital/pages/appointment_page/controller/appointment_page_controller.dart';
import 'package:asgar_ali_hospital/pages/doctor_page/doctor_page_controller/doctor_page_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DoctorAppointment extends StatelessWidget {
  const DoctorAppointment({super.key});

  @override
  Widget build(BuildContext context) {
    DoctorPageController dcontroller = Get.find<DoctorPageController>();
    DoctorAppointmentController controller = Get.put(
        DoctorAppointmentController(docId: dcontroller.doctorMaster.dOCID!));
    controller.context = context;
    controller.doctorMaster = dcontroller.doctorMaster;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
              40.heightBox,
              _backButton(context),
              18.heightBox,
              _doctorDatails(controller, dcontroller),
              4.heightBox,
              Expanded(
                child: Obx(() {
                  return controller.isLoading.value
                      ? const Center(child: CupertinoActivityIndicator())
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _datePart(controller),
                            6.heightBox,
                            Divider(
                              height: 0.8,
                              color: appColorGrayDark.withOpacity(0.2),
                            ),
                            6.heightBox,
                            _timePart(controller),
                            8.heightBox,
                            _patientDetails(controller)
                          ],
                        );
                }),
              ),
            ],
          )),
    );
  }
}

Widget _patientDetails(DoctorAppointmentController controller) {
  bool b = false;
  return Expanded(
    child: SingleChildScrollView(
      child: CustomAccordionContainer(
          isExpansion: false,
          headerName: "Patient Details",
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Have a HCN?",
                  style: customTextStyle.copyWith(fontSize: 12),
                ),
                SizedBox(
                  //  color: Colors.red,
                  height: 30, //set desired REAL HEIGHT
                  width: 55, //set desired REAL WIDTH
                  child: Transform.scale(
                    transformHitTests: false,
                    scale: .5,
                    child: CupertinoSwitch(
                      value: controller.isHCN.value,
                      onChanged: (value) {
                        controller.isHCN.value = value;
                        if (!value) {
                          controller.txt_hcn.text = '';
                        }
                      },
                      activeColor: appColorLogo,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                controller.isHCN.value
                    ? Expanded(
                        flex: 4,
                        child: CustomTextBox(
                            height: 34,
                            isCapitalization: true,
                            caption: "HCN",
                            maxlength: 11,
                            controller: controller.txt_hcn,
                            onChange: (v) {
                              controller.txt_mobile.text = '';
                              controller.txt_name.text = '';
                              controller.date_of_birth.value = '';
                              controller.genderID.value = '';
                              controller.bloodGroupID.value = '';
                              if (v.length == 11) {
                                controller.onHCnSubmitted();
                              }
                            },
                            onSubmitted: (v) {
                              // print("called");
                            }),
                      )
                    : const SizedBox(),
                controller.isHCN.value ? 8.widthBox : const SizedBox(),
                Expanded(
                  flex: 5,
                  child: CustomTextBox(
                    textInputType: TextInputType.phone,
                    height: 34,
                    caption: "Mobile Number",
                    maxlength: 11,
                    controller: controller.txt_mobile,
                    onChange: (v) {},
                  ),
                ),
              ],
            ),
            CustomTextBox(
                height: 34,
                caption: "Patient Name",
                width: double.infinity,
                maxlength: 100,
                controller: controller.txt_name,
                onChange: (v) {}),
            4.heightBox,
            Row(
              children: [
                InkWell(
                  onTap: () {
                    controller.date_of_birth.value = '';
                    controller.isDateShow.value = true;
                    controller.date_of_birth_temp.value =
                        DateFormat('dd/MM/yyyy').format(DateTime.now());
                  },
                  child: Container(
                    height: 34,
                    width: 110,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2.0),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                              blurRadius: 0,
                              spreadRadius: 0.02,
                              color: Colors.black)
                        ]),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: Text(controller.date_of_birth.value,
                              style: const TextStyle(
                                  fontFamily: "Muli",
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black87)),
                        ),
                        const Icon(Icons.calendar_month_outlined)
                      ],
                    ),
                  ),
                ),
                8.widthBox,
                CustomDropDown(
                    labeltext: "Gender",
                    height: 34,
                    width: 100,
                    id: controller.genderID.value,
                    list: controller.list_gender
                        .map((e) => DropdownMenuItem<String>(
                            value: e.iD, child: Text(e.nAME!)))
                        .toList(),
                    onTap: (v) {
                      controller.genderID.value = v!;
                    }),
                8.widthBox,
                Expanded(
                  child: CustomDropDown(
                      labeltext: "Blood Group",
                      height: 34,
                      width: 110,
                      id: controller.bloodGroupID.value,
                      list: controller.bg_list
                          .map((e) => DropdownMenuItem<String>(
                              value: e, child: Text(e)))
                          .toList(),
                      onTap: (v) {
                        controller.bloodGroupID.value = v!;
                      }),
                )
              ],
            ),
            8.heightBox,
            controller.isDateShow.value
                ? GestureDetector(
                    onTap: () {
                      controller.isDateShow.value = false;
                      controller.date_of_birth.value =
                          controller.date_of_birth_temp.value;
                    },
                    child: Container(
                      decoration: const BoxDecoration(color: kBgLightColor),
                      height: 90,
                      child: CupertinoDatePicker(
                        minimumYear: 1900,
                        maximumDate: DateTime.now(),
                        mode: CupertinoDatePickerMode.date,
                        initialDateTime:
                            DateTime(DateTime.now().year - 1, 1, 1),
                        onDateTimeChanged: (DateTime newDateTime) {
                          controller.date_of_birth_temp.value =
                              DateFormat('dd/MM/yyyy').format(newDateTime);
                          // String formattedDate =
                          //     DateFormat('dd/MM/yyyy')
                          //         .format(newDateTime);
                          // print(formattedDate);
                          // Do something
                        },
                      ),
                    ),
                  )
                : const SizedBox(),
            8.heightBox,
            controller.isDateShow.value
                ? const SizedBox()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          if (!b) {
                            b = true;
                            controller.saveAppointment();
                            Future.delayed(
                              const Duration(seconds: 3),
                              () {
                                b = false;
                              },
                            );
                          }
                        },
                        child: _continueButton(),
                      )
                    ],
                  )
          ]),
    ),
  );
}

Widget _continueButton() => Container(
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
    );

Widget _timePart(DoctorAppointmentController controller) => Wrap(
      children: controller.list_slot_selected
          .map((element) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                child: GestureDetector(
                  onTap: () {
                    controller.chkTimeID.value = element.iD!;
                  },
                  child: AnimatedContainer(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                    margin: const EdgeInsets.only(right: 6),
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadiusDirectional.all(
                            Radius.circular(4)),
                        color: controller.chkTimeID.value == element.iD
                            ? appColorIndigoA100
                            : Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: appColorGrayDark.withOpacity(0.3),
                              blurRadius: 3,
                              spreadRadius: .1)
                        ]),
                    duration: const Duration(milliseconds: 300),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 1),
                      width: 90,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            controller.chkTimeID.value == element.iD
                                ? Icons.check_box_outlined
                                : Icons.crop_square_outlined,
                            size: 18,
                            color: controller.chkTimeID.value == element.iD
                                ? Colors.white
                                : appColorGrayDark,
                          ),
                          Text(
                            element.aPPOINTMENTTIME!,
                            style: customTextStyle.copyWith(fontSize: 11),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ))
          .toList(),
    );

Widget _datePart(DoctorAppointmentController controller) => Column(
      children: [
        Align(
            alignment: Alignment.centerLeft,
            child: controller.chkDate.value == ''
                ? const SizedBox()
                : Text(
                    "Appointment Date: ${controller.chkDate.value}",
                    style: customTextStyle.copyWith(fontSize: 10),
                  )),
        2.heightBox,
        Row(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Wrap(
                children: controller.dateNames
                    .map((element) => GestureDetector(
                          onTap: () {
                            controller.chkDate.value = element;
                            controller.selectDate();
                          },
                          child: AnimatedContainer(
                            margin: const EdgeInsets.only(right: 4),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 4),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadiusDirectional.circular(4),
                                color: controller.chkDate.value == element
                                    ? appColorLogo
                                    : appColorGrayLight,
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 3,
                                      spreadRadius: 1,
                                      color: appColorGrayDark.withOpacity(0.3))
                                ]),
                            duration: const Duration(milliseconds: 300),
                            child: Text(
                              element,
                              style: customTextStyle.copyWith(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: controller.chkDate.value == element
                                      ? Colors.white
                                      : appColorGrayDark),
                            ),
                          ),
                        ))
                    .toList(),
              ),
            )
          ],
        )
      ],
    );

Widget _doctorDatails(
  DoctorAppointmentController controller,
  DoctorPageController dcontroller,
) =>
    Column(
      children: [
        Container(
            height: 160,
            padding: const EdgeInsets.all(4),
            // height: 150,
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      blurRadius: 2,
                      spreadRadius: 1,
                      color: appColorGrayDark.withOpacity(0.2)),
                ]),
            child: Row(children: [
              Hero(
                tag: dcontroller.doctorMaster.dOCID!,
                child: ClipRRect(
                  borderRadius: BorderRadiusDirectional.circular(8),
                  child: CustomCachedNetworkImageSquareShape(
                    img: dcontroller.doctorMaster.iMAGE!,
                    height: 160,
                    width: 120,
                    errorIconSize: 50,
                  ),
                ),
              ),
              6.widthBox,
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,

                  children: [
                    const Spacer(),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        dcontroller.doctorMaster.dOCTORNAME!,
                        overflow: TextOverflow.ellipsis,
                        style: customTextStyle.copyWith(
                            fontSize: 16,
                            color: appColorLogoDeep,
                            fontWeight: FontWeight.w800),
                      ),
                    ),
                    _degree(dcontroller.doctorMaster.uNIT, Colors.black87, 13),
                    _degree(
                        dcontroller.doctorMaster.dEGREE1, appColorGrayDark, 12),
                    _degree(dcontroller.doctorMaster.dEGREE2, appColorGrayDark),
                    _degree(dcontroller.doctorMaster.dEGREE3, appColorGrayDark),
                    const Spacer(),
                    4.heightBox,
                  ],
                  // color: Colors.grey,
                ),
              )
            ])),
      ],
    );

Widget _backButton(BuildContext context) => Row(
      children: [
        InkWell(
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: () {
              Navigator.pop(context);
              Get.delete<DoctorAppointmentController>();
            },
            child: Container(
              color: Colors.transparent,
              padding: const EdgeInsets.only(right: 50, top: 4, bottom: 4),
              // ignore: prefer_const_constructors
              child: Icon(Icons.arrow_back_sharp),
            )),
      ],
    );

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
