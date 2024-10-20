import '../../../../core/config/const.dart';
import '../../../../widget/custom_datepicker.dart';
import '../controller/diet_approval_controller.dart';

class DietApproval extends StatelessWidget {
  const DietApproval({super.key});
  void disposeController() {
    try {
      Get.delete<DietApprovalController>();
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    final DietApprovalController c = Get.put(DietApprovalController());
    c.context = context;
    return Obx(() => CommonBodyWithToolBar(c, [
          _bodyPart(c),
        ], (v) {
          c.toolEvent(v!);
        }));
  }
}

Widget _bodyPart(DietApprovalController c) => Expanded(
      child: CustomGroupBox(
          child: Column(
        children: [
          _topPanel(c),
          _tablePart(c),
        ],
      )),
    );

Widget _tablePart(DietApprovalController controller) => Expanded(
      child: CustomGroupBox(
          padingvertical: 0,
          groupHeaderText: "List",
          child: Obx(() => Column(
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: CustomGroupBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Obx(() => ScrollableTabsWithArrows(
                                      children: controller.list_ns
                                          .map((f) => CustomTabWithCheckBox(
                                              text: f.name!,
                                              isCheck: controller
                                                      .selectedTabID.value ==
                                                  f.id,
                                              fun: () {
                                                // print(f.id);
                                                controller.selectedTabID.value =
                                                    f.id!;
                                                controller.loadPatient();
                                              }))
                                          .toList(),
                                    )),
                              ),
                              4.widthBox,
                              CustomTextBox(
                                  width: 350,
                                  caption: 'Search',
                                  controller: controller.txt_search,
                                  onChange: (v) {
                                    controller.search();
                                  }),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  8.heightBox,
                  controller.list_final_list.isEmpty
                      ? const SizedBox()
                      : Table(
                          border: CustomTableBorderNew,
                          columnWidths:
                              customColumnWidthGenarator(controller.col),
                          children: [
                            TableRow(
                                decoration: CustomTableHeaderRowDecorationnew,
                                children: [
                                  CustomTableClumnHeader('#', Alignment.center),
                                  CustomTableClumnHeader("HCN"),
                                  CustomTableClumnHeader("Adm.No"),
                                  CustomTableClumnHeader("NS. Name"),
                                  CustomTableClumnHeader("Name"),
                                  CustomTableClumnHeader("Bed No"),
                                  CustomTableClumnHeader("Remarks"),
                                  CustomTableClumnHeader("Diet"),
                                  ...controller.list_final_list.first.menu
                                      .where((e) => e.sl != null)
                                      .map((f) => CustomTableClumnHeader(
                                          f.name ?? '', Alignment.center)),
                                ]),
                          ],
                        ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Stack(
                        children: [
                          Table(
                              border: CustomTableBorderNew,
                              columnWidths:
                                  customColumnWidthGenarator(controller.col),
                              children: [
                                ...controller.list_final_list.map((f) => TableRow(
                                        decoration:
                                            CustomTableHeaderRowDecorationnew
                                                .copyWith(
                                                    color: controller
                                                                .selectedConfigID
                                                                .value ==
                                                            f.regid
                                                        ? appColorPista
                                                        : Colors.white),
                                        children: [
                                          CustomTableCellx(
                                            text: (controller.list_final_list
                                                        .indexOf(f) +
                                                    1)
                                                .toString(),
                                            alignment: Alignment.center,
                                          ),
                                          f.hcn_cell!,
                                          f.regid_cell!,
                                          f.nsName_cell!,
                                          f.name_cell!,
                                          f.bedno_cell!,
                                          TableCell(
                                              verticalAlignment:
                                                  TableCellVerticalAlignment.fill,
                                              child: CustomTextBox(
                                                  isFilled: true,
                                                  fillColor: controller
                                                              .selectedConfigID
                                                              .value ==
                                                          f.regid
                                                      ? appColorPista
                                                      : Colors.white,
                                                  caption: '',
                                                  maxlength: 150,
                                                  controller: f.remarks!,
                                                  onChange: (v) {
                                                    controller.textRemarksChenged();
                                                  })),
                                          TableCell(
                                            verticalAlignment:
                                                TableCellVerticalAlignment.fill,
                                            child: CustomDropDown2(
                                                fontSize: 9,
                                                fontWidth: FontWeight.bold,
                                                fillColor: controller
                                                            .selectedConfigID
                                                            .value ==
                                                        f.regid
                                                    ? appColorPista
                                                    : Colors.white,
                                                labeltext: '',
                                                id: f.dietid,
                                                list: controller.lis_diet_master,
                                                onTap: (v) {
                                                  f.dietid = v!;
                                                  controller.setDiet(f, v);
                                                }),
                                          ),
                                          ...f.menu.map((m) => TableCell(
                                                verticalAlignment:
                                                    TableCellVerticalAlignment.fill,
                                                child: f.dietid==''?const SizedBox(): CustomDropDown2(
                                                    fontSize: 9,
                                                    fontWidth: FontWeight.bold,
                                                    fillColor: controller
                                                                .selectedConfigID
                                                                .value ==
                                                            f.regid
                                                        ? appColorPista
                                                        : Colors.white,
                                                    labeltext: '',
                                                    id: m.val,
                                                    list: controller
                                                        .list_meal_attributes
                                                        .where((t) =>
                                                            t.mealTypeid == m.id)
                                                        .toList(),
                                                    onTap: (v) {
                                                      m.val = v!;
                                                      controller
                                                          .textRemarksChenged();
                                                    }),
                                              ))
                                        ])),
                              ]),
                        
                        
                         controller.list_diet_approved_ns.where((e)=>e.nsId==controller.selectedTabID.value).isNotEmpty?
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
    );

_topPanel(DietApprovalController c) => Row(
      children: [
        Flexible(
          child: SizedBox(
              width: 450,
              child: CustomGroupBox(
                  borderRadius: 4,
                  groupHeaderText: "Attributes",
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
                                c.loadPatient();
                              },
                            ),
                            4.widthBox,
                            Expanded(
                                child: CustomDropDown2(
                                    id: c.selectedDiettypeID.value,
                                    list: c.list_diet_type,
                                    onTap: (v) {
                                      c.selectedDiettypeID.value = v!;
                                      c.loadPatient();
                                    })),
                            4.widthBox,
                            Expanded(
                                child: CustomDropDown2(
                                    id: c.selectedTimeID.value,
                                    list: c.list_time,
                                    onTap: (v) {
                                      c.selectedTimeID.value = v!;
                                      c.loadPatient();
                                    })),
                            4.widthBox,
                            InkWell(
                                onTap: () {
                                  c.loadPatient();
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
                        4.heightBox,
                      ],
                    ),
                  ))),
        )
      ],
    );

_menuListGenerate(DietApprovalController controller, String id) {
  List<DropdownMenuItem<String>> list = controller.list_meal_attributes
      .where((t) => t.mealTypeid == id)
      .map((f) => DropdownMenuItem<String>(
          value: f.id,
          child: Center(
              child: Text(
            f.name ?? '',
            style: customTextStyle.copyWith(fontSize: 10.5),
          ))))
      .toList();

  return list;
}
