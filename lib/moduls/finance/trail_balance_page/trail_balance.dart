// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, unused_element

import 'package:agmc/core/config/const_widget.dart';

import 'package:agmc/widget/custom_datepicker.dart';



import '../../../core/config/const.dart';

import 'controller/trail_balance_controller.dart';
//import 'package:pdf/widgets.dart' as wd;



class TrailBalance extends StatelessWidget {
  const TrailBalance({super.key});
  void disposeController() {
    try {
      Get.delete<TarailBalanceController>();
    } catch (e) {
      // print('Error disposing EmployeeController: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    TarailBalanceController controller = Get.put(TarailBalanceController());
    controller.context = context;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
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

_mainWidget(TarailBalanceController controller) => CustomAccordionContainer(
        headerName: "Trail Balance",
        height: 0,
        isExpansion: false,
        children: [
          _panelHeader(controller),
          _tableHeader,
          _TableBody(controller),
          _grandTotal(controller)
        ]);

List<int> _col = [80, 120, 120, 120, 120];

Widget _TableBody(TarailBalanceController controller) {
  return Expanded(
      child: Padding(
    padding: EdgeInsets.symmetric(horizontal: 8),
    child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: appColorGrayDark, width: 0.5)),
        child: SingleChildScrollView(
            child: Column(
          children: controller.list_group
              .map((element) => Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              color: appColorPista.withOpacity(0.03),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 4, top: 6, bottom: 6),
                                child: Text(
                                  element.name!,
                                  style: customTextStyle.copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),

                      Obx(() => tableBodyGenerator(
                          _col,
                          controller.list_sub
                              .where((p0) => p0.pid == element.id)
                              .map(
                                (e) => _tableRow(
                                    _sub(
                                      pid: e.pid,
                                      id: e.id,
                                      code: e.code,
                                      name: e.name,
                                      odr: e.odr,
                                      ocr: e.ocr,
                                      tdr: e.tdr,
                                      tcr: e.tcr,
                                      cdr: e.cdr,
                                      ccr: e.ccr,
                                    ),
                                    controller.list_sub.indexOf(e)),
                              )
                              .toList())),
                      Obx(() => _subTotal(controller.list_sub
                          .where((p0) => p0.pid == element.id))),

                      //_grouDetails(controller, element.id)
                      // Obx(() => controller.grouDetails(element.id!, _col)),
                      // _grandTotal(controller),
                      ///  here table generate
                      // _bodyGenerator(),
                      // _bodyGenerator(),
                      // _bodyGenerator(),
                      //, _bodyGenerator()
                    ],
                  ))
              .toList(),
        ))),
  ));
}

_subTotal(dynamic list) => Table(
      // border: CustomTableBorderNew,
      columnWidths: CustomColumnWidthGenarator(_col),
      children: [
        TableRow(
            decoration: CustomTableHeaderRowDecorationnew.copyWith(
                color: kBgDarkColor,
                border: Border.all(color: Colors.black, width: 0.1),
                boxShadow: [
                  BoxShadow(
                      color: Colors.white, spreadRadius: 1, blurRadius: 0.5)
                ]),
            children: [
              TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: SizedBox()),
              TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: _colHeaderText("Sub Total")),
              TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: _twoColumnHeaderInTableColumnHeader(
                      list
                          .fold(0.0,
                              (previous, current) => previous + current.odr!)
                          .toStringAsFixed(2),
                      list
                          .fold(0.0,
                              (previous, current) => previous + current.ocr!)
                          .toStringAsFixed(2),
                      appColorGray200,
                      Colors.black,
                      12.5)),
              TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: _twoColumnHeaderInTableColumnHeader(
                      list
                          .fold(0.0,
                              (previous, current) => previous + current.tdr!)
                          .toStringAsFixed(2),
                      list
                          .fold(0.0,
                              (previous, current) => previous + current.tcr!)
                          .toStringAsFixed(2),
                      appColorGray200,
                      Colors.black,
                      12.5)),
              TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: _twoColumnHeaderInTableColumnHeader(
                      list
                          .fold(0.0,
                              (previous, current) => previous + current.cdr!)
                          .toStringAsFixed(2),
                      list
                              .fold(
                                  0.0,
                                  (previous, current) =>
                                      previous + current.ccr!)
                              .toStringAsFixed(2) +
                          '  ',
                      appColorGray200,
                      Colors.black,
                      12.5))
            ])
      ],
    );

