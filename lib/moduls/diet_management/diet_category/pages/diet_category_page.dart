import '../../../../core/config/const.dart';
import '../controller/diet_category_controller.dart';

class DietCategory extends StatelessWidget {
  const DietCategory({super.key});
  void disposeController() {
    try {
      Get.delete<DietCategoryController>();
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    final DietCategoryController controller = Get.put(DietCategoryController());
    controller.context = context;
    return Obx(() => CommonBody2(controller, _mainWidget(controller)));
  }
}

_mainWidget(DietCategoryController controller) => CustomAccordionContainer(
        isExpansion: false,
        headerName: "Diet Category",
        height: 0,
        bgColor: appGray100,
        children: [
          Expanded(
            child: controller.context.width > 1150
                ? _desktop(controller)
                : _mobile(controller),
          )
        ]);

_mobile(DietCategoryController controller) => Column(
      children: [
        _dietType(controller,2),
        8.heightBox,
        _dietCategory(controller),
      ],
    );

_desktop(DietCategoryController controller) => Row(
      children: [
        _dietType(controller, 3),
        8.widthBox,
        _dietCategory(controller, 6),
      ],
    );

_typeEntryPart(DietCategoryController controller) => CustomGroupBox(
    groupHeaderText: "Diet Type Entry",
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                  child: CustomTextBox(
                      caption: "Name",
                      controller: controller.txt_name,
                      onChange: (v) {})),
              8.widthBox,
              CustomButton(
                  Icons.save,
                  controller.editDietTypeID.value == '' ? "Save" : 'Update',
                  () {}),
              controller.editDietTypeID.value == ''
                  ? const SizedBox()
                  : Row(
                      children: [
                        8.widthBox,
                        InkWell(
                          onTap: () {
                            controller.editDietTypeID.value = '';
                            controller.txt_name.text = '';
                           
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Icon(Icons.undo),
                          ),
                        )
                      ],
                    )
            ],
          ),
          8.heightBox,
        ],
      ),
    ));

_typeTablePart(DietCategoryController controller) => Expanded(
      child: CustomGroupBox(
          groupHeaderText: "Diet Type List",
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Table(
                  border: CustomTableBorderNew,
                  columnWidths: customColumnWidthGenarator(_col1),
                  children: [
                    TableRow(
                        decoration: CustomTableHeaderRowDecorationnew,
                        children: [
                          CustomTableClumnHeader("ID", Alignment.center),
                          CustomTableClumnHeader(
                            "Name",
                            Alignment.center,
                          ),
                          // CustomTableClumnHeader(
                          //   "Edit",
                          //   Alignment.center,
                          // ),
                          CustomTableClumnHeader(
                            "Set",
                            Alignment.center,
                          ),
                        ])
                  ],
                ),
                Expanded(
                  child: ListView(
                    children: [
                      Obx(() => Table(
                            columnWidths: customColumnWidthGenarator(_col1),
                            border: CustomTableBorderNew,
                            children: controller.lis_diet_type_temp
                                .map((element) => TableRow(
                                        decoration: BoxDecoration(
                                            color: controller.editDietTypeID
                                                            .value ==
                                                        element.id ||
                                                    controller
                                                            .selectedID.value ==
                                                        element.id
                                                ? appColorPista.withOpacity(0.5)
                                                : Colors.white),
                                        children: [
                                          oneColumnCellBody(element.id!, 12,
                                              Alignment.center),
                                          oneColumnCellBody(element.name!, 12,
                                              Alignment.centerLeft),
                                          // CustomTableEditCell(() {
                                          //   controller.editDietTypeID.value =
                                          //       element.id!;
                                          //   controller.txt_name.text =
                                          //       element.name!;
                                          // }, Icons.edit),
                                          CustomTableEditCell(() {
                                            controller.selectedID.value =
                                                element.id!;
                                            controller.selectedName.value =
                                                element.name!;
                                            controller.loadDietMaster();
                                          }, Icons.approval),
                                        ]))
                                .toList(),
                          ))
                    ],
                  ),
                )
              ],
            ),
          )),
    );

_dietType(DietCategoryController controller, [int flex = 3]) => Expanded(
    flex: flex,
    child: CustomGroupBox(
        bgColor: appGray100,
        groupHeaderText: "",
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
             /// _typeEntryPart(controller),
           //   8.heightBox,
              _typeTablePart(controller),
            ],
          ),
        )));

