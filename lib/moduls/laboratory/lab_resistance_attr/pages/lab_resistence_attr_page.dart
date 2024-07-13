
import '../../../../core/config/const.dart';
import '../controller/lab_resistence_attr_controller.dart';

class ResistenceAttr extends StatelessWidget {
  const ResistenceAttr({super.key});
  void disposeController() {
    try {
      Get.delete<RsistenceAttrController>();
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    final RsistenceAttrController controller = Get.put(RsistenceAttrController());
    controller.context = context;
    return Obx(() => CommonBody3(
        controller,
        [
          CommonMainWidgetTwo2(
              _entryPart(controller), _viewPart(controller), context)
        ],
        'Resistence Attributes'));
  }
}

Widget _entryPart(RsistenceAttrController controller) => SizedBox(
      width: 600,
      child: CustomGroupBox(
          groupHeaderText: 'Resistence Group List for Config',
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomGroupBox(
                borderWidth: 0.1,
                groupHeaderText: '',
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Flexible(
                            child: CustomSearchBox(
                                caption: 'Search',
                                width: 350,
                                borderRadious: 4,
                                controller: controller.txt_serach,
                                onChange: (v) {
                                  controller.searhGroup();
                                }))
                      ],
                    ),
                    8.heightBox,
                    Expanded(
                      child: CustomTableGenerator(
                          colWidtList: _col0,
                          childrenHeader: [
                            oneColumnCellBody(
                                'ID', 13, Alignment.center, FontWeight.w600),
                            oneColumnCellBody('Resistence Group Name', 13,
                                Alignment.centerLeft, FontWeight.w600),
                            oneColumnCellBody(
                                '*', 13, Alignment.center, FontWeight.w600),
                          ],
                          childrenTableRowList: controller.list_pathogen_temp
                              .map((f) => TableRow(
                                      decoration: BoxDecoration(
                                          color: controller.selectedPathogen
                                                      .value.id ==
                                                  f.id
                                              ? appColorPista.withOpacity(0.3)
                                              : Colors.white),
                                      children: [
                                        oneColumnCellBody(
                                            f.id!, 12, Alignment.center),
                                        oneColumnCellBody(f.name!),
                                        CustomTableEditCell(() {
                                          controller.selectedPathogen.value = f;
                                          controller.loadAttr();
                                        }, Icons.settings, appColorBlue)
                                      ]))
                              .toList()),
                    )
                  ],
                )),
          )),
    );

