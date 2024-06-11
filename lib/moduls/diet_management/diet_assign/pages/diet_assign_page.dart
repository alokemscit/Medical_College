import 'package:agmc/widget/custom_datepicker.dart';

import '../../../../core/config/const.dart';
import '../controller/diet_assign_controller.dart';

class DietAssign extends StatelessWidget {
  const DietAssign({super.key});
  void disposeController() {
    try {
      Get.delete<DietAssignController>();
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    final DietAssignController controller = Get.put(DietAssignController());
    controller.context = context;
    return Obx(() => CommonBody2(controller, _mainWidget(controller)));
  }
}

_mainWidget(DietAssignController controller) => CustomAccordionContainer(
        headerName: "Diet Assign",
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
                                          CustomTableClumnHeader("HCN"),
                                          CustomTableClumnHeader("Adm.No"),
                                          CustomTableClumnHeader("Name"),
                                          CustomTableClumnHeader("Bed No"),
                                          CustomTableClumnHeader("Remarks"),
                                          CustomTableClumnHeader("Diet"),
                                          for (var i = 0;
                                              i <
                                                  controller.list_final_list
                                                      .first.menu.length;
                                              i++)
                                            if (controller.list_final_list.first
                                                    .menu[i].sl !=
                                                null)
                                              CustomTableClumnHeader(
                                                  controller.list_final_list
                                                      .first.menu[i].name!,
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
                                                                  .regid
                                                          ? appColorPista
                                                          : Colors.white),
                                          children: [
                                            /*              hcn,reg,name,bed,rem,  */
                                            oneColumnCellBody(controller
                                                .list_final_list[i].hcn!),
                                            oneColumnCellBody(controller
                                                .list_final_list[i].regid!),
                                            GestureDetector(
                                              onTap: () => controller
                                                      .selectedConfigID.value =
                                                  controller.list_final_list[i]
                                                      .regid!,
                                              child: CustomTableCell(controller
                                                  .list_final_list[i].name!),
                                            ),
                                            oneColumnCellBody(controller
                                                .list_final_list[i].bedno!),
                                            TableCell(
                                                verticalAlignment:
                                                    TableCellVerticalAlignment
                                                        .fill,
                                                child: CustomTextBox(
                                                    fillColor: controller
                                                                  .selectedConfigID
                                                                  .value ==
                                                              controller
                                                                  .list_final_list[
                                                                      i]
                                                                  .regid
                                                          ? appColorPista
                                                          : Colors.white,
                                                    caption: "",
                                                    hintText: "Note",
                                                    controller:
                                                        TextEditingController(),
                                                    onChange: (v) {})),
                                            TableCell(
                                                verticalAlignment:
                                                    TableCellVerticalAlignment
                                                        .fill,
                                                child: CustomDropDown(
                                                  fillColor: controller
                                                                  .selectedConfigID
                                                                  .value ==
                                                              controller
                                                                  .list_final_list[
                                                                      i]
                                                                  .regid
                                                          ? appColorPista
                                                          : Colors.white,
                                                    id: controller.list_final_list[i].dietid,
                                                    list: _generateComboList(controller.lis_diet_master,10) ,
                                                    onTap: (v) {})),

                                            for (var j = 0;
                                                j <
                                                    controller.list_final_list
                                                        .first.menu.length;
                                                j++)
                                              if (controller.list_final_list
                                                      .first.menu[j].sl !=
                                                  null)
                                                //'---- '+controller.list_final_list.first.menu![j].name!+' ----'
                                                TableCell(
                                                    verticalAlignment:
                                                        TableCellVerticalAlignment
                                                            .fill,
                                                    child: CustomDropDown(
                                                        labeltext: '',
                                                        fillColor: controller
                                                                    .selectedConfigID
                                                                    .value ==
                                                                controller
                                                                    .list_final_list[
                                                                        i]
                                                                    .regid
                                                            ? appColorPista
                                                            : Colors.white,
                                                        id: '',
                                                        list:_menuListGenerate(controller,controller.list_final_list[i].menu[j].id!),
                                                        
                                                        //  controller
                                                        //     .list_meal_attributes
                                                        //     .where(
                                                        //         (t) => t.mealTypeid == controller.list_final_list[i].menu[j].id)
                                                        //     .map((f) => DropdownMenuItem<String>(value: f.id, child: Center(child: Text(f.name!))))
                                                        //     .toList(),


                                                        onTap: (v) {
                                                          // controller.updateMenuItem(
                                                          //     controller
                                                          //         .list_final_list[
                                                          //             i]
                                                          //         .regid!,
                                                          //     controller
                                                          //         .list_final_list[
                                                          //             i]
                                                          //         .menu![j]
                                                          //         .sl!,
                                                          //     v!);
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
                        //   controller.savePlan();
                      }))
            ],
          ))
        ]);

