import 'package:agmc/widget/custom_datepicker.dart';
import 'package:agmc/widget/custom_snakbar.dart';

import '../../../../core/config/const.dart';
import '../controller/lab_biofire_test_result_entry_controller.dart';

class BiofireResultEntry extends StatelessWidget {
  const BiofireResultEntry({super.key});
  void disposeController() {
    try {
      Get.delete<BiofireResultEntryController>();
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    final BiofireResultEntryController controller =
        Get.put(BiofireResultEntryController());
    controller.context = context;
    print(context.width);
    return Obx(() => CommonBody3(
        controller,
        [
          _mainwidget(controller),
        ],
        'Biofire Test Result'));
  }
}

Widget _mainwidget(BiofireResultEntryController controller) => Expanded(
      child: controller.context.width > 1350
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _leftPanel(controller),
                4.widthBox,
                Expanded(
                  child: _rightPanel(controller),
                )
              ],
            )
          : Column(
              children: [
                !controller.isShowLeftPanel.value
                    ? const SizedBox()
                    : Expanded(flex: 4, child: _leftPanel(controller)),
                Expanded(flex: 6, child: _rightPanel(controller))
              ],
            ),
    );

Widget _rightPanel(BiofireResultEntryController controller) => Stack(
      children: [
        CustomGroupBox(
            groupHeaderText: '',
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _patientDetails(controller),
                  _testEntryPanel(controller)
                ],
              ),
            )),
        controller.list_attr.isEmpty
            ? const SizedBox()
            : Positioned(
                bottom: 16,
                right: 22,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomButton(Icons.preview, 'Preview', () {
                      controller.save(true);
                    }, appColorGrayLight, appColorGrayLight, appColorLogo),
                    24.widthBox,
                    CustomButton(Icons.save, 'Save', () {
                      controller.save(false);
                    }, appColorGrayLight, appColorGrayLight, appColorPrimary)
                  ],
                ))
      ],
    );

