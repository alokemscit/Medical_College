import '../../../../core/config/const.dart';
import '../controller/goods_formula_setup_controller.dart';

class GoodsFormulaSetup extends StatelessWidget {
  const GoodsFormulaSetup({super.key});
  void disposeController() {
    try {
      Get.delete<GoodsFormulaSetupController>();
    } catch (e) {}
  }

  //GoodsFormulaSetupController controller;
  @override
  Widget build(BuildContext context) {
    final GoodsFormulaSetupController controller =
        Get.put(GoodsFormulaSetupController());
    controller.context = context;
    return Obx(() => CommonBody2(
          controller,
          _commonWidget(controller),
          //_commonWidget(controller),
          //_commonWidget(controller),
        ));
  }
}

Widget _commonWidget(GoodsFormulaSetupController controller) =>
    controller.context.width > 1000
        ? Row(
            children: [
              Expanded(flex: 4, child: _foodItemList(controller)),
              8.widthBox,
              Expanded(flex: 6, child: _setupList(controller))
            ],
          )
        : Column(
            children: [
              Expanded(flex: 6, child: _foodItemList(controller)),
              8.heightBox,
              Expanded(flex: 4, child: _setupList(controller))
            ],
          );

Widget _foodItemList(GoodsFormulaSetupController controller,
        [double height = 0]) =>
    CustomAccordionContainer(
        isExpansion: false,
        headerName: "List Of Finished Goods",
        height: height,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(2),
              child: Container(
                decoration: customBoxDecoration,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Column(
                    children: [
                      _leftSearch(controller),
                      10.heightBox,
                      _tableHeaderLeft,
                      _leftTableBody(controller),
                    ],
                  ),
                ),
              ),
            ),
          )
        ]);

Widget _leftSearch(GoodsFormulaSetupController controller) => Row(
      children: [
        Expanded(
            child: CustomSearchBox(
                borderRadious: 4,
                caption: "Finished Product Search",
                controller: controller.txt_search_goods,
                onChange: (v) {
                  controller.searchProduct();
                }))
      ],
    );

Widget _leftTableBody(GoodsFormulaSetupController controller) => Expanded(
        child: SingleChildScrollView(
      child: Table(
        border: CustomTableBorderNew,
        columnWidths: customColumnWidthGenarator(_col),
        children: controller.list_item_temp
            .map((e) => TableRow(
                    decoration: BoxDecoration(
                        color: controller.list_item_temp.indexOf(e) % 2 == 0
                            ? Colors.white
                            : appColorPista.withOpacity(0.1)),
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        // alignment: Alignment.centerLeft,
                        child: CustomTableCell(e.fOODID!),
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: CustomTableCell(
                              e.fOODNAME!,
                              customTextStyle.copyWith(
                                  fontSize: 13, fontWeight: FontWeight.w500))),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        // alignment: Alignment.centerLeft,
                        child: CustomTableCell(
                            e.sTATUS == '0' ? 'Not Setup' : 'Done'),
                      ),
                      CustomTableEditCell(() {
                        // controller.list_entry_item.clear();
                        controller.selectedID.value = e.fOODID!;
                        controller.setupItem();
                        //print(e.fOODID!);
                      }, Icons.launch_outlined)
                    ]))
            .toList(),
      ),
    ));

Widget _tableHeaderLeft = Table(
  border: CustomTableBorderNew,
  columnWidths: customColumnWidthGenarator(_col),
  children: [
    TableRow(decoration: CustomTableHeaderRowDecorationnew, children: [
      Padding(
        padding: const EdgeInsets.all(4),
        child: CustomTableCell(
            "Code",
            customTextStyle.copyWith(
                fontSize: 14, fontWeight: FontWeight.bold)),
      ),
      Padding(
        padding: const EdgeInsets.all(4),
        child: CustomTableCell(
            "Name",
            customTextStyle.copyWith(
                fontSize: 14, fontWeight: FontWeight.bold)),
      ),
      Padding(
        padding: const EdgeInsets.all(4),
        child: CustomTableCell(
            "Status",
            customTextStyle.copyWith(
                fontSize: 14, fontWeight: FontWeight.bold)),
      ),
      Center(
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: CustomTableCell(
              "*",
              customTextStyle.copyWith(
                  fontSize: 14, fontWeight: FontWeight.bold)),
        ),
      ),
    ])
  ],
);

