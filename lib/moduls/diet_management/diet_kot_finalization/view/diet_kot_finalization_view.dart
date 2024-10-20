import '../../../../core/config/const.dart';
import '../../../../widget/custom_datepicker.dart';
import '../controller/diet_kot_finalization_controller.dart';

class DietKotFinalization extends StatelessWidget {
  const DietKotFinalization({super.key});
  void disposeController() {
    try {
      mdisposeController<DietKotFinalizationController>();
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    final DietKotFinalizationController c =
        Get.put(DietKotFinalizationController());
    c.context = context;

    return Obx(() => CommonBodyWithToolBar(c, [_bodyPart(c)], (v) {}));
  }
}

_bodyPart(DietKotFinalizationController c) => Expanded(
      child: CustomGroupBox(
          child: Column(
        children: [
          _topPanel(c),
          _tablePart(c),
        ],
      )),
    );

_tablePart(DietKotFinalizationController controller) => Expanded(
    child: CustomGroupBox(
        padingvertical: 0,
        groupHeaderText: "List",
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ...controller.list_diet_approved_ns
                              .map(
                                  (f) =>
                                      controller.list_menu_sort
                                              .where((e) => e.nsid == f.nsId)
                                              .isEmpty
                                          ? const SizedBox()
                                          : Wrap(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 8),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      CustomTextHeader(
                                                        text: f.nsName ?? '',
                                                        textSize: 14,
                                                      ),
                                                      SizedBox(
                                                        width: 400,
                                                        child: CustomTableGenerator(
                                                            isBodyScrollable:
                                                                false,
                                                            colWidtList: const [
                                                              30,
                                                              50
                                                            ],
                                                            childrenHeader: [
                                                              CustomTableCellx(
                                                                  text: "Menu"),
                                                              CustomTableCellx(
                                                                  text:
                                                                      "Particulars"),
                                                            ],
                                                            childrenTableRowList: [
                                                              ...controller
                                                                  .list_menu_sort
                                                                  .where((e) =>
                                                                      e.nsid ==
                                                                      f.nsId)
                                                                  .map((a) =>
                                                                      TableRow(
                                                                          decoration:
                                                                              const BoxDecoration(color: Colors.white),
                                                                          children: [
                                                                            //CustomTableCellx(text: a.menuName??''),
                                                                            TableCell(
                                                                                verticalAlignment: TableCellVerticalAlignment.middle,
                                                                                // verticalAlignment:TableCellVerticalAlignment.fill,
                                                                                child: Padding(
                                                                                  padding: const EdgeInsets.symmetric(horizontal: 8),
                                                                                  child: Text(
                                                                                    a.menuName ?? '',
                                                                                    style: customTextStyle.copyWith(fontSize: 13, fontWeight: FontWeight.bold),
                                                                                  ),
                                                                                )),
                                                                            TableCell(
                                                                                // verticalAlignment:TableCellVerticalAlignment.fill,
                                                                                child: CustomTableGenerator(isBodyScrollable: false, colWidtList: const [
                                                                              30,
                                                                              10
                                                                            ], childrenHeader: const [], childrenTableRowList: [
                                                                              ...controller.list_diet_summ.where((e1) => e1.nsId == a.nsid && e1.menuId == a.menuId).map((x) => TableRow(
                                                                                decoration: const BoxDecoration(color:    Colors.white),
                                                                                children: [
                                                                                    CustomTableCellx(text: x.itemName ?? ''),
                                                                                    CustomTableCellx(
                                                                                      text: (x.cnt ?? 0.0).toString(),
                                                                                      alignment: Alignment.center,
                                                                                    ),
                                                                                  ]))
                                                                            ]))
                                                                          ]))
                                                            ]),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            )),
                        ],
                      ),
                    ),
                    8.heightBox,
                  ],
                ),
              ),
            ),
          ],
        )));

_topPanel(DietKotFinalizationController c) => Row(
      children: [
        Flexible(
          child: SizedBox(
              width: 450,
              child: CustomGroupBox(
                  borderRadius: 4,
                  groupHeaderText: "Filter",
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            CustomDatePickerDropDown(
                              date_controller: c.txt_date,
                              isBackDate: false,
                              isShowCurrentDate: true,
                              width: 120,
                              isFutureDateDisplay: true,
                              onDateChanged: (p0) {
                                //print(p0);
                                c.loadData();
                              },
                            ),
                            4.widthBox,
                            Expanded(
                                child: CustomDropDown2(
                                    id: c.selectedDiettypeID.value,
                                    list: c.list_diet_type,
                                    onTap: (v) {
                                      c.selectedDiettypeID.value = v!;
                                      c.loadData();
                                    })),
                            4.widthBox,
                            Expanded(
                                child: CustomDropDown2(
                                    id: c.selectedTimeID.value,
                                    list: c.list_time,
                                    onTap: (v) {
                                      c.selectedTimeID.value = v!;
                                      c.loadData();
                                    })),
                          ],
                        ),
                        4.heightBox,
                      ],
                    ),
                  ))),
        )
      ],
    );