Widget _testEntryPanel(BiofireResultEntryController controller) => Expanded(
      child: controller.list_group.isEmpty
          ? const SizedBox()
          : CustomGroupBox(
              padingvertical: 4,
              groupHeaderText: 'Entry',
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    (controller.list_attr.where((e) => e.isDedect!)).isEmpty
                        ? const SizedBox()
                        : Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Table(
                              border: TableBorder.all(
                                  width: 0.8, color: appColorGrayDark),
                              columnWidths:
                                  customColumnWidthGenarator([30, 150]),
                              children: [
                                TableRow(
                                    decoration: const BoxDecoration(
                                        color: appColorGray200),
                                    children: [
                                      TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 4),
                                            child: Text(
                                              'Detected',
                                              style: customTextStyle,
                                            ),
                                          )),
                                      TableCell(
                                          child: Table(
                                        border: CustomTableBorderNew,
                                        columnWidths:
                                            customColumnWidthGenarator(
                                                [50, 50]),
                                        children: [
                                          TableRow(
                                              decoration: const BoxDecoration(
                                                  color: appColorGray200),
                                              children: [
                                                oneColumnCellBody('Pathogen'),
                                                oneColumnCellBody(
                                                    'Antimicrobal Resistance Genes'),
                                              ]),
                                          TableRow(
                                              decoration: const BoxDecoration(
                                                  color: Colors.white),
                                              children: [
                                                TableCell(
                                                    verticalAlignment:
                                                        TableCellVerticalAlignment
                                                            .middle,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text(
                                                          (controller.list_attr
                                                                  .where((f) =>
                                                                      f.typeID ==
                                                                          '1' &&
                                                                      f
                                                                          .isDedect!)
                                                                  .map((a) =>
                                                                      '${a.name!} ')
                                                                  .toString())
                                                              .replaceAll(
                                                                  '()', ''),
                                                          style: customTextStyle
                                                              .copyWith(
                                                                  fontSize: 11,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500)),
                                                    )),
                                                TableCell(
                                                    verticalAlignment:
                                                        TableCellVerticalAlignment
                                                            .middle,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text(
                                                        controller.list_attr
                                                            .where((f) =>
                                                                f.typeID ==
                                                                    '2' &&
                                                                f.isDedect!)
                                                            .map((a) =>
                                                                '${a.name!} ')
                                                            .toString()
                                                            .replaceAll(
                                                                '()', ''),
                                                        style: customTextStyle
                                                            .copyWith(
                                                                fontSize: 11,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                      ),
                                                    )),
                                              ]),
                                        ],
                                      ))
                                    ])
                              ],
                            ),
                          ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Wrap(
                        children: controller.list_group
                            .map((f) => SizedBox(
                                  width: 350,
                                  // height: 650,
                                  child: Container(
                                    margin: const EdgeInsets.only(right: 8),
                                    decoration: BoxDecoration(
                                        // border: Border.all(color: Colors.black, width: 2),
                                        borderRadius: BorderRadius.circular(4),
                                        color: Colors.white,
                                        boxShadow: const [
                                          BoxShadow(
                                              color: appColorGray200,
                                              spreadRadius: 1,
                                              blurRadius: 5)
                                        ]
                                        // color: Colors.amber,
                                        ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(6),
                                                decoration: const BoxDecoration(
                                                    color: appColorGrayDark,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topLeft: Radius
                                                                .circular(4),
                                                            topRight:
                                                                Radius.circular(
                                                                    4))),
                                                child: Text(
                                                  f.name!,
                                                  style:
                                                      customTextStyle.copyWith(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),

                                        Table(
                                            border: CustomTableBorderNew,
                                            columnWidths:
                                                customColumnWidthGenarator(
                                                    f.isBin == '1'
                                                        ? [60, 100, 40]
                                                        : [60, 100]),
                                            children: controller.list_attr
                                                .where((e) => e.gid == f.id)
                                                .map((a) => TableRow(
                                                        decoration: BoxDecoration(
                                                            color: a.isDedect!
                                                                ? appGray100
                                                                : Colors.white),
                                                        children: [
                                                          TableCell(
                                                              verticalAlignment:
                                                                  TableCellVerticalAlignment
                                                                      .middle,
                                                              child: Row(
                                                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                children: [
                                                                  Checkbox(
                                                                      value: a
                                                                          .isDedect,
                                                                      onChanged:
                                                                          (v) {
                                                                        a.isDedect =
                                                                            v!;
                                                                        controller
                                                                            .list_attr
                                                                            .refresh();
                                                                      }),
                                                                  4.widthBox,
                                                                  Flexible(
                                                                      child:
                                                                          Text(
                                                                    a.isDedect!
                                                                        ? 'Detected'
                                                                        : 'Not Detected',
                                                                    style: customTextStyle.copyWith(
                                                                        fontSize:
                                                                            10,
                                                                        fontWeight: !a.isDedect!
                                                                            ? FontWeight.w500
                                                                            : FontWeight.bold),
                                                                  ))
                                                                ],
                                                              )),
                                                          TableCell(
                                                              verticalAlignment:
                                                                  TableCellVerticalAlignment
                                                                      .middle,
                                                              child: Padding(
                                                                padding: const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        4),
                                                                child: Text(
                                                                  a.name!,
                                                                  style: customTextStyle.copyWith(
                                                                      fontSize:
                                                                          11,
                                                                      fontWeight: !a.isDedect!
                                                                          ? FontWeight
                                                                              .w500
                                                                          : FontWeight
                                                                              .bold),
                                                                ),
                                                              )),
                                                          f.isBin == '1'
                                                              ? TableCell(
                                                                  verticalAlignment:
                                                                      TableCellVerticalAlignment
                                                                          .fill,
                                                                  child: CustomTextBox(
                                                                      isFilled:
                                                                          true,
                                                                      fillColor: a.isDedect!
                                                                          ? appGray100
                                                                          : Colors
                                                                              .white,
                                                                      height:
                                                                          26,
                                                                      caption:
                                                                          '',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      textInputType:
                                                                          TextInputType
                                                                              .text,
                                                                      maxlength:
                                                                          10,
                                                                      controller: a
                                                                          .ncopy!,
                                                                      onChange:
                                                                          (v) {}))
                                                              : const SizedBox()
                                                        ]))
                                                .toList()),

                                        // 8.heightBox,
                                        f.isNote != '1'
                                            ? const SizedBox()
                                            : Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 4),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                        child: CustomTextBox(
                                                            textInputType:
                                                                TextInputType
                                                                    .multiline,
                                                            caption: 'Note',
                                                            maxLine: 3,
                                                            height: null,
                                                            maxlength: 1500,
                                                            controller: f.rem!,
                                                            onChange: (v) {})),
                                                  ],
                                                ),
                                              ),
                                      ],
                                    ),
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Row(
                        children: [
                          Flexible(
                              child: CustomTextBox(
                                  caption: "Method",
                                  height: null,
                                  textInputType: TextInputType.multiline,
                                  maxLine: 5,
                                  maxlength: 2000,
                                  width: 800,
                                  controller: controller.txt_method,
                                  onChange: (v) {})),
                        ],
                      ),
                    )
                  ],
                ),
              )),
    );

