import 'package:agmc/core/config/const.dart';
import 'package:equatable/equatable.dart';
import 'package:quill_html_editor/quill_html_editor.dart';

import '../../../core/config/delta_to_html_converter.dart';
import '../../../widget/custom_datepicker.dart';
import '../../../widget/custom_snakbar.dart';
import '../lab_outsource_result_entry/model/lab_model_outsource_test_data.dart';
 

class lab_widget {


Widget lab_leftPanel( dynamic controller,double width ,Widget child) =>
    !controller.isShowLeftPanel.value
        ? CustomRoundedButton(
            iconColor: appColorBlue,
            icon: Icons.menu_sharp,
            bgColor: Colors.transparent,
            iconSize: 18,
            onTap: () {
              controller.isShowLeftPanel.value = true;
            })
        : Stack(
            children: [
              !controller.isShowLeftPanel.value
                  ? const SizedBox()
                  : SizedBox(
                      width: width > 1350
                          ? 360
                          : width,
                      child: !controller.isShowLeftPanel.value
                          ? const SizedBox()
                          : CustomGroupBox(
                              groupHeaderText: 'MRR List',
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                  Obx(()=>  lab_widget().lab_filterPanel(controller),),
                                   // _filterPanel(controller),
                                    8.heightBox,
                                    // _treeview(controller),
                                 child,
                                   
                                  ],
                                ),
                              )),
                    ),
              //  controller.selectedMrrID.value.mrId != null &&
              controller.isShowLeftPanel.value
                  ? Positioned(
                      top: 12,
                      right: 4,
                      child: CustomRoundedButton(
                          iconColor: appColorBlue,
                          icon: Icons.arrow_back_sharp,
                          bgColor: Colors.transparent,
                          iconSize: 18,
                          onTap: () {
                            controller.isShowLeftPanel.value = false;
                          }))
                  : const SizedBox(),
            ],
          );





Widget lab_rightPanel(dynamic controller,[String? buttonName]) => Stack(
      children: [
        CustomGroupBox(
            padingvertical: 0,
            groupHeaderText: '',
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  !controller.isShowPatientDetails.value
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () {
                                controller.isShowPatientDetails.value = true;
                              },
                              child: Container(
                                  padding: const EdgeInsets.all(4),
                                  child: const Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    color: appColorLogoDeep,
                                    size: 24,
                                  )),
                            )
                          ],
                        )
                      : _patientDetails(controller),
                 // _bodyEntry(controller)
                 4.heightBox,
                  _lab_htm_wdget(controller.Qcontroller)
                ],
              ),
            )),
        Positioned(
            bottom: 22,
            right: 12,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomButton(Icons.preview, '  Preview  ', () {
                  controller.priview();
                }, appColorGrayLight, appColorGrayLight, appColorLogo),
                24.heightBox,
                CustomButton(Icons.save, buttonName!, () {
                  controller.save();
                }, appColorGrayLight, appColorGrayLight, appColorPrimary)
              ],
            ))
      ],
    );

