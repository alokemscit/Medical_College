import 'package:agmc/widget/custom_datepicker.dart';
 
import '../../../../core/config/const.dart';
import '../controller/production_plan_controller.dart';

class ProductionPlan extends StatelessWidget {
  const ProductionPlan({super.key});
  void disposeController() {
    try {
      Get.delete<ProductionPlanController>();
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    final ProductionPlanController controller =
        Get.put(ProductionPlanController());
    controller.context = context;
    return Obx(() => CommonBody2(
          controller,
          //  _mainWidget(controller),
          //  _mainWidget(controller),
          _mainWidget(controller),
        ));
  }
}

_desktop(ProductionPlanController controller) => Row(
      children: [
        Expanded(flex: 5, child: _masterPanel(controller)),
        8.widthBox,
        Expanded(flex: 6, child: _peviousPanel(controller))
      ],
    );

_mobileTabs(ProductionPlanController controller) => Column(
      children: [
        Expanded(flex: 5, child: _masterPanel(controller)),
        8.heightBox,
        Expanded(flex: 6, child: _peviousPanel(controller))
      ],
    );

Widget _mainWidget(ProductionPlanController controller) =>
    controller.context.width > 1000
        ? _desktop(controller)
        : _mobileTabs(controller);

_headerEntryPart(ProductionPlanController controller) => Row(
      children: [
        Expanded(
            child: CustomDropDown(
                id: controller.selectedGoodsId.value,
                list: controller.list_item_temp
                    .map((element) => DropdownMenuItem<String>(
                        value: element.fOODID,
                        child: Text(
                          '${element.fOODNAME!} -  ${element.fOODID!}',
                          style: customTextStyle.copyWith(
                              fontSize: 12.5, fontWeight: FontWeight.w500),
                        )))
                    .toList(),
                onTap: (v) {
                  controller.selectedGoodsId.value = v!;
                  controller.focusNode1.requestFocus();
                })),
        8.widthBox,
        InkWell(
            onTap: () {
              controller.isSearch.value = true;
            },
            child: _fiterButton()),
        8.widthBox,
        CustomTextBox(
          focusNode: controller.focusNode1,
          maxlength: 10,
          textInputType: TextInputType.number,
          caption: "qty",
          controller: controller.txt_qty,
          onChange: (v) {},
          onSubmitted: (p0) {
            //print(p0);
            if (p0.isNotEmpty) {
              controller.addItem();
            }
          },
        ),
        12.widthBox,
        RoundedButton(() {
          controller.addItem();
        }, Icons.add_link_rounded)
      ],
    );

Widget _masterPanel(ProductionPlanController controller) => Stack(
      children: [
        CustomAccordionContainer(
            headerName: "Plan Entry ::",
            height: 0,
            isExpansion: false,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: customBoxDecoration.copyWith(
                                // color: appColorGrayLight,
                                // boxShadow: [
                                //   BoxShadow(color: Colors.black12,
                                //   spreadRadius: 0.3,
                                //   blurRadius: 4,
                                //   offset: Offset(0, 0)
                                //   ),
                                
                                // ]
                                ),
                              child: _headerPart(controller),
                            ),
                          ),
                        ],
                      ),
                      10.heightBox,
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: customBoxDecoration,
                          // child: _headerPart(controller),
                          child: Column(
                            children: [
                              4.heightBox,
                              _headerEntryPart(controller),
                              10.heightBox,
                              _tableHeader,
                              _tablebody(controller)
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ]),
        _popupmenu(controller),
        Obx(() => controller.list_temp_entry_item.isEmpty
            ? const SizedBox()
            : Positioned(
                bottom: 22,
                right: 26,
                child: CustomButton(Icons.save, 'Save', () {
                  controller.saveData();
                }, Colors.white, Colors.white, appColorBlue)))
      ],
    );

