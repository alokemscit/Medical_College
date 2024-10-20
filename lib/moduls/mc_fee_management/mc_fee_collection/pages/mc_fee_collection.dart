import 'package:agmc/widget/custom_datepicker.dart';

import '../../../../core/config/const.dart';

import '../controller/mc_fee_collection_controller.dart';

class McFeeCollection extends StatelessWidget {
  const McFeeCollection({super.key});
  void disposeController() {
    try {
      Get.delete<McFeeCollectionController>();
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    final McFeeCollectionController controller =
        Get.put(McFeeCollectionController());
    controller.context = context;
    // print(context.width);
    return Obx(() => CommonBody3(
        controller,
        [
          _studentPanel(controller),
        ],
        'Fees Collection'));
  }
}

_studentInfoDisplay(McFeeCollectionController controller) => CustomGroupBox(
    padingvertical: 0,
    groupHeaderText: 'Student Info',
    child: Padding(
      padding: const EdgeInsets.only(bottom: 8, left: 8, right: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _setStudenInfo('ID', controller.selectedStudent.value.stId ?? ''),
          12.widthBox,
          _setStudenInfo('Roll', controller.selectedStudent.value.roll ?? ''),
          12.widthBox,
          _setStudenInfo('Session', controller.selectedStudent.value.ses ?? ''),
          12.widthBox,
          _setStudenInfo('Name', controller.selectedStudent.value.name ?? ''),
           12.widthBox,
          _setStudenInfo('Quota', controller.selectedStudent.value.quota_name ?? ''),
        ],
      ),
    ));
Widget _feesPart(McFeeCollectionController controller) => Stack(
      children: [
        CustomGroupBox(
            padingvertical: 0,
            groupHeaderText: 'Selected Student::',
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  _studentInfoDisplay(controller),
                  4.heightBox,
                  Expanded(
                      child: CustomGroupBox(
                          padingvertical: 0,
                          groupHeaderText: 'Collection Details::',
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _leftPanel(controller),
                                controller.context.width > 1250
                                    ? 4.widthBox
                                    : const SizedBox(),
                                controller.context.width < 1250
                                    ? const SizedBox()
                                    : _rightPanel(controller)
                              ],
                            ),
                          )))
                ],
              ),
            )),
        Positioned(
            top: 8,
            right: 4,
            child: CustomUndoButtonRounded(
                iconSize: 22,
                bgColor: Colors.transparent,
                onTap: () {
                  controller.deletecStudent();
                })),
      ],
    );