_grandTotal(TarailBalanceController controller) => Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Table(
        // border: CustomTableBorderNew,
        columnWidths: CustomColumnWidthGenarator(_col),
        children: [
          TableRow(
              decoration: CustomTableHeaderRowDecorationnew.copyWith(
                  color: Colors.brown[30]),
              children: [
                TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: SizedBox()),
                TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: _colHeaderText("Grand Total")),
                TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: _twoColumnHeaderInTableColumnHeader(
                        controller.list_sub
                            .fold(0.0,
                                (previous, current) => previous + current.odr!)
                            .toStringAsFixed(2),
                        controller.list_sub
                            .fold(0.0,
                                (previous, current) => previous + current.ocr!)
                            .toStringAsFixed(2),
                        appColorGrayDark,
                        appColorLogoDeep)),
                TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: _twoColumnHeaderInTableColumnHeader(
                        controller.list_sub
                            .fold(0.0,
                                (previous, current) => previous + current.tdr!)
                            .toStringAsFixed(2),
                        controller.list_sub
                            .fold(0.0,
                                (previous, current) => previous + current.tcr!)
                            .toStringAsFixed(2),
                        appColorGrayDark,
                        appColorLogoDeep)),
                TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: _twoColumnHeaderInTableColumnHeader(
                        controller.list_sub
                            .fold(0.0,
                                (previous, current) => previous + current.cdr!)
                            .toStringAsFixed(2),
                        controller.list_sub
                            .fold(0.0,
                                (previous, current) => previous + current.ccr!)
                            .toStringAsFixed(2),
                        appColorGrayDark,
                        appColorLogoDeep))
              ])
        ],
      ),
    );

Widget _panelHeader(TarailBalanceController controller) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        decoration: customBoxDecoration,
        child: Column(
          children: [
            Row(
              children: [
                CustomDatePicker(
                    label: "From Date",
                    isShowCurrentDate: true,
                    isBackDate: true,
                    width: 120,
                    date_controller: controller.txt_fromDate),
                12.widthBox,
                CustomDatePicker(
                    label: "From Date",
                    width: 120,
                    isShowCurrentDate: true,
                    isBackDate: true,
                    date_controller: controller.txt_toDate),
                8.widthBox,
                CustomButton(Icons.search, "Show", () {
                  controller.showData();
                  // _selectDate(controller.context);
                }),
                8.widthBox,
                // controller.list_sub.isNotEmpty
                //     ? Tooltip(
                //         message: 'Print View',
                //         child: RoundedButton(() async {
                //           await PdfInvoiceApi.generatePDF(
                //               wd.Text('header'),
                //               [
                //                 t_tab(controller,_col),
                           
                //               ],
                //               wd.Text('Footer'),
                //               true);
                //         }, Icons.analytics),
                //       )
                //     : SizedBox()
              ],
            ),
            10.heightBox,
            Row(
              children: [
                _radio(1, controller, "Group Wase"),
                8.widthBox,
                _radio(2, controller, "Sub Group Wase"),
                8.widthBox,
                _radio(3, controller, "Category Wase")
              ],
            )
          ],
        ),
      ),
    );

dynamic _tableHeader = Padding(
  padding: EdgeInsets.symmetric(horizontal: 8),
  child: Table(
    border: CustomTableBorderNew,
    columnWidths: CustomColumnWidthGenarator(_col),
    children: [
      TableRow(
          decoration: CustomTableHeaderRowDecorationnew.copyWith(
              color: Colors.brown[30]),
          children: [
            TableCell(
                verticalAlignment: TableCellVerticalAlignment.middle,
                child: _colHeaderText("Code")),
            TableCell(
                verticalAlignment: TableCellVerticalAlignment.middle,
                child: _colHeaderText("Particulars")),
            TableCell(
                verticalAlignment: TableCellVerticalAlignment.middle,
                child: Column(
                  children: [
                    _colHeaderText("Opening"),
                    _twoColumnHeaderInTableColumnHeader("Debit", "Credit"),
                  ],
                )),
            TableCell(
                verticalAlignment: TableCellVerticalAlignment.middle,
                child: Column(
                  children: [
                    _colHeaderText("Transaction"),
                    _twoColumnHeaderInTableColumnHeader("Debit", "Credit"),
                  ],
                )),
            TableCell(
                verticalAlignment: TableCellVerticalAlignment.middle,
                child: Column(
                  children: [
                    _colHeaderText("Closing"),
                    _twoColumnHeaderInTableColumnHeader("Debit", "Credit"),
                  ],
                ))
          ])
    ],
  ),
);

