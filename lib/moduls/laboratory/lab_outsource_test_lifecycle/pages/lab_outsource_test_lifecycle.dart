import '../../../../core/config/const.dart';
import '../../../../widget/custom_datepicker.dart';
import '../controller/lab_outsource_test_lifecycle_controller.dart';

class OutsourceTestlifecycle extends StatelessWidget {
  const OutsourceTestlifecycle({super.key});
  void disposeController() {
    try {
      Get.delete<LabOutsourceTestLifecycleController>();
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    final LabOutsourceTestLifecycleController controller =
        Get.put(LabOutsourceTestLifecycleController());
    controller.context = context;
    return Obx(() => CommonBody3(
        controller,
        [_filterPanel(controller), _tablePart(controller)],
        'Outsource Report Life Cycle::'));
  }
}

List<int> _col = [20, 50, 50, 100, 50, 100, 40, 60, 60, 60, 60, 20];

Widget _tablePart(LabOutsourceTestLifecycleController controller) => Expanded(
      child: CustomGroupBox(
          padingvertical: 4,
          groupHeaderText: 'Sample List',
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Flexible(
                        child: CustomSearchBox(
                      width: 400,
                      caption: 'Search',
                      controller: controller.txt_search,
                      onChange: (v) {
                        controller.search();
                      },
                      borderRadious: 4,
                    )),
                  ],
                ),
                8.heightBox,
                Expanded(
                  child: CustomTableGenerator(
                      colWidtList: _col,
                      childrenHeader: [
                        CustomTableClumnHeader('Type', Alignment.center),
                        CustomTableClumnHeader('MR.No'),
                        CustomTableClumnHeader('Sample ID'),
                        CustomTableClumnHeader('Test Name'),
                        CustomTableClumnHeader('HCN'),
                        CustomTableClumnHeader('Patient Name'),
                        CustomTableClumnHeader('Is S.Coll?', Alignment.center),
                        CustomTableClumnHeader('Entry By'),
                        CustomTableClumnHeader('Verify By'),
                        CustomTableClumnHeader('Finalized By'),
                        CustomTableClumnHeader('Is Cancel'),
                        CustomTableClumnHeader('*', Alignment.center),
                      ],
                      childrenTableRowList: controller.list_test_data_temp
                          .map((f) => TableRow(
                                  decoration: BoxDecoration(
                                      color: f.isCancel == '1'
                                          ? const Color.fromARGB(
                                              255, 255, 250, 250)
                                          : f.resultID == ' '
                                              ? Colors.white
                                              : const Color.fromARGB(
                                                  255, 248, 252, 248)),
                                  children: [
                                    oneColumnCellBody(
                                        f.mrType == 'I'
                                            ? 'IPD'
                                            : f.mrType == 'O'
                                                ? 'OPD'
                                                : 'Emr',
                                        12,
                                        Alignment.center),
                                    oneColumnCellBody(
                                        f.mrId!,
                                        12,
                                        Alignment.centerLeft,
                                        FontWeight.w400,
                                        const EdgeInsets.all(4),
                                        Colors.transparent,
                                        true),
                                    oneColumnCellBody(
                                        f.sampleId!,
                                        12,
                                        Alignment.centerLeft,
                                        FontWeight.w400,
                                        const EdgeInsets.all(4),
                                        Colors.transparent,
                                        true),
                                    oneColumnCellBody(f.testName!),
                                    oneColumnCellBody(f.hcn!),
                                    oneColumnCellBody(f.pname!),
                                    oneColumnCellBody(
                                        f.isSampleColl == '0' ? 'No' : 'Yes',
                                        12,
                                        Alignment.center),
                                    oneColumnCellBody(f.entryBy == ' '
                                        ? ''
                                        : '${f.entryBy!} ${f.entryByName!}\n${f.entryDate!}'),
                                    oneColumnCellBody(f.verifyBy == ' '
                                        ? ''
                                        : '${f.verifyBy!} ${f.verifyByName!}\n${f.verifyDate!}'),
                                    oneColumnCellBody(f.finalizedBy == ' '
                                        ? ''
                                        : '${f.finalizedBy!} ${f.finalizedByName!}\n${f.finalizedDate!}'),
                                    oneColumnCellBody(
                                        f.isCancel == '0' ? 'No' : 'Yes',
                                        12,
                                        Alignment.center,
                                        FontWeight.w600,
                                        const EdgeInsets.all(4),
                                        Colors.transparent,
                                        false,
                                        f.isCancel == '0'
                                            ? Colors.black
                                            : Colors.red),
                                    f.resultID == ' '
                                        ? const TableCell(child: SizedBox())
                                        : CustomTableEditCell(() {
                                            controller.printPreview(f);
                                            // controller.showReport2(
                                            //     f.resIdTemp!, false);
                                          }, Icons.assignment, appColorPrimary,
                                            18)
                                  ]))
                          .toList()),
                )
              ],
            ),
          )),
    );

Widget _filterPanel(LabOutsourceTestLifecycleController controller) =>
    CustomGroupBox(
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
                12.widthBox,
                CustomFilterButtonRounded(
                    icon: controller.isShowFilter.value
                        ? Icons.undo
                        : Icons.filter_alt,
                    onTap: () {
                      controller.isShowFilter.value =
                          !controller.isShowFilter.value;
                    })
              ],
            ),
            controller.isShowFilter.value ? 14.heightBox : const SizedBox(),
            controller.isShowFilter.value
                ? Row(
                    children: [
                      Flexible(
                        child: CustomDatePickerDropDown(
                          date_controller: controller.txt_fdate,
                          width: 120,
                          height: 26,
                          borderRadious: 4,
                          label: 'From ',
                          isBackDate: true,
                          isShowCurrentDate: false,
                        ),
                      ),
                      12.widthBox,
                      Flexible(
                        child: CustomDatePickerDropDown(
                          borderRadious: 4,
                          width: 120,
                          height: 26,
                          date_controller: controller.txt_tdate,
                          isBackDate: true,
                          label: 'To ',
                          isShowCurrentDate: false,
                        ),
                      ),
                      12.widthBox,
                      CustomButton(Icons.search, 'Show', () {
                        controller.showData();
                      }, appColorGrayDark, appColorGrayDark, appColorGray200)
                    ],
                  )
                : const SizedBox(),
            4.heightBox
          ],
        ),
      ),
    );
