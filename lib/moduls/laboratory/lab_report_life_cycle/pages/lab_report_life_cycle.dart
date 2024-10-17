import '../../../../core/config/const.dart';
import '../../../../widget/custom_datepicker.dart';
import '../controller/lab_report_life_cycle_controller.dart';

class LabReportLifeCycle extends StatelessWidget {
  const LabReportLifeCycle({super.key});
  void disposeController() {
    try {
      Get.delete<LabReportLifeCycleController>();
      // ignore: empty_catches
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    final LabReportLifeCycleController controller =
        Get.put(LabReportLifeCycleController());
    controller.context = context;
    return Obx(() => CommonBody3(
        controller,
        [_filterPanel(controller), 4.heightBox, _tablePart(controller)],
        'Report Life Cycle'));
  }
}

List<int> _col = [20, 50, 50, 100, 50, 100, 40, 60, 60, 60, 60, 20];

Widget _tablePart(LabReportLifeCycleController controller) => Expanded(
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
                        CustomTableClumnHeader('Pat.Name'),
                        CustomTableClumnHeader('Is S. Coll?', Alignment.center),
                        CustomTableClumnHeader('Entry By'),
                        CustomTableClumnHeader('Verify By'),
                        CustomTableClumnHeader('Finalized By'),
                        CustomTableClumnHeader('Is Cancel'),
                        CustomTableClumnHeader('*', Alignment.center),
                      ],
                      childrenTableRowList: controller.list_life_cycle_temp
                          .map((f) => TableRow(
                                  decoration: BoxDecoration(
                                      color: f.isCancel == '1'
                                          ? const Color.fromARGB(255, 255, 250, 250) 
                                          : f.resId == ' '
                                              ? Colors.white
                                              : const Color.fromARGB(255, 248, 252, 248)),
                                  children: [
                                    oneColumnCellBody(
                                        f.mrType == 'I'
                                            ? 'IPD'
                                            : f.mrType == 'O'
                                                ? 'OPD'
                                                : 'Emr',
                                        12,
                                        Alignment.center),
                                    oneColumnCellBody(f.mrId!, 12,
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
                                    oneColumnCellBody(f.cancelBy == ' '
                                        ? ''
                                        : '${f.cancelBy!} ${f.cancelByName!}\n${f.cancelDate!}',
                                        12,
                                        Alignment.centerLeft,
                                        FontWeight.w600,
                                        const EdgeInsets.all(4),
                                        Colors.transparent,
                                        false,Colors.red
                                        ),
                                    f.resIdTemp == ' '
                                        ? const TableCell(child: SizedBox())
                                        : CustomTableEditCell(() {
                                            controller.showReport2(
                                                f.resIdTemp!, false);
                                          }, Icons.assignment, appColorPrimary,
                                            18)
                                    //  TableCell(
                                    //   verticalAlignment: TableCellVerticalAlignment.middle,
                                    //   child: f.resIdTemp==' '?const SizedBox(): Center(
                                    //     child: Container(
                                    //       decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),color: appGray50),
                                    //       padding: const EdgeInsets.all(4),
                                    //       child: const Icon(Icons.assignment,color: appColorPrimary,size: 18,)),
                                    //   ))
                                  ]))
                          .toList()),
                )
                // Table(
                //   columnWidths: customColumnWidthGenarator(_col),
                //   border: CustomTableBorderNew,
                //   children: [

                //     TableRow(
                //       decoration: const BoxDecoration(color: kBgColorG,),
                //       children: [

                //     CustomTableClumnHeader('Type',Alignment.center),
                //   CustomTableClumnHeader('MR.No'),
                //   CustomTableClumnHeader('Sample ID'),
                //   CustomTableClumnHeader('Test Name'),
                //   CustomTableClumnHeader('HCN'),
                //   CustomTableClumnHeader('Pat.Name'),
                //   CustomTableClumnHeader('S.Receive By'),
                //   CustomTableClumnHeader('Entry By'),
                //   CustomTableClumnHeader('Verify By'),
                //   CustomTableClumnHeader('Finalized By'),
                //   CustomTableClumnHeader('Is Cancel'),
                //   CustomTableClumnHeader('*',Alignment.center),
                //     ])
                //   ],)
                //Expanded(child: SingleChildScrollView(child: ,))
              ],
            ),
          )),
    );

Widget _filterPanel(LabReportLifeCycleController controller) => CustomGroupBox(
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
                          isShowCurrentDate: true,
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
                          isShowCurrentDate: true,
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