Widget _patientDetails(BiofireResultEntryController controller) =>
    controller.selectedMrrID.value.testName == null
        ? const SizedBox()
        : Stack(
            children: [
              CustomGroupBox(
                  groupHeaderText: 'Patient Details',
                  borderWidth: 1.2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const CustomTextHeader(
                              text: "Test Name : ",
                              textSize: 14,
                            ),
                            Flexible(
                                child: Container(
                              padding: const EdgeInsets.all(2),
                              color: kBgColorG,
                              // decoration: customBoxDecoration.copyWith(color: kBgColorG,),
                              child: CustomTextHeader(
                                text: controller.selectedMrrID.value.testName!,
                                textColor: appColorMint,
                                textSize: 14,
                              ),
                            )),
                            16.widthBox,
                            const CustomTextHeader(
                              text: "Specimen : ",
                              textSize: 14,
                            ),
                            Flexible(
                                child: Container(
                              padding: const EdgeInsets.all(2),
                              color: kBgColorG,
                              child: CustomTextHeader(
                                text: controller.selectedMrrID.value.method!,
                                textColor: appColorMint,
                                textSize: 14,
                              ),
                            )),
                          ],
                        ),
                        4.heightBox,
                        Row(
                          children: [
                            const CustomTextHeader(
                              text: "Mr. No  : ",
                              textSize: 14,
                            ),
                            Flexible(
                                child: Container(
                              padding: const EdgeInsets.all(2),
                              color: kBgColorG,
                              child: CustomTextHeader(
                                text: controller.selectedMrrID.value.mrId!,
                                textColor: appColorMint,
                                textSize: 14,
                              ),
                            )),
                            16.widthBox,
                            const CustomTextHeader(
                              text: "Sample ID : ",
                              textSize: 14,
                            ),
                            Flexible(
                                child: Container(
                              padding: const EdgeInsets.all(2),
                              color: kBgColorG,
                              child: CustomTextHeader(
                                text: controller.selectedMrrID.value.sampleId!,
                                textColor: appColorMint,
                                textSize: 14,
                              ),
                            )),
                          ],
                        ),
                        4.heightBox,
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 36),
                          child: Divider(
                            height: 1.5,
                            color: appColorGrayDark,
                          ),
                        ),
                        4.heightBox,
                        Row(
                          children: [
                            const CustomTextHeader(
                              text: "Pat. Name  : ",
                              textSize: 14,
                            ),
                            Flexible(
                                child: Container(
                              padding: const EdgeInsets.all(2),
                              color: kBgColorG,
                              child: CustomTextHeader(
                                text: controller.selectedMrrID.value.pname!,
                                textColor: appColorMint,
                                textSize: 14,
                              ),
                            )),
                            16.widthBox,
                            const CustomTextHeader(
                              text: "Age : ",
                              textSize: 14,
                            ),
                            Flexible(
                                child: Container(
                              padding: const EdgeInsets.all(2),
                              color: kBgColorG,
                              child: CustomTextHeader(
                                text: controller.selectedMrrID.value.age!,
                                textColor: appColorMint,
                                textSize: 14,
                              ),
                            )),
                            16.widthBox,
                            const CustomTextHeader(
                              text: "Gender : ",
                              textSize: 14,
                            ),
                            Flexible(
                                child: Container(
                              padding: const EdgeInsets.all(2),
                              color: kBgColorG,
                              child: CustomTextHeader(
                                text: controller.selectedMrrID.value.psex == 'M'
                                    ? 'Male'
                                    : 'Femal',
                                textColor: appColorMint,
                                textSize: 14,
                              ),
                            )),
                          ],
                        ),
                        4.heightBox,
                      ],
                    ),
                  )),
              Positioned(
                  top: 12,
                  right: 6,
                  child: CustomUndoButtonRounded(onTap: () {
                    controller.undo_panel();
                  }))
            ],
          );

Widget _leftPanel(BiofireResultEntryController controller) =>
    !controller.isShowLeftPanel.value
        ? CustomRoundedButton(
            iconColor: appColorBlue,
            icon: Icons.menu_sharp,
            bgColor: Colors.transparent,
            iconSize: 18,
            onTap: () {
              controller.isShowLeftPanel.value = true;
            })
        : Stack(
            children: [
              !controller.isShowLeftPanel.value
                  ? const SizedBox()
                  : SizedBox(
                      width: controller.context.width > 1350
                          ? 360
                          : controller.context.width,
                      child: !controller.isShowLeftPanel.value
                          ? const SizedBox()
                          : CustomGroupBox(
                              groupHeaderText: 'MRR List',
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _filterPanel(controller),
                                    8.heightBox,
                                    _treeview(controller),
                                  ],
                                ),
                              )),
                    ),
              controller.selectedMrrID.value.mrId != null &&
                      controller.isShowLeftPanel.value
                  ? Positioned(
                      top: 12,
                      right: 4,
                      child: CustomRoundedButton(
                          iconColor: appColorBlue,
                          icon: Icons.arrow_back_sharp,
                          bgColor: Colors.transparent,
                          iconSize: 18,
                          onTap: () {
                            controller.isShowLeftPanel.value = false;
                          }))
                  : const SizedBox(),
            ],
          );