List<int> _col0 = [30, 150, 20];
List<int> _col_attr = [100, 20];
Widget _viewPart(RsistenceAttrController controller) => controller
            .selectedPathogen.value.id ==
        null
    ? const SizedBox()
    : Stack(
        children: [
          CustomGroupBox(
            groupHeaderText: 'Resistence Attributes Entry',
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          CustomGroupBox(
                              groupHeaderText: 'Selected Resistence Group',
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      const CustomTextHeader(
                                          text: 'Resistence Group     :   '),
                                      Flexible(
                                          child: CustomTextHeader(
                                        text: controller
                                            .selectedPathogen.value.name!,
                                        textColor: appColorMint,
                                        textSize: 14,
                                      ))
                                    ],
                                  ),
                                  12.heightBox,
                                  Row(
                                    children: [
                                      const CustomTextHeader(
                                          text: 'Resistence Attribute : '),
                                      8.widthBox,
                                      Flexible(
                                          child: CustomTextBox(
                                              caption: '',
                                              width: 350,
                                              controller:
                                                  controller.txt_attr_name,
                                              onChange: (v) {})),
                                      12.widthBox,
                                      CustomButton(
                                          controller.selectedEdit.value.id ==
                                                  null
                                              ? Icons.add
                                              : Icons.update,
                                          controller.selectedEdit.value.id ==
                                                  null
                                              ? 'Add'
                                              : 'Update', () {
                                        controller.add_Attr_temp();
                                      }, appColorGrayLight, appColorGrayLight,
                                          appColorGrayDark),
                                      controller.selectedEdit.value.id == null
                                          ? const SizedBox()
                                          : Row(
                                              children: [
                                                8.widthBox,
                                                CustomUndoButtonRounded(
                                                  onTap: () {
                                                    controller.undoE();
                                                  },
                                                  bgColor: Colors.transparent,
                                                )
                                              ],
                                            )
                                    ],
                                  ),
                                  8.heightBox,
                                ],
                              )),
                          8.heightBox,
                          controller.list_attr_temp.isEmpty
                              ? const SizedBox()
                              : Stack(
                                  children: [
                                    SizedBox(
                                      height: 300,
                                      child: CustomGroupBox(
                                          groupHeaderText:
                                              'Resistence Attribute for save',
                                          child: Column(
                                            children: [
                                              CustomTableHeaderWeb(
                                                  colWidtList: _col_attr,
                                                  children: [
                                                    oneColumnCellBody(
                                                        'Resistence Name',
                                                        13,
                                                        Alignment.centerLeft,
                                                        FontWeight.w600),
                                                    oneColumnCellBody(
                                                        '*',
                                                        13,
                                                        Alignment.center,
                                                        FontWeight.w600),
                                                  ]),
                                              Expanded(
                                                child: SingleChildScrollView(
                                                  child: Table(
                                                      columnWidths:
                                                          customColumnWidthGenarator(
                                                              _col_attr),
                                                      border:
                                                          CustomTableBorderNew,
                                                      children: controller
                                                          .list_attr_temp
                                                          .map((f) => TableRow(
                                                                  decoration:
                                                                      const BoxDecoration(
                                                                          color:
                                                                              Colors.white),
                                                                  children: [
                                                                    oneColumnCellBody(
                                                                        f.name!),
                                                                    CustomTableEditCell(
                                                                        () {
                                                                      controller
                                                                          .delete_attr_temp(
                                                                              f);
                                                                    },
                                                                        Icons
                                                                            .delete,
                                                                        Colors
                                                                            .red)
                                                                  ]))
                                                          .toList()),
                                                ),
                                              )
                                            ],
                                          )),
                                    ),
                                    Positioned(
                                        bottom: 8,
                                        right: 8,
                                        child: CustomButton(
                                            Icons.arrow_downward_sharp, 'Save',
                                            () {
                                          controller.save();
                                        }, appColorGrayLight, appColorGrayLight,
                                            appColorPrimary))
                                  ],
                                ),
                          CustomGroupBox(
                              groupHeaderText: 'Resistence Attributes List',
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Flexible(
                                          child: CustomSearchBox(
                                            borderRadious: 4,
                                              caption: 'Search',
                                              width: 400,
                                              controller:
                                                  controller.txt_serach_attr,
                                              onChange: (v) {
                                                controller.searhAttr();
                                              }))
                                    ],
                                  ),
                                  8.heightBox,
                                  CustomTableHeaderWeb(
                                      colWidtList: _col3,
                                      children: [
                                        oneColumnCellBody('ID', 13,
                                            Alignment.center, FontWeight.w600),
                                        oneColumnCellBody(
                                            'Attributes Name',
                                            13,
                                            Alignment.centerLeft,
                                            FontWeight.w600),
                                        oneColumnCellBody('*', 13,
                                            Alignment.center, FontWeight.w600),
                                      ]),
                                  Table(
                                      border: CustomTableBorderNew,
                                      columnWidths:
                                          customColumnWidthGenarator(_col3),
                                      children: controller.list_saved_attr_temp
                                          .map((f) => TableRow(
                                                  decoration: BoxDecoration(
                                                      color: controller
                                                                  .selectedEdit
                                                                  .value
                                                                  .id ==
                                                              f.id
                                                          ? appColorPista
                                                              .withOpacity(0.3)
                                                          : Colors.white),
                                                  children: [
                                                    oneColumnCellBody(f.id!, 12,
                                                        Alignment.center),
                                                    oneColumnCellBody(f.name!),
                                                    CustomTableEditCell(() {
                                                      controller.edit(f);
                                                    })
                                                  ]))
                                          .toList()),
                                ],
                              ))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 12,
            right: 8,
            child: InkWell(
              onTap: () {
                controller.undo();
              },
              child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                      color: appColorGray200,
                      borderRadius: BorderRadiusDirectional.circular(50)),
                  child: const Icon(
                    Icons.undo,
                    size: 18,
                    color: appColorLogoDeep,
                  )),
            ),
          )
        ],
      );
List<int> _col3 = [30, 150, 20];
