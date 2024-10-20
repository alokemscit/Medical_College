import 'package:agmc/widget/custom_datepicker.dart';
import 'package:agmc/widget/custom_dialog.dart';

import '../../../../core/config/const.dart';
import '../controller/mc_acc_enroll_controller.dart';

class McAccountEnrollMent extends StatelessWidget {
  const McAccountEnrollMent({super.key});
  void disposeController() {
    try {
      Get.delete<McAccountEnrollMentController>();
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    final McAccountEnrollMentController controller =
        Get.put(McAccountEnrollMentController());
    controller.context = context;
    return Obx(() => CommonBody3(
        controller,
        [Expanded(child: _entitleListWidget(controller))],
        'Student Account Enrollment'));
  }
}

Widget _studentWidget(McAccountEnrollMentController controller) => Stack(
      children: [
        CustomGroupBox(
            groupHeaderText: "Online Student List",
            child: Column(
              children: [
                16.heightBox,
                _sessionCombo(controller),
                12.heightBox,
                CustomTableHeaderWeb(colWidtList: _col, children: [
                  CustomTableCellTableBody('#',13,FontWeight.bold,  Alignment.center),
                  CustomTableCellTableBody('ID'),
                  CustomTableCellTableBody('Roll'),
                  CustomTableCellTableBody('Student Name'),
                   CustomTableCellTableBody('Quota'),
                  CustomTableCellTableBody('Contact No'),
                  CustomTableCellTableBody(
                      '*', 13, FontWeight.bold, Alignment.center),
                ]),
                Expanded(
                  child: SingleChildScrollView(
                    child: Table(
                      columnWidths: customColumnWidthGenarator(_col),
                      border: CustomTableBorderNew,
                      children: controller.list_student_temp
                          .map((f) => TableRow(
                                  decoration: BoxDecoration(
                                      color: controller.selectedOnlineStudentID
                                                  .value ==
                                              f.sTUDENTID
                                          ? appColorPista.withOpacity(0.3)
                                          : Colors.white),
                                  children: [
                                    oneColumnCellBody((controller.list_student_temp.indexOf(f)+1).toString()),
                                    CustomTableCellx(
                                      text: f.sTUDENTID!,
                                      onTap: () {
                                        controller.SelectOnlineStudent(f);
                                      },
                                      onExit: () {
                                        controller
                                            .selectedOnlineStudentID.value = '';
                                      },
                                      onHover: () {
                                        controller.selectedOnlineStudentID
                                            .value = f.sTUDENTID!;
                                      },
                                    ),
                                    oneColumnCellBody(f.rOLL!),
                                    oneColumnCellBody(f.sTUDENTFULLNAME!),
                                     oneColumnCellBody(f.QUOTA_NAME!),
                                    oneColumnCellBody(f.cONTACTNO!),
                                    CustomTableEditCell(() {
                                      controller.SelectOnlineStudent(f);
                                    }, Icons.settings, appColorBlue),
                                  ]))
                          .toList(),
                    ),
                  ),
                )
              ],
            )),
        Positioned(
            right: 8,
            top: 12,
            child: CustomUndoButtonRounded(
                bgColor: Colors.black,
                iconColor: Colors.white,
                onTap: () {
                  controller.isShowOnlineStudent.value = false;
                }))
      ],
    );
List<int> _col = [10,50, 50, 150,50 ,50, 20];

Widget _entitleListWidget(McAccountEnrollMentController controller) => Stack(
      children: [
        CustomGroupBox(
            padingvertical: 2,
            groupHeaderText: "",
            child: controller.context.height > 700
                ? _element(controller)
                : SingleChildScrollView(
                    child: SizedBox(
                      height: 700,
                      child: _element(controller),
                    ),
                  )),
        !controller.isShowOnlineStudent.value
            ? const SizedBox()
            : Positioned(
                left: 0,
                right: 0,
                top: 0,
                bottom: 0,
                child: _studentWidget(controller)),
        _addNewStudent(controller),
      ],
    );

Widget _element(McAccountEnrollMentController controller) => Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            controller.selectedOnlineStudent.value.sTUDENTID == null
                ? const SizedBox()
                : Column(
                    children: [
                      _studentInfo(controller),
                      _financePart(controller)
                    ],
                  ),
            _undoButton1(controller),
          ],
        ),
        _EntitledStudentList(controller),
      ],
    );