List<int> _col = [80, 150, 50, 30];

Widget _setupList(GoodsFormulaSetupController controller,
        [double height = 0]) =>
    controller.selectedID.value == ''
        ? const SizedBox()
        : Stack(
            children: [
              CustomAccordionContainer(
                  isExpansion: false,
                  headerName: "Formula With Raw Materials",
                  height: height,
                  children: [
                    _entryPart(controller),
                    4.heightBox,
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Container(
                          padding: const EdgeInsets.only(bottom: 8),
                          decoration: customBoxDecoration,
                          child: Column(
                            children: [
                              4.heightBox,
                              _tableHeader2,
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: Table(
                                        columnWidths:
                                            customColumnWidthGenarator(_col1),
                                        border: CustomTableBorderNew,
                                        children: controller.list_entry_item
                                            .map(
                                              (element) => TableRow(
                                                  decoration:
                                                      const BoxDecoration(
                                                          color: Colors.white),
                                                  children: [
                                                    oneColumnCellBody(
                                                        element.name),
                                                    oneColumnCellBody(
                                                        element.unit,
                                                        12,
                                                        Alignment.center),
                                                    oneColumnCellBody(
                                                        element.qty,
                                                        12,
                                                        Alignment.center),
                                                    CustomTableEditCell(() {
                                                      controller.deleteItem(
                                                          element.id);
                                                    }, Icons.delete)
                                                    //CustomTableCell("text"),
                                                  ]),
                                            )
                                            .toList()
                                        // [
                                        //   //for (var i = 0; i < 500; i++)

                                        // ],
                                        ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ]),
              _searchItem(controller),
              Obx(() => controller.list_entry_item.isEmpty
                  ? const SizedBox()
                  : Positioned(
                      bottom: 22,
                      right: 26,
                      child: CustomButton(Icons.save, 'Save', () {
                        controller.save();
                      }, Colors.white, Colors.white, appColorBlue)))
            ],
          );

_entryPart(GoodsFormulaSetupController controller) => Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: customBoxDecoration,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        RoundedButton(() {
                          controller.selectedID.value = '';
                        }, Icons.close, 12, Colors.black)
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Product Cide :",
                          style: customTextStyle.copyWith(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        12.widthBox,
                        Text(controller.selectedID.value)
                      ],
                    ),
                    8.heightBox,
                    Row(
                      children: [
                        Text("Product Name :",
                            style: customTextStyle.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                        12.widthBox,
                        Text(controller.list_item
                            .where((p0) =>
                                p0.fOODID == controller.selectedID.value)
                            .first
                            .fOODNAME!),
                      ],
                    ),
                    10.heightBox,
                    Row(
                      children: [
                        Expanded(
                            flex: 5,
                            child: CustomDropDown(
                                labeltext: 'Raw materials name',
                                id: controller.rawmaterialId.value,
                                list: controller.list_raw_material
                                    .map((element) => DropdownMenuItem<String>(
                                        value: element.iTEMID,
                                        child: Row(
                                          children: [
                                            Text(element.nAME!),
                                            8.widthBox,
                                            Text(element.uNAME!),
                                          ],
                                        )))
                                    .toList(),
                                onTap: (v) {
                                  controller.rawmaterialId.value = v!;
                                  controller.focusNode1.requestFocus();
                                })),
                        InkWell(
                          onTap: () {
                            controller.isSearch.value = true;
                          },
                          child: _fiterButton(),
                        ),
                        6.widthBox,
                        CustomTextBox(
                          focusNode: controller.focusNode1,
                          caption: "Qty",
                          textInputType: TextInputType.number,
                          controller: controller.txt_qty,
                          onChange: (v) {},
                          onSubmitted: (p0) {
                            if (p0.isNotEmpty) {
                              controller.addItem();
                            }
                          },
                        ),
                        12.widthBox,
                        RoundedButton(() {
                          controller.addItem();
                        }, Icons.add_link),
                        const Expanded(flex: 1, child: SizedBox()),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );

Widget _searchItem(GoodsFormulaSetupController controller) => !controller
        .isSearch.value
    ? const SizedBox()
    : Positioned(
        top: 130,
        left: 0,
        right: 0,
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(left: 24),
                height: 300,
                //width: 500,
                child: Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Container(
                        padding:
                            const EdgeInsets.only(left: 6, top: 4, right: 4),
                        decoration: customBoxDecoration.copyWith(
                            borderRadius: BorderRadius.circular(4),
                            color: Colors.white),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                    child: CustomSearchBox(
                                        caption: "Search",
                                        controller:
                                            controller.txt_search_rawMaterials,
                                        onChange: (v) {
                                          controller.serarchRawMaterial();
                                        })),
                                12.widthBox,
                                InkWell(
                                  onTap: () {
                                    controller.isSearch.value = false;
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Colors.white,
                                        boxShadow: const [
                                          BoxShadow(
                                              color: appColorGray200,
                                              blurRadius: 1,
                                              spreadRadius: 2)
                                        ]),
                                    child: const Center(
                                        child: Icon(
                                      Icons.close,
                                      size: 18,
                                      color: Colors.black,
                                    )),
                                  ),
                                )
                              ],
                            ),
                            6.heightBox,
                            Expanded(
                                child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              child: Obx(() => ListView(
                                    children: controller.list_raw_material_temp
                                        .map((element) => InkWell(
                                              onTap: () {
                                                controller.rawmaterialId.value =
                                                    element.iTEMID!;
                                                controller.isSearch.value =
                                                    false;
                                                controller.focusNode1
                                                    .requestFocus();
                                              },
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              color:
                                                                  appColorGray200)),
                                                      child: Row(
                                                        children: [
                                                          Text(element.nAME!),
                                                          6.widthBox,
                                                          Text(element.uNAME!),
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ))
                                        .toList(),
                                  )),
                            )),
                          ],
                        ),
                      ),
                    ),
                    153.widthBox,
                    const Expanded(flex: 1, child: SizedBox())
                  ],
                ),
              ),
            ),
          ],
        ),
      );

