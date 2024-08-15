 

import '../../../../core/config/const.dart';
 
import '../../../../widget/custom_datepicker.dart';
import '../../../../widget/custom_dialog.dart';
 
import '../../voucher_entry_page/controller/voucher_entry_controller.dart';
import '../../voucher_entry_page/model/model_voucher_type.dart';

var _col = [80, 50, 70, 180, 50, 80, 50, 30];
Widget _tableHeader() => Table(
      columnWidths: CustomColumnWidthGenarator(_col),
      children: [
        TableRow(
            decoration: CustomTableHeaderRowDecorationnew.copyWith(
                border: Border.all(color: appColorGrayLight)),
            children: [
              CustomTableCell("Voucher No",
                  customTextStyle.copyWith(fontWeight: FontWeight.bold)),
              CustomTableCell("Voucher Date",
                  customTextStyle.copyWith(fontWeight: FontWeight.bold)),
              CustomTableCell("Voucher Type",
                  customTextStyle.copyWith(fontWeight: FontWeight.bold)),
              CustomTableCell("Ledger",
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
              CustomTableCell2("Status", true, 14, FontWeight.bold),
              CustomTableCell2("Is Posted", true, 14, FontWeight.bold),
              const TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: Icon(
                    Icons.auto_awesome_motion_sharp,
                    size: 16,
                  ))
            ])
      ],
      border: CustomTableBorderNew,
    );

Future<void> getPopupDialog(VoucherEntryController controller) async {
  var anotherVariable = List.from(controller.list_vtype);
  anotherVariable.insert(0, ModelVoucherType(iD: "0", nAME: 'All'));
  controller.list_voucher_view.clear();
  controller.list_voucher_view_main.clear();
  controller.txt_SearchVoucher.text = '';
  await CustomDialog(
      controller.context,
      const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text("Voucher list"),
      ),
      Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(top: 8, left: 12, right: 12),
          child: SizedBox(
            width: controller.context.width - 350,
            height: controller.context.height - 200,
            child: Column(
              children: [
                4.heightBox,
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: customBoxDecoration.copyWith(
                      color: kBgLightColor,
                      borderRadius: BorderRadius.circular(4)),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CustomDropDown(
                            width: 150,
                            labeltext: 'Voucher Type',
                            id: controller.searchVoucherTypeID.value,
                            list: anotherVariable
                                .map((element) => DropdownMenuItem<String>(
                                    value: element.iD,
                                    child: Text(
                                      element.nAME!,
                                      style: customTextStyle.copyWith(
                                          fontSize: 11),
                                    )))
                                .toList(),
                            onTap: (v) {
                              controller.searchVoucherTypeID.value = v!;
                            },
                          ),
                          8.widthBox,
                          CustomDatePicker(
                              isShowCurrentDate: true,
                              fontColor: Colors.black,
                              isFilled: true,
                              isBackDate: true,
                              width: 130,
                              date_controller:
                                  controller.txt_searchVoucherFromDate),
                          8.widthBox,
                          CustomDatePicker(
                              fontColor: Colors.black,
                              isShowCurrentDate: true,
                              isFilled: true,
                              isBackDate: true,
                              width: 130,
                              date_controller:
                                  controller.txt_searchVoucherToDate),
                          8.widthBox,
                          CustomButton(Icons.search_outlined, "Show", () {
                            controller.showVoucherList();
                          }),
                          const Expanded(child: SizedBox()),
                          controller.context.width > 1200
                              ? CustomSearchBox(
                                  caption: "Voucher Search",
                                  width: 300,
                                  controller: controller.txt_SearchVoucher,
                                  onChange: (v) {
                                    controller.searchVoucher();
                                  })
                              : const SizedBox(),
                        ],
                      ),
                    ],
                  ),
                ),
                4.heightBox,
                Expanded(
                  child: Column(
                    children: [
                      _tableHeader(),
                      Expanded(
                          child: SingleChildScrollView(
                        child: Obx(() => _tableBody(controller)),
                      )),
                      Obx(() => _tableFooter(controller)),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      () {},
      true,
      false);
}

_tableBody(VoucherEntryController controller) {
  return Table(
    border: CustomTableBorderNew,
    columnWidths: CustomColumnWidthGenarator(_col),
    children: controller.list_voucher_view
        .map((e) => TableRow(children: [
              TableCell(
                verticalAlignment: TableCellVerticalAlignment.middle,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  child: SelectableText(
                    e.vNO!,
                    style: customTextStyle.copyWith(
                        fontSize: 12, fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              CustomTableCell2(e.vDATE!),
              CustomTableCell2(e.vTYPE!),
              CustomTableCell2(e.lNAME!),
              TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 4, vertical: 4),
                        child: Text(e.vAMOUNT.toString(),
                            style: customTextStyle.copyWith(
                                fontWeight: FontWeight.bold)),
                      ))),
              CustomTableCell2(e.sTATUS == "1" ? "Active" : "Inactive", true),
              CustomTableCell2(e.iSPOSTED == "1" ? "Posted" : "Unposted", true),
              TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.edit,
                        size: 14,
                        color: appColorBlue,
                      ),
                      8.widthBox,
                      InkWell(
                        onTap: () {
                          controller.showVoucher2(e.vNO!);
                        },
                        child: const Icon(
                          Icons.search,
                          size: 14,
                          color: appColorBlue,
                        ),
                      ),
                    ],
                  ))
            ]))
        .toList(),
  );
}

_tableFooter(VoucherEntryController controller) {
  final double amt = controller.list_voucher_view
      .sum((p0) => double.parse(p0.vAMOUNT == '' ? '0' : p0.vAMOUNT!))
      .toDouble();
  return Table(
      //border: CustomTableBorderNew,
      columnWidths: CustomColumnWidthGenarator(_col),
      children: [
        TableRow(
            decoration: BoxDecoration(
              color: amt > 0 ? kWebBackgroundColor : Colors.transparent,
            ),
            children: [
              CustomTableCell2(""),
              CustomTableCell2(""),
              CustomTableCell2(""),
              TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 4, vertical: 4),
                        child: amt > 0
                            ? Text(
                                "Grand Total",
                                style: customTextStyle.copyWith(
                                    fontSize: 13, fontWeight: FontWeight.bold),
                              )
                            : SizedBox(),
                      ))),
              TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 4, vertical: 4),
                        child: amt > 0
                            ? Text(
                                amt.toString(),
                                style: customTextStyle.copyWith(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: appColorLogoDeep),
                              )
                            : const SizedBox(),
                      ))),
              CustomTableCell2(""),
              CustomTableCell2(""),
              CustomTableCell2(""),
            ])
      ]);
}
