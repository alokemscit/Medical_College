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
    // print(context.width);
    return Obx(() => CommonBody3(
        controller,
        [
          CommonMainWidgetTwo2(
              _leftTestListPart(controller),
              _rightPanelPart(controller),
              context,
              controller.context.width < 1150 &&
                      controller.selectdTestMain.value.id != null
                  ? 0
                  : 4,
              controller.selectdTestMain.value.id != null ? 5 : 0)
        ],
        'Biofire Test Panel Configuration'));
  }
}

Widget _leftTestListPart(BiofirePanelController controller) => !controller
        .isShowTestlist.value
    ? InkWell(
        onTap: () {
          controller.isShowTestlist.value = true;
        },
        child: Container(
            padding: const EdgeInsets.all(4),
            decoration: const BoxDecoration(),
            child: const Icon(
              Icons.menu_sharp,
              size: 18,
              color: appColorPrimary,
            )),
      )
    : SizedBox(
        width: controller.context.width < 600 ? 1000 : 400,
        child: Stack(
          children: [
            CustomGroupBox(
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
                                      controller: controller.txt_search_test,
                                      onChange: (v) {
                                        controller.search_test();
                                      }))
                            ],
                          ),
                          8.heightBox,
                          Expanded(
                            child: CustomTableGenerator(
                                colWidtList: _col0,
                                childrenHeader: [
                                  oneColumnCellBody('ID', 13, Alignment.center,
                                      FontWeight.w600),
                                  oneColumnCellBody('Test Name', 13,
                                      Alignment.centerLeft, FontWeight.w600),
                                  oneColumnCellBody('*', 13, Alignment.center,
                                      FontWeight.w600),
                                ],
                                childrenTableRowList: controller
                                    .list_test_main_temp
                                    .map((f) => TableRow(
                                            decoration: BoxDecoration(
                                                color: controller
                                                            .selectdTestMain
                                                            .value
                                                            .id ==
                                                        f.id
                                                    ? appColorPista
                                                        .withOpacity(0.3)
                                                    : Colors.white),
                                            children: [
                                              oneColumnCellBody(
                                                  f.id!, 11, Alignment.center),
                                              oneColumnCellBody(
                                                  f.name!,
                                                  11,
                                                  Alignment.centerLeft,
                                                  FontWeight.bold),
                                              CustomTableEditCell(() {
                                                controller.load_config_data(f);
                                              }, Icons.settings, appColorBlue)
                                            ]))
                                    .toList()),
                          )
                        ],
                      )),
                )),
            Positioned(
                right: 8,
                top: 16,
                child: controller.selectdTestMain.value.id == null
                    ? const SizedBox()
                    : InkWell(
                        onTap: () {
                          controller.isShowTestlist.value = false;
                        },
                        child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                                //color: appColorGray200,
                                borderRadius: BorderRadius.circular(50)),
                            child: const Icon(
                              Icons.arrow_back_sharp,
                              size: 14,
                              color: appColorBlue,
                            )),
                      ))
          ],
        ),
      );

List<int> _col0 = [30, 150, 20];

Widget _rightPanelPart(BiofirePanelController controller) =>
    controller.selectdTestMain.value.id == null
        ? const SizedBox()
        : Stack(
            children: [
              CustomGroupBox(
                groupHeaderText: 'Config With Pathogen/Resitance Group',
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      _topViewPart(controller),
                      8.heightBox,
                      _mainEntryPartPanel(controller),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 12,
                right: 8,
                child: CustomUndoButtonRounded(
                  onTap: () {
                    controller.undo_panel();
                  },
                ),
              ),
              !controller.isShowPopup.value
                  ? const SizedBox()
                  : _popup(controller),
            ],
          );
Widget _topViewPart(BiofirePanelController controller) => CustomGroupBox(
    groupHeaderText: 'Selected Biofire Test',
    child: Column(
      children: [
        Row(
          children: [
            const CustomTextHeader(text: 'Test Name     :   '),
            Flexible(
                child: CustomTextHeader(
              text: controller.selectdTestMain.value.name!,
              textColor: appColorMint,
              textSize: 14,
            ))
          ],
        ),
        12.heightBox,
        Row(
          children: [
            _filterButton(controller),
            8.widthBox,
            Flexible(child: _filterButton2(controller)),
          ],
        ),
        8.heightBox,
      ],
    ));

