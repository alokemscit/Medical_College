import '../../../../core/config/const.dart';
import '../controller/diet_menu_config_controller.dart';

class DietMenuConfig extends StatelessWidget {
  const DietMenuConfig({super.key});
  void disposeController() {
    try {
      Get.delete<DietMenuConfigController>();
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    final DietMenuConfigController controller =
        Get.put(DietMenuConfigController());
    controller.context = context;
    return Obx(() => CommonBody2(controller, _maibWindow(controller)));
  }
}

_maibWindow(DietMenuConfigController controller) => CustomAccordionContainer(
        headerName: "Configuration",
        bgColor:appGray100,
        height: 0,
        isExpansion: false,
        children: [
          controller.context.width > 1150
              ? Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: _leftPanel(controller),
                      ),
                      8.widthBox,
                      Expanded(flex: 6, child: _rightPanel(controller)),
                    ],
                  ),
                )
              : Expanded(
                  child: Column(
                    children: [
                      Expanded(flex: 4, child: _leftPanel(controller)),
                      8.heightBox,
                      Expanded(flex: 6, child: _rightPanel(controller)),
                    ],
                  ),
                )
        ]);

_leftPanel(DietMenuConfigController controller) => CustomGroupBox(
    groupHeaderText: "",
    bgColor: appGray100,
    child: Column(
      children: [
        Row(
          children: [
            Expanded(
              child: CustomGroupBox(
                  groupHeaderText: "Attributes",
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                              flex: 5,
                              child: CustomDropDown(
                                  id: controller.cmb_diet_type.value,
                                  list: controller.list_diet_type
                                      .map((e) => DropdownMenuItem<String>(
                                          value: e.id,
                                          child: Text(
                                            e.name!,
                                            style: customTextStyle.copyWith(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w600),
                                          )))
                                      .toList(),
                                  onTap: (v) {
                                    controller.cmb_diet_type.value = v!;
                                    controller.setTimeSlot();
                                  })),
                          const Expanded(flex: 4, child: SizedBox())
                        ],
                      ),
                    ],
                  )),
            ),
          ],
        ),
        8.heightBox,
        Expanded(
            child: CustomGroupBox(
                groupHeaderText: "Diet Time",
                child: Column(
                  children: [
                    Table(
                      columnWidths: customColumnWidthGenarator(_col),
                      border: CustomTableBorderNew,
                      children: [
                        TableRow(
                            decoration: CustomTableHeaderRowDecorationnew,
                            children: [
                              CustomTableClumnHeader("Id"),
                              CustomTableClumnHeader("Name"),
                              CustomTableClumnHeader("*", Alignment.center),
                            ])
                      ],
                    ),
                    Expanded(
                        child: SingleChildScrollView(
                      child: Table(
                        border: CustomTableBorderNew,
                        columnWidths: customColumnWidthGenarator(_col),
                        children: controller.list_time
                            .map((element) => TableRow(
                                    decoration: BoxDecoration(
                                        color: controller.selected_dietTypeID
                                                    .value ==
                                                element.id
                                            ? appColorPista.withOpacity(0.5)
                                            : Colors.white),
                                    children: [
                                      CustomTableColumnCellBody(
                                          element.id!, 12, Alignment.center),
                                      CustomTableColumnCellBody(element.name!,
                                          12, Alignment.centerLeft),
                                      CustomTableEditCell(() {
                                        controller.selected_dietTypeID.value =
                                            element.id!;
                                        controller.selected_dietTypeName.value =
                                            element.name!;
                                        controller.loadMealType();
                                      }, Icons.edit)
                                    ]))
                            .toList(),
                      ),
                    ))
                  ],
                )))
      ],
    ));

