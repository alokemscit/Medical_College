import '../../../../core/config/const.dart';
import '../controller/lab_pathogen_attr_controller.dart';

class PathogenAttr extends StatelessWidget {
  const PathogenAttr({super.key});
  void disposeController() {
    try {
      Get.delete<PathogenAttrController>();
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    final PathogenAttrController controller = Get.put(PathogenAttrController());
    controller.context = context;
    return Obx(() => CommonBody3(
        controller,
        [
          CommonMainWidgetTwo2(
              _entryPart(controller), _viewPart(controller), context)
        ],
        'Pathogen Attributes'));
  }
}

Widget _entryPart(PathogenAttrController controller) => SizedBox(
      width: 600,
      child: CustomGroupBox(
          groupHeaderText: 'Pathogen Group List',
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
                                controller: TextEditingController(),
                                onChange: (v) {}))
                      ],
                    ),
                    8.heightBox,
                    CustomTableHeaderWeb(colWidtList: _col0, children: [
                      oneColumnCellBody(
                          'ID', 13, Alignment.center, FontWeight.w600),
                      oneColumnCellBody('Pathogen Group', 13,
                          Alignment.centerLeft, FontWeight.w600),
                      oneColumnCellBody(
                          'Is BMC', 13, Alignment.center, FontWeight.w600),
                      oneColumnCellBody(
                          'Is note', 13, Alignment.center, FontWeight.w600),
                      oneColumnCellBody(
                          '*', 13, Alignment.center, FontWeight.w600),
                    ]),
                  ],
                )),
          )),
    );

List<int> _col0 = [30, 150, 40, 40, 20];
List<int> _col_attr = [100, 20];
Widget _viewPart(PathogenAttrController controller) =>
    controller.selectedGroupID.value == ''
        ? const SizedBox()
        : Stack(
            children: [
              CustomGroupBox(
                groupHeaderText: 'Pathogen Attributes Entry',
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              CustomGroupBox(
                                  groupHeaderText: 'Selected Pathogen Group',
                                  child: Column(
                                    children: [
                                      const Row(
                                        children: [
                                          CustomTextHeader(
                                              text: 'Pathogen Group     :   '),
                                          Flexible(
                                              child: CustomTextHeader(
                                            text: 'Xyz Pathogen Group : ',
                                            textColor: appColorMint,
                                            textSize: 14,
                                          ))
                                        ],
                                      ),
                                      12.heightBox,
                                      Row(
                                        children: [
                                          const CustomTextHeader(
                                              text: 'Pathogen Attribute : '),
                                          8.widthBox,
                                          Flexible(
                                              child: CustomTextBox(
                                                  caption: '',
                                                  width: 350,
                                                  controller:
                                                      controller.txt_attr_name,
                                                  onChange: (v) {})),
                                          12.widthBox,
                                          CustomButton(Icons.add, 'Add', () {
                                            controller.add_Attr_temp();
                                          },
                                              appColorGrayLight,
                                              appColorGrayLight,
                                              appColorGrayDark),
                                        ],
                                      ),
                                      8.heightBox,
                                    ],
                                  )),
                              8.heightBox,
                         controller.list_attr_temp.isEmpty?const SizedBox():  Stack(
                                children: [
                                  SizedBox(
                                    height: 300,
                                    child: CustomGroupBox(
                                        groupHeaderText:
                                            'Pathogen Attribute for save',
                                        child: Column(
                                          children: [
                                            CustomTableHeaderWeb(
                                                colWidtList: _col_attr,
                                                children: [
                                                  oneColumnCellBody(
                                                      'Pathogen Name',
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
                                                    border: CustomTableBorderNew,
                                                    children: controller
                                                        .list_attr_temp
                                                        .map((f) => TableRow(
                                                                decoration:
                                                                    const BoxDecoration(
                                                                        color: Colors
                                                                            .white),
                                                                children: [
                                                                  oneColumnCellBody(
                                                                      f.name!),
                                                                  CustomTableEditCell(
                                                                      () {
                                                                    controller
                                                                        .delete_attr_temp(
                                                                            f);
                                                                  }, Icons.delete,
                                                                      Colors.red)
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
                                          Icons.arrow_downward_sharp,
                                          'Save',
                                          () {},
                                          appColorGrayLight,
                                          appColorGrayLight,
                                          appColorPrimary))
                                ],
                              ),
                              CustomGroupBox(
                                  groupHeaderText: 'Pathogen Attributes List',
                                  child: Column(
                                    children: [
                                      CustomTableHeaderWeb(
                                          colWidtList: _col3,
                                          children: [
                                            oneColumnCellBody(
                                                'ID',
                                                13,
                                                Alignment.center,
                                                FontWeight.w600),
                                            oneColumnCellBody(
                                                'Attributes Name',
                                                13,
                                                Alignment.centerLeft,
                                                FontWeight.w600),
                                            oneColumnCellBody(
                                                '*',
                                                13,
                                                Alignment.center,
                                                FontWeight.w600),
                                          ])
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
                    controller.selectedGroupID.value = '';
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