List<int> _col3 = [30, 80, 30, 30,40 ,30, 50, 60, 20];
List<int> _col2 = [150, 50, 50];

_addNewStudent(McAccountEnrollMentController controller) =>
    controller.selectedOnlineStudent.value.sTUDENTID != null ||
            controller.isShowOnlineStudent.value
        ? const SizedBox()
        : Positioned(
            top: 16,
            left: 10,
            child: Row(
              children: [
                controller.context.width < 1000
                    ? const SizedBox()
                    : const CustomTextHeader(
                        text: 'Add New Student',
                        textSize: 11,
                        textColor: appColorMint,
                      ),
                4.widthBox,
                InkWell(
                  onTap: () {
                    controller.isShowOnlineStudent.value = true;
                  },
                  child: Container(
                      padding: const EdgeInsets.all(4),
                      child: const Icon(
                        Icons.settings,
                        size: 18,
                        color: appColorMint,
                      )),
                )
              ],
            ),
          );

_EntitledStudentList(McAccountEnrollMentController controller) =>
    controller.selectedOnlineStudent.value.sTUDENTID != null
        ? const SizedBox()
        : Expanded(
            child: Column(
              children: [
                32.heightBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: CustomDropDown(
                        labeltext: 'Session',
                        id: controller.cmb_sessionEntitledID.value,
                        list: controller.list_session
                            .map((f) => DropdownMenuItem<String>(
                                value: f.sessionId,
                                child: Text(
                                  f.SessionName!,
                                  style: CustomDropdownTextStyle,
                                )))
                            .toList(),
                        onTap: (v) {
                          //print(v!);
                          controller.setSessionForAccSudent(v!);
                        },
                        width: 130,
                      ),
                    ),
                    8.widthBox,
                    Row(
                      children: [
                        CustomSearchBox(
                            caption: "Search Entitled Student",
                            width: controller.context.width < 600 ? 250 : 450,
                            controller: controller.txt_search_entitled,
                            onChange: (v) {
                              controller.entitledSearch();
                            }),
                        controller.list_ent_student_temp.isEmpty
                            ? const SizedBox()
                            : InkWell(
                                onTap: () {
                                  controller.showOutStanding();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Row(
                                    children: [
                                      8.widthBox,
                                      const Icon(
                                        Icons.print_rounded,
                                        size: 16,
                                        color: appColorBlue,
                                      )
                                    ],
                                  ),
                                ),
                              )
                      ],
                    ),
                  ],
                ),
                12.heightBox,
                CustomTableHeaderWeb(colWidtList: _col3, children: [
                  CustomTableCellTableBody('ID'),
                  CustomTableCellTableBody('Name'),
                  CustomTableCellTableBody(
                      'Mob. NO', 13, FontWeight.bold, Alignment.center),
                  CustomTableCellTableBody(
                      'Is Poor Quota', 13, FontWeight.bold, Alignment.center),
               CustomTableCellTableBody('Quota Name', 13, FontWeight.bold, ),
                  CustomTableCellTableBody('Roll'),
                  CustomTableCellTableBody('Session'),
                  CustomTableCellTableBody('Outstanding', 13, FontWeight.bold,
                      Alignment.centerRight),
                  CustomTableCellTableBody(
                      '*', 13, FontWeight.bold, Alignment.center),
                ]),
                Expanded(
                    child: SingleChildScrollView(
                  child: Table(
                    columnWidths: customColumnWidthGenarator(_col3),
                    border: CustomTableBorderNew,
                    children: controller.list_ent_student_temp
                        .map(
                            (f) => TableRow(
                                    decoration: BoxDecoration(
                                        color: controller.list_ent_student_temp
                                                .indexOf(f)
                                                .isEven
                                            ? appGray50
                                            : Colors.white),
                                    children: [
                                      oneColumnCellBody(
                                        f.stId??'',
                                        12,
                                        Alignment.centerLeft,
                                        FontWeight.w400,
                                        const EdgeInsets.all(4),
                                        Colors.transparent,
                                      ),
                                      oneColumnCellBody(
                                        f.name??'',
                                      ),
                                      oneColumnCellBody(
                                          f.mob!, 12, Alignment.center),
                                      oneColumnCellBody(
                                          f.isfree == '1' ? "Yes" : "No",
                                          12,
                                          Alignment.center,
                                          FontWeight.w800,
                                          const EdgeInsets.all(4),
                                          Colors.transparent,
                                          false,
                                          f.isfree == '1'
                                              ? Colors.red
                                              : Colors.black),
                                         oneColumnCellBody(f.quota_name??''),      
                                      oneColumnCellBody(f.roll??''),
                                      oneColumnCellBody(f.ses??''),
                                      oneColumnCellBody(f.omt!.toString(), 12,
                                          Alignment.centerRight),
                                      CustomTableEditCell(() {
                                        controller.list_trans_summery.clear();
                                        CustomDialog(
                                            controller.context,
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 12.0,
                                                  top: 2,
                                                  bottom: 2),
                                              child: Text(
                                                'Collection history',
                                                style: customTextStyle,
                                              ),
                                            ),
                                            Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Flexible(
                                                        child: SizedBox(
                                                      width: 1000,
                                                      height: 800,
                                                      child: CustomGroupBox(
                                                          padingvertical: 0,
                                                          groupHeaderText:
                                                              'Student Transaction info::',
                                                          child: Column(
                                                            children: [
                                                              CustomGroupBox(
                                                                  padingvertical:
                                                                      0,
                                                                  groupHeaderText:
                                                                      'Student info:: ',
                                                                  child: Column(
                                                                    children: [
                                                                      Row(
                                                                        children: [
                                                                          const SizedBox(
                                                                              width: 70,
                                                                              child: CustomTextHeader(
                                                                                text: 'ID :',
                                                                                textSize: 13.5,
                                                                              )),
                                                                          CustomTextHeader(
                                                                            text:
                                                                                f.stId ?? '',
                                                                            textColor:
                                                                                appColorMint,
                                                                          )
                                                                        ],
                                                                      ),
                                                                      8.heightBox,
                                                                      Row(
                                                                        children: [
                                                                          const SizedBox(
                                                                              width: 70,
                                                                              child: CustomTextHeader(
                                                                                text: 'Roll : ',
                                                                                textSize: 13.5,
                                                                              )),
                                                                          CustomTextHeader(
                                                                            text:
                                                                                f.roll ?? '',
                                                                            textColor:
                                                                                appColorMint,
                                                                          )
                                                                        ],
                                                                      ),
                                                                      8.heightBox,
                                                                      Row(
                                                                        children: [
                                                                          const SizedBox(
                                                                              width: 70,
                                                                              child: CustomTextHeader(
                                                                                text: 'Session :',
                                                                                textSize: 13.5,
                                                                              )),
                                                                          CustomTextHeader(
                                                                            text:
                                                                                f.ses ?? '',
                                                                            textColor:
                                                                                appColorMint,
                                                                          )
                                                                        ],
                                                                      ),
                                                                      8.heightBox,
                                                                      Row(
                                                                        children: [
                                                                          const SizedBox(
                                                                              width: 70,
                                                                              child: CustomTextHeader(
                                                                                text: 'Name :',
                                                                                textSize: 13.5,
                                                                              )),
                                                                          CustomTextHeader(
                                                                            text:
                                                                                f.name ?? '',
                                                                            textColor:
                                                                                appColorMint,
                                                                          )
                                                                        ],
                                                                      ),
                                                                      4.heightBox,
                                                                    ],
                                                                  )),
                                                              CustomGroupBox(
                                                                  groupHeaderText:
                                                                      '',
                                                                  child: Row(
                                                                    children: [
                                                                      CustomDatePickerDropDown(
                                                                        date_controller:
                                                                            controller.txt_from_date,
                                                                        isBackDate:
                                                                            true,
                                                                        label:
                                                                            'From Date ',
                                                                        isShowCurrentDate:
                                                                            true,
                                                                      ),
                                                                      12.widthBox,
                                                                      CustomDatePickerDropDown(
                                                                        date_controller:
                                                                            controller.txt_to_date,
                                                                        isBackDate:
                                                                            true,
                                                                        label:
                                                                            'To Date ',
                                                                        isShowCurrentDate:
                                                                            true,
                                                                      ),
                                                                      12.widthBox,
                                                                      CustomButton(
                                                                          Icons
                                                                              .search,
                                                                          'Show',
                                                                          () {
                                                                        controller
                                                                            .viewTransSummery(f.stId!);
                                                                      },
                                                                          Colors
                                                                              .black,
                                                                          appColorMint,
                                                                          kBgColorG)
                                                                      // CustomSaveUpdateButtonWithUndo(
                                                                      //     false,
                                                                      //     () {
                                                                      //   controller
                                                                      //       .viewTransSummery(f.stId!);
                                                                      // }, () {},
                                                                      //     true)
                                                                    ],
                                                                  )),
                                                              Expanded(
                                                                child:
                                                                    CustomGroupBox(
                                                                        padingvertical:
                                                                            0,
                                                                        groupHeaderText:
                                                                            'Transaction List',
                                                                        child:
                                                                            Column(
                                                                          children: [
                                                                            Expanded(
                                                                              child: Obx(() => CustomTableGenerator(
                                                                                      colWidtList: const [
                                                                                        50,
                                                                                        40,
                                                                                        100,
                                                                                        50,
                                                                                        20
                                                                                      ],
                                                                                      childrenHeader: [
                                                                                        CustomTableClumnHeader('Trns. No'),
                                                                                        CustomTableClumnHeader('Trns. Date'),
                                                                                        CustomTableClumnHeader('Trns. Note'),
                                                                                        CustomTableClumnHeader('Trns. Amount', Alignment.centerRight),
                                                                                        CustomTableClumnHeader('*', Alignment.center),
                                                                                      ],
                                                                                      childrenTableRowList: controller.list_trans_summery
                                                                                          .map((f) => TableRow(decoration: const BoxDecoration(color: Colors.white), children: [
                                                                                                CustomTableCell3(f.trnsNo ?? ''),
                                                                                                CustomTableCell3(f.tillDate ?? ''),
                                                                                                CustomTableCell3(f.trnsDetails ?? ''),
                                                                                                CustomTableCell3(f.cr.toString(), MainAxisAlignment.end),
                                                                                                CustomTableEditCell(() {
                                                                                                  controller.viewReport(f.id!);
                                                                                                }, Icons.print_rounded, appColorPrimary, 14)
                                                                                              ]))
                                                                                          .toList())),
                                                                            )
                                                                          ],
                                                                        )),
                                                              )
                                                            ],
                                                          )),
                                                    ))
                                                  ],
                                                ),
                                              ],
                                            ),
                                            () {},
                                            true,
                                            false);
                                      }, Icons.search, appColorMint, 14)
                                    ]))
                        .toList(),
                  ),
                ))
              ],
            ),
          );

