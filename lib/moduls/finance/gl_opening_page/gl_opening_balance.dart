 

import '../../../core/config/const.dart';
import '../../../core/config/const_widget.dart';
 
import '../../../widget/custom_datepicker.dart';
import 'controller/gl_opening_balance_controller.dart';

class GlOpeningBalance extends StatelessWidget {
  const GlOpeningBalance({super.key});
  void disposeController() {
    try {
      Get.delete<GlOpeningBalanceController>();
    } catch (e) {
      // print('Error disposing EmployeeController: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    GlOpeningBalanceController controller =
        Get.put(GlOpeningBalanceController());
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

_mainWidget(GlOpeningBalanceController controller) => CustomAccordionContainer(
        headerName: "Ledger Opening Balance",
        height: 0,
        isExpansion: false,
        children: [
          _panelHeader(controller),
          _tableHeader,
          _tablebody(controller),
          // _grandTotal(controller)
        ]);

Widget _panelHeader(GlOpeningBalanceController controller) => Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: customBoxDecoration,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CustomButton(Icons.undo, "Refresh", () {
              controller.test();
            }, Colors.white),
            12.widthBox,
            CustomButton(Icons.upload, "Excel Import", () {}, Colors.white),
            12.widthBox,
            CustomDatePicker(
                borderRadious: 4,
                borderColor: appColorGrayDark,
                label: "Till Date",
                isShowCurrentDate: false,
                isBackDate: true,
                isFilled: true,
                date_controller: controller.txt_till_date),
            8.widthBox,
            CustomButton(
              Icons.save,
              "Save",
              () async{
              //await  exportExcelData([]);
              },
              appColorGrayLight,
              appColorGrayLight,
              appColorBlue,
            ),
            8.widthBox,
          ],
        ),
      ),
    );

Widget _tablebody(GlOpeningBalanceController controller) => Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Table(
            border: CustomTableBorderNew,
            columnWidths: CustomColumnWidthGenarator(_col),
            children: [
              for (var i = 0;
                  i < controller.list_lg_opening_bal_temp.length;
                  i++)
                TableRow(
                    decoration: const BoxDecoration(color: Colors.white),
                    children: [
                      TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: _colBodyText(
                              controller.list_lg_opening_bal_temp[i].cODE!,
                              Alignment.centerLeft)),
                      TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: _colBodyText(
                              controller.list_lg_opening_bal_temp[i].nAME!,
                              Alignment.centerLeft)),
                      TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: CustomTextBox(
                              height: 24,
                              caption: "",
                              fontColor: Colors.black,
                              textAlign: TextAlign.end,
                              borderColor: Colors.transparent,
                              textInputType: TextInputType.number,
                              maxLine: 1,
                              maxlength: 20,
                              enabledBorderColor: Colors.transparent,
                              focusedBorderColor: Colors.transparent,
                              controller: controller.controllers_txt[i]['dr']!,
                              onChange: (v) {
                                controller.updateDr(
                                    controller.list_lg_opening_bal_temp[i].iD!,
                                    double.parse(v == '' ? '0' : v));
                              })),
                      TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: CustomTextBox(
                              height: 24,
                              caption: "",
                              fontColor: Colors.black,
                              textAlign: TextAlign.end,
                              borderColor: Colors.transparent,
                              textInputType: TextInputType.number,
                              maxLine: 1,
                              maxlength: 20,
                              enabledBorderColor: Colors.transparent,
                              focusedBorderColor: Colors.transparent,
                              controller: controller.controllers_txt[i]['cr']!,
                              onChange: (v) {
                                controller.updateCr(
                                    controller.list_lg_opening_bal_temp[i].iD!,
                                    double.parse(v == '' ? '0' : v));
                              })

                          //_colBodyText(element.cR!.toString(), Alignment.centerRight)

                          ),
                    ])
            ],
          ),
        ),
      ),
    );

List<int> _col = [80, 200, 80, 80];
Widget _tableHeader = Padding(
  padding: const EdgeInsets.symmetric(horizontal: 8),
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
                child: _colHeaderText("Code", Alignment.centerLeft)),
            TableCell(
                verticalAlignment: TableCellVerticalAlignment.middle,
                child: _colHeaderText("Ledger Name", Alignment.centerLeft)),
            TableCell(
                verticalAlignment: TableCellVerticalAlignment.middle,
                child: Column(
                  children: [
                    _colHeaderText("Debit", Alignment.centerRight),
                    // _twoColumnHeaderInTableColumnHeader("Debit", "Credit"),
                  ],
                )),
            TableCell(
                verticalAlignment: TableCellVerticalAlignment.middle,
                child: Column(
                  children: [
                    _colHeaderText("Credit", Alignment.centerRight),
                    //  _twoColumnHeaderInTableColumnHeader("Debit", "Credit"),
                  ],
                )),
          ])
    ],
  ),
);

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