_twoColumnHeaderInTableColumnHeader(String leftString, String rightString,
        [Color borderColor = appColorGrayDark,
        Color fontColor = Colors.black,
        double fontSize = 13.5]) =>
    Row(
      children: [
        Expanded(
          flex: 5,
          child: Container(
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(color: borderColor, width: 0.2),
                      right: BorderSide(color: borderColor, width: 0.4))),
              padding: EdgeInsets.all(4),
              child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    leftString,
                    style: customTextStyle.copyWith(
                        fontSize: fontSize,
                        color: fontColor,
                        fontWeight: FontWeight.w600),
                  ))),
        ),
        Expanded(
          flex: 5,
          child: Container(
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(color: borderColor, width: 0.2),
                      right: BorderSide(color: borderColor, width: 0.4))),
              padding: EdgeInsets.all(4),
              child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    rightString,
                    style: customTextStyle.copyWith(
                        fontSize: fontSize,
                        color: fontColor,
                        fontWeight: FontWeight.w600),
                  ))),
        )
      ],
    );

_colHeaderText(String txt) => Align(
    alignment: Alignment.center,
    child: Padding(
      padding: const EdgeInsets.all(4.0),
      child: Text(
        txt,
        style: customTextStyle,
      ),
    ));

void _selectDate(BuildContext context) async {
  DateTime selectedDate = await showDialog(
    context: context,
    builder: (BuildContext context) {
      DateTime selectedDate = DateTime.now();
      return Dialog(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pop(selectedDate);
          },
          child: Container(
            padding: EdgeInsets.all(20.0),
            child: CalendarDatePicker(
              initialDate: selectedDate,
              firstDate: DateTime(2022),
              lastDate: DateTime(2025),
              onDateChanged: (DateTime date) {
                selectedDate = date;
                print(selectedDate);
              },
            ),
          ),
        ),
      );
    },
  );

  // Handle the selected date here
  if (selectedDate != null) {
    print('Selected date: $selectedDate');
  }
}

Widget _radio(@required int val, @required TarailBalanceController controller,
        @required String caption) =>
    Row(
      children: [
        SizedBox(
          width: 15,
          height: 15,
          child: Radio(
            value: val,
            groupValue: controller.selectedRadioValue.value,
            onChanged: (value) {
              controller.selectedRadioValue.value = value as int;
            },
            visualDensity: VisualDensity(horizontal: -4.0, vertical: -4.0),
          ),
        ),
        4.widthBox,
        Text(
          caption,
          style: customTextStyle.copyWith(
              fontSize: 12,
              fontWeight: controller.selectedRadioValue.value == val
                  ? FontWeight.bold
                  : FontWeight.w500),
        ),
      ],
    );

TableRow _tableRow(dynamic data, [int index = 1]) => TableRow(
        decoration: CustomTableHeaderRowDecorationnew.copyWith(
            color: index % 2 != 0 ? Colors.white : kBgColorG),
        children: [
          TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: oneColumnCellBody(data.code!)),
          TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: oneColumnCellBody(data.name!)),
          TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: twoColumnCellBody(
                  data.odr!.toStringAsFixed(2), data.ocr!.toStringAsFixed(2))),
          TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: twoColumnCellBody(
                  data.tdr!.toStringAsFixed(2), data.tcr!.toStringAsFixed(2))),
          TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: twoColumnCellBody(
                  data.cdr! > data.ccr!
                      ? (data.cdr! - data.ccr!).toStringAsFixed(2)
                      : "0.00 ",
                  data.ccr! > data.cdr!
                      ? (data.ccr! - data.cdr!).toStringAsFixed(2) + '  '
                      : "0.00  "))
        ]);





 














class _sub {
  final String? pid;
  final String? id;
  final String? code;
  final String? name;
  final double? odr;
  final double? ocr;
  final double? tdr;
  final double? tcr;
  final double? cdr;
  final double? ccr;

  _sub(
      {required this.pid,
      required this.id,
      required this.code,
      required this.name,
      required this.odr,
      required this.ocr,
      required this.tdr,
      required this.tcr,
      required this.cdr,
      required this.ccr});
}
