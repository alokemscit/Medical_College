// ignore_for_file: invalid_required_positional_param, unused_element

import 'package:agmc/moduls/finance/voucher_entry_page/controller/voucher_entry_controller.dart';
import 'package:agmc/widget/custom_datepicker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../core/config/const.dart';
import '../../../core/config/const_widget.dart';

class VoucherEntryPage extends StatelessWidget {
  const VoucherEntryPage({super.key});
  void disposeController() {
    try {
      Get.delete<VoucherEntryController>();
    } catch (e) {
      // print('Error disposing EmployeeController: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    VoucherEntryController controller = Get.put(VoucherEntryController());
    controller.context = context;
    //print(context.height);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Obx(() => CustomCommonBody(
            controller.isLoading.value,
            controller.isError.value,
            controller.errorMessage.value,
            _mainWidget(controller),
            _mainWidget(controller),
            _mainWidget(controller))),
      ),
    );
  }
}

_mainWidget(VoucherEntryController controller) =>
    controller.context.width > 1150
        ? _responsiveDesktop(controller)
        : _responsiveNonDesktop(controller);

_responsiveDesktop(VoucherEntryController controller) => Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _leftPart(controller),
        8.widthBox,
        _rightPartMenu(controller),
      ],
    );
_leftPart(VoucherEntryController controller) => Expanded(
      child: CustomAccordionContainer(
        isExpansion: false,
        // crossAxisAlignment: CrossAxisAlignment.start,
        headerName: 'Voucher Entry',
        height: 0,
        children: [
          Expanded(
            child: Stack(
              children: [_mainEntry(controller), _popUpTable(controller)],
            ),
          )
        ],
      ),
    );

_popUpTable(VoucherEntryController controller) => controller
        .isSearchEnabled.value
    ? Positioned(
        top: 128,
        left: 0,
        right: 0,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          color: Colors.transparent,
          //height: 300,
          child: Table(
            columnWidths: CustomColumnWidthGenarator(_tableCol),
            children: [
              TableRow(children: [
                const TableCell(child: SizedBox()),
                TableCell(
                    child: controller.isSearchLedger.value
                        ? _popUpGenerator(
                            controller.ledger_search
                                .map((element) =>
                                    _commonList(element.iD, element.nAME))
                                .toList(),
                            controller.txt_ledgerSearch, () {
                            controller.searchLedger();
                          }, (v) {
                            controller.allSearchClose();
                            controller.selectedLedgerID.value = v!;
                            controller.loadSubLedger();
                          }, () {
                            controller.allSearchClose();
                          }, 'Ledger Search')
                        : const SizedBox()),
                TableCell(
                    child: controller.isSearchSubLedger.value
                        ? _popUpGenerator(
                            controller.sl_list_search
                                .map((element) =>
                                    _commonList(element.sLID, element.sLNAME))
                                .toList(),
                            controller.txt_SubLedgerSearch, () {
                            controller.searchSubLedger();
                          }, (v) {
                            controller.selectedSubLedgerID.value = v!;
                            controller.allSearchClose();
                            controller.txt_SubLedgerSearch.text = '';
                          }, () {
                            controller.allSearchClose();
                            controller.txt_SubLedgerSearch.text = '';
                          }, "Sub Leadger Search")
                        : const SizedBox()),
                TableCell(
                    child: controller.isSearchCostCenter.value
                        ? _popUpGenerator(
                            controller.cc_list_search
                                .map((element) =>
                                    _commonList(element.cCID, element.cCNAME))
                                .toList(),
                            controller.txt_CostCenterSearch, () {
                            controller.searchCostCenter();
                          }, (v) {
                            controller.selectedCostCenterID.value = v!;
                            controller.allSearchClose();
                            controller.txt_CostCenterSearch.text = '';
                          }, () {
                            controller.allSearchClose();
                            controller.txt_CostCenterSearch.text = '';
                          }, "Cost Center Search")
                        : const SizedBox()),
                const TableCell(child: SizedBox()),
                const TableCell(child: SizedBox()),
                const TableCell(child: SizedBox()),
              ])
            ],
          ),
        ),
      )
    : const SizedBox();