Widget _treeview(BiofireResultEntryController controller) => Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: controller.list_mrr_master_temp
              .map(
                (f) => _node(
                    0,
                    Text(
                      f.name!,
                      style: customTextStyle.copyWith(
                          fontSize: 13, color: appColorMint),
                    ),
                    const SizedBox(),
                    [
                      ...controller.list_mrr_details
                          .where((e) => e.mrId == f.id)
                          .map((a) => Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 6, vertical: 2),
                                child: InkWell(
                                  onTap: () {
                                    controller.undo_panel();
                                    if (a.sampleId == ' ') {
                                      CustomSnackbar(
                                          context: controller.context,
                                          message: "No Test Sample Collected!",
                                          type: MsgType.warning);
                                      return;
                                    }
                                    if (a.isSampleColl == '0') {
                                      CustomSnackbar(
                                          context: controller.context,
                                          message: "No Sample Received!",
                                          type: MsgType.warning);
                                      return;
                                    }
                                    controller.load_patinfo_test_details(a);
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 2, horizontal: 8),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            color: controller.selectedMrrID
                                                        .value.sampleId ==
                                                    a.sampleId
                                                ? appColorPista.withOpacity(0.8)
                                                : kBgColorG,
                                            //border: Border.all(width: 0.1,color: Colors.black)
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                              left: 12,
                                            ),
                                            child: Row(
                                              children: [
                                                const Icon(
                                                  Icons.arrow_right,
                                                  color: appColorMint,
                                                  size: 24,
                                                ),
                                                4.widthBox,
                                                Expanded(
                                                  child: Text(
                                                    a.sampleId == ' '
                                                        ? 'No Sample'
                                                        : a.sampleId!,
                                                    style: customTextStyle
                                                        .copyWith(
                                                            fontSize: 11.5,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color:
                                                                appColorPrimary),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ))
                    ]),
              )
              .toList(),
        ),
      ),
    );

Widget _filterPanel(BiofireResultEntryController controller) => CustomGroupBox(
      groupHeaderText: '',
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomRadioButton(1, controller, "All", () {
                  controller.clickRadioButtpn();
                }),
                14.widthBox,
                CustomRadioButton(2, controller, "OPD", () {
                  controller.clickRadioButtpn();
                }),
                14.widthBox,
                CustomRadioButton(3, controller, "IPD", () {
                  controller.clickRadioButtpn();
                }),
                14.widthBox,
                CustomRadioButton(4, controller, "Emergency.", () {
                  controller.clickRadioButtpn();
                }),
              ],
            ),
            controller.isShowFilter.value ? 14.heightBox : const SizedBox(),
            controller.isShowFilter.value
                ? Row(
                    children: [
                      CustomDatePickerDropDown(
                        date_controller: controller.txt_fdate,
                        width: 120,
                        height: 26,
                        borderRadious: 4,
                        label: 'From ',
                        isBackDate: true,
                        isShowCurrentDate: true,
                      ),
                      12.widthBox,
                      CustomDatePickerDropDown(
                        borderRadious: 4,
                        width: 120,
                        height: 26,
                        date_controller: controller.txt_tdate,
                        isBackDate: true,
                        label: 'To ',
                        isShowCurrentDate: true,
                      ),
                    ],
                  )
                : const SizedBox(),
            12.heightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                    child: CustomSearchBox(
                  caption: 'Search',
                  controller: controller.txt_search,
                  onChange: (v) {
                    controller.search();
                  },
                  borderRadious: 4,
                )),
                12.widthBox,
                CustomFilterButtonRounded(
                    icon: controller.isShowFilter.value
                        ? Icons.undo
                        : Icons.filter_alt,
                    onTap: () {
                      controller.isShowFilter.value =
                          !controller.isShowFilter.value;
                    }),
                12.widthBox,
                CustomButton(Icons.search, 'Show', () {}, appColorGrayDark,
                    appColorGrayDark, appColorGray200)
              ],
            )
          ],
        ),
      ),
    );

Widget _node(@required double leftPad, @required Widget name,
        @required Widget event, @required List<Widget> children) =>
    Padding(
        padding: EdgeInsets.only(left: leftPad),
        child: CustomPanel(
          isSelectedColor: false,
          isSurfixIcon: false,
          isLeadingIcon: false,
          isExpanded: true,
          title: Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [name, event],
            ),
          ),

          /// Ledger-------
          children: children,
        ));
