import '../../../../core/config/const.dart';
import '../controller/lab_resistance_group_controller.dart';

class ResistanceGroup extends StatelessWidget {
  const ResistanceGroup({super.key});
  void disposeController() {
    try {
      Get.delete<ResistanceGroupController>();
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    final ResistanceGroupController controller =
        Get.put(ResistanceGroupController());
    controller.context = context;
    return Obx(() => CommonBody3(
        controller,
        [
          CommonMainWidgetTwo2(
              _entryPart(controller), _viewPart(controller), context)
        ],
        'Resistance Group Master'));
  }
}

Widget _entryPart(ResistanceGroupController controller) => SizedBox(
      width: 600,
      child: CustomGroupBox(
          groupHeaderText: 'Entry',
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                CustomGroupBox(
                    groupHeaderText: '',
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const CustomTextHeader(
                                text: 'Resistance Group : ',
                                textColor: appColorMint,
                              ),
                              8.widthBox,
                              Expanded(
                                  child: CustomTextBox(
                                      caption: '',
                                      controller: controller.txt_name,
                                      onChange: (v) {},
                                      onSubmitted: (v) {
                                        if (v.isNotEmpty) {
                                          controller.add();
                                        }
                                      }))
                            ],
                          ),
                          10.heightBox,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                   
                                  
                                  
                                  Checkbox(
                                      value: controller.chk_isnote.value,
                                      onChanged: (v) {
                                        controller.chk_isnote.value = v!;
                                      }),
                                  8.widthBox,
                                  const CustomTextHeader(
                                    text: 'Is Note Required',
                                    textColor: appColorMint,
                                  ),
                                ],
                              ),
                              CustomButton(Icons.add, "Add", () {
                                controller.add();
                              }, appColorGrayLight, appColorGrayLight,
                                  appColorGrayDark)
                            ],
                          )
                        ],
                      ),
                    )),
                10.heightBox,
                Expanded(
                  child: Stack(
                    children: [
                      CustomGroupBox(
                          groupHeaderText: 'Temporary Resistance Group',
                          child: CustomTableGenerator(
                            colWidtList: _col,
                            childrenHeader: [
                              oneColumnCellBody('Resistance Group Name', 13,
                                  Alignment.centerLeft, FontWeight.w600),
                              
                              oneColumnCellBody('Is note', 13, Alignment.center,
                                  FontWeight.w600),
                              oneColumnCellBody(
                                  '*', 13, Alignment.center, FontWeight.w600),
                            ],
                            childrenTableRowList: controller.list_tmp_pathGroup
                                .map((f) => TableRow(
                                        decoration: const BoxDecoration(
                                            color: Colors.white),
                                        children: [
                                          oneColumnCellBody(f.name!),
                                          
                                          oneColumnCellBody(
                                              f.isNote == true ? 'Yes' : 'No',
                                              12,
                                              Alignment.center),
                                          CustomTableEditCell(() {
                                            CustomCupertinoAlertWithYesNo(
                                                controller.context,
                                                Text(
                                                  'Are you sure to delete?',
                                                  style:
                                                      customTextStyle.copyWith(
                                                          color: Colors.red),
                                                ),
                                                Text(
                                                  f.name!,
                                                  style:
                                                      customTextStyle.copyWith(
                                                          color: appColorMint),
                                                ),
                                                () {}, () {
                                              controller.delTemp(f);
                                            });
                                          }, Icons.delete, Colors.red)
                                        ]))
                                .toList(),
                          )),
                      controller.list_tmp_pathGroup.isEmpty
                          ? const SizedBox()
                          : Positioned(
                              bottom: 8,
                              right: 8,
                              child: CustomButton(
                                  Icons.arrow_right_sharp, 'Save', () {
                                controller.save();
                              }, appColorGrayLight, appColorGrayLight,
                                  appColorPrimary))
                    ],
                  ),
                )
              ],
            ),
          )),
    );

List<int> _col = [150, 40,  20];
List<int> _col2 = [30, 150,  40, 20];

Widget _viewPart(ResistanceGroupController controller) => CustomGroupBox(
    groupHeaderText: 'View Resistance Group',
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Flexible(
                  child: CustomSearchBox(
                      caption: 'Search',
                      width: 450,
                      controller: controller.txt_search,
                      onChange: (v) {})),
            ],
          ),
          8.heightBox,
          CustomTableHeaderWeb(colWidtList: _col2, children: [
            oneColumnCellBody('ID', 13, Alignment.center, FontWeight.w600),
            oneColumnCellBody(
                'Resistance Group Name', 13, Alignment.centerLeft, FontWeight.w600),
            
            oneColumnCellBody('Is note', 13, Alignment.center, FontWeight.w600),
            oneColumnCellBody('*', 13, Alignment.center, FontWeight.w600),
          ]),
          Expanded(
            child: SingleChildScrollView(
              child: Table(
                columnWidths: customColumnWidthGenarator(_col2),
                border: CustomTableBorderNew,
                children: [],
              ),
            ),
          )
        ],
      ),
    ));