_maintryHeader(VoucherEntryController controller) => Row(
      children: [
        Expanded(
          child: Container(
            //height: 80,

            decoration: customBoxDecoration.copyWith(
                borderRadius: BorderRadius.circular(4)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Text(
                              "Voucher Type : ",
                              style: customTextStyle.copyWith(
                                  fontSize: 13, fontWeight: FontWeight.bold),
                            ),
                            6.widthBox,
                            CustomDropDown(
                                id: controller.voucherTypeID.value,
                                width: 150,
                                list: controller.list_vtype
                                    .map((element) => DropdownMenuItem<String>(
                                        value: element.iD,
                                        child: Text(
                                          element.nAME!,
                                          style: customTextStyle.copyWith(
                                              fontSize: 12,
                                              fontFamily: appFontMuli),
                                        )))
                                    .toList(),
                                onTap: (v) {}),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Checkbox(
                              value: controller.isAutoApprove.value,
                              onChanged: (v) {
                                controller.isAutoApprove.value = v!;
                              }),
                          4.widthBox,
                          Text(
                            "Is Approve? (Auto)",
                            style: customTextStyle.copyWith(
                                fontSize: 13, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ],
                  ),
                  4.heightBox,
                  Row(
                    children: [
                      Text(
                        "Voucher Date : ",
                        style: customTextStyle.copyWith(
                            fontSize: 13, fontWeight: FontWeight.bold),
                      ),
                      6.widthBox,
                      CustomDatePicker(
                          isFilled: true,
                          isBackDate: true,
                          width: 150,
                          date_controller: TextEditingController()),
                      8.widthBox,
                      //Text("Voucher No : ",style: customTextStyle.copyWith(fontSize: 13,fontWeight: FontWeight.bold),),
                      6.widthBox,
                      Row(
                        children: [
                          CustomTextBox(
                              caption: "Voucher No",
                              width: 150,
                              isCapitalization: true,
                              controller: TextEditingController(),
                              onChange: (v) {}),
                          InkWell(
                            onTap: () {},
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.search,
                                size: 18,
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );

_mainEntry(VoucherEntryController controller) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _maintryHeader(controller),
        _mainEntryControll(controller),
        _mainTableEntryPart(controller),
        const Spacer(),
        _tableFooter(controller),
      ],
    );

_mainTableEntryPart(VoucherEntryController controller) => Expanded(
      flex: 40,
      child: Container(
        decoration: customBoxDecoration.copyWith(
            borderRadius: BorderRadius.circular(4), color: Colors.white),
        child: Column(
          children: [
            _tableHeader(),
            4.heightBox,
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8, bottom: 8, right: 8),
                  child: Table(
                      columnWidths: CustomColumnWidthGenarator(_tableCol),
                      children: [
                        ...controller.list_voucher
                            .map((e) => TableRow(children: [
                                  CustomTableCell(e.drcrName!),
                                  CustomTableCell(e.ledgerName!),
                                  CustomTableCell(e.subLedgerName!),
                                  CustomTableCell(e.costCenterName!),
                                  TableCell(
                                      verticalAlignment:
                                          TableCellVerticalAlignment.middle,
                                      child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 4),
                                            child: Text(
                                              e.amount!,
                                              style: customTextStyle.copyWith(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ))),
                                  CustomTableCell(e.narration!),
                                  TableCell(
                                      verticalAlignment:
                                          TableCellVerticalAlignment.middle,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 4),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            // Flexible(
                                            //   child: InkWell(
                                            //     onTap: () {},
                                            //     child: const Icon(
                                            //       Icons.edit,
                                            //       size: 14,
                                            //     ),
                                            //   ),
                                            // ),
                                            Flexible(
                                              child: InkWell(
                                                onTap: () {
                                                  controller
                                                      .deleteSelectedVoucherLedger(
                                                          e);
                                                },
                                                child: const Icon(
                                                  Icons.delete,
                                                  size: 14,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )),
                                ]))
                      ]),
                ),
              ),
            ),
          ],
        ),
      ),
    );

_mainEntryControll(VoucherEntryController controller) => Row(
      children: [
        Expanded(
            child: Container(
          decoration: customBoxDecoration.copyWith(
              borderRadius: BorderRadius.circular(4)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Voucher Entry",
                  style: customTextStyle.copyWith(
                      fontSize: 11, fontStyle: FontStyle.italic),
                ),
                6.heightBox,
                Table(
                  columnWidths: CustomColumnWidthGenarator(_tableCol),
                  children: [
                    TableRow(children: [
                      TableCell(
                          child: CustomDropDown(
                              labeltext: "Dr/Cr",
                              id: controller.selectedDrCr.value,
                              list: controller.list_dr_cr
                                  .map((element) => DropdownMenuItem<String>(
                                      value: element.id,
                                      child: Text(
                                        element.name!,
                                        style: customTextStyle.copyWith(
                                            fontSize: 11),
                                      )))
                                  .toList(),
                              onTap: (v) {
                                controller.selectedDrCr.value = v!;
                                controller.selectedCostCenterID.value = '';
                                controller.selectedSubLedgerID.value = '';
                                controller.selectedLedgerID.value = '';
                                controller.setIsAddEnable();
                                //controller.txt_amount.text = '';
                                //controller.txt_narration.text = '';
                              })),
                      TableCell(
                          child: Row(
                        children: [
                          Expanded(
                            child: CustomDropDown(
                                labeltext: controller.ledger_temp.isNotEmpty
                                    ? "Ledger"
                                    : '',
                                id: controller.selectedLedgerID.value,
                                list: controller.ledger_temp
                                    .map((element) => DropdownMenuItem<String>(
                                        value: element.iD,
                                        child: Text(
                                          element.nAME!,
                                          style: customTextStyle.copyWith(
                                              fontSize: 11),
                                        )))
                                    .toList(),
                                onTap: (v) {
                                  controller.selectedLedgerID.value = v!;
                                  controller.selectedCostCenterID.value = '';
                                  controller.selectedSubLedgerID.value = '';
                                  controller.loadSubLedger();
                                  controller.loadCostCenter();
                                  controller.setIsAddEnable();
                                  //controller.txt_amount.text = '';
                                  //controller.txt_narration.text = '';
                                }),
                          ),
                          InkWell(
                              onTap: () {
                                controller.allSearchClose();
                                controller.isSearchEnabled.value = true;
                                controller.isSearchLedger.value = true;
                                controller.searchLedger();
                                controller.setIsAddEnable();
                              },
                              child: _fiterButton()),
                        ],
                      )),
                      TableCell(
                          child: Row(
                        children: [
                          Expanded(
                            child: CustomDropDown(
                                labeltext: controller.sl_list_temp.isNotEmpty
                                    ? "Sub Ledger"
                                    : '',
                                id: controller.selectedSubLedgerID.value,
                                list: controller.sl_list_temp
                                    .map((element) => DropdownMenuItem<String>(
                                        value: element.sLID,
                                        child: Text(
                                          element.sLNAME!,
                                          style: customTextStyle.copyWith(
                                              fontSize: 11),
                                        )))
                                    .toList(),
                                onTap: (v) {
                                  controller.selectedSubLedgerID.value = v!;
                                  controller.selectedCostCenterID.value = '';
                                  controller.loadCostCenter();
                                  controller.setIsAddEnable();
                                }),
                          ),
                          InkWell(
                              onTap: () {
                                controller.allSearchClose();
                                controller.isSearchEnabled.value = true;
                                controller.isSearchSubLedger.value = true;
                                controller.searchSubLedger();
                                controller.setIsAddEnable();
                              },
                              child: _fiterButton()),
                        ],
                      )),
                      TableCell(
                          child: Row(
                        children: [
                          Expanded(
                            child: CustomDropDown(
                                labeltext: controller.cc_list_temp.isNotEmpty
                                    ? "Cost Center"
                                    : '',
                                id: controller.selectedCostCenterID.value,
                                list: controller.cc_list_temp
                                    .map((element) => DropdownMenuItem<String>(
                                        value: element.cCID,
                                        child: Text(element.cCNAME!,
                                            style: customTextStyle.copyWith(
                                                fontSize: 11))))
                                    .toList(),
                                onTap: (v) {
                                  controller.selectedCostCenterID.value = v!;
                                  controller.setIsAddEnable();
                                }),
                          ),
                          InkWell(
                              onTap: () {
                                controller.allSearchClose();
                                controller.isSearchEnabled.value = true;
                                controller.isSearchCostCenter.value = true;
                                controller.searchCostCenter();
                                controller.setIsAddEnable();
                              },
                              child: _fiterButton()),
                        ],
                      )),
                      TableCell(
                          child: CustomTextBox(
                              fontColor: Colors.black,
                              caption: "Amount",
                              width: double.infinity,
                              textAlign: TextAlign.right,
                              textInputType: TextInputType.number,
                              controller: controller.txt_amount,
                              onChange: (v) {
                                controller.setIsAddEnable();
                              })),
                      TableCell(
                          child: CustomTextBox(
                              //labelTextColor: appColorGrayDark,

                              caption: "Narration",
                              controller: controller.txt_narration,
                              onChange: (v) {
                                controller.setIsAddEnable();
                              })),
                      TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: controller.isAddEnable.value
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // const Icon( Icons.undo ,color: Colors.white,size: 18,),
                                    4.widthBox,
                                    InkWell(
                                      onTap: () => controller.addVoucher(),
                                      child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadiusDirectional
                                                    .circular(8),
                                            color: appColorBlue,
                                          ),
                                          padding: const EdgeInsets.all(4),
                                          child: const Icon(
                                            Icons.add_shopping_cart,
                                            color: Colors.white,
                                            size: 18,
                                          )),
                                    ),
                                  ],
                                )
                              : const SizedBox()),
                    ])
                  ],
                ),
              ],
            ),
          ),
        ))
      ],
    );