Widget _mainEntryPartPanel(BiofirePanelController controller) => Expanded(
      child: CustomGroupBox(
          groupHeaderText: 'Configured Pathogen Group',
          child: controller.context.width > 1480
              ? Row(
                  children: [
                    _entryPartConfig(controller),
                    controller.selectedGroupForAttr.value.id != null
                        ? 4.widthBox
                        : const SizedBox(),
                    controller.selectedGroupForAttr.value.id != null
                        ? _selectedPartAttrConfig(controller)
                        : const SizedBox()
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 4, child: _entryPartConfig(controller)),
                    //  _selectedPartAttrConfig(controller)
                    controller.selectedGroupForAttr.value.id != null
                        ? _selectedPartAttrConfig(controller)
                        : const SizedBox()
                  ],
                )),
    );

Widget _selectedPartAttrConfig(BiofirePanelController controller) =>
    Expanded(
        flex: 5,
        child: Stack(
          children: [
            CustomGroupBox(
                groupHeaderText: 'Attributes',
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const CustomTextHeader(text: 'Attributes for '),
                          4.widthBox,
                          CustomTextHeader(
                            text: controller.selectedGroupForAttr.value.name!,
                            textColor: appColorMint,
                            textSize: 14,
                          )
                        ],
                      ),
                      Expanded(
                        child: CustomTableGenerator(
                            colWidtList: const [
                              20,
                              150,
                              30
                            ],
                            childrenHeader: [
                              oneColumnCellBody('ID', 13, Alignment.center),
                              oneColumnCellBody('Name', 13),
                              oneColumnCellBody('*', 13, Alignment.center)
                            ],
                            childrenTableRowList: controller
                                .list_attr_mastr_temp
                                .map((f) => TableRow(
                                        decoration: const BoxDecoration(
                                            color: Colors.white),
                                        children: [
                                          oneColumnCellBody(
                                              f.id!, 12, Alignment.center),
                                          //  oneColumnCellBody(f.name!),
                                          TableCell(
                                              verticalAlignment:
                                                  TableCellVerticalAlignment
                                                      .middle,
                                              child: InkWell(
                                                onTap: () {
                                                  controller.add_attribute(f);
                                                },
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(4.0),
                                                  child: Text(
                                                    f.name!,
                                                    style: customTextStyle
                                                        .copyWith(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                  ),
                                                ),
                                              )),
                                          CustomTableEditCell(() {
                                            controller.add_attribute(f);
                                          }, Icons.add, appColorBlue)
                                        ]))
                                .toList()),
                      ),
                    ],
                  ),
                )),
            Positioned(
                top: 12,
                right: 8,
                child: CustomUndoButtonRounded(
                  onTap: () {
                    controller.undo_attr_panel();
                  },
                ))
          ],
        ));

Widget _entryPartConfig(BiofirePanelController controller) => SizedBox(
      width: controller.isShowTestlist.value ? 600 : 800,
      child: Stack(
        children: [
          CustomGroupBox(
              bgColor: Colors.white,
              groupHeaderText: 'Config',
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: controller.list_temp_group_added
                            .map(
                              (f) => _node(
                                  8,
                                  Text(
                                    f.name!,
                                    style: customTextStyle.copyWith(
                                        fontSize: 16,
                                        color: controller.selectedGroupForAttr
                                                    .value.id ==
                                                f.id
                                            ? appColorPrimary
                                            : appColorMint),
                                  ),
                                  Row(
                                    children: [
                                      InkWell(
                                          onTap: () {
                                            controller.delete_temp(f);
                                          },
                                          child: Container(
                                              padding: const EdgeInsets.all(4),
                                              decoration: BoxDecoration(
                                                  color: appColorGray200,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50)),
                                              child: const Icon(
                                                Icons.delete,
                                                color: Colors.red,
                                                size: 14,
                                              ))),
                                      4.widthBox,
                                      controller.list_temp_group_added
                                                  .indexOf(f) ==
                                              0
                                          ? const SizedBox()
                                          : InkWell(
                                              onTap: () {
                                                controller.group_inedxChange(f);
                                              },
                                              child: Container(
                                                  padding:
                                                      const EdgeInsets.all(4),
                                                  decoration: BoxDecoration(
                                                      color: appColorGray200,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50)),
                                                  child: const Icon(
                                                    Icons.arrow_upward,
                                                    color: appColorPrimary,
                                                    size: 16,
                                                  ))),
                                      4.widthBox,
                                      InkWell(
                                          onTap: () {
                                            controller.show_attr_for_add(f);
                                          },
                                          child: Container(
                                              padding: const EdgeInsets.all(4),
                                              decoration: BoxDecoration(
                                                  color: appColorGray200,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50)),
                                              child: const Icon(
                                                Icons.add,
                                                color: appColorBlue,
                                                size: 16,
                                              ))),
                                    ],
                                  ),
                                  [
                                    ...controller.list_attr_for_added
                                        .where((e) => e.gid == f.id)
                                        .map((a) => Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 6,
                                                      vertical: 2),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: Container(
                                                      //   padding: EdgeInsets.symmetric(vertical: 2),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4),
                                                        color: kBgColorG,
                                                        //border: Border.all(width: 0.1,color: Colors.black)
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            a.name!,
                                                            style: customTextStyle
                                                                .copyWith(
                                                                    fontSize:
                                                                        11.5,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    color: Colors
                                                                        .black),
                                                          ),
                                                          Row(
                                                            children: [
                                                              InkWell(
                                                                onTap: () {
                                                                  controller
                                                                      .delete_Attr(
                                                                          a);
                                                                },
                                                                child:
                                                                    Container(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          4),
                                                                  decoration: BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              50)),
                                                                  child:
                                                                      const Icon(
                                                                    Icons
                                                                        .delete,
                                                                    size: 12,
                                                                    color: Colors
                                                                        .red,
                                                                  ),
                                                                ),
                                                              ),
                                                              8.widthBox,
                                                              InkWell(
                                                                onTap: () {
                                                                  controller
                                                                      .attr_inedxChange(
                                                                          a);
                                                                },
                                                                child:
                                                                    Container(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          4),
                                                                  decoration: BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              50)),
                                                                  child: const Icon(
                                                                      Icons
                                                                          .arrow_upward,
                                                                      size: 12,
                                                                      color:
                                                                          appColorPrimary),
                                                                ),
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ))
                                  ]),
                            )
                            .toList(),
                      ),
                    ),
                  ),
                  24.heightBox,
                ],
              )),
          controller.list_temp_group_added.isEmpty
              ? const SizedBox()
              : Positioned(
                  right: 12,
                  bottom: 4,
                 // left: 0,
                  child: CustomButton(Icons.save, 'Save', () {
                    controller.save();
                  },appColorGrayLight,
                      appColorGrayLight,
                    appColorPrimary))
        ],
      ),
    );

