import 'package:agmc/core/config/const_widget.dart';
import 'package:agmc/widget/custom_datepicker.dart';
 

import '../../../core/config/const.dart';
 
import 'controller/fin_balancesheet_controller.dart';

class BalanceSgeetPage extends StatelessWidget {
  const BalanceSgeetPage({super.key});

  void disposeController() {
    try {
      Get.delete<BalanceSheetController>();
    } catch (e) {
      // print('Error disposing EmployeeController: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    BalanceSheetController controller = Get.put(BalanceSheetController());
    controller.context = context;
    return Obx(() => CommonBody(
           controller,
           _desktop(controller),
           _desktop(controller),
           _desktop(controller),
        ));
  }
}

Widget _desktop(BalanceSheetController controller) => CustomAccordionContainer(
        headerName: "Balance Sheet",
        height: 0,
        isExpansion: false,
        children: [
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
              decoration: customBoxDecoration,
              child: Column(children: [
                _header(controller),
                8.heightBox,
                controller.comparisonType.value == 1
                    ? _dateRangeW(controller)
                    : controller.comparisonType.value == 2
                        ? _monthW(controller)
                        : _yearW(controller),
              ])),
          _tablePart(controller),
        ]);

Widget _tablePart(BalanceSheetController controller) => Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        child: Container(
          width: double.infinity,
          decoration: customBoxDecoration.copyWith(
              border: Border.all(color: appColorGrayDark)),
          child: Column(
            children: [
              Table(
                border: CustomTableBorderNew,
                columnWidths: CustomColumnWidthGenarator(_col),
                children: [
                  TableRow(
                      decoration: CustomTableHeaderRowDecorationnew,
                      children: [
                        oneColumnCellBody(
                            "Particulers",
                            14,
                            Alignment.centerLeft,
                            FontWeight.bold,
                            const EdgeInsets.symmetric(
                                vertical: 6, horizontal: 6)),
                        oneColumnCellBody(
                            controller.displayPreviuos.value,
                            14,
                            Alignment.centerRight,
                            FontWeight.bold,
                            const EdgeInsets.symmetric(
                                vertical: 6, horizontal: 6)),
                        oneColumnCellBody(
                            controller.displayCurrent.value,
                            14,
                            Alignment.centerRight,
                            FontWeight.bold,
                            const EdgeInsets.symmetric(
                                vertical: 6, horizontal: 6)),
                      ])
                ],
              ),
              const Expanded(
                child: SingleChildScrollView(),
              ),
            ],
          ),
        ),
      ),
    );

List<int> _col = [250, 120, 120];

Widget _header(BalanceSheetController controller) => Row(
      children: [
        _radio(1, controller, "Date Wise"),
        12.widthBox,
        _radio(2, controller, "Month"),
        12.widthBox,
        _radio(3, controller, "Year"),
        12.widthBox,
        CustomButton(Icons.search, "Show", () {
          controller.show();
          //controller.showData();
          // _selectDate(controller.context);
        }),
      ],
    );
//

Widget _dateRangeW(BalanceSheetController controller) => Row(
      children: [
        CustomDatePicker(
          isShowCurrentDate :true,
          label: "From Date",
          textfontWeight: FontWeight.w600,
          width: 130,
          date_controller: controller.txt_fdate,
          isBackDate: true,
        ),
        12.widthBox,
        CustomDatePicker(
          isShowCurrentDate :true,
          textfontWeight: FontWeight.w600,
          label: "To Date",
          width: 130,
          date_controller: controller.txt_tdate,
          isBackDate: true,
        )
      ],
    );

Widget _monthW(BalanceSheetController controller) => Row(
      children: [
        CustomDropDown(
            width: 130,
            labeltext: "Month",
            id: controller.monthID.value,
            list: controller.list_month
                .map((element) => DropdownMenuItem<String>(
                    value: element.id,
                    child: Text(
                      element.name!,
                      style: customTextStyle.copyWith(fontSize: 12.5),
                    )))
                .toList(),
            onTap: (v) {
              controller.monthID.value = v!;
            }),
        12.widthBox,
        CustomDropDown(
            width: 130,
            labeltext: "Year",
            id: controller.yearID.value,
            list: controller.list_year
                .map((element) => DropdownMenuItem<String>(
                    value: element.id,
                    child: Text(
                      element.name!,
                      style: customTextStyle.copyWith(fontSize: 12.5),
                    )))
                .toList(),
            onTap: (v) {
              controller.yearID.value = v!;
            }),
      ],
    );

Widget _yearW(BalanceSheetController controller) => Row(
      children: [
        CustomDropDown(
            labeltext: "Select Year",
            id: controller.yearID.value,
            list: controller.list_year
                .map((element) => DropdownMenuItem<String>(
                    value: element.id,
                    child: Text(
                      element.name!,
                      style: customTextStyle.copyWith(fontSize: 12.5),
                    )))
                .toList(),
            onTap: (v) {
              controller.yearID.value = v!;
            }),
      ],
    );

Widget _radio(@required int val, @required BalanceSheetController controller,
        @required String caption) =>
    Row(
      children: [
        SizedBox(
          width: 15,
          height: 15,
          child: Radio(
            value: val,
            groupValue: controller.comparisonType.value,
            onChanged: (value) {
              controller.comparisonType.value = value as int;
            },
            visualDensity: VisualDensity(horizontal: -4.0, vertical: -4.0),
          ),
        ),
        4.widthBox,
        Text(
          caption,
          style: customTextStyle.copyWith(
              fontSize: 12,
              fontWeight: controller.comparisonType.value == val
                  ? FontWeight.bold
                  : FontWeight.w500),
        ),
      ],
    );