_tableFooter(VoucherEntryController controller) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            "Dr. Amount : ",
            style: customTextStyle.copyWith(
                fontSize: 13, fontWeight: FontWeight.bold),
          ),
          Text(
            controller.list_voucher
                .where((p0) => p0.drcrID == 'dr')
                .sum((p0) => double.parse(p0.amount!))
                .toString(),
            style: customTextStyle.copyWith(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: appColorLogoDeep),
          ),
          10.widthBox,
          Text(
            "Cr. Amount : ",
            style: customTextStyle.copyWith(
                fontSize: 13, fontWeight: FontWeight.bold),
          ),
          Text(
            controller.list_voucher
                .where((p0) => p0.drcrID == 'cr')
                .sum((p0) => double.parse(p0.amount!))
                .toString(),
            style: customTextStyle.copyWith(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: appColorLogoDeep),
          ),
          10.widthBox,
          Text(
            "Balance : ",
            style: customTextStyle.copyWith(
                fontSize: 13, fontWeight: FontWeight.bold),
          ),
          Text(
            (controller.list_voucher
                        .where((p0) => p0.drcrID == 'dr')
                        .sum((p0) => double.parse(p0.amount!)) -
                    controller.list_voucher
                        .where((p0) => p0.drcrID == 'cr')
                        .sum((p0) => double.parse(p0.amount!)))
                .toString(),
            style: customTextStyle.copyWith(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: appColorLogoDeep),
          ),
          24.widthBox,
          CustomButton(Icons.undo, "Undo", () {
            controller.clearAll();
          }, Colors.white, Colors.white, appColorGrayDark),
          18.widthBox,
          CustomButton(Icons.save, "Save", () {})
        ],
      ),
    );
