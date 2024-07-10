import 'package:flutter/rendering.dart';

import '../../../../core/config/const.dart';
import '../controller/lab_biofire_panel_controller.dart';

class BiofirePanel extends StatelessWidget {
  const BiofirePanel({super.key});
  void disposeController() {
    try {
      Get.delete<BiofirePanelController>();
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    final BiofirePanelController controller = Get.put(BiofirePanelController());
    controller.context = context;
    return Obx(() => CommonBody3(
        controller,
        [
          CommonMainWidgetTwo2(
              _entryPart(controller), _viewPart(controller), context)
        ],
        'Biofire Test Panel Configuration'));
  }
}

Widget _entryPart(BiofirePanelController controller) => SizedBox(
      width: 600,
      child: CustomGroupBox(
          groupHeaderText: 'Biofire Test List',
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
                      oneColumnCellBody('Test Name', 13, Alignment.centerLeft,
                          FontWeight.w600),
                      oneColumnCellBody(
                          '*', 13, Alignment.center, FontWeight.w600),
                    ]),



                  ],
                )),
          )),
    );

List<int> _col0 = [30, 150, 20];

Widget _viewPart(BiofirePanelController controller) => Stack(
      children: [
        CustomGroupBox(
          groupHeaderText: 'Config With Pathogen Group',
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                CustomGroupBox(
                    groupHeaderText: 'Selected Biofire Test',
                    child: Column(
                      children: [
                        const Row(
                          children: [
                            CustomTextHeader(text: 'Test Name     :   '),
                            Flexible(
                                child: CustomTextHeader(
                              text: 'Xyz Pathogen Group  ',
                              textColor: appColorMint,
                              textSize: 14,
                            ))
                          ],
                        ),
                        12.heightBox,
                        _filterButton(controller),
                        8.heightBox,
                      ],
                    )),
                8.heightBox,
                Expanded(
                  child: SizedBox(
                    child: Stack(
                      children: [
                        const CustomGroupBox(
                            groupHeaderText: 'Configured Pathogen Group',
                            child: Column(
                              children: [],
                            )),
                        Positioned(
                            bottom: 8,
                            right: 8,
                            child: CustomButtonAnimated(
                              caption: 'Save',
                              icon:   Icons.arrow_downward_sharp,
                               onClick: (){},
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
          child: CustomUndoButtonRounded(onTap: () {
            
          },),
        ),
        !controller.isShowPopup.value ? const SizedBox() : _popup(controller),
      ],
    );
_filterButton(BiofirePanelController controller) => Row(
      children: [
        const CustomTextHeader(text: 'Add Pathogen Group : '),
        4.widthBox,
        CustomFilterButtonRounded(onTap: () {
          controller.isShowPopup.value = true;
        },)
         
      ],
    );

_popup(BiofirePanelController controller) => Positioned(
    top: 50,
    left: 24,
    child: Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 650,
            height: 250,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(8)),
                boxShadow: [
                  BoxShadow(
                      color: appColorGrayDark, spreadRadius: 0.1, blurRadius: 5)
                ]),
          ),
        ),
        Positioned(
            right: 0,
            top: 0,
            child: CustomCloseButtonRounded(
              onTap: () {
                controller.isShowPopup.value = false;
              },
            ))
      ],
    ));
