import '../../../../core/config/const.dart';
import '../controller/app_health_package_master_controller.dart';

class HealthPackageMaster extends StatelessWidget {
  const HealthPackageMaster({super.key});
  void disposeController() {
    try {
      Get.delete<HealthPackageMasterController>();
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    final HealthPackageMasterController controller =
        Get.put(HealthPackageMasterController());
    controller.context = context;
    return Obx(() => CommonBody2(controller, _mainWindow(controller)));
  }
}

Widget _mainWindow(HealthPackageMasterController controller) =>
    CustomAccordionContainer(
     // bgColor:appGray50,
        headerName: "Health Package Master",
        height: 0,
        isExpansion: false,
        children: [
          _entryPart(controller),
          8.heightBox,
          _tablePart(controller)
        ]);

Widget _tablePart(HealthPackageMasterController controller) => Expanded(
    child: CustomGroupBox(
     borderWidth: 1,
     // borderRadius: 8,
        // bgColor: kWebBackgroundDeepColor,
        groupHeaderText: "Package List",
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Flexible(
                      child: CustomSearchBox(
                          caption: "Search",
                          width: 450,
                          controller: controller.txt_search,
                          onChange: (v) {
                            controller.search();
                          })),
                ],
              ),
              12.heightBox,
              Table(
                border: CustomTableBorderNew,
                columnWidths: customColumnWidthGenarator(_col),
                children: [
                  TableRow(
                      decoration: CustomTableHeaderRowDecorationnew,
                      children: [
                        CustomTableCell2("ID"),
                        CustomTableCell2("Package Name"),
                        CustomTableCell2("Specification"),
                        CustomTableCellTableBody("Reguler Price", 12,
                            FontWeight.w400, Alignment.centerRight),
                        CustomTableCellTableBody("Discounted Price", 12,
                            FontWeight.w400, Alignment.centerRight),
                        CustomTableCell2("*", true),
                        //CustomTableClumnHeader(text)
                      ])
                ],
              ),
              Expanded(
                  child: SingleChildScrollView(
                child: Table(
                  border: CustomTableBorderNew,
                  columnWidths: customColumnWidthGenarator(_col),
                  children: controller.list_package_temp
                      .map((f) => TableRow(
                              decoration: BoxDecoration(
                                  color: controller.editID == f.id
                                      ? appColorPista.withOpacity(0.3)
                                      : Colors.white),
                              children: [
                                oneColumnCellBody(f.id!, 12, Alignment.center),
                                oneColumnCellBody(
                                    f.name!, 12, Alignment.centerLeft),
                                oneColumnCellBody(
                                    f.des!, 12, Alignment.centerLeft),
                                oneColumnCellBody(f.rate!.toString(), 12,
                                    Alignment.centerRight),
                                oneColumnCellBody(f.accRate!.toString(), 12,
                                    Alignment.centerRight),
                                CustomTableEditCell(() {
                                  controller.edit(f);
                                })
                              ]))
                      .toList(),
                ),
              ))
            ],
          ),
        )));

List<int> _col = [20, 150, 120, 50, 50, 30];

Widget _entryPart(HealthPackageMasterController controller) => Row(
      children: [
        Flexible(
          child: SizedBox(
            width: 550,
            child: CustomGroupBox(
              //borderWidth: 2,
             // borderRadius: 8,
                // bgColor: kWebBackgroundDeepColor,
                groupHeaderText: "Entry",
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                  child: CustomTextBox(
                                      maxlength: 150,
                                      caption: "Package Name",
                                      controller: controller.txt_name,
                                      onChange: (v) {})),
                            ],
                          ),
                          12.heightBox,
                          Row(
                            children: [
                              Expanded(
                                  child: CustomTextBox(
                                      maxlength: 150,
                                      caption: "Specification",
                                      controller: controller.txt_speci,
                                      onChange: (v) {})),
                            ],
                          ),
                          12.heightBox,
                          Row(
                            children: [
                              Flexible(
                                child: CustomTextBox(
                                  textAlign :TextAlign.end,
                                    caption: "Original Rate",
                                    textInputType: TextInputType.number,
                                    width: 150,
                                    controller: controller.txt_rate,
                                    onChange: (v) {}),
                              ),
                              12.widthBox,
                              Flexible(
                                child: CustomTextBox(
                                 textAlign :TextAlign.end,
                                    caption: "Discounted Rate",
                                    textInputType: TextInputType.number,
                                    width: 150,
                                    controller: controller.txt_acc_rate,
                                    onChange: (v) {}),
                              ),
                              const Spacer(),
                              CustomButton(
                                  Icons.save,
                                  controller.editID.value == ''
                                      ? "Save"
                                      : "Update", () {
                                controller.save();
                              }),
                              controller.editID.value == ''
                                  ? const SizedBox()
                                  : Padding(
                                      padding: const EdgeInsets.only(left: 12),
                                      child: InkWell(
                                        onTap: () {
                                          controller.undo();
                                        },
                                        child: Container(
                                            padding: const EdgeInsets.all(4),
                                            child: const Icon(
                                              Icons.undo,
                                              color: appColorBlue,
                                            )),
                                      ),
                                    )
                            ],
                          ),
                          12.heightBox,
                        ],
                      ),
                    )
                  ],
                )),
          ),
        )
      ],
    );
