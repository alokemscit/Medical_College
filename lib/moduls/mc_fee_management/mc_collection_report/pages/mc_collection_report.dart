import 'package:agmc/widget/custom_datepicker.dart';

import '../../../../core/config/const.dart';
import '../controller/mc_collection_report_controller.dart';

class McCollectionReport extends StatelessWidget {
  const McCollectionReport({super.key});
  void disposeController() {
    try {
      Get.delete<McCollectionReportController>();
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    final McCollectionReportController controller =
        Get.put(McCollectionReportController());
    controller.context = context;
    return Obx(() => CommonBody3(
        controller,
        [_header(controller), 8.heightBox, _tablePart(controller)],
        'Collection Details::'));
  }
}

_tablePart(McCollectionReportController controller) => Expanded(
    child: CustomGroupBox(
        padingvertical: 0,
        groupHeaderText: 'Transaction List',
        child: Column(
          children: [
            mCustomSearchWithRightSideIconButton(
              controller: controller.txt_search,
              isShorwRightButton: controller.list_trans_temp.isNotEmpty,
              onChange: (p0) {
                controller.search();
              },
              onButtonClick: () {
                controller.printTable();
              },
            ),
            12.heightBox,
            Expanded(
                child: CustomTableGenerator(colWidtList: const [
              10,
              40,
              20,
              70,
              40,
              40,
              50,
              60,
              30,
              30,
              20
            ], childrenHeader: [
              CustomTableClumnHeader('#', Alignment.center),
              CustomTableClumnHeader('St. ID'),
              CustomTableClumnHeader('Roll', Alignment.center),
              CustomTableClumnHeader('Name'),
              CustomTableClumnHeader('Session'),
              CustomTableClumnHeader('Trans. No'),
              CustomTableClumnHeader('Trans. type'),
              CustomTableClumnHeader('Note'),
              CustomTableClumnHeader('Trns. Date'),
              CustomTableClumnHeader('Amount', Alignment.bottomRight),
              CustomTableClumnHeader('*', Alignment.center),
            ], childrenTableRowList: [
              ...controller.list_trans_temp.map((f) => TableRow(
                      decoration: const BoxDecoration(color: Colors.white),
                      children: [
                        CustomTableCellx(
                          text: (controller.list_trans_temp.indexOf(f) + 1)
                              .toString(),
                          alignment: Alignment.center,
                        ),
                        CustomTableCellx(text: f.stNo!),
                        CustomTableCellx(
                          text: f.roll!,
                          alignment: Alignment.center,
                        ),
                        CustomTableCellx(text: f.stName!),
                        CustomTableCellx(text: f.sesName!),
                        CustomTableCellx(text: f.trnsNo!),
                        CustomTableCellx(text: f.feeTypeBname!),
                        CustomTableCellx(text: f.trnsDetails!),
                        CustomTableCellx(text: f.tillDate!),
                        CustomTableCellx(
                          text: (f.cr ?? 0).toString(),
                          alignment: Alignment.centerRight,
                        ),
                        CustomTableEditCell(() {
                          controller.showTransReport(f.id!);
                        }, Icons.local_printshop_rounded, appColorBlue, 14)
                      ]))
            ]))
          ],
        )));

_header(McCollectionReportController controller) => Row(
      children: [
        Expanded(
          child: CustomGroupBox(
              padingvertical: 0,
              groupHeaderText: '',
              child: Padding(
                padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
                child: Row(
                  children: [
                    Flexible(
                      child: CustomDropDown2(
                          width: 140,
                          labeltext: 'Trans. Type',
                          id: controller.cmb_fee_typeID.value,
                          list: controller.list_fee_type,
                          onTap: (v) {
                            controller.cmb_fee_typeID.value = v!;
                          }),
                    ),
                    12.widthBox,
                    CustomDatePickerDropDown(
                      date_controller: controller.txt_fdate,
                      width: 120,
                      label: 'From',
                    ),
                    12.widthBox,
                    CustomDatePickerDropDown(
                      date_controller: controller.txt_tdate,
                      width: 120,
                      label: 'To',
                    ),
                    12.widthBox,
                    CustomButton(Icons.search, 'Show', () {
                      controller.showData();
                    })
                  ],
                ),
              )),
        )
      ],
    );
