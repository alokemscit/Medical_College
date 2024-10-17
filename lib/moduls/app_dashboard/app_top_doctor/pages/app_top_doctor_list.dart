import 'package:flutter/cupertino.dart';

import '../../../../core/config/const.dart';
import '../controller/app_top_doctor_controller.dart';

class AppTopDoctorList extends StatelessWidget {
  const AppTopDoctorList({super.key});
  void disposeController() {
    try {
      Get.delete<AppTopDoctorListController>();
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    final AppTopDoctorListController controller =
        Get.put(AppTopDoctorListController());
    controller.context = context;
    return Obx(() => CommonBody2(controller, _mainWidget(controller)));
  }
}

_mainWidget(AppTopDoctorListController controller) => CustomAccordionContainer(
        headerName: "Top Doctor List",
        height: 0,
        isExpansion: false,
        children: [
          Expanded(
              child: controller.context.width > 1050
                  ? Row(
                      children: [
                        _leftPanel(controller, 6),
                        8.widthBox,
                        _rightPanel(controller),
                      ],
                    )
                  : Column(children: [
                      _leftPanel(controller, 4),
                      8.heightBox,
                      _rightPanel(controller),
                    ]))
        ]);
List<int> _col = [20, 100, 20, 50, 50, 20];
List<int> _col2 = [20, 100, 20, 50, 20];

_leftPanel(AppTopDoctorListController controller, [int flex = 5]) => Expanded(
    flex: flex,
    child: CustomGroupBox(
        groupHeaderText: "All Doctor List",
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomSearchBox(
                    caption: "Search",
                    width: 400,
                    controller: controller.txt_search,
                    onChange: (v) {
                      controller.search();
                    }),
              ],
            ),
            8.heightBox,
            Table(
              border: CustomTableBorderNew,
              columnWidths: customColumnWidthGenarator(_col),
              children: [
                TableRow(
                    decoration: CustomTableHeaderRowDecorationnew,
                    children: [
                      //30,100,50,50,50,20
                      CustomTableClumnHeader("ID", Alignment.center),
                      CustomTableClumnHeader(
                        "Name",
                        Alignment.centerLeft,
                      ),
                      CustomTableClumnHeader(
                        "Photo",
                        Alignment.centerLeft,
                      ),
                      CustomTableClumnHeader(
                        "Designation",
                        Alignment.centerLeft,
                      ),

                      CustomTableClumnHeader(
                        "Department",
                        Alignment.centerLeft,
                      ),
                      CustomTableClumnHeader(
                        "*",
                        Alignment.center,
                      ),
                    ])
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Table(
                  border: CustomTableBorderNew,
                  columnWidths: customColumnWidthGenarator(_col),
                  children: controller.list_doctor_temp
                      .map((f) => TableRow(
                              decoration:
                                  const BoxDecoration(color: Colors.white),
                              children: [
                                _customCell(f.docId, true),
                                _customCell(f.docName),
                                TableCell(
                                    verticalAlignment:
                                        TableCellVerticalAlignment.middle,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.network(
                                          'https://web.asgaralihospital.com/pub/doc_image/${f.imagePath!}',
                                          width: 50.0, // Adjust width as needed
                                          height: 60.0,
                                          fit: BoxFit
                                              .fitHeight, // Adjust height as needed
                                        ),
                                      ),
                                    )),
                                _customCell(f.desig),
                                _customCell(f.deptName),
                                TableCell(
                                    verticalAlignment:
                                        TableCellVerticalAlignment.middle,
                                    child: Center(
                                      child: InkWell(
                                        onTap: () {
                                           controller.setRemoveTop(f, 1);
                                        },
                                        child: Container(
                                            padding: const EdgeInsets.all(4),
                                            child: const Icon(
                                              CupertinoIcons
                                                  .arrow_turn_down_right,
                                              color: appColorLogoDeep,
                                              size: 18,
                                            )),
                                      ),
                                    )),
                              ]))
                      .toList(),
                ),
              ),
            )
          ],
        )));

_customCell(String? text, [bool isCenter = false]) => TableCell(
      verticalAlignment: TableCellVerticalAlignment.middle,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Align(
            alignment: isCenter ? Alignment.center : Alignment.centerLeft,
            child: Text(
              text!,
              style: customTextStyle.copyWith(
                  fontSize: 12, fontWeight: FontWeight.w600),
            )),
      ),
    );

_rightPanel(AppTopDoctorListController controller, [int flex = 5]) => Expanded(
    flex: flex,
    child: CustomGroupBox(
        groupHeaderText: "Top Doctor List",
        child: Column(
          children: [
            Table(
              border: CustomTableBorderNew,
              columnWidths: customColumnWidthGenarator(_col2),
              children: [
                TableRow(
                    decoration: CustomTableHeaderRowDecorationnew,
                    children: [
                      //30,100,50,50,50,20
                      CustomTableClumnHeader("ID", Alignment.center),
                      CustomTableClumnHeader(
                        "Name",
                        Alignment.centerLeft,
                      ),
                      CustomTableClumnHeader(
                        "Photo",
                        Alignment.centerLeft,
                      ),
                      CustomTableClumnHeader(
                        "Designation",
                        Alignment.centerLeft,
                      ),

                      CustomTableClumnHeader(
                        "*",
                        Alignment.center,
                      ),
                    ])
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Table(
                  border: CustomTableBorderNew,
                  columnWidths: customColumnWidthGenarator(_col2),
                  children: controller.list_doctor_top
                      .map((f) => TableRow(
                              decoration:
                                  const BoxDecoration(color: Colors.white),
                              children: [
                                _customCell(f.docId, true),
                                _customCell(f.docName),
                                TableCell(
                                    verticalAlignment:
                                        TableCellVerticalAlignment.middle,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.network(
                                          'https://web.asgaralihospital.com/pub/doc_image/${f.imagePath!}',
                                          width: 50.0, // Adjust width as needed
                                          height: 60.0,
                                          fit: BoxFit
                                              .fitHeight, // Adjust height as needed
                                        ),
                                      ),
                                    )),
                                _customCell(f.desig),
                                TableCell(
                                    verticalAlignment:
                                        TableCellVerticalAlignment.middle,
                                    child: Center(
                                      child: InkWell(
                                        onTap: () {
                                          controller.setRemoveTop(f, 0);
                                        },
                                        child: Container(
                                            padding: const EdgeInsets.all(4),
                                            child: const Icon(
                                              CupertinoIcons.delete_left,
                                              color: Colors.red,
                                              size: 18,
                                            )),
                                      ),
                                    )),
                              ]))
                      .toList(),
                ),
              ),
            )
          ],
        )));