_sessionCombo(McAccountEnrollMentController controller) => Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const CustomTextHeader(text: "Session : "),
            CustomDropDown(
                id: controller.selectedSessionID.value,
                width: 250,
                list: controller.list_session
                    .map((f) => DropdownMenuItem<String>(
                        value: f.sessionId,
                        child: Text(
                          f.SessionName!,
                          style: customTextStyle.copyWith(fontSize: 12),
                        )))
                    .toList(),
                onTap: (v) {
                  controller.selectedSessionID.value = v!;
                  controller.loadStudentMaster();
                })
          ],
        ),
        controller.context.width > 1250
            ? CustomSearchBox(
                caption: "Search",
                width: 450,
                controller: controller.txt_search_for_entitle,
                onChange: (v) {
                  controller.searchForEntitle();
                })
            : const SizedBox(),
      ],
    );

_studentInfo(McAccountEnrollMentController controller) => CustomGroupBox(
    groupHeaderText: 'Student Info:',
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          _displayInfo("ID           :  ",
              controller.selectedOnlineStudent.value.sTUDENTID!),
          8.heightBox,
          _displayInfo("Name    :  ",
              controller.selectedOnlineStudent.value.sTUDENTFULLNAME!),
          8.heightBox,
          _displayInfo("Session :  ",
              controller.selectedOnlineStudent.value.sTUDENTFULLNAME!),
          8.heightBox,
        ],
      ),
    ));