_menuListGenerate(DietAssignController controller, String id) {
  List<DropdownMenuItem<String>> list = controller.list_meal_attributes
      .where((t) => t.mealTypeid == id)
      .map((f) => DropdownMenuItem<String>(
          value: f.id, child: Center(child: Text(f.name!))))
      .toList();
  list.insertT(
      0,
      const DropdownMenuItem<String>(
        value: null,
        child: Text(''),
      ));
  return list;
}

_topPanel(DietAssignController controller) => Row(
      children: [
        Flexible(
          child: SizedBox(
              width: 450,
              child: CustomGroupBox(
                  groupHeaderText: "Attributes",
                  child: Padding(
                    padding:
                        const EdgeInsets.only(bottom: 4, left: 4, right: 4),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            CustomDatePicker(
                                width: 130,
                                isBackDate: false,
                                isShowCurrentDate: true,
                                date_controller: controller.txt_date),

                            4.widthBox,
                            Expanded(
                                child: CustomDropDown(
                                    id: controller.selectedDiettypeID.value,
                                    list: _generateComboList(
                                        controller.list_diet_type),
                                    onTap: (v) {
                                      controller.selectedDiettypeID.value = v!;
                                      controller.loadPatient();
                                      //controller.loadData();
                                    })),
                            // 4.widthBox,
                            // Expanded(
                            //   child: CustomDropDown(
                            //       id: controller.selectedWeekID.value,
                            //       list: _generateComboList(controller.list_week),
                            //       onTap: (v) {
                            //         controller.selectedWeekID.value = v!;
                            //        // controller.loadData();
                            //       }),
                            // ),
                            4.widthBox,
                            Expanded(
                                child: CustomDropDown(
                                    id: controller.selectedTimeID.value,
                                    list: _generateComboList(
                                        controller.list_time),
                                    onTap: (v) {
                                      controller.selectedTimeID.value = v!;
                                      controller.loadPatient();
                                    })),

                            36.widthBox,
                          ],
                        ),
                        4.heightBox,
                        Row(
                          children: [
                            Expanded(
                                child: CustomDropDown(
                                    id: controller.selectedNsID.value,
                                    list: _generateComboList(
                                        controller.lis_nurse_station),
                                    onTap: (v) {
                                      controller.selectedNsID.value = v!;
                                      controller.loadPatient();
                                    })),
                            4.widthBox,
                            InkWell(
                                onTap: () {
                                  controller.loadPatient();
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  child: const Icon(
                                    Icons.sync,
                                    color: appColorLogoDeep,
                                  ),
                                ))
                          ],
                        )
                      ],
                    ),
                  ))),
        )
      ],
    );

List<DropdownMenuItem<String>> _generateComboList(List<dynamic> list,[double fontSize=13]) => list
    .map((element) => DropdownMenuItem<String>(
        value: element.id,
        child: Text(
          element.name!,
          style: customTextStyle.copyWith(
              fontSize: fontSize, fontWeight: FontWeight.w500),
        )))
    .toList();