_leftPanel(McFeeCollectionController controller) => SizedBox(
      width: 500,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: CustomGroupBox(
                  padingvertical: 0,
                  groupHeaderText: '',
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: controller.list_tab
                              .map((f) => Padding(
                                    padding: const EdgeInsets.only(right: 1),
                                    child: CustomTabWithCheckBox(
                                     text:    f.id == "4" ? 'Admission Outstanding' : f.name!,
                                      isCheck:   controller.selectedTabIndex.value ==
                                            f.id, fun: () {
                                      controller.selectTab(f.id!);
                                    }),
                                  ))
                              .toList(),
                        ),
                      ),
                      4.heightBox,
                      CustomTableGenerator(
                          isBodyScrollable: false,
                          colWidtList: const [
                            20,
                            70,
                            50,
                            50
                          ],
                          childrenHeader: [
                            CustomTableClumnHeader("ID", Alignment.center),
                            CustomTableClumnHeader("Fee Head Name"),
                            CustomTableClumnHeader(
                                "Default Amt.", Alignment.centerRight),
                            CustomTableClumnHeader(
                                "Amount", Alignment.centerRight),
                          ],
                          childrenTableRowList: [
                            ...controller.list_fee_master_temp.map((f) =>
                                TableRow(children: [
                                  oneColumnCellBody(
                                      f.id!, 12, Alignment.center),
                                  oneColumnCellBody(
                                    f.name!,
                                    13,
                                    Alignment.centerLeft,
                                    FontWeight.bold,
                                  ),
                                  oneColumnCellBody(
                                      f.damount!, 12, Alignment.centerRight),
                                  TableCell(
                                      verticalAlignment:
                                          TableCellVerticalAlignment.fill,
                                      child: CustomTextBox(
                                          caption: '',
                                          maxlength: 20,
                                          textAlign: TextAlign.end,
                                          textInputType: TextInputType.number,
                                          controller: f.amt!,
                                          onChange: (v) {
                                            controller.getTotal();
                                          })),
                                ])),
                            TableRow(
                                decoration: const BoxDecoration(
                                    color: appColorGrayDark),
                                children: [
                                  const TableCell(
                                    child: Text(''),
                                  ),
                                  const TableCell(child: SizedBox()),
                                  TableCell(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          'Grand total',
                                          style: customTextStyle.copyWith(
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                  TableCell(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 8),
                                          child: Text(
                                            controller.gTotal.value,
                                            style: customTextStyle.copyWith(
                                                color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ]),
                          ]),
                      12.heightBox,
                      Row(
                        children: [
                          CustomDatePickerDropDown(
                            width: 120,
                            date_controller: controller.txt_date,
                            isBackDate: true,
                            isFutureDateDisplay: false,
                            isShowCurrentDate: true,
                            label: 'Collection Date',
                          ),
                          12.widthBox,
                          Expanded(
                            child: CustomTextBox(
                                // height: 50,
                                maxlength: 250,
                                maxLine: null,
                                textInputType: TextInputType.multiline,
                                caption: 'Remarks',
                                controller: controller.txt_remarks,
                                onChange: (v) {}),
                          ),
                          12.widthBox,
                          CustomButton(Icons.save, 'Save', () {
                            controller.saveCollection();
                          }, appColorGrayLight, appColorGrayLight,
                              appColorGrayDark)
                        ],
                      )
                    ],
                  ))),
        ],
      ),
    );

_rightPanel(McFeeCollectionController controller) => Expanded(
    child: CustomGroupBox(
        padingvertical: 0,
        groupHeaderText: 'Previous Transaction history::',
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              CustomGroupBox(
                padingvertical: 0,
                groupHeaderText: '',
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Row(
                    children: [
                      CustomDatePickerDropDown(
                        date_controller: controller.txt_fdate,
                        isBackDate: true,
                        isShowCurrentDate: true,
                        width: 120,
                        label: 'From Date',
                      ),
                      12.widthBox,
                      CustomDatePickerDropDown(
                        date_controller: controller.txt_tdate,
                        isBackDate: true,
                        isShowCurrentDate: true,
                        width: 120,
                        label: 'To Date',
                      ),
                      12.widthBox,
                      CustomButton(
                        Icons.search,
                        'Show',
                        () {
                          controller.viewTransSummery();
                        },
                        appColorGrayLight,
                        appColorGrayLight,
                        appColorGrayDark,
                      )
                    ],
                  ),
                ),
              ),
              4.heightBox,
              Expanded(
                child: CustomGroupBox(
                    groupHeaderText: 'Transaction List',
                    child: Column(
                      children: [
                        Expanded(
                          child: Obx(() => CustomTableGenerator(
                                  colWidtList: const [
                                    50,
                                    40,
                                    80,
                                    60,
                                    50,
                                    20
                                  ],
                                  childrenHeader: [
                                    CustomTableClumnHeader('Trns. No'),
                                    CustomTableClumnHeader('Trns. Date'),
                                    CustomTableClumnHeader('Trns. Note'),
                                    CustomTableClumnHeader('Trns. Type'),
                                    CustomTableClumnHeader(
                                        'Trns. Amount', Alignment.centerRight),
                                    CustomTableClumnHeader(
                                        '*', Alignment.center),
                                  ],
                                  childrenTableRowList: controller
                                      .list_trans_summery
                                      .map((f) => TableRow(
                                              decoration: const BoxDecoration(
                                                  color: Colors.white),
                                              children: [
                                                CustomTableCell3(
                                                    f.trnsNo ?? ''),
                                                CustomTableCell3(
                                                    f.tillDate ?? ''),
                                                CustomTableCell3(
                                                    f.trnsDetails ?? ''),
                                                CustomTableCell3(
                                                    f.feeTypeBname ?? ''),
                                                CustomTableCell3(
                                                    f.cr.toString(),
                                                    MainAxisAlignment.end),
                                                CustomTableEditCell(() {
                                                  controller.viewReport(f.id!);
                                                }, Icons.print_rounded,
                                                    appColorPrimary, 14)
                                              ]))
                                      .toList())),
                        )
                      ],
                    )),
              )
            ],
          ),
        )));