_displayInfo(String caption, String TextValue) => Row(
      children: [
        Container(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(color: appGray100, boxShadow: const [
              BoxShadow(
                  color: appColorGray200, spreadRadius: 0.1, blurRadius: 3)
            ]),
            child: CustomTextHeader(text: caption)),
        Flexible(
            child: CustomTextHeader(text: TextValue, textColor: appColorMint)),
      ],
    );

_financePart(McAccountEnrollMentController controller) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: CustomGroupBox(
          padingvertical: 2,
          groupHeaderText: 'Accounts Particulars',
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    const CustomTextHeader(text: "Entitlement Date : "),
                    CustomDatePickerDropDown(
                        isBackDate: true,
                        isShowCurrentDate: true,
                        label: '',
                        date_controller: controller.txt_till_date)
                  ],
                ),
                12.heightBox,
                Row(
                  children: [
                    // const CustomTextHeader(
                    //   text: "Quota Type : ",
                    //   textColor: appColorMint,
                    //   textSize: 11,
                    // ),
                    // 4.widthBox,
                   const CustomTextHeader(text: 'Quota Type : ',textColor: Colors.black,),
                   Obx(()=>CustomTextHeader(text: controller.selectedOnlineStudent.value.QUOTA_NAME??'',textColor: appColorMint,))
                    // Checkbox(
                    //     value: false, //controller.isfreeQuota.value,
                    //     onChanged: (v) {
                    //       //print(v);
                    //       // controller.isfreeQuota.value = v!;
                    //       // if (v) {
                    //       //   controller.loadBill(true);
                    //       // } else {
                    //       //   controller.loadBill();
                    //       // }
                    //     })
                  ],
                ),
                8.heightBox,
                const Align(
                    alignment: Alignment.centerLeft,
                    child: CustomTextHeader(
                      text: "Particulars : ",
                      textSize: 11,
                      fontweight: FontWeight.w500,
                    )),
                const Row(
                  children: [
                    Expanded(
                        child: Divider(
                      height: 1,
                      color: appColorGray200,
                    ))
                  ],
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: SizedBox(
                    width: 600,
                    child: Column(
                      children: [
                        CustomTableHeaderWeb(colWidtList: _col2, children: [
                          CustomTableCell2("Head Name"),
                          oneColumnCellBody(
                              "Charge Amount", 12, Alignment.centerRight),
                          oneColumnCellBody(
                              "Collection Amount", 12, Alignment.centerRight)
                        ]),
                        SingleChildScrollView(
                          child: Table(
                              columnWidths: customColumnWidthGenarator(_col2),
                              border: CustomTableBorderNew,
                              children: controller.list_bill
                                  .map((f) => TableRow(children: [
                                        oneColumnCellBody(
                                            f.name!,
                                            12,
                                            Alignment.centerLeft,
                                            FontWeight.bold,
                                            const EdgeInsets.all(4),
                                            appGray50),
                                        TableCell(
                                            verticalAlignment:
                                                TableCellVerticalAlignment.fill,
                                            child: CustomTextBox(
                                                fontColor: appColorLogoDeep,
                                                caption: '',
                                                isReadonly: true,
                                                isDisable: true,
                                                fontWeight: FontWeight.bold,
                                                textInputType:
                                                    TextInputType.number,
                                                textAlign: TextAlign.end,
                                                controller: f.billAmt!,
                                                onChange: (v) {
                                                  //      controller.Total();
                                                })),
                                        TableCell(
                                            verticalAlignment:
                                                TableCellVerticalAlignment.fill,
                                            child: CustomTextBox(
                                                caption: '',
                                                textInputType:
                                                    TextInputType.number,
                                                textAlign: TextAlign.end,
                                                controller: f.collAmt!,
                                                onChange: (v) {
                                                  controller.Total();
                                                })),
                                      ]))
                                  .toList()),
                        ),
                        Table(
                          border: CustomTableBorderNew,
                          columnWidths: customColumnWidthGenarator(_col2),
                          children: [
                            TableRow(
                                decoration:
                                    const BoxDecoration(color: appColorGray200),
                                children: [
                                  oneColumnCellBody("Total : ", 13,
                                      Alignment.topRight, FontWeight.bold),
                                  oneColumnCellBody(controller.total.value, 13,
                                      Alignment.topRight, FontWeight.bold),
                                  oneColumnCellBody(controller.billTotal.value,
                                      13, Alignment.topRight, FontWeight.bold),
                                ])
                          ],
                        ),
                        12.heightBox,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Expanded(
                                child: CustomTextBox(
                                    caption: "Note",
                                    maxLine: null,
                                    // height: 70,
                                    textInputType: TextInputType.multiline,
                                    maxlength: 250,
                                    controller: controller.txt_rem,
                                    onChange: (v) {})),
                            12.widthBox,
                            CustomButton(Icons.save, "Save", () {
                              controller.save();
                            }, appColorMint, appColorMint, kBgColorG)
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          )),
    );

_undoButton1(McAccountEnrollMentController controller) => Positioned(
    right: 8,
    top: 16,
    child: CustomUndoButtonRounded(
        iconSize: 14,
        bgColor: Colors.black,
        iconColor: Colors.white,
        onTap: () {
          controller.undo();
        }));