_tableHeader() => Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 0),
      child: Table(
        columnWidths: CustomColumnWidthGenarator(_tableCol),
        children: [
          TableRow(decoration: CustomTableHeaderRowDecoration(), children: [
            CustomTableCell(
                "Dr/Cr", customTextStyle.copyWith(fontWeight: FontWeight.bold)),
            CustomTableCell("Ledger",
                customTextStyle.copyWith(fontWeight: FontWeight.bold)),
            CustomTableCell("Sub Ledger",
                customTextStyle.copyWith(fontWeight: FontWeight.bold)),
            CustomTableCell("Cost Center",
                customTextStyle.copyWith(fontWeight: FontWeight.bold)),
            TableCell(
                verticalAlignment: TableCellVerticalAlignment.middle,
                child: Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Text("Amount",
                          style: customTextStyle.copyWith(
                              fontWeight: FontWeight.bold)),
                    ))),
            CustomTableCell("Narration",
                customTextStyle.copyWith(fontWeight: FontWeight.bold)),
            CustomTableCell(""),
          ])
        ],
        border: TableBorder.all(width: 0.1, color: appColorGrayDark),
      ),
    );

Widget _fiterButton() => Container(
    height: 28,
    width: 20,
    color: appColorGray200,
    child: const Center(
        child: Icon(
      Icons.filter_alt,
      size: 18,
      color: appColorBlue,
    )));

_rightPartMenu(VoucherEntryController controller) => SizedBox(
      width: 160,
      height: controller.context.height,
      child: CustomAccordionContainer(
        isExpansion: false,
        height: 0,
        headerName: 'Voucher Type',
        children: [
          Expanded(
              flex: controller.context.height > 695 ? 2 : 1,
              child: const SizedBox()),
          Expanded(
            flex: 6,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ...controller.list_vtype.map((e) {
                      return Column(
                        children: [
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  fixedSize: const Size(124, 28),
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 4),
                                  backgroundColor:
                                      controller.voucherTypeID.value == e.iD
                                          ? appColorLogo
                                          : appColorIndigoA100,
                                  foregroundColor: Colors.white),
                              onPressed: () {
                                controller.voucherTypeID.value = e.iD!;
                                controller.loadLeadger();
                              },
                              child: Text(
                                e.nAME!,
                                style: customTextStyle.copyWith(
                                    fontSize: 11,
                                    fontFamily: appFontMuli,
                                    color:
                                        controller.voucherTypeID.value == e.iD
                                            ? Colors.white
                                            : Colors.black,
                                    fontWeight: FontWeight.bold),
                              )),
                          16.heightBox,
                        ],
                      );
                    }),
                  ],
                ),
              ),
            ),
          ),
          const Expanded(flex: 1, child: SizedBox())
        ],
      ),
    );