_setStudenInfo(String capton, String text) => Row(
      children: [
        CustomTextHeader(
          text: capton,
          // width: 60,
        ),
        const CustomTextHeader(text: ': '),
        CustomTextHeader(
          text: text,
          textColor: appColorMint,
        )
      ],
    );

Widget _studentPanel(McFeeCollectionController controller) => Expanded(
      child: controller.selectedStudent.value.id == null
          ? _studentSelectionPart(controller)
          : _feesPart(controller),
    );

Widget _studentSelectionPart(McFeeCollectionController controller) =>
    CustomGroupBox(
        padingvertical: 0,
        groupHeaderText: 'Student list::',
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              _sessionSelectionPart(controller),
              4.heightBox,
              Expanded(child: _studenList(controller))
            ],
          ),
        ));

Widget _sessionSelectionPart(McFeeCollectionController controller) =>
    CustomGroupBox(
      groupHeaderText: '',
      padingvertical: 2,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 4),
        child: Row(
          children: [
            const CustomTextHeader(text: 'Session :'),
            8.widthBox,
            CustomDropDown2(
                width: 150,
                id: controller.cmb_sessionID.value,
                list: controller.list_session,
                onTap: (v) {
                  controller.selectSession(v!);
                })
          ],
        ),
      ),
    );

Widget _studenList(McFeeCollectionController controller) => CustomGroupBox(
    padingvertical: 0,
    groupHeaderText: '',
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Flexible(
                child: CustomSearchBox(
                    width: 350,
                    caption: 'Search',
                    controller: controller.txt_search,
                    onChange: (v) {
                      controller.search();
                    }))
          ],
        ),
        10.heightBox,
        Expanded(
          child: CustomTableGenerator(
              colWidtList: const [
                50,
                20,
                100,
                70,
                50,
                50,
                30
              ],
              childrenHeader: [
                CustomTableClumnHeader('ID'),
                CustomTableClumnHeader('Roll', Alignment.center),
                CustomTableClumnHeader('Student Name'),
                 CustomTableClumnHeader('Quota Name'),
                CustomTableClumnHeader('Contact No'),
                CustomTableClumnHeader('Session'),
                CustomTableClumnHeader('*', Alignment.center),
              ],
              childrenTableRowList: controller.list_ent_student_temp
                  .map((f) => TableRow(
                          decoration: BoxDecoration(
                              color: controller.selectedRow.value == f.id
                                  ? appColorPista
                                  : Colors.white),
                          children: [
                            CustomTableCellx(
                                onHover: () {
                                  controller.selectedRow.value = f.id!;
                                },
                                onExit: () {
                                  controller.selectedRow.value = '';
                                },
                                onTap: () {
                                  controller.selectStudent(f);
                                },
                                text: f.stId ?? ''),
                            CustomTableCellx(
                              text: f.roll ?? '',
                              alignment: Alignment.center,
                            ),
                            CustomTableCellx(text: f.name ?? ''),
                              CustomTableCellx(text: f.quota_name ?? ''),
                            CustomTableCellx(text: f.mob ?? ''),
                            CustomTableCellx(text: f.ses ?? ''),
                            CustomTableEditCell(() {
                              controller.selectStudent(f);
                            }, Icons.settings, appColorBlue, 18)
                          ]))
                  .toList()),
        )
      ],
    ));