List<int> _col = [30, 150, 25];
_rightPanel(DietMenuConfigController controller) => Stack(
      children: [
        controller.selected_dietTypeID.value == ''
            ? const SizedBox()
            : CustomGroupBox(
              bgColor: appGray100,
                groupHeaderText: "",
                child: Column(
                  children: [
                    CustomGroupBox(
                        groupHeaderText: "Selected Time",
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const CustomTextHeader(text: "ID        :"),
                                8.widthBox,
                                Container(
                                    padding: const EdgeInsets.all(4),
                                    color: appColorPista,
                                    child: CustomTextHeader(
                                        text: controller
                                            .selected_dietTypeID.value))
                              ],
                            ),
                            8.heightBox,
                            Row(
                              children: [
                                const CustomTextHeader(text: "Name :"),
                                8.widthBox,
                                Container(
                                    padding: const EdgeInsets.all(4),
                                    color: appColorPista,
                                    child: CustomTextHeader(
                                        text: controller
                                            .selected_dietTypeName.value))
                              ],
                            ),
                          ],
                        )),
                    8.heightBox,
                    Expanded(
                      child: CustomGroupBox(
                          groupHeaderText: "Menu Item List",
                          child: Column(
                            children: [
                              Table(
                                columnWidths: customColumnWidthGenarator(_col2),
                                border: CustomTableBorderNew,
                                children: [
                                  TableRow(
                                      decoration:
                                          CustomTableHeaderRowDecorationnew,
                                      children: [
                                         CustomTableClumnHeader(
                                            "#", Alignment.center),
                                        CustomTableClumnHeader(
                                            "^", Alignment.center),
                                        CustomTableClumnHeader(
                                            "*", Alignment.center),
                                        CustomTableClumnHeader(
                                            "ID", Alignment.center),
                                        CustomTableClumnHeader("Name"),
                                      ])
                                ],
                              ),
                              Expanded(
                                  child: SingleChildScrollView(
                                child: Table(
                                  columnWidths:
                                      customColumnWidthGenarator(_col2),
                                  border: CustomTableBorderNew,
                                  children: controller.list_menu
                                      .map((e) => TableRow(
                                              decoration: const BoxDecoration(
                                                  color: Colors.white),
                                              children: [
 TableCell(
   verticalAlignment:TableCellVerticalAlignment.middle,
   child: Center(child: Text((controller.list_menu.indexOf(e)+1).toString(),style: customTextStyle.copyWith(fontSize: 13,fontWeight: FontWeight.bold),),),
 ),


                                                TableCell(
                                                    verticalAlignment:
                                                        TableCellVerticalAlignment
                                                            .middle,
                                                    child: controller.list_menu
                                                                .indexOf(e) ==
                                                            0
                                                        ? const SizedBox()
                                                        : Center(
                                                            child: InkWell(
                                                              onTap: () {
                                                                controller
                                                                    .inedxChange(
                                                                        e);
                                                              },
                                                              child: Container(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(6),
                                                                child:
                                                                    const Icon(
                                                                  Icons
                                                                      .arrow_upward_sharp,
                                                                  size: 22,
                                                                  color:
                                                                      appColorBlue,
                                                                ),
                                                              ),
                                                            ),
                                                          )),
                                                TableCell(
                                                    verticalAlignment:
                                                        TableCellVerticalAlignment
                                                            .middle,
                                                    child: Checkbox(
                                                        value: e.val,
                                                        onChanged: (v) {
                                                          controller.updateList(
                                                              e.id!, v!);
                                                        })),
                                                TableCell(
                                                    verticalAlignment:
                                                        TableCellVerticalAlignment
                                                            .middle,
                                                    child: Center(
                                                      child: Text(e.id!),
                                                    )),
                                                TableCell(
                                                    verticalAlignment:
                                                        TableCellVerticalAlignment
                                                            .middle,
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 8),
                                                      child: Text(e.name!),
                                                    )),
                                              ]))
                                      .toList(),
                                ),
                              ))
                            ],
                          )),
                    )
                  ],
                )),
        Positioned(
            right: 0,
            top: 0,
            child: RoundedButton(() {
              controller.selected_dietTypeID.value = '';
              controller.selected_dietTypeName.value = '';
            }, Icons.close, 14, Colors.black)),
        controller.list_menu.where((e) => e.val == true).isEmpty
            ? const SizedBox()
            : Positioned(
                bottom: 20,
                right: 20,
                child: CustomButton(Icons.save, "Save", () {
                  controller.Saveupdate();
                }))
      ],
    );

List<int> _col2 = [
  10,
  20,
  20,
  20,
  180,
];
