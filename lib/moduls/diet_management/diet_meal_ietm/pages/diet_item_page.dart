import '../../../../core/config/const.dart';
import '../controller/diet_item_controller.dart';

class DietItems extends StatelessWidget {
  const DietItems({super.key});
  void disposeController() {
    try {
      Get.delete<DietItemsController>();
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    final DietItemsController controller = Get.put(DietItemsController());
    controller.context = context;
    return Obx(() => CommonBody2(controller, _mainWidget(controller)));
  }
}

_mainWidget(DietItemsController controller) => CustomAccordionContainer(
        isExpansion: false,
        headerName: "Item Mater",
        height: 0,
        bgColor: appGray100,
        children: [
          Expanded(
            child: controller.context.width > 1150
                ? _desktop(controller)
                : _mobile(controller),
          )
        ]);

_mobile(DietItemsController controller) => Column(
      children: [
        _mealItemType(controller),
        8.heightBox,
        _mealItem(controller),
      ],
    );

_desktop(DietItemsController controller) => Row(
      children: [
        _mealItemType(controller, 3),
        8.widthBox,
        _mealItem(controller, 5),
      ],
    );

_dietCategory(DietItemsController controller) => CustomGroupBox(
    groupHeaderText: "Diet Category",
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 4,
                child: CustomDropDown(
                  id: controller.selectedDietCategoryID.value,
                  list: controller.list_diet_category
                      .map((element) => DropdownMenuItem<String>(
                          value: element.id, child: Text(element.name!)))
                      .toList(),
                  onTap: (v) {
                    controller.selectedDietCategoryID.value = v!;
                    controller.loadMealType();
                  },
                ),
              ),
              //8.widthBox,
              // RoundedButton(() {}, Icons.search),
              Expanded(
                  flex: controller.context.width > 1050 ? 5 : 0,
                  child: const SizedBox())
            ],
          ),
          12.heightBox,
          Row(
            children: [
              Expanded(
                  child: CustomTextBox(
                      maxlength: 50,
                      caption: "Meal Type Name",
                      controller: controller.txt_mmeal_type,
                      onChange: (v) {})),
              8.widthBox,
              CustomButton(Icons.save,
                  controller.editMeaalTypeID.value == '' ? "Save" : "Update",
                  () {
                controller.saveUpdateMealType();
              }),
              8.widthBox,
              controller.editMeaalTypeID.value == ''
                  ? const SizedBox()
                  : RoundedButton(
                      () {
                        controller.editMeaalTypeID.value = '';
                        controller.txt_mmeal_type.text = '';
                      },
                      Icons.undo,
                      18,
                    )
            ],
          ),
          8.heightBox,
        ],
      ),
    ));

_mealTypeTableList(DietItemsController controller) => Expanded(
      child: CustomGroupBox(
          groupHeaderText: "Meal Type List",
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: controller.context.width > 1150 ? 4 : 0,
                      child: const SizedBox(),
                    ),
                    Expanded(
                        flex: 5,
                        child: CustomSearchBox(
                            caption: "Search",
                            controller: controller.txt_mmeal_type_search,
                            onChange: (v) {
                              controller.mealtypeSearch();
                            }))
                  ],
                ),
                8.heightBox,
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
                            Alignment.centerLeft,
                          ),
                          CustomTableClumnHeader(
                            "Edit",
                            Alignment.center,
                          ),
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
                      Table(
                        columnWidths: customColumnWidthGenarator(_col1),
                        border: CustomTableBorderNew,
                        children: controller.list_meale_type_temp
                            .map((element) => TableRow(
                                    decoration: BoxDecoration(
                                      color:
                                          (controller.editMeaalTypeID.value ==
                                                      element.id ||
                                                  controller.selectedDMealTypeID
                                                          .value ==
                                                      element.id)
                                              ? appColorPista.withOpacity(0.3)
                                              : Colors.white,
                                      //  border: Border(left: BorderSide(color: appColorGrayDark,),right:  BorderSide(color: appColorGrayDark))
                                    ),
                                    children: [
                                      oneColumnCellBody(
                                          element.id!, 12, Alignment.center),
                                      oneColumnCellBody(element.name!, 12,
                                          Alignment.centerLeft),
                                      CustomTableEditCell(() {
                                        controller.editMeaalTypeID.value =
                                            element.id!;
                                        controller.txt_mmeal_type.text =
                                            element.name!;
                                        controller.editItemId.value = '';
                                      }),
                                      CustomTableEditCell(() {
                                        controller.selectedDMealTypeID.value =
                                            element.id!;
                                        controller.selectedDMealTypeName.value =
                                            element.name!;
                                        controller.loadMealItem();
                                      }, Icons.link),
                                    ]))
                            .toList(),
                      )
                    ],
                  ),
                )
              ],
            ),
          )),
    );