Widget _tableHeader2 = Padding(
  padding: const EdgeInsets.only(left: 8, right: 8, top: 4),
  child: Table(
    border: CustomTableBorderNew,
    columnWidths: customColumnWidthGenarator(_col1),
    children: [
      // CustomTableRow(['Raw Item', 'Unit', 'Qty', '*']),
      TableRow(decoration: CustomTableHeaderRowDecorationnew, children: [
        oneColumnCellBody(
            "Raw Materials Name",
            14,
            Alignment.centerLeft,
            FontWeight.bold,
            const EdgeInsets.symmetric(vertical: 4, horizontal: 4)),
        oneColumnCellBody("Unit", 14, Alignment.center, FontWeight.bold,
            const EdgeInsets.symmetric(vertical: 4)),
        oneColumnCellBody("qty", 14, Alignment.center, FontWeight.bold,
            const EdgeInsets.symmetric(vertical: 4, horizontal: 4)),
        oneColumnCellBody("*", 14, Alignment.center, FontWeight.bold,
            const EdgeInsets.symmetric(vertical: 4, horizontal: 4)),
      ])
    ],
  ),
);

List<int> _col1 = [150, 50, 50, 30];

Widget _fiterButton() => Container(
    height: 28,
    width: 20,
    color: appColorGray200,
    child: const Center(
        child: Icon(
      Icons.filter_alt,
      size: 18,
      color: appColorBlue,
    )));