Widget _patientDetails(dynamic controller) => controller
            .selected_mrr.value.testName ==
        null
    ? const SizedBox()
    : Stack(
        children: [
          CustomGroupBox(
              padingvertical: 4,
              groupHeaderText: 'Patient Details',
              borderWidth: 1.2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 1),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: Colors.black),
                            child: Text(
                              "Result For Entry ",
                              style: customTextStyle.copyWith(
                                  color: Colors.white, fontSize: 11),
                            ))
                      ],
                    ),
                    Row(
                      children: [
                        const CustomTextHeader(
                          text: "Test Name : ",
                          textSize: 14,
                        ),
                        Flexible(
                            child: Container(
                          padding: const EdgeInsets.all(2),
                          color: kBgColorG,
                          // decoration: customBoxDecoration.copyWith(color: kBgColorG,),
                          child: CustomTextHeader(
                            text: controller.selected_mrr.value.testName ?? '',
                            textColor: appColorMint,
                            textSize: 14,
                          ),
                        )),
                        16.widthBox,
                        const CustomTextHeader(
                          text: "Specimen : ",
                          textSize: 14,
                        ),
                        Flexible(
                            child: Container(
                          padding: const EdgeInsets.all(2),
                          color: kBgColorG,
                          child: CustomTextHeader(
                            text: controller.selected_mrr.value.method ?? '',
                            textColor: appColorMint,
                            textSize: 14,
                          ),
                        )),
                      ],
                    ),
                    4.heightBox,
                    Row(
                      children: [
                        const CustomTextHeader(
                          text: "Mr. No  : ",
                          textSize: 14,
                        ),
                        Flexible(
                            child: Container(
                          padding: const EdgeInsets.all(2),
                          color: kBgColorG,
                          child: CustomTextHeader(
                            text: controller.selected_mrr.value.mrId ?? '',
                            textColor: appColorMint,
                            textSize: 14,
                          ),
                        )),
                        16.widthBox,
                        const CustomTextHeader(
                          text: "Sample ID : ",
                          textSize: 14,
                        ),
                        Flexible(
                            child: Container(
                          padding: const EdgeInsets.all(2),
                          color: kBgColorG,
                          child: CustomTextHeader(
                            text: controller.selected_mrr.value.sampleId ?? '',
                            textColor: appColorMint,
                            textSize: 14,
                          ),
                        )),
                      ],
                    ),
                    4.heightBox,
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 36),
                      child: Divider(
                        height: 1.5,
                        color: appColorGrayDark,
                      ),
                    ),
                    4.heightBox,
                    Row(
                      children: [
                        const CustomTextHeader(
                          text: "Pat. Name  : ",
                          textSize: 14,
                        ),
                        Flexible(
                            child: Container(
                          padding: const EdgeInsets.all(2),
                          color: kBgColorG,
                          child: CustomTextHeader(
                            text: controller.selected_mrr.value.pname ?? '',
                            textColor: appColorMint,
                            textSize: 14,
                          ),
                        )),
                        16.widthBox,
                        const CustomTextHeader(
                          text: "Age : ",
                          textSize: 14,
                        ),
                        Flexible(
                            child: Container(
                          padding: const EdgeInsets.all(2),
                          color: kBgColorG,
                          child: CustomTextHeader(
                            text: controller.selected_mrr.value.age ?? '',
                            textColor: appColorMint,
                            textSize: 14,
                          ),
                        )),
                        16.widthBox,
                        const CustomTextHeader(
                          text: "Gender : ",
                          textSize: 14,
                        ),
                        Flexible(
                            child: Container(
                          padding: const EdgeInsets.all(2),
                          color: kBgColorG,
                          child: CustomTextHeader(
                            text: controller.selected_mrr.value.psex == null
                                ? ''
                                : controller.selected_mrr.value.psex == 'M'
                                    ? 'Male'
                                    : 'Femal',
                            textColor: appColorMint,
                            textSize: 14,
                          ),
                        )),
                      ],
                    ),
                    4.heightBox,
                  ],
                ),
              )),
          Positioned(
              top: 12,
              right: 6,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomUndoButtonRounded(
                    onTap: () {
                      controller.isShowPatientDetails.value = false;
                    },
                    icon: Icons.arrow_upward,
                  ),
                  24.widthBox,
                  CustomUndoButtonRounded(onTap: () {
                    controller.undo_panel();
                  }),
                ],
              ))
        ],
      );








