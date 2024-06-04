import '../../../../core/config/const.dart';
import '../controller/app_doc_department_controller.dart';

class AppDocDepartment extends StatelessWidget {
  const AppDocDepartment({super.key});
  void disposeController() {
    try {
      Get.delete<AppDocDepartmentController>();
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    final AppDocDepartmentController controller =
        Get.put(AppDocDepartmentController());
    controller.context = context;
    return Obx(() => CommonBody2(controller, _mainWidget(controller)));
  }
}

_mainWidget(AppDocDepartmentController controller) => CustomAccordionContainer(
    headerName: "App Doctor Department",
    height: 0,
    isExpansion: false,
    children: [_entryPart(controller), 8.heightBox, _TablePart(controller)]);

_TablePart(AppDocDepartmentController controller) => Expanded(
      child: Row(
        children: [
          Expanded(
              flex: 4,
              child: CustomGroupBox(
                  groupHeaderText: "Department List",
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                                child: CustomSearchBox(
                                    caption: "Search",
                                    controller: controller.txt_search,
                                    onChange: (v) {
                                      controller.search();
                                    })),
                          ],
                        ),
                        8.heightBox,
                        Table(
                          border: CustomTableBorderNew,
                          columnWidths: customColumnWidthGenarator(_col),
                          children: [
                            TableRow(
                                decoration:
                                    CustomTableHeaderRowDecorationnew.copyWith(
                                        color: kBgColorG),
                                children: [
                                  CustomTableClumnHeader(
                                      "ID", Alignment.center),
                                  CustomTableClumnHeader("Department Name"),
                                  CustomTableClumnHeader("*", Alignment.center),
                                ])
                          ],
                        ),
                        Expanded(
                            child: SingleChildScrollView(
                                child: Table(
                                    columnWidths:
                                        customColumnWidthGenarator(_col),
                                    border: CustomTableBorderNew,
                                    children: controller.list_department
                                        .map((element) => TableRow(
                                                decoration: BoxDecoration(
                                                    color: controller.editDeptID
                                                                .value ==
                                                            element.id!
                                                        ? appColorPista
                                                            .withOpacity(0.3)
                                                        : Colors.white),
                                                children: [
                                                  oneColumnCellBody(element.id!,
                                                      12, Alignment.center),
                                                  oneColumnCellBody(
                                                      element.name!),
                                                  CustomTableEditCell(() {
                                                    controller.editDeptID
                                                        .value = element.id!;
                                                    controller.txt_name.text =
                                                        element.name!;
                                                  })
                                                ]))
                                        .toList())))
                      ],
                    ),
                  ))),
          Expanded(
              flex: controller.context.width > 1150 ? 6 : 0,
              child: const SizedBox())
        ],
      ),
    );

List<int> _col = [20, 150, 20];

_entryPart(AppDocDepartmentController controller) => Row(
      children: [
        Expanded(
            flex: 4,
            child: CustomGroupBox(
                groupHeaderText: "Entry",
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                              child: CustomTextBox(
                                  caption: "Department Name",
                                  controller: controller.txt_name,
                                  onChange: (v) {})),
                          8.widthBox,
                          CustomButton(
                              Icons.save,
                              controller.editDeptID.value == ''
                                  ? "Save"
                                  : "Update", () {
                            controller.saveUpdate();
                          }),
                          controller.editDeptID.value == ''
                              ? const SizedBox()
                              : InkWell(
                                  onTap: () {
                                    controller.txt_name.text = '';
                                    controller.editDeptID.value = '';
                                  },
                                  child: Container(
                                      padding: const EdgeInsets.all(8),
                                      child: const Icon(
                                        Icons.undo,
                                        size: 18,
                                      )),
                                )
                        ],
                      ),
                      4.heightBox
                    ],
                  ),
                ))),
        Expanded(
            flex: controller.context.width > 1150 ? 6 : 0,
            child: const SizedBox())
      ],
    );