Widget _popupmenu(ProductionPlanController controller) => !controller
        .isSearch.value
    ? const SizedBox()
    : Positioned(
        top: 170,
        left: 0,
        right: 0,
        child: Row(
          children: [
            Expanded(
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Container(
                    height: 350,
                    decoration: customBoxDecoration.copyWith(
                        color: Colors.white,
                        borderRadius: BorderRadiusDirectional.circular(4),
                        boxShadow: [
                          const BoxShadow(
                              color: appColorGrayDark,
                              blurRadius: 3,
                              spreadRadius: .5)
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Column(
                        children: [
                          6.heightBox,
                          Row(
                            children: [
                              Expanded(
                                  child: CustomSearchBox(
                                      borderRadious: 4,
                                      caption: "Search",
                                      controller:
                                          controller.txt_search_rawMaterials,
                                      onChange: (v) {
                                        controller.serarchGoods();
                                      })),
                              6.widthBox,
                              RoundedButton(() {
                                controller.isSearch.value = false;
                                controller.txt_search_rawMaterials.text = '';
                                controller.serarchGoods();
                              }, Icons.close, 16, Colors.black),
                            ],
                          ),
                          6.heightBox,
                          Expanded(
                            child: ListView(
                              children: controller.list_item_temp
                                  .map((element) => InkWell(
                                        onTap: () {
                                          controller.selectedGoodsId.value =
                                              element.fOODID!;
                                          controller.isSearch.value = false;
                                          controller.txt_search_rawMaterials
                                              .text = '';
                                          controller.serarchGoods();
                                          controller.focusNode1.requestFocus();
                                        },
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 4),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color:
                                                            appColorGray200)),
                                                child: Row(
                                                  children: [
                                                    Text(element.fOODNAME!),
                                                    //6.widthBox,
                                                    // Text(element.!),
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ))
                                  .toList(),
                            ),
                          )
                        ],
                      ),
                    ),
                  )),
            ),
            38.widthBox,
          ],
        ));

Widget _tablebody(ProductionPlanController controller) => Expanded(
      child: SingleChildScrollView(
        child: Obx(() => Table(
            border: CustomTableBorderNew,
            columnWidths: customColumnWidthGenarator(_col),
            children: controller.list_temp_entry_item
                .map((element) => TableRow(
                        decoration: BoxDecoration(
                            color: controller.list_temp_entry_item
                                            .indexOf(element) %
                                        2 !=
                                    0
                                ? appColorPista.withOpacity(0.03)
                                : Colors.white),
                        children: [
                          //tableCell1(text: text)
                          // CustomTableCell1(text: 'text'),
                          CustomTableCellTableBody(
                              element.id,
                              13,
                              FontWeight.w500,
                              Alignment.centerLeft,
                              const EdgeInsets.all(4)),
                          CustomTableCellTableBody(
                              element.name,
                              13,
                              FontWeight.w500,
                              Alignment.centerLeft,
                              const EdgeInsets.all(4)),
                          CustomTableCellTableBody(
                              element.unit,
                              13,
                              FontWeight.w500,
                              Alignment.center,
                              const EdgeInsets.symmetric(vertical: 4)),
                          CustomTableCellTableBody(
                              element.qty,
                              13,
                              FontWeight.w500,
                              Alignment.center,
                              const EdgeInsets.symmetric(vertical: 4)),

                          // CustomTableCell2(element.name,false,13,FontWeight.w500),
                          // CustomTableCell2(element.unit,true,13,FontWeight.w500),
                          // CustomTableCell2(element.qty,true,13,FontWeight.w500),
                          CustomTableEditCell(() {
                            controller.deleteItem(element.id);
                          }, Icons.delete)
                        ]))
                .toList())),
      ),
    );

Widget _tableHeader = Table(
  columnWidths: customColumnWidthGenarator(_col),
  border: CustomTableBorderNew,
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
            "Finished Goods Name",
            customTextStyle.copyWith(
                fontSize: 14, fontWeight: FontWeight.bold)),
      ),
      Padding(
        padding: const EdgeInsets.all(4),
        child: Center(
          child: CustomTableCell(
              "Unit",
              customTextStyle.copyWith(
                  fontSize: 14, fontWeight: FontWeight.bold)),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(4),
        child: Center(
          child: CustomTableCell(
              "Qty",
              customTextStyle.copyWith(
                  fontSize: 14, fontWeight: FontWeight.bold)),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(4),
        child: Center(
          child: CustomTableCell(
              "*",
              customTextStyle.copyWith(
                  fontSize: 14, fontWeight: FontWeight.bold)),
        ),
      ),
    ])
  ],
);

List<int> _col = [50, 150, 50, 50, 30];

Widget _peviousPanel(ProductionPlanController controller) =>
    CustomAccordionContainer(
        headerName: "Previous history ::",
        height: 0,
        isExpansion: false,
        children: [
          _datePartPrevious(controller),
          6.heightBox,
          _tablePrevoious(controller)
        ]);