Widget _lab_htm_wdget(QuillEditorController  Qcontroller) => Expanded(
        child: Center(
      child: Container(
        width: 794.0, // Approximate A4 width in pixels at 96 DPI
        height: 1123.0, // Approximate A4 height in pixels at 96 DPI
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: appColorGrayDark,
              blurRadius: 1,
              spreadRadius:.1
            )
          ]
        ), // Representing the paper color
        child: Column(
          children: [
            ToolBar(
              toolBarColor: Colors.grey.shade200,
              padding: const EdgeInsets.all(8),
              iconSize: 25,
              iconColor: Colors.black87,
              activeIconColor: Colors.greenAccent.shade400,
              controller: Qcontroller,
              crossAxisAlignment: WrapCrossAlignment.start,
              direction: Axis.horizontal,
              customButtons: [
                InkWell(
                    onTap: () {
                      Qcontroller.clear();
                    },
                    child: const Icon(
                      Icons.remove_done,
                      size: 24,
                      color: appColorLogoDeep,
                    )),
                 // CustomButton(Icons.save, 'Save', (){})
              ],
            ),
            Expanded(
              child: QuillHtmlEditor(
                text: "",
                hintText: '',
                controller: Qcontroller,
                isEnabled: true,
                ensureVisible: false,
                minHeight: 500,
                autoFocus: true,
                textStyle: const TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                    fontFamily: appFontMuli),
                hintTextStyle: const TextStyle(
                    fontSize: 18,
                    color: Colors.black38,
                    fontWeight: FontWeight.normal),
                hintTextAlign: TextAlign.start,
                padding: const EdgeInsets.only(left: 10, top: 10),
                hintTextPadding: const EdgeInsets.only(left: 20),
                backgroundColor: Colors.white70,
                inputAction: InputAction.newline,
                onEditingComplete: (s) => debugPrint('Editing completed $s'),
                loadingBuilder: (context) {
                  return const SizedBox(); // Center(child: CupertinoActivityIndicator(),);
                },

                onFocusChanged: (focus) {
                  // debugPrint('has focus $focus');
                  // setState(() {
                  //   _hasFocus = focus;
                  // });
                },
                //   onTextChanged: (text) => debugPrint('widget text change $text'),
                onEditorCreated: () {
                  //  debugPrint('Editor has been loaded');
                  // setHtmlText('Testing text on load');
                },
                //// onEditorResized: (height) =>
                //  debugPrint('Editor resized $height'),
                // onSelectionChanged: (sel) =>
                // debugPrint('index ${sel.index}, range ${sel.length}'),
              ),
            )
          ],
        ),
      ),
    ));



  Widget lab_node(@required double leftPad, @required String name,
          @required List<Widget> children) =>
      Padding(
          padding: EdgeInsets.only(left: leftPad,bottom: 8),
          child: CustomPanel(
            isSelectedColor: false,
            isSurfixIcon: false,
            isLeadingIcon: false,
            isExpanded: true,
            title: Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    name,
                    style: customTextStyle.copyWith(
                        fontSize: 13, ),
                  )
                ],
              ),
            ),

            /// Ledger-------
            children: children,
          ));

  Widget lab_treeview(
          BuildContext context,
          List<lab_mrr> mrr,
          List<ModelOutSourceTestData> mrrDetails,
          ModelOutSourceTestData selectedMR,
           dynamic controller)=>
      Expanded(
        child: SingleChildScrollView(
          child: Column(
            children: mrr
                .map(
                  (f) => lab_widget().lab_node(0, f.name!, [
                    ...mrrDetails.where((e) => e.mrId == f.id).map((a) =>
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 2),
                          child: InkWell(
                            onTap: () {
                              controller.undo_panel();
                              
                              if (a.sampleId == ' ') {
                                CustomSnackbar(
                                    context: context,
                                    message: "No Test Sample Collected!",
                                    type: MsgType.warning);
                                return;
                              }
                              if (a.isSampleColl == '0') {
                                CustomSnackbar(
                                    context: context,
                                    message: "No Sample Received!",
                                    type: MsgType.warning);
                                return;
                              }
                              // controller.selected_mrr.value = a;
                              controller.setMrr(a);
                              //onTapSetValue(a);

                              // controller.load_patinfo_test_details(a);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 2, horizontal: 8),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      color: selectedMR.sampleId == a.sampleId && selectedMR.testId==a.testId
                                          ? appColorPista.withOpacity(0.8)
                                          : kBgColorG,
                                      //border: Border.all(width: 0.1,color: Colors.black)
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        left: 12,
                                      ),
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.arrow_right,
                                            color: appColorMint,
                                            size: 24,
                                          ),
                                          4.widthBox,
                                          Expanded(
                                            child: Row(
                                              children: [
                                                Text(
                                                  a.sampleId == ' '
                                                      ? 'No Sample'
                                                      : a.sampleId!,
                                                  style: customTextStyle.copyWith(
                                                      fontSize: 11.5,
                                                      fontWeight: FontWeight.w600,
                                                      color: appColorPrimary),
                                                ),4.widthBox,const Icon(Icons.arrow_forward_rounded,size: 14,),4.widthBox,
                                                Expanded(
                                                  child: Text(
                                                     
                                                         a.testName!,
                                                    style: customTextStyle.copyWith(
                                                        fontSize: 10 ,
                                                        fontWeight: FontWeight.w600,
                                                        color: appColorMint),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ))
                  ]),
                )
                .toList(),
          ),
        ),
      );



Widget lab_filterPanel(dynamic controller) =>
    CustomGroupBox(
      groupHeaderText: '',
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomRadioButton(1, controller, "All", () {
                  controller.clickRadioButtpn();
                }),
                14.widthBox,
                CustomRadioButton(2, controller, "OPD", () {
                  controller.clickRadioButtpn();
                }),
                14.widthBox,
                CustomRadioButton(3, controller, "IPD", () {
                  controller.clickRadioButtpn();
                }),
                14.widthBox,
                CustomRadioButton(4, controller, "Emergency.", () {
                  controller.clickRadioButtpn();
                }),
              ],
            ),
            controller.isShowFilter.value ? 14.heightBox : const SizedBox(),
            controller.isShowFilter.value
                ? Row(
                    children: [
                      CustomDatePickerDropDown(
                        date_controller: controller.txt_fdate,
                        width: 120,
                        height: 26,
                        borderRadious: 4,
                        label: 'From ',
                        isBackDate: true,
                        isShowCurrentDate: true,
                      ),
                      12.widthBox,
                      CustomDatePickerDropDown(
                        borderRadious: 4,
                        width: 120,
                        height: 26,
                        date_controller: controller.txt_tdate,
                        isBackDate: true,
                        label: 'To ',
                        isShowCurrentDate: true,
                      ),
                    ],
                  )
                : const SizedBox(),
            12.heightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                    child:  CustomSearchBox(
                  caption: 'Search',
                  controller: controller.txt_search,
                  onChange: (v) {
                    controller.search();
                  },
                  borderRadious: 4,
                )),
                !controller.isShowFilterButton.value?const SizedBox(): 12.widthBox,
             !controller.isShowFilterButton.value?const SizedBox():   CustomFilterButtonRounded(
                    icon: controller.isShowFilter.value
                        ? Icons.undo
                        : Icons.filter_alt,
                    onTap: () {
                      controller.isShowFilter.value =
                          !controller.isShowFilter.value;
                    }),
               !controller.isShowFilter.value?const SizedBox(): 12.widthBox,
               !controller.isShowFilter.value?const SizedBox(): CustomButton(Icons.search, 'Show', () {
                  controller.showFilterData();
                }, appColorGrayDark, appColorGrayDark, appColorGray200)
              ],
            )
          ],
        ),
      ),
    );


