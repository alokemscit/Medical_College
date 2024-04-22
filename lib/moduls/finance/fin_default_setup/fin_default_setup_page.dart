import 'package:agmc/widget/custom_datepicker.dart';
 
import '../../../core/config/const.dart';
import '../../../core/config/const_widget.dart';
import 'controller/fin_default_setup_controller.dart';

class FinDefaultPageSetup extends StatelessWidget {
  const FinDefaultPageSetup({super.key});
  void disposeController() {
    try {
      Get.delete<FinDefaultSetupController>();
    } catch (e) {
      // print('Error disposing EmployeeController: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    FinDefaultSetupController controller = Get.put(FinDefaultSetupController());
    controller.context = context;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
        child: Obx(() => CustomCommonBody(
            controller.isLoading.value,
            controller.isError.value,
            controller.errorMessage.value,
            _TabWidget(controller),
            _TabWidget(controller),
            _desktopWidget(controller))),
      ),
    );
  }
}

_desktopWidget(FinDefaultSetupController controller) => Row(
      children: [
        Expanded(
          flex: 4,
          child: CustomAccordionContainer(
              headerName: "Voucher Type Master",
              height: 0,
              isExpansion: true,
              children: [
                _vooucherTypeMaster(controller),
              ]),
        ),
        8.widthBox,
        Expanded(
          flex: 5,
          child: CustomAccordionContainer(
              headerName: "Fiscal Year Master",
              height: 0,
              isExpansion: true,
              children: [
                _fiscalMaster(controller),
              ]),
        ),
        8.widthBox,
        Expanded(
          flex: 5,
          child: CustomAccordionContainer(
              headerName: "Approver Master",
              height: 0,
              isExpansion: true,
              children: [
                _approverMaster(controller),
              ]),
        ),
      ],
    );

_TabWidget(FinDefaultSetupController controller) => SingleChildScrollView(
      child: Column(
        children: [
          CustomAccordionContainer(
              headerName: "Voucher Type Master",
              height: 400,
              isExpansion: true,
              children: [
                _vooucherTypeMaster(controller),
              ]),
          8.widthBox,
          CustomAccordionContainer(
              headerName: "Fiscal Year Master",
              height: 400,
              isExpansion: true,
              children: [
                _fiscalMaster(controller),
              ]),
          8.widthBox,
          CustomAccordionContainer(
              headerName: "Approver Master",
              height: 400,
              isExpansion: true,
              children: [
                _approverMaster(controller),
              ]),
        ],
      ),
    );