_responsiveNonDesktop(VoucherEntryController controller) =>
    CustomAccordionContainer(
      headerName: "Voucher Entry",
      height: 0,
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Container(
              decoration: customBoxDecoration.copyWith(
                  borderRadius: BorderRadius.circular(4)),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomDropDown(
                        labeltext: "Voucher Type",
                        id: controller.voucherTypeID.value,
                        width: 150,
                        list: controller.list_vtype
                            .map((element) => DropdownMenuItem<String>(
                                value: element.iD,
                                child: Text(
                                  element.nAME!,
                                  style: customTextStyle.copyWith(
                                      fontSize: 12, fontFamily: appFontMuli),
                                )))
                            .toList(),
                        onTap: (v) {}),
                    4.heightBox,
                    CustomDatePicker(
                        width: 150, date_controller: TextEditingController()),
                    4.heightBox,
                    Row(
                      children: [
                        CustomTextBox(
                            caption: "Voucher No",
                            width: 150,
                            isCapitalization: true,
                            controller: TextEditingController(),
                            onChange: (v) {}),
                        InkWell(
                          onTap: () {},
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.search,
                              size: 18,
                            ),
                          ),
                        )
                      ],
                    ),
                    4.heightBox,
                    Row(
                      children: [
                        Checkbox(value: false, onChanged: (v) {}),
                        4.widthBox,
                        Text(
                          "Is Approve? (Auto)",
                          style: customTextStyle.copyWith(
                              fontSize: 13, fontWeight: FontWeight.bold),
                        )
                      ],
                    )

                    // Column(
                    //   children: controller.ledger_list
                    //       .where((p0) => p0.pARENTID == '0')
                    //       .map((e) => _chartAccount(controller, e))
                    //       .toList(),
                    // ),
                    // controller.selectedLedger.value.iD == null
                    //     ? const SizedBox()
                    //     : Padding(
                    //         padding: const EdgeInsets.all(8.0),
                    //         child: SizedBox(
                    //           height: 500,
                    //           child: _slList(controller),
                    //         ),
                    //       )
                  ]),
            ),
          ),
        ),
      ],
    );

class _commonList {
  String? id;
  String? name;
  _commonList(this.id, this.name);
}

Widget _popUpGenerator(
        @required List<_commonList> list,
        @required TextEditingController txt_controller,
        Function() ItemSearch,
        Function(String? v) ItemClick,
        Function() CloseClick,
        [String searchCap = 'Search']) =>
    Stack(
      children: [
        AnimatedContainer(
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadiusDirectional.only(
                  bottomStart: Radius.circular(8),
                  bottomEnd: Radius.circular(8)),
              boxShadow: [
                BoxShadow(
                    spreadRadius: 2, blurRadius: 1, color: appColorGray200)
              ]),
          height: 450,
          duration: const Duration(milliseconds: 400),
          curve: Curves.fastOutSlowIn,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                child: Row(
                  children: [
                    Expanded(
                        child: CustomTextBox(
                            caption: searchCap,
                            controller: txt_controller,
                            onChange: (v) {
                              ItemSearch();
                            })),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    ...list.map((element) => MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () {
                              ItemClick(element.id!);
                              txt_controller.text = '';
                            },
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            width: 0.3,
                                            color: appColorGray200)),
                                    child: Text(
                                      element.name!,
                                      style: customTextStyle.copyWith(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ))
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
            bottom: 0,
            right: 0,
            child: InkWell(
              onTap: () {
                CloseClick();
                txt_controller.text = '';
              },
              child: Container(
                  decoration: BoxDecoration(
                      color: appColorGrayDark,
                      borderRadius: BorderRadiusDirectional.circular(50)),
                  child: const Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Icon(
                      Icons.close,
                      color: appColorGrayLight,
                      size: 14,
                    ),
                  )),
            )),
      ],
    );

List<int> _tableCol = [50, 150, 130, 130, 80, 150, 30];
