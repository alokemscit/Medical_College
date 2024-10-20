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
                  padingvertical: 0,
                  groupHeaderText: "List",
                  child: Obx(() => Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Flexible(
                                  child: CustomTextBox(
                                      width: 350,
                                      caption: 'Search',
                                      controller: controller.txt_search,
                                      onChange: (v) {
                                        controller.search();
                                      })),
                              controller.isEditMode.value
                                  ? const SizedBox()
                                  : InkWell(
                                      onTap: () {
                                        controller.viewPrint();
                                      },
                                      child: const Padding(
                                        padding: EdgeInsets.only(
                                            left: 8, right: 8, bottom: 8),
                                        child: Icon(
                                          Icons.print,
                                          color: appColorBlue,
                                          size: 18,
                                        ),
                                      ),
                                    )
                            ],
                          ),
                          8.heightBox,
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
                              child: Stack(
                                children: [
                                  Table(
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
                                  
                                                CustomTableCellx(
                                                  text: controller
                                                      .list_final_list[i].hcn!,
                                                  isTextTuncate: true,
                                                  fontWeight: FontWeight.bold,
                                                  onTap: () {
                                                    controller.selectedConfigID
                                                            .value =
                                                        controller
                                                            .list_final_list[i]
                                                            .regid!;
                                                  },
                                                ),
                                                CustomTableCellx(
                                                  text: controller
                                                      .list_final_list[i].regid!,
                                                  isTextTuncate: true,
                                                  fontWeight: FontWeight.bold,
                                                  onTap: () {
                                                    controller.selectedConfigID
                                                            .value =
                                                        controller
                                                            .list_final_list[i]
                                                            .regid!;
                                                  },
                                                ),
                                                CustomTableCellx(
                                                  text: controller
                                                      .list_final_list[i].name!,
                                                  onTap: () {
                                                    controller.selectedConfigID
                                                            .value =
                                                        controller
                                                            .list_final_list[i]
                                                            .regid!;
                                                  },
                                                  isTextTuncate: true,
                                                ),
                                                CustomTableCellx(
                                                  text: controller
                                                      .list_final_list[i].bedno!,
                                                  onTap: () {
                                                    controller.selectedConfigID
                                                            .value =
                                                        controller
                                                            .list_final_list[i]
                                                            .regid!;
                                                  },
                                                  isTextTuncate: true,
                                                ),
                                                TableCell(
                                                    verticalAlignment:
                                                        TableCellVerticalAlignment
                                                            .fill,
                                                    child: CustomTextBox(
                                                        maxlength: 150,
                                                        isFilled: true,
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
                                                        controller: controller
                                                            .list_final_list[i]
                                                            .remarks!,
                                                        onChange: (v) {
                                                          controller.isEditMode
                                                              .value = true;
                                                          controller
                                                                  .selectedConfigID
                                                                  .value =
                                                              controller
                                                                  .list_final_list[
                                                                      i]
                                                                  .regid!;
                                                        })),
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
                                                        id: controller
                                                            .list_final_list[i]
                                                            .dietid,
                                                        list: _generateComboListDiet(
                                                            controller
                                                                .lis_diet_master,
                                                            10),
                                                        onTap: (v) {
                                                          controller.isEditMode
                                                              .value = true;
                                                          controller
                                                                  .selectedConfigID
                                                                  .value =
                                                              controller
                                                                  .list_final_list[
                                                                      i]
                                                                  .regid!;
                                  
                                                          controller.setDiet(
                                                              controller
                                                                  .list_final_list[i],
                                                              v);
                                                        })),
                                                for (var j = 0;
                                                    j <
                                                        controller
                                                            .list_final_list[i]
                                                            .menu
                                                            .length;
                                                    j++)
                                                  if (controller.list_final_list[i]
                                                          .menu[j].sl !=
                                                      null)
                                                    //'---- '+controller.list_final_list.first.menu![j].name!+' ----'
                                                    TableCell(
                                                        verticalAlignment:
                                                            TableCellVerticalAlignment
                                                                .fill,
                                                        child: controller.list_final_list[i].dietid ==
                                                                ''
                                                            ? const SizedBox()
                                                            : CustomDropDown(
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
                                                                id: controller
                                                                    .list_final_list[
                                                                        i]
                                                                    .menu[j]
                                                                    .val,
                                                                list: _menuListGenerate(
                                                                    controller,
                                                                    controller
                                                                        .list_final_list[i]
                                                                        .menu[j]
                                                                        .id!),
                                                                onTap: (v) {
                                                                  controller
                                                                      .isEditMode
                                                                      .value = true;
                                  
                                                                  controller
                                                                          .selectedConfigID
                                                                          .value =
                                                                      controller
                                                                          .list_final_list[
                                                                              i]
                                                                          .regid!;
                                  
                                                                  controller.updateMenuItem(
                                                                      controller
                                                                          .list_final_list[
                                                                              i]
                                                                          .regid!,
                                                                      controller
                                                                          .list_final_list[
                                                                              i]
                                                                          .menu[j]
                                                                          .sl!,
                                                                      v!);
                                                                }))
                                              ])
                                      ]),
                               
                               

                    controller.list_diet_approved_ns.where((e)=>e.nsId==controller.selectedNsID.value).isNotEmpty?
                       Positioned( top: 0 ,right: 0, left: 0,bottom: 0, child: Container(
                        color:Colors.black.withOpacity(0.05),
                        child: Center(child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Flexible(child: Icon(Icons.approval,color: Colors.red,size: 28,)),12.widthBox,
                            Flexible(child: Text('Approved',style: customTextStyle.copyWith(fontSize: 18,color: Colors.red),)),
                          ],
                        ),),
                       )):const SizedBox(),
                               
                                ],
                              ),
                            ),
                          ),
                          32.heightBox,
                        ],
                      ))),
              controller.list_final_list.isEmpty
                  ? const SizedBox()
                  : controller.list_diet_approved_ns.where((e)=>e.nsId==controller.selectedNsID.value).isNotEmpty?const SizedBox(): Positioned(
                      bottom: 4,
                      right: 10,
                      child: CustomButton(Icons.save, "Save", () {
                        controller.save();
                      }))
            ],
          ))
        ]);