_mealItemType(DietItemsController controller, [int flex = 4]) => Expanded(
    flex: flex,
    child: CustomGroupBox(
        bgColor: appGray100,
        groupHeaderText: "",
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              _dietCategory(controller),
              8.heightBox,
              _mealTypeTableList(controller),
            ],
          ),
        )));

List<int> _col2 = [30, 80, 150, 30];
List<int> _col1 = [30, 150, 30, 30];
_mealItem(DietItemsController controller, [int flex = 5]) => Expanded(
    flex: flex,
    child: controller.selectedDMealTypeID.value == ''
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
                        controller.selectedDMealTypeID.value = '';
                      }, Icons.close, 14, Colors.black))
                ],
              ),
            )));

_categoryTablePart(DietItemsController controller) => CustomGroupBox(
    groupHeaderText: "Item List",
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
                      controller: controller.txt_mmeal_item_search,
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
                    CustomTableClumnHeader("Type Name"),
                    CustomTableClumnHeader("Name"),
                    CustomTableClumnHeader("Edit", Alignment.center),
                  ])
            ],
          ),
          Expanded(
            child: ListView(
              children: [
                Obx(() => Table(
                    columnWidths: customColumnWidthGenarator(_col2),
                    border: CustomTableBorderNew,
                    children: controller.list_meal_item_temp
                        .map((element) => TableRow(
                                decoration: BoxDecoration(
                                    color: controller.editItemId.value ==
                                            element.id
                                        ? appColorPista.withOpacity(0.3)
                                        : Colors.white),
                                children: [
                                  oneColumnCellBody(
                                      element.id!, 12, Alignment.center),
                                  oneColumnCellBody(element.mealTypename!),
                                  oneColumnCellBody(element.name!),
                                  CustomTableEditCell(() {
                                    controller.editItemId.value = element.id!;
                                    controller.txt_mmeal_item.text =
                                        element.name!;
                                  })
                                ]))
                        .toList()))
              ],
            ),
          )
        ],
      ),
    ));
_categoryEntryPart(DietItemsController controller) => CustomGroupBox(
    groupHeaderText: "Item Entry",
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              const CustomTextHeader(text: "ID        :"),
              6.widthBox,
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                color: appColorPista,
                child: CustomTextHeader(
                  text: controller.selectedDMealTypeID.value,
                  textColor: appColorGrayDark,
                ),
              ),
            ],
          ),
          6.heightBox,
          Row(
            children: [
              const CustomTextHeader(text: "Name :"),
              6.widthBox,
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                color: appColorPista,
                child: CustomTextHeader(
                  text: controller.selectedDMealTypeName.value,
                  textColor: appColorGrayDark,
                ),
              ),
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
                            maxlength: 50,
                            caption: "Item Name",
                            controller: controller.txt_mmeal_item,
                            onChange: (v) {})),
                    8.widthBox,
                    CustomButton(Icons.save, "Save", () {
                      controller.saveUpdateItem();
                    }),
                    8.widthBox,
                    controller.editItemId.value != ''
                        ? RoundedButton(() {
                            controller.editItemId.value = '';
                            controller.txt_mmeal_item.text = '';
                          }, Icons.undo)
                        : const SizedBox()
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
