import '../../../../core/config/const.dart';
import '../controller/app_investigation_attr_controller.dart';

class AppInvAttrMaster extends StatelessWidget {
  const AppInvAttrMaster({super.key});
  void disposeController() {
    try {
      Get.delete<AppInvAttrMasterController>();
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    final AppInvAttrMasterController controller =
        Get.put(AppInvAttrMasterController());
    controller.context = context;
    return Obx(() => CommonBody2(controller, _mainWidget(controller)));
  }
}

Widget _mainWidget(AppInvAttrMasterController controller) =>
    CustomAccordionContainer(
        headerName: "Investigation Attributes",
        height: 0,
        isExpansion: false,
        children: [
          _entryPart(controller),
          16.heightBox,
          _tablePart(controller)
        ]);

Widget _tablePart(AppInvAttrMasterController controller) => Expanded(
      child: Row(
        children: [
          Flexible(
              child: SizedBox(
            width: 600,
            child: CustomGroupBox(
                groupHeaderText: "Attributes List",
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Flexible(
                              child: CustomSearchBox(
                                  caption: "Search",
                                  width: 350,
                                  controller: TextEditingController(),
                                  onChange: (v) {
                                    controller.search();
                                  })),
                        ],
                      ),
                      12.heightBox,
                      CustomTableHeaderWeb(colWidtList: _col, children: [
                        CustomTableCell2("ID", true),
                        CustomTableCell2("Attribute Name"),
                        CustomTableCell2("*", true)
                      ]),
                      Expanded(
                          child: SingleChildScrollView(
                        child: Table(
                          columnWidths: customColumnWidthGenarator(_col),
                          border: CustomTableBorderNew,
                          children: controller.list_attr_temp
                              .map((f) => TableRow(
                                      decoration: BoxDecoration(
                                          color: controller.editID.value != f.id
                                              ? Colors.white
                                              : appColorPista.withOpacity(0.3)),
                                      children: [
                                        oneColumnCellBody(
                                            f.id!, 12, Alignment.center),
                                        oneColumnCellBody(f.name!),
                                        CustomTableEditCell(() {
                                          controller.edit(f);
                                        })
                                      ]))
                              .toList(),
                        ),
                      ))
                    ],
                  ),
                )),
          ))
        ],
      ),
    );
List<int> _col = [20, 150, 20];
Widget _entryPart(AppInvAttrMasterController controller) => Row(
      children: [
        Flexible(
          child: SizedBox(
            width: 600,
            child: CustomGroupBox(
                groupHeaderText: "Entry",
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                              child: CustomTextBox(
                                  maxlength: 150,
                                  caption: "Attributes name",
                                  controller: controller.txt_name,
                                  onChange: (v) {})),
                          12.widthBox,
                          CustomButton(Icons.save,
                              controller.editID.value == '' ? "Save" : "Update",
                              () {
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
                )),
          ),
        )
      ],
    );