_menuListGenerate(DietAssignController controller, String id) {
  List<DropdownMenuItem<String>> list = controller.list_meal_attributes
      .where((t) => t.mealTypeid == id)
      .map((f) => DropdownMenuItem<String>(
          value: f.id,
          child: Center(
              child: Text(
            f.name!,
            style: customTextStyle.copyWith(fontSize: 10.5),
          ))))
      .toList();

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
                            CustomDatePickerDropDown(
                              date_controller: controller.txt_date,
                              isBackDate: false,
                              isShowCurrentDate: true,
                              width: 120,
                              isFutureDateDisplay: true,
                              onDateChanged: (p0) {
                                //print(p0);
                                controller.loadPatient();
                              },
                            ),

                            // CustomDatePicker(
                            //     width: 130,
                            //     isBackDate: false,
                            //     isShowCurrentDate: true,
                            //     date_controller: controller.txt_date),

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

                            4.widthBox,
                            Expanded(
                                child: CustomDropDown(
                                    id: controller.selectedTimeID.value,
                                    list: _generateComboList(
                                        controller.list_time,
                                        10,
                                        FontWeight.bold),
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
                                        controller.lis_nurse_station,
                                        10,
                                        FontWeight.bold),
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

List<DropdownMenuItem<String>> _generateComboList(List<dynamic> list,
        [double fontSize = 13, FontWeight fontWeight = FontWeight.w500]) =>
    list
        .map((element) => DropdownMenuItem<String>(
            value: element.id,
            child: Text(
              element.name!,
              style: customTextStyle.copyWith(
                  fontSize: fontSize, fontWeight: FontWeight.w500),
            )))
        .toList();

List<DropdownMenuItem<String>> _generateComboListDiet(List<dynamic> list,
    [double fontSize = 13, FontWeight fontWeight = FontWeight.w500]) {
var x=  list
      .map((element) => DropdownMenuItem<String>(
          value: element.id,
          child: Text(
            element.name!,
            style: customTextStyle.copyWith(
                fontSize: fontSize, fontWeight: FontWeight.w500),
          )))
      .toList();
      x.insert(0,DropdownMenuItem<String>(
          value: '',
          child: Text(
           '',
            style: customTextStyle.copyWith(
                fontSize: fontSize, fontWeight: FontWeight.w500),
          )) );
  return x;
}