List<int> _col2 = [20, 30, 150, 20];
List<int> _col1 = [30, 150,  30];
_dietCategory(DietCategoryController controller, [int flex = 5]) => Expanded(
    flex: flex,
    child: controller.selectedID.value == ''
        ? const SizedBox()
        : CustomGroupBox(
            bgColor: appGray100,
            groupHeaderText: "",
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                children: [
                  Column(
                    children: [
                      _categoryEntryPart(controller),
                      8.heightBox,
                      Expanded(
                        child: _categoryTablePart(controller),
                      )
                    ],
                  ),
                  Positioned(
                      top: 0,
                      right: 0,
                      child: RoundedButton(() {
                        controller.selectedID.value = '';
                        controller.selectedName.value = '';
                      }, Icons.close, 14, Colors.black))
                ],
              ),
            )));

_categoryTablePart(DietCategoryController controller) => CustomGroupBox(
    groupHeaderText: "Diet Category List",
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                  flex: controller.context.width > 1150 ? 5 : 0,
                  child: const SizedBox()),
              Expanded(
                  flex: 4,
                  child: CustomSearchBox(
                      caption: "Search",
                      controller: TextEditingController(),
                      onChange: (v) {})),
            ],
          ),
          8.heightBox,
          Table(
            border: CustomTableBorderNew,
            columnWidths: customColumnWidthGenarator(_col2),
            children: [
              TableRow(
                  decoration: CustomTableHeaderRowDecorationnew,
                  children: [
                    CustomTableClumnHeader("ID", Alignment.center),
                    CustomTableClumnHeader("Type"),
                    CustomTableClumnHeader("Name"),
                    CustomTableClumnHeader("*", Alignment.center),
                  ])
            ],
          ),
          Expanded(
            child: ListView(
              children: [
                Obx(() => Table(
                    columnWidths: customColumnWidthGenarator(_col2),
                    border: CustomTableBorderNew,
                    children: controller.lis_diet_master_temp
                        .map((element) => TableRow(
                                decoration: BoxDecoration(
                                    color: controller.editDietID.value ==
                                            element.id
                                        ? appColorPista.withOpacity(0.3)
                                        : Colors.white),
                                children: [
                                  oneColumnCellBody(
                                      element.id!, 12, Alignment.center),
                                  oneColumnCellBody(element.typeName!),
                                  oneColumnCellBody(element.name!),
                                  CustomTableEditCell(() {
                                    controller.editDietID.value = element.id!;
                                    controller.txt_cat_name.text =
                                        element.name!;
                                  }),
                                ]))
                        .toList())),
              ],
            ),
          )
        ],
      ),
    ));
_categoryEntryPart(DietCategoryController controller) => CustomGroupBox(
    groupHeaderText: "Diet Category Entry",
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              const CustomTextHeader(text: "ID        :"),
              6.widthBox,
              Flexible(
                  child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                color: Colors.white,
                child: CustomTextHeader(
                  textSize: 15,
                  text: controller.selectedID.value,
                  textColor: Colors.black,
                ),
              )),
            ],
          ),
          6.heightBox,
          Row(
            children: [
              const CustomTextHeader(text: "Name :"),
              6.widthBox,
              Flexible(
                  child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                color: Colors.white,
                child: CustomTextHeader(
                  textSize: 15,
                  text: controller.selectedName.value,
                  textColor: Colors.black,
                ),
              )),
            ],
          ),
          2.heightBox,
          const Divider(
            color: appColorGrayDark,
            thickness: 0.1,
          ),
          8.heightBox,
          Row(
            children: [
              Expanded(
                flex: 5,
                child: Row(
                  children: [
                    Expanded(
                        child: CustomTextBox(
                        //  labelTextColor: appColorGrayDark,
                         // fontColor: Colors.black,
                            caption: "Diet Category Name",
                            controller: controller.txt_cat_name,
                            onChange: (v) {})),
                    8.widthBox,
                    CustomButton(Icons.save, "Save", () {
                      controller.saveCategory();
                    }),
                    controller.editDietID.value == ''
                        ? const SizedBox()
                        : Row(
                            children: [
                              8.widthBox,
                              InkWell(
                                onTap: () {
                                  controller.editDietID.value = '';
                                  controller.txt_cat_name.text = '';
                                },
                                child: const Padding(
                                  padding: EdgeInsets.all(4.0),
                                  child: Icon(Icons.undo),
                                ),
                              )
                            ],
                          )
                  ],
                ),
              ),
              Expanded(
                  flex: controller.context.width > 1150 ? 3 : 0,
                  child: const SizedBox())
            ],
          ),
          8.heightBox,
        ],
      ),
    ));