Future<String> getHtmlText(QuillEditorController Qcontroller) async {
    Map<dynamic, dynamic> l = await Qcontroller.getDelta();

    var y = Delta.fromJson(l['ops']);

    var k = y.toHtml(options: ConverterOptions.forEmail());
    //print(k);
    var k1 = k
        .replaceAll('<table>',
            '<table style="width:100%;border: 1px solid black;border-collapse: collapse;">')
        .replaceAll('<tr>', '<tr style="border: 1px solid black;">')
        .replaceAll('<td',
            '<td style="border: 1px solid black; padding-left: 10px; margin-left:10px;"')
        .replaceAll('class="ql-align-center"', 'style="text-align:center"')
        .replaceAll('class="ql-align-right"', 'style="text-align:right"')
        .replaceAll('class="ql-size-small"', 'style="font-size:small"')
        .replaceAll('class="ql-size-large"', 'style="font-size:large"')
        .replaceAll('class="ql-size-huge"', 'style="font-size:x-large"')
        .replaceAll('<br/>', '<br/>\n')
        .replaceAll('<br>', '<br>\n')
        .replaceAll('class="ql-align-right"', 'style="text-align:right"');
    // print(k1);
    return k1;
  }


Future<String> getHtmlFromDelta( Map<dynamic, dynamic> l) async {
   // Map<dynamic, dynamic> l = await Qcontroller.getDelta();

    var y = Delta.fromJson(l['ops']);

    var k = y.toHtml(options: ConverterOptions.forEmail());
    //print(k);
    var k1 = k
        .replaceAll('<table>',
            '<table style="width:100%;border: 1px solid black;border-collapse: collapse;">')
        .replaceAll('<tr>', '<tr style="border: 1px solid black;">')
        .replaceAll('<td',
            '<td style="border: 1px solid black; padding-left: 10px; margin-left:10px;"')
        .replaceAll('class="ql-align-center"', 'style="text-align:center"')
        .replaceAll('class="ql-align-right"', 'style="text-align:right"')
        .replaceAll('class="ql-size-small"', 'style="font-size:small"')
        .replaceAll('class="ql-size-large"', 'style="font-size:large"')
        .replaceAll('class="ql-size-huge"', 'style="font-size:x-large"')
        .replaceAll('<br/>', '<br/>\n')
        .replaceAll('<br>', '<br>\n')
        .replaceAll('class="ql-align-right"', 'style="text-align:right"');
    // print(k1);
    return k1;
  }

}




// ignore: must_be_immutable
class lab_mrr extends Equatable {
  String? id;
  String? name;
  lab_mrr({
    this.id,
    this.name,
  });

  @override
  List<Object?> get props => [id, name];
}


