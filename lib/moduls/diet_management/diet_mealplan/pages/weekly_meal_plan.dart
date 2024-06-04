import 'package:agmc/moduls/diet_management/diet_mealplan/controller/weekly_meal_plan_controller.dart';

import '../../../../core/config/const.dart';

class WeeklyMealPlan extends StatelessWidget {
  const WeeklyMealPlan({super.key});
  void disposeController() {
    try {
      Get.delete<WeeklyMealPlanController>();
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    final WeeklyMealPlanController controller =
        Get.put(WeeklyMealPlanController());
    controller.context = context;
    // print(context.width);
    return Obx(() => CommonBody2(controller, _mainWidget(controller)));
  }
}

_mainWidget(WeeklyMealPlanController controller) => CustomAccordionContainer(
        bgColor: appGray100,
        headerName: "Weekly Meal Plan",
        height: 0,
        isExpansion: false,
        children: [
          _topPanel(controller),
          Expanded(
              child: Stack(
            children: [
              CustomGroupBox(
                  groupHeaderText: "List",
                  child: Obx(() => Column(
                        children: [
                          controller.list_final_list.isEmpty
                              ? const SizedBox()
                              : Table(
                                  border: CustomTableBorderNew,
                                  columnWidths: customColumnWidthGenarator(
                                      controller.col),
                                  children: [
                                    TableRow(
                                        decoration:
                                            CustomTableHeaderRowDecorationnew,
                                        children: [
                                          CustomTableClumnHeader("id"),
                                          CustomTableClumnHeader("Name"),
                                          for (var i = 0;
                                              i <
                                                  controller.list_final_list
                                                      .first.menu!.length;
                                              i++)
                                            if (controller.list_final_list.first
                                                    .menu![i].sl !=
                                                null)
                                              CustomTableClumnHeader(
                                                  controller.list_final_list
                                                      .first.menu![i].name!,
                                                  Alignment.center),
                                        ]),
                                  ],
                                ),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Table(
                                  border: CustomTableBorderNew,
                                  columnWidths: customColumnWidthGenarator(
                                      controller.col),
                                  children: [
                                    for (var i = 0;
                                        i < controller.list_final_list.length;
                                        i++)
                                      TableRow(
                                          // key: ValueKey(controller.list_final_list[i].id),

                                          decoration:
                                              CustomTableHeaderRowDecorationnew
                                                  .copyWith(
                                                      color: controller
                                                                  .selectedConfigID
                                                                  .value ==
                                                              controller
                                                                  .list_final_list[
                                                                      i]
                                                                  .id
                                                          ? appColorPista
                                                          : Colors.white),
                                          children: [
                                            // CustomTableClumnHeader("id"),
                                            // CustomTableClumnHeader("Name"),

                                            // if(controller.list_final_list.first.menu![i].sl !=null )
                                            oneColumnCellBody(controller
                                                .list_final_list[i].id!),
                                            // CustomTableCell2(controller.list_final_list[i].id! ),
                                            GestureDetector(
                                              onTap: () => controller
                                                      .selectedConfigID.value =
                                                  controller
                                                      .list_final_list[i].id!,
                                              child: CustomTableCell(controller
                                                  .list_final_list[i].name!),
                                            ),

                                            for (var j = 0;
                                                j <
                                                    controller.list_final_list
                                                        .first.menu!.length;
                                                j++)
                                              if (controller.list_final_list
                                                      .first.menu![j].sl !=
                                                  null)
                                                //'---- '+controller.list_final_list.first.menu![j].name!+' ----'
                                                TableCell(
                                                    verticalAlignment:
                                                        TableCellVerticalAlignment
                                                            .fill,
                                                    child: CustomDropDown(
                                                        labeltext: '',
                                                        fillColor:
                                                            controller.selectedConfigID.value == controller.list_final_list[i].id
                                                                ? appColorPista
                                                                : Colors.white,
                                                        id: '',
                                                        list: controller
                                                            .list_meal_attributes
                                                            .where((t) =>
                                                                t.mealTypeid ==
                                                                controller
                                                                    .list_final_list[i]
                                                                    .menu![j]
                                                                    .id)
                                                            .map((f) => DropdownMenuItem<String>(value: f.id, child: Center(child: Text(f.name!))))
                                                            .toList(),
                                                        onTap: (v) {
                                                          controller.updateMenuItem(
                                                              controller
                                                                  .list_final_list[
                                                                      i]
                                                                  .id!,
                                                              controller
                                                                  .list_final_list[
                                                                      i]
                                                                  .menu![j]
                                                                  .sl!,
                                                              v!);

                                                          // controller
                                                          //     .list_final_list[
                                                          //         i]
                                                          //     .menu![j]
                                                          //     .val = v;

                                                          // controller
                                                          //     .list_final_list
                                                          //     .refresh();
                                                          // controller
                                                          //     .list_final_list
                                                          //     .first
                                                          //     .menu![j]
                                                          //     .val = v!;
                                                        }))
                                          ])
                                  ]),
                            ),
                          )
                        ],
                      ))),
              controller.list_final_list.isEmpty
                  ? const SizedBox()
                  : Positioned(
                      bottom: 10,
                      right: 10,
                      child: CustomButton(Icons.save, "Save", () {
                        controller.savePlan();
                      }))
            ],
          ))
        ]);

_topPanel(WeeklyMealPlanController controller) => Row(
      children: [
        Flexible(
          child: SizedBox(
              width: 450,
              child: CustomGroupBox(
                  groupHeaderText: "Attributes",
                  child: Padding(
                    padding:
                        const EdgeInsets.only(bottom: 4, left: 4, right: 4),
                    child: Row(
                      children: [
                        Expanded(
                            child: CustomDropDown(
                                id: controller.selectedDiettypeID.value,
                                list: _generateComboList(
                                    controller.list_diet_type),
                                onTap: (v) {
                                  controller.selectedDiettypeID.value = v!;
                                  controller.loadData();
                                })),
                        4.widthBox,
                        Expanded(
                          child: CustomDropDown(
                              id: controller.selectedWeekID.value,
                              list: _generateComboList(controller.list_week),
                              onTap: (v) {
                                controller.selectedWeekID.value = v!;
                                controller.loadData();
                              }),
                        ),
                        4.widthBox,
                        Expanded(
                            child: CustomDropDown(
                                id: controller.selectedTimeID.value,
                                list: _generateComboList(controller.list_time),
                                onTap: (v) {
                                  controller.selectedTimeID.value = v!;
                                  controller.loadData();
                                })),
                        4.widthBox,
                        InkWell(
                            onTap: () {
                              controller.loadData();
                            },
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              child: const Icon(
                                Icons.sync,
                                color: appColorLogoDeep,
                              ),
                            ))
                      ],
                    ),
                  ))),
        )
      ],
    );

List<DropdownMenuItem<String>> _generateComboList(List<dynamic> list) => list
    .map((element) => DropdownMenuItem<String>(
        value: element.id,
        child: Text(
          element.name!,
          style: customTextStyle.copyWith(
              fontSize: 13, fontWeight: FontWeight.w500),
        )))
    .toList();