Widget _filterButton(BiofirePanelController controller) => Row(
      children: [
        const CustomTextHeader(
          text: 'Add Pathogen:',
          textSize: 12,
        ),
        4.widthBox,
        CustomFilterButtonRounded(
          onTap: () {
            controller.popUpDataGenerate('1');
          },
        )
      ],
    );
_filterButton2(BiofirePanelController controller) => Row(
      children: [
        const CustomTextHeader(
          text: 'Add Resistance:',
          textSize: 12,
        ),
        4.widthBox,
        CustomFilterButtonRounded(
          onTap: () {
            controller.popUpDataGenerate('2');
          },
        )
      ],
    );

_popup(BiofirePanelController controller) => Positioned(
    top: 0,
    left: 0,
    child: Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: controller.context.width < 800 ? 380 : 600,
            height: 170,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(8)),
                boxShadow: [
                  BoxShadow(
                      color: appColorGrayDark, spreadRadius: 0.1, blurRadius: 5)
                ]),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 1),
                        decoration: CustomCaptionDecoration(),
                        child: CustomTextHeader(
                          text:
                              '${controller.popUpHeaderName.value}  For (${controller.selectdTestMain.value.name})',
                          textColor: appColorMint,
                          textSize: 11,
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                    child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  child: CustomTableGenerator(
                      colWidtList: const [
                        20,
                        200
                      ],
                      childrenHeader: [
                        oneColumnCellBody('Id', 13, Alignment.center),
                        oneColumnCellBody('Name', 13),
                      ],
                      childrenTableRowList: controller.list_PathRes_temp
                          .map((f) => TableRow(children: [
                                TableCell(
                                    verticalAlignment:
                                        TableCellVerticalAlignment.middle,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 3),
                                      child: Text(
                                        f.id!,
                                        style: customTextStyle.copyWith(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12),
                                      ),
                                    )),
                                TableCell(
                                    verticalAlignment:
                                        TableCellVerticalAlignment.middle,
                                    child: InkWell(
                                      onTap: () {
                                        controller.add_tempGroup(f);
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 3),
                                        child: Text(
                                          f.name!,
                                          style: customTextStyle.copyWith(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12),
                                        ),
                                      ),
                                    ))
                              ]))
                          .toList()),
                ))
              ],
            ),
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

Widget _node(@required double leftPad, @required Widget name,
        @required Widget event, @required List<Widget> children) =>
    Padding(
        padding: EdgeInsets.only(left: leftPad),
        child: CustomPanel(
          isSelectedColor: false,
          isSurfixIcon: false,
          isLeadingIcon: false,
          isExpanded: true,
          title: Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [name, event],
            ),
          ),

          /// Ledger-------
          children: children,
        ));