Widget _vooucherTypeMaster(FinDefaultSetupController controller) => Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                    decoration: customBoxDecoration,
                    child: Row(
                      children: [
                        Expanded(
                            child: CustomTextBox(
                                caption: "Voucher Type Name",
                                controller: controller.txt_voucherTypeName,
                                onChange: (v) {})),
                        8.widthBox,
                        CustomTextBox(
                            maxlength: 3,
                            caption: "Short Name",
                            width: 80,
                            controller: controller.txt_voucherTypeShortName,
                            onChange: (v) {}),
                        8.widthBox,
                        RoundedButton(() {
                          controller.vTypeEditId.value = '';
                          controller.txt_voucherTypeName.text = '';
                          controller.txt_voucherTypeShortName.text = '';
                        }, Icons.undo),
                        8.widthBox,
                        RoundedButton(() {}, Icons.save),
                      ],
                    ),
                  ),
                )
              ],
            ),
            4.heightBox,
            Table(
              border: CustomTableBorderNew,
              columnWidths: CustomColumnWidthGenarator(_col_vtype),
              children: [
                TableRow(
                    decoration: CustomTableHeaderRowDecorationnew.copyWith(
                        color: appColorGrayLight),
                    children: [
                      TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: _colHeaderText(
                              "Voucher Type Name", Alignment.centerLeft)),
                      TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Column(
                            children: [
                              _colHeaderText("Short Name", Alignment.center),
                              // _twoColumnHeaderInTableColumnHeader("Debit", "Credit"),
                            ],
                          )),
                      TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Column(
                            children: [
                              _colHeaderText("?", Alignment.center),
                              //  _twoColumnHeaderInTableColumnHeader("Debit", "Credit"),
                            ],
                          )),
                    ])
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Table(
                  border: CustomTableBorderNew,
                  columnWidths: CustomColumnWidthGenarator(_col_vtype),
                  children: [
                    // for (var i = 0; i < 100; i++)
                    ...controller.list_vtype.map((element) => TableRow(
                            decoration: BoxDecoration(
                                color:
                                    controller.vTypeEditId.value == element.iD
                                        ? appColorPista
                                        : Colors.white),
                            children: [
                              TableCell(
                                  verticalAlignment:
                                      TableCellVerticalAlignment.middle,
                                  child: _colBodyText(
                                      element.nAME!, Alignment.centerLeft)),
                              TableCell(
                                  verticalAlignment:
                                      TableCellVerticalAlignment.middle,
                                  child: _colBodyText(
                                      element.sNAME!, Alignment.center)),
                              CustomTableEditCell(() {
                                controller.txt_voucherTypeName.text =
                                    element.nAME!;
                                controller.txt_voucherTypeShortName.text =
                                    element.sNAME!;
                                controller.vTypeEditId.value = element.iD!;
                              }),
                            ])),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );

List<int> _col_vtype = [200, 100, 50];

Widget _fiscalMaster(FinDefaultSetupController controller) => Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                    decoration: customBoxDecoration,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            CustomDatePicker(
                              date_controller: controller.txt_fis_start_date,
                              width: 140,
                              borderColor: appColorGrayDark,
                              label: "From Date",
                              isShowCurrentDate: false,
                              isBackDate: true,
                              isFilled: true,
                            ),
                            8.widthBox,
                            CustomDatePicker(
                              date_controller: controller.txt_fis_end_date,
                              width: 140,
                              borderColor: appColorGrayDark,
                              label: "To Date",
                              isShowCurrentDate: false,
                              isBackDate: true,
                              isFilled: true,
                            ),
                            controller.context.width > 650
                                ? 8.widthBox
                                : const SizedBox(),
                            controller.context.width > 650
                                ? Expanded(child: _secondPart(controller))
                                : const SizedBox(),
                          ],
                        ),
                        controller.context.width > 650
                            ? const SizedBox()
                            : _secondPart(controller),
                      ],
                    ),
                  ),
                )
              ],
            ),
            4.heightBox,
            Table(
              border: CustomTableBorderNew,
              columnWidths: CustomColumnWidthGenarator(_col_fiscal),
              children: [
                TableRow(
                    decoration: CustomTableHeaderRowDecorationnew.copyWith(
                        color: appColorGrayLight),
                    children: [
                      TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: _colHeaderText(
                              "Start Date", Alignment.centerLeft)),
                      TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Column(
                            children: [
                              _colHeaderText("End Date", Alignment.centerLeft),
                              // _twoColumnHeaderInTableColumnHeader("Debit", "Credit"),
                            ],
                          )),
                      TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Column(
                            children: [
                              _colHeaderText("Status", Alignment.center),
                              //  _twoColumnHeaderInTableColumnHeader("Debit", "Credit"),
                            ],
                          )),
                      TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Column(
                            children: [
                              _colHeaderText("?", Alignment.center),
                              //  _twoColumnHeaderInTableColumnHeader("Debit", "Credit"),
                            ],
                          )),
                    ])
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Table(
                  border: CustomTableBorderNew,
                  columnWidths: CustomColumnWidthGenarator(_col_fiscal),
                  children: [
                    // for (var i = 0; i < 100; i++)
                    ...controller.list_fiscalYear.map((element) => TableRow(
                            decoration: BoxDecoration(
                                color: controller.editFisID.value == element.iD
                                    ? appColorPista
                                    : Colors.white),
                            children: [
                              TableCell(
                                  verticalAlignment:
                                      TableCellVerticalAlignment.middle,
                                  child: _colBodyText(
                                      element.sDATE!, Alignment.centerLeft)),
                              TableCell(
                                  verticalAlignment:
                                      TableCellVerticalAlignment.middle,
                                  child: _colBodyText(
                                      element.tDATE!, Alignment.centerLeft)),
                              TableCell(
                                  verticalAlignment:
                                      TableCellVerticalAlignment.middle,
                                  child: _colBodyText(
                                      element.sTATUS == '1'
                                          ? 'Active'
                                          : 'Closed',
                                      Alignment.center)),
                              CustomTableEditCell(() {
                                controller.editFisID.value = element.iD!;
                                controller.txt_fis_start_date.text =
                                    element.sDATE!;
                                controller.txt_fis_end_date.text =
                                    element.tDATE!;
                                controller.cmb_fisStatusID.value =
                                    element.sTATUS!;
                              }),
                            ]))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );

_secondPart(FinDefaultSetupController controller) => Row(
      children: [
        Expanded(
            child: CustomDropDown(
                id: controller.cmb_fisStatusID.value,
                labeltext: "Status",
                list: controller.listStatus
                    .map((element) => DropdownMenuItem<String>(
                        value: element.id,
                        child: Text(
                          element.name,
                          style: customTextStyle.copyWith(fontSize: 12),
                        )))
                    .toList(),
                onTap: (v) {
                  controller.cmb_fisStatusID.value = v!;
                })),
        8.widthBox,
        RoundedButton(() {
          controller.editFisID.value = '';
          controller.txt_fis_start_date.text = '';
          controller.txt_fis_end_date.text = '';
          controller.cmb_fisStatusID.value = '';
        }, Icons.undo),
        8.widthBox,
        RoundedButton(() {}, Icons.save),
      ],
    );

List<int> _col_fiscal = [150, 150, 150, 50];

Widget _approverMaster(FinDefaultSetupController controller) => Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                    decoration: customBoxDecoration,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: CustomDropDown(
                                  id: controller.cmb_appTypeId.value,
                                  width: 150,
                                  labeltext: "Approver Type",
                                  list: controller.list_voucher_appType
                                      .map(
                                          (element) => DropdownMenuItem<String>(
                                              value: element.iD,
                                              child: Text(
                                                element.nAME!,
                                                style: customTextStyle.copyWith(
                                                    fontSize: 12),
                                              )))
                                      .toList(),
                                  onTap: (v) {
                                    controller.cmb_appTypeId.value = v!;
                                  }),
                            ),
                            8.widthBox,
                            CustomTextBox(
                                caption: "Emp ID",
                                width: 100,
                                maxlength: 4,
                                controller: controller.txt_appEmpId,
                                onChange: (v) {}),
                            controller.context.width > 650
                                ? 8.widthBox
                                : const SizedBox(),
                            controller.context.width > 650
                                ? Expanded(
                                    child: _partOne(controller),
                                  )
                                : const SizedBox()
                          ],
                        ),
                        controller.context.width > 650
                            ? const SizedBox()
                            : _partOne(controller),
                      ],
                    ),
                  ),
                )
              ],
            ),
            4.heightBox,
            Table(
              border: CustomTableBorderNew,
              columnWidths: CustomColumnWidthGenarator(_col_approver),
              children: [
                TableRow(
                    decoration: CustomTableHeaderRowDecorationnew.copyWith(
                        color: appColorGrayLight),
                    children: [
                      TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: _colHeaderText(
                              "Approver Type", Alignment.centerLeft)),
                      TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Column(
                            children: [
                              _colHeaderText(
                                  "Approver name", Alignment.centerLeft),
                              // _twoColumnHeaderInTableColumnHeader("Debit", "Credit"),
                            ],
                          )),
                      TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Column(
                            children: [
                              _colHeaderText("Status", Alignment.center),
                              //  _twoColumnHeaderInTableColumnHeader("Debit", "Credit"),
                            ],
                          )),
                      TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Column(
                            children: [
                              _colHeaderText("?", Alignment.center),
                              //  _twoColumnHeaderInTableColumnHeader("Debit", "Credit"),
                            ],
                          )),
                    ])
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Table(
                  border: CustomTableBorderNew,
                  columnWidths: CustomColumnWidthGenarator(_col_approver),
                  children: [
                    ...controller.list_voucher_approver.map((element) =>
                        TableRow(
                            decoration:
                                 BoxDecoration(color: controller.cmb_editApprorver.value ==
                                    element.iD?appColorPista: Colors.white),
                            children: [
                              TableCell(
                                  verticalAlignment:
                                      TableCellVerticalAlignment.middle,
                                  child: _colBodyText(
                                      element.aNAME!, Alignment.centerLeft)),
                              TableCell(
                                  verticalAlignment:
                                      TableCellVerticalAlignment.middle,
                                  child: _colBodyText(
                                      element.eNAME!, Alignment.centerLeft)),
                              TableCell(
                                  verticalAlignment:
                                      TableCellVerticalAlignment.middle,
                                  child: _colBodyText(
                                      element.sTATUS == '1'
                                          ? 'Active'
                                          : 'Inactive',
                                      Alignment.center)),
                              CustomTableEditCell(() {
                                controller.cmb_editApprorver.value =
                                    element.iD!;
                                controller.cmb_appTypeId.value = element.aID!;
                                controller.txt_appEmpId.text = element.eMPID!;
                                controller.cmb_editApprorverStatusID.value =
                                    element.sTATUS!;
                              }),
                            ]))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );

_partOne(FinDefaultSetupController controller) => Row(
      children: [
        Expanded(
            child: CustomDropDown(
                id: controller.cmb_editApprorverStatusID.value,
                labeltext: "Status",
                list: controller.listStatus
                    .map((element) => DropdownMenuItem<String>(
                        value: element.id,
                        child: Text(
                          element.name,
                          style: customTextStyle.copyWith(fontSize: 12),
                        )))
                    .toList(),
                onTap: (v) {
                  controller.cmb_editApprorverStatusID.value = v!;
                })),
        8.widthBox,
        RoundedButton(() {
          controller.cmb_editApprorver.value ='';
           controller.cmb_appTypeId.value = '';
            controller.txt_appEmpId.text = '';
           controller.cmb_editApprorverStatusID.value ='';
        }, Icons.undo),
        8.widthBox,
        RoundedButton(() {}, Icons.save),
      ],
    );

List<int> _col_approver = [150, 250, 150, 50];

_colHeaderText(String txt, [alignments = Alignment.center]) => Align(
    alignment: alignments,
    child: Padding(
      padding: const EdgeInsets.all(4.0),
      child: Text(
        txt,
        style: customTextStyle,
      ),
    ));

_colBodyText(String txt, [alignments = Alignment.center]) => Align(
    alignment: alignments,
    child: Padding(
      padding: const EdgeInsets.all(4.0),
      child: Text(
        txt,
        style:
            customTextStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w500),
      ),
    ));