_tablePrevoious(ProductionPlanController controller) => Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
        child: Container(
            width: double.infinity,
            decoration: customBoxDecoration.copyWith(
                borderRadius: BorderRadius.circular(8)),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Table(
                    border: CustomTableBorderNew,
                    columnWidths: customColumnWidthGenarator(_col2),
                    children: [
                      TableRow(
                          decoration: CustomTableHeaderRowDecorationnew,
                          children: [
                            CustomTableCellTableBody("Plan No"),
                            CustomTableCellTableBody("Entry Date"),
                            CustomTableCellTableBody("Prod. Date"),
                            CustomTableCellTableBody("Note"),
                            CustomTableCellTableBody("Status", 13,
                                FontWeight.bold, Alignment.center),
                            CustomTableCellTableBody(
                                "*", 13, FontWeight.bold, Alignment.center),
                            // CustomTableEditCell(() {}, Icons.search_rounded)
                          ])
                    ],
                  ),
                 
                
                  Expanded(
                    child: SingleChildScrollView(
                      child: Table(
                        columnWidths: customColumnWidthGenarator(_col2),
                        border: CustomTableBorderNew,
                        children: 
                       controller.lis_plan_master.map((e) => TableRow(
                        decoration:const BoxDecoration(color: Colors.white) ,
                        children:[
                          
                         // CustomTableColumnCellBody(text)
                          CustomTableColumnCellBody(e.pno),
                          CustomTableColumnCellBody(e.edate),
                          CustomTableColumnCellBody(e.pdate),
                          CustomTableColumnCellBody(e.note),
                          CustomTableColumnCellBody(e.status),
                          CustomTableEditCell((){},Icons.search_sharp)
                      
                        ] 
                       )).toList()
                      ,),
                    ),
                  )

                 


                ],
              ),
            )),
      ),
    );

List<int> _col2 = [50, 50, 50, 150, 50, 30];

_datePartPrevious(ProductionPlanController controller) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        // padding: EdgeInsets.all(8),
        decoration: customBoxDecoration.copyWith(
            borderRadius: BorderRadius.circular(4)),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Row(
                children: [
                  _fromDate(controller),
                  //controller.context.width<850?const SizedBox():  4.widthBox,
                  controller.context.width < 1300
                      ? const SizedBox()
                      : _toDate(controller)
                ],
              ),
              controller.context.width < 1300 ? const SizedBox() : 6.heightBox,
              controller.context.width > 1300
                  ? const SizedBox()
                  : _toDate(controller),
            ],
          ),
        ),
      ),
    );

_toDate(ProductionPlanController controller) => Row(children: [
      Text(
        "     To Date : ",
        style:
            customTextStyle.copyWith(fontSize: 13, fontWeight: FontWeight.bold),
      ),
      6.widthBox,
      CustomDatePicker(
         isOnClickDate: true,
          isBackDate: true,
          isShowCurrentDate: true,
          date_controller: controller.txt_tdate),
      12.widthBox,
      CustomButton(Icons.search, 'Show', () {
        controller.viewPlanList();
      }, Colors.white, Colors.white, appColorLogo)
    ]);
_fromDate(ProductionPlanController controller) => Row(children: [
      Text(
        "From Date : ",
        style:
            customTextStyle.copyWith(fontSize: 13, fontWeight: FontWeight.bold),
      ),
      6.widthBox,
      CustomDatePicker(
         isOnClickDate: true,
          isBackDate: true,
          isShowCurrentDate: true,
          date_controller: controller.txt_fdate),
    ]);

Widget _headerPart(ProductionPlanController controller) => Column(
      children: [
        6.heightBox,
        Row(
          children: [
            const Text("Production Date : "),
            6.widthBox,
            CustomDatePicker(
              date_controller: controller.txt_production_date,
              isBackDate: true,
              isShowCurrentDate: true,
            ),
          ],
        ),
        8.heightBox,
        Row(
          children: [
            const Text("Production Note : "),
            6.widthBox,
            Expanded(
              child: CustomTextBox(
                  textInputType: TextInputType.multiline,
                  caption: "Note",
                  maxlength: 500,
                  maxLine: 3,
                  height: 50,
                  controller: controller.txt_note,
                  onChange: (v) {}),
            ),
          ],
        ),
        8.heightBox,
      ],
    );
Widget _fiterButton() => const SizedBox(
    height: 28,
    width: 20,
    //color: appColorGray200,
    child: Center(
        child: Icon(
      Icons.filter_alt,
      size: 18,
      color: appColorBlue,
    )));
