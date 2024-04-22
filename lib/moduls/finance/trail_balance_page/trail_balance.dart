// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, unused_element

import 'package:agmc/core/config/const_widget.dart';

import 'package:agmc/widget/custom_datepicker.dart';

import '../../../core/config/const.dart';

import 'controller/trail_balance_controller.dart';
import 'model/model_trail_balance.dart';

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

Widget _TableBody(TarailBalanceController controller) => Expanded(
        child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Container(
          color: Colors.white,
          child: SingleChildScrollView(
              child: Column(
            children: const [
              // for (var i = 0; i < 5; i++) Row(
              //              children: [
              //  Text("data      ;dl;fjd "),
              // ],
              //            )
            ],
          ))),
    ));

_bodyGenerator(List<ModelTralBalance> data) => Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
    );

_grandTotal(TarailBalanceController controller) => Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Table(
        // border: CustomTableBorderNew,
        columnWidths: CustomColumnWidthGenarator(_col),
        children: [
          TableRow(
              decoration: CustomTableHeaderRowDecorationnew.copyWith(
                  color: appColorGrayLight),
              children: [
                TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: SizedBox()),
                TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: _colHeaderText("Grang Total")),
                TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child:
                        _twoColumnHeaderInTableColumnHeader("Debit", "Credit")),
                TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child:
                        _twoColumnHeaderInTableColumnHeader("Debit", "Credit")),
                TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child:
                        _twoColumnHeaderInTableColumnHeader("Debit", "Credit"))
              ])
        ],
      ),
    );

Widget _panelHeader(TarailBalanceController controller) => Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        decoration: customBoxDecoration,
        child: Row(
          children: [
            CustomDatePicker(
                label: "From Date",
                isShowCurrentDate: true,
                isBackDate: true,
                date_controller: controller.txt_fromDate),
            8.widthBox,
            CustomDatePicker(
                label: "From Date",
                isShowCurrentDate: true,
                isBackDate: true,
                date_controller: controller.txt_toDate),
            8.widthBox,
            CustomButton(Icons.search, "Show", () {
              controller.showData();
             // _selectDate(controller.context);
            })
          ],
        ),
      ),
    );

Widget _tableHeader = Padding(
  padding: EdgeInsets.symmetric(horizontal: 8),
  child: Table(
    border: CustomTableBorderNew,
    columnWidths: CustomColumnWidthGenarator(_col),
    children: [
      TableRow(
          decoration: CustomTableHeaderRowDecorationnew.copyWith(
              color: appColorGrayLight),
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
        [Color borderColor = appColorGrayDark]) =>
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
                    style: customTextStyle,
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
                    style: customTextStyle,
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
