import 'package:agmc/widget/custom_datepicker.dart';

import '../../../../core/config/const.dart';

import '../controller/mc_fee_collection_controller.dart';

class McFeeCollection extends StatelessWidget {
  const McFeeCollection({super.key});
  void disposeController() {
    try {
      Get.delete<McFeeCollectionController>();
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    final McFeeCollectionController controller =
        Get.put(McFeeCollectionController());
    controller.context = context;
    print(context.width);
    return Obx(() => CommonBody3(
        controller,
        [
          Expanded(
            child: Row(
              children: [
                SizedBox(
                  width: 600,
                  child: Column(
                    children: [
                      _topPanel(controller),
                      8.heightBox,
                      _collectionPanel(controller),
                    ],
                  ),
                ),
                _space(controller),
                _rightPanel(controller),
              ],
            ),
          )
        ],
        'Fees Collection'));
  }
}

_space(McFeeCollectionController controller) =>
    controller.selectedStudent.value.id == null ||
            controller.context.width < 1250
        ? const SizedBox()
        : 8.widthBox;

Widget _rightPanel(McFeeCollectionController controller) =>
    controller.selectedStudent.value.id == null ||
            controller.context.width < 1250
        ? const SizedBox()
        : Expanded(
            child: CustomGroupBox(
                groupHeaderText: 'Transaction History',
                child: Column(
                  children: [
                    CustomGroupBox(
                      groupHeaderText: 'Student Details',
                      child: _studentInfo2(controller),
                    ),
                    8.heightBox,
                    Expanded(
                        child: CustomGroupBox(
                            bgColor: Colors.white,
                            groupHeaderText: 'Transaction Details',
                            child: Column(
                              children: [
                                Expanded(child: _tranDetails(controller)),
                              ],
                            )))
                  ],
                )));

Widget _tranDetails(McFeeCollectionController controller) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: SingleChildScrollView(
        child: controller.radioValue.value == '1'
            ? _outstandingTrans(controller)
            : _collectionTransaction(controller),
      ),
    );

_collectionTransaction(McFeeCollectionController controller) => Column(
      children: [
        ...controller.list_trans_fee_head.map((f) {
          return Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Table(
              // border: CustomTableBorderNew,
              children: [
                TableRow(
                    decoration: BoxDecoration(
                      color: appGray50,
                    ),
                    children: [
                      TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const CustomTextHeader(
                                      text: 'Transaction No : '),
                                  8.widthBox,
                                  Text(
                                    f.tno!,
                                    style: customTextStyle.copyWith(
                                        fontSize: 14, color: Colors.black),
                                  ),
                                  12.widthBox,
                                  const CustomTextHeader(
                                      text: 'Transaction Date : '),
                                  8.widthBox,
                                  Text(
                                    f.tdate!,
                                    style: customTextStyle.copyWith(
                                        fontSize: 14, color: Colors.black),
                                  ),
                                ],
                              ),
                              Table(
                                columnWidths:
                                    customColumnWidthGenarator(_col_col),
                                children: [
                                  TableRow(
                                      decoration: const BoxDecoration(
                                          color: Colors.white),
                                      children: [
                                        TableCell(
                                            verticalAlignment:
                                                TableCellVerticalAlignment
                                                    .middle,
                                            child: Text(
                                              'Particulars',
                                              style: customTextStyle.copyWith(
                                                  fontSize: 14,
                                                  color: appColorMint,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                        TableCell(
                                            verticalAlignment:
                                                TableCellVerticalAlignment
                                                    .middle,
                                            child: Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Text(
                                                  'Amount',
                                                  style:
                                                      customTextStyle.copyWith(
                                                          fontSize: 14,
                                                          color: appColorMint,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                ))),
                                      ])
                                ],
                              ),
                              ...controller.list_trans_fee
                                  .where((e) => e.trid == f.id)
                                  .map((a) => Table(
                                        columnWidths:
                                            customColumnWidthGenarator(
                                                _col_col),
                                        children: [
                                          TableRow(
                                              decoration: const BoxDecoration(
                                                  color: Colors.white),
                                              children: [
                                                TableCell(
                                                    verticalAlignment:
                                                        TableCellVerticalAlignment
                                                            .middle,
                                                    child: Text(a.hname!)),
                                                TableCell(
                                                    verticalAlignment:
                                                        TableCellVerticalAlignment
                                                            .middle,
                                                    child: Align(
                                                        alignment: Alignment
                                                            .centerRight,
                                                        child: Text(a.trnamt
                                                            .toString()))),
                                              ])
                                        ],
                                      ))
                            ],
                          )),
                    ])
              ],
            ),
          );
        }),
     controller.list_trans_fee.isEmpty?SizedBox():   Table(columnWidths: customColumnWidthGenarator(_col_col),
        children: [
          TableRow(
            decoration: const BoxDecoration(color: kBgColorG),
            children: [
               TableCell(
                                                    verticalAlignment:
                                                        TableCellVerticalAlignment
                                                            .middle,
                                                    child: Align(
                                                        alignment: Alignment
                                                            .centerRight,
                                                        child: Text('Grand Total'
                                                    .toString(),style: customTextStyle.copyWith(fontSize: 15,color:appColorMint),))),
                                                            TableCell(
                                                    verticalAlignment:
                                                        TableCellVerticalAlignment
                                                            .middle,
                                                    child: Align(
                                                        alignment: Alignment
                                                            .centerRight,
                                                        child: Text(  controller.list_trans_fee.fold(0.00, (sum, item) => sum +  double.parse(item.trnamt!.toString())).toString()
                                                            ,style: customTextStyle.copyWith(fontSize: 15,color: appColorMint),)))
            ]
          )
        ],
        )
        // CustomTableHeaderWeb(colWidtList: colWidtList, children: children)
      ],
    );

List<int> _col_col = [100, 50];

_outstandingTrans(McFeeCollectionController controller) => Column(
      children: [
        ...controller.list_head.map((f) {
          return Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Table(
              // border: CustomTableBorderNew,
              children: [
                TableRow(
                    decoration: BoxDecoration(
                      color: appGray50,
                    ),
                    children: [
                      TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                f.name!,
                                style: customTextStyle.copyWith(
                                    fontSize: 14, color: Colors.black),
                              ),
                              Table(
                                columnWidths:
                                    customColumnWidthGenarator(_col_trns),
                                children: [
                                  TableRow(
                                      decoration: const BoxDecoration(
                                          color: Colors.white),
                                      children: [
                                        TableCell(
                                            verticalAlignment:
                                                TableCellVerticalAlignment
                                                    .middle,
                                            child: Text(
                                              'Date',
                                              style: customTextStyle.copyWith(
                                                  fontSize: 14,
                                                  color: appColorMint,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                        TableCell(
                                            verticalAlignment:
                                                TableCellVerticalAlignment
                                                    .middle,
                                            child: Text(
                                              'Transaction no.',
                                              style: customTextStyle.copyWith(
                                                  fontSize: 14,
                                                  color: appColorMint,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                        TableCell(
                                            verticalAlignment:
                                                TableCellVerticalAlignment
                                                    .middle,
                                            child: Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Text(
                                                  'Opening',
                                                  style:
                                                      customTextStyle.copyWith(
                                                          fontSize: 14,
                                                          color: appColorMint,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                ))),
                                        TableCell(
                                            verticalAlignment:
                                                TableCellVerticalAlignment
                                                    .middle,
                                            child: Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Text(
                                                  'Trans. Amount',
                                                  style:
                                                      customTextStyle.copyWith(
                                                          fontSize: 14,
                                                          color: appColorMint,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                ))),
                                        TableCell(
                                            verticalAlignment:
                                                TableCellVerticalAlignment
                                                    .middle,
                                            child: Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Text(
                                                  'Closing',
                                                  style:
                                                      customTextStyle.copyWith(
                                                          fontSize: 14,
                                                          color: appColorMint,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                ))),
                                      ])
                                ],
                              ),
                              ...controller.list_trans
                                  .where((e) => e.id == f.id)
                                  .map((a) => Table(
                                        columnWidths:
                                            customColumnWidthGenarator(
                                                _col_trns),
                                        children: [
                                          TableRow(
                                              decoration: const BoxDecoration(
                                                  color: Colors.white),
                                              children: [
                                                TableCell(
                                                    verticalAlignment:
                                                        TableCellVerticalAlignment
                                                            .middle,
                                                    child: Text(a.date!)),
                                                TableCell(
                                                    verticalAlignment:
                                                        TableCellVerticalAlignment
                                                            .middle,
                                                    child: Text(a.tno!)),
                                                TableCell(
                                                    verticalAlignment:
                                                        TableCellVerticalAlignment
                                                            .middle,
                                                    child: Align(
                                                      alignment:
                                                          Alignment.centerRight,
                                                      child: Text(
                                                          a.oamt.toString()),
                                                    )),
                                                TableCell(
                                                    verticalAlignment:
                                                        TableCellVerticalAlignment
                                                            .middle,
                                                    child: Align(
                                                      alignment:
                                                          Alignment.centerRight,
                                                      child: Text(
                                                          a.tamt.toString()),
                                                    )),
                                                TableCell(
                                                    verticalAlignment:
                                                        TableCellVerticalAlignment
                                                            .middle,
                                                    child: Align(
                                                        alignment: Alignment
                                                            .centerRight,
                                                        child: Text(
                                                            a.bal.toString()))),
                                              ])
                                        ],
                                      ))
                            ],
                          )),
                    ])
              ],
            ),
          );
        })
        // CustomTableHeaderWeb(colWidtList: colWidtList, children: children)
      ],
    );

// Date
// Trans. No
// Opening
// Trans amt
// cloasing
List<int> _col_trns = [
  50,
  60,
  50,
  50,
  60,
];

List<int> _col3 = [
  30,
  50,
];

_studentInfo2(McFeeCollectionController controller) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          Row(
            children: [
              const CustomTextHeader(
                text: "Student ID   : ",
                textSize: 13,
              ),
              CustomTextHeader(
                text: controller.selectedStudent.value.stId == null
                    ? ''
                    : controller.selectedStudent.value.stId!,
                textSize: 13,
                textColor: appColorMint,
              ),
            ],
          ),
          8.heightBox,
          Row(
            children: [
              const CustomTextHeader(
                text: "Name         : ",
                textSize: 13,
              ),
              CustomTextHeader(
                text: controller.selectedStudent.value.name == null
                    ? ''
                    : controller.selectedStudent.value.name!,
                textSize: 13,
                textColor: appColorMint,
              ),
            ],
          ),
          18.heightBox,
          Row(
            children: [
              CustomDatePickerDropDown(
                width: 120,
                borderRadious: 4,
                label: 'From Date',
                date_controller: controller.txt_fdate,
                isBackDate: true,
                isShowCurrentDate: true,
              ),
              Flexible(child: 12.widthBox),
              // Flexible(child: 12.widthBox),
              // const Flexible(
              //   child: CustomTextHeader(
              //     text: "To Date : ",
              //     textSize: 13,
              //   ),
              // ),
              CustomDatePickerDropDown(
                borderRadious: 4,
                width: 120,
                label: 'To Date',
                date_controller: controller.txt_tdate,
                isBackDate: true,
                isShowCurrentDate: true,
              ),
              Flexible(child: 12.widthBox),

              CustomButton(Icons.search, 'Show', () {
                if (controller.radioValue.value == '1') {
                  controller.showData_outstanding();
                } else {
                  controller.show_Transaction();
                }
              }, Colors.black, appColorBlue, appGray50),
            ],
          ),
          Row(
            children: [
              Radio<String>(
                value: '1',
                groupValue: controller.radioValue.value,
                onChanged: (value) {
                  controller.radioValue.value = value!;
                  controller.list_head.clear();
                  controller.list_trans.clear();
                },
              ),
              Text(
                'Outstanding',
                style: customTextStyle.copyWith(
                    fontSize: 12,
                    color: controller.radioValue.value == '1'
                        ? appColorMint
                        : Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              20.widthBox,
              Radio<String>(
                value: '2',
                groupValue: controller.radioValue.value,
                onChanged: (value) {
                  controller.radioValue.value = value!;
                  controller.list_head.clear();
                  controller.list_trans.clear();
                },
              ),
              Text(
                'Collection',
                style: customTextStyle.copyWith(
                    fontSize: 12,
                    color: controller.radioValue.value == '2'
                        ? appColorMint
                        : Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ],
          )
        ],
      ),
    );

Widget _collectionPanel(McFeeCollectionController controller) => controller
        .list_coll_attr.isEmpty
    ? const SizedBox()
    : Expanded(
        child: Row(
          children: [
            Flexible(
                child: SizedBox(
              width: 600,
              child: Stack(
                children: [
                  CustomGroupBox(
                      groupHeaderText: 'Collection Details',
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const CustomTextHeader(
                                  text: "Coll. Date :",
                                  textSize: 13,
                                  textColor: Colors.black,
                                ),
                                CustomDatePickerDropDown(
                                  date_controller: controller.txt_date,
                                  isShowCurrentDate: true,
                                  isBackDate: true,
                                ),
                                12.widthBox,
                                const CustomTextHeader(
                                  text: "Remarks :",
                                  textSize: 13,
                                  textColor: Colors.black,
                                ),
                                Expanded(
                                    child: CustomTextBox(
                                        caption: "",
                                        maxlength: 250,
                                        controller: controller.txt_remarks,
                                        onChange: (v) {})),
                              ],
                            ),
                            12.heightBox,
                            CustomTableHeaderWeb(colWidtList: _col2, children: [
                              oneColumnCellBody("Head Name"),
                              oneColumnCellBody(
                                  "Outstanding", 12, Alignment.centerRight),
                              oneColumnCellBody(
                                  "Coll. Amount", 12, Alignment.centerRight),
                              oneColumnCellBody("Remarks"),
                            ]),
                            Expanded(
                                child: SingleChildScrollView(
                              child: Table(
                                border: CustomTableBorderNew,
                                columnWidths: customColumnWidthGenarator(_col2),
                                children: controller.list_coll_attr
                                    .map((f) => TableRow(
                                            decoration: const BoxDecoration(
                                                color: Colors.white),
                                            children: [
                                              oneColumnCellBody(
                                                  f.name!,
                                                  12,
                                                  Alignment.centerLeft,
                                                  FontWeight.w400,
                                                  const EdgeInsets.all(4),
                                                  appGray50),
                                              oneColumnCellBody(
                                                  f.outAmt!,
                                                  12,
                                                  Alignment.centerLeft,
                                                  FontWeight.w400,
                                                  const EdgeInsets.all(4),
                                                  appGray50),
                                              TableCell(
                                                  verticalAlignment:
                                                      TableCellVerticalAlignment
                                                          .fill,
                                                  child: CustomTextBox(
                                                      textInputType:
                                                          TextInputType.number,
                                                      maxlength: 10,
                                                      textAlign: TextAlign.end,
                                                      caption: '',
                                                      controller: f.amt!,
                                                      onChange: (v) {
                                                        controller.total_cal();
                                                      })),
                                              TableCell(
                                                  verticalAlignment:
                                                      TableCellVerticalAlignment
                                                          .fill,
                                                  child: CustomTextBox(
                                                      textInputType:
                                                          TextInputType.text,
                                                      maxlength: 150,
                                                      caption: '',
                                                      controller: f.rem!,
                                                      onChange: (v) {}))
                                            ]))
                                    .toList(),
                              ),
                            )),
                            controller.total.value == ''
                                ? const SizedBox()
                                : const Padding(
                                    padding: EdgeInsets.only(left: 8),
                                    child: Divider(
                                      height: 3,
                                      color: appColorLogoDeep,
                                    ),
                                  ),
                            controller.total.value == ''
                                ? const SizedBox()
                                : Table(
                                    columnWidths:
                                        customColumnWidthGenarator(_col2),
                                    children: [
                                      TableRow(children: [
                                        const TableCell(child: Text('')),
                                        TableCell(
                                            child: Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Text(
                                                  'Total :',
                                                  style:
                                                      customTextStyle.copyWith(
                                                          color: Colors.black,
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                ))),
                                        TableCell(
                                            child: Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Text(
                                                  controller.total.value,
                                                  style:
                                                      customTextStyle.copyWith(
                                                          color: appColorMint,
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                ))),
                                        const TableCell(child: Text('')),
                                      ]),
                                    ],
                                  )
                          ],
                        ),
                      )),
                  8.heightBox,
                  Positioned(
                      right: 12,
                      bottom: 8,
                      child: CustomButton(Icons.save, "Save", () {
                        controller.save();
                      }, Colors.white)),
                ],
              ),
            ))
          ],
        ),
      );

List<int> _col2 = [150, 50, 50, 100];

Widget _topPanel(McFeeCollectionController controller) => Row(
      children: [
        Flexible(
          child: Stack(
            children: [
              _entryPanel(controller),
              _popUp(controller),
              _popUpClosebutton(controller),
            ],
          ),
        ),
      ],
    );

_studentGeneralInfo(McFeeCollectionController controller) => Column(
      children: [
        Row(
          children: [
            const CustomTextHeader(
              text: "Session      : ",
              textSize: 13,
            ),
            CustomTextHeader(
              text: controller.selectedStudent.value.ses == null
                  ? ''
                  : controller.selectedStudent.value.ses!,
              textSize: 13,
              textColor: appColorMint,
            ),
          ],
        ),
        8.heightBox,
        Row(
          children: [
            const CustomTextHeader(
              text: "Roll             : ",
              textSize: 13,
            ),
            CustomTextHeader(
              text: controller.selectedStudent.value.roll == null
                  ? ''
                  : controller.selectedStudent.value.roll!,
              textSize: 13,
              textColor: appColorMint,
            ),
          ],
        ),
        8.heightBox,
        Row(
          children: [
            const CustomTextHeader(
              text: "Name         : ",
              textSize: 13,
            ),
            CustomTextHeader(
              text: controller.selectedStudent.value.name == null
                  ? ''
                  : controller.selectedStudent.value.name!,
              textSize: 13,
              textColor: appColorMint,
            ),
          ],
        ),
      ],
    );

_entryPanel(McFeeCollectionController controller) => SizedBox(
      width: 600,
      child: CustomGroupBox(
          borderRadius: 8,
          borderWidth: 1,
          groupHeaderText: 'Student Details',
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    const CustomTextHeader(text: "Student ID  : "),
                    Flexible(
                        child: CustomTextBox(
                            caption: "",
                            width: 150,
                            controller: controller.txt_st_id,
                            onChange: (v) {})),
                    8.widthBox,
                    CustomButton(Icons.search, 'Show', () {
                      controller.show();
                    }, Colors.black, appColorBlue, appGray50),
                    8.widthBox,
                    InkWell(
                      onTap: () {
                        controller.isShowPopup.value = true;
                        controller.txt_search.text = '';
                        controller.search();
                      },
                      child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: appGray50,
                            // boxShadow: const [
                            //   BoxShadow(color: appColorBlue, blurRadius: 3,spreadRadius: 0.5)
                            // ]
                          ),
                          child: const Icon(
                            Icons.filter_alt,
                            size: 22,
                            color: appColorBlue,
                          )),
                    ),
                  ],
                ),
                8.heightBox,
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Divider(
                    color: Colors.black26,
                    height: 2,
                  ),
                ),
                16.heightBox,
                _studentGeneralInfo(controller),
                8.heightBox,
                controller.selectedStudent.value.id == null
                    ? const SizedBox()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          // CustomButton(Icons.save, "Save", () {}),
                          // 12.widthBox,
                          InkWell(
                            onTap: () {
                              controller.undo();
                            },
                            child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: appGray50,
                                ),
                                child: const Icon(
                                  Icons.undo,
                                  size: 22,
                                  color: appColorBlue,
                                )),
                          ),
                        ],
                      )
              ],
            ),
          )),
    );

_popUp(McFeeCollectionController controller) => !controller.isShowPopup.value
    ? const SizedBox()
    : Positioned(
        top: 20,
        left: 8,
        right: 8,
        bottom: 4,
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: const [
                BoxShadow(
                    color: appColorGrayDark, spreadRadius: 0, blurRadius: 1)
              ]),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Flexible(
                        child: CustomSearchBox(
                            borderRadious: 4.0,
                            height: 26,
                            caption: "Search",
                            width: 350,
                            controller: controller.txt_search,
                            onChange: (v) {
                              controller.search();
                            })),
                  ],
                ),
                4.heightBox,
                CustomTableHeaderWeb(colWidtList: _col, children: [
                  oneColumnCellBody("ID"),
                  oneColumnCellBody("Name"),
                  oneColumnCellBody("Roll"),
                  oneColumnCellBody("*", 12, Alignment.center),
                ]),
                Expanded(
                  child: SingleChildScrollView(
                    child: Table(
                      border: CustomTableBorderNew,
                      columnWidths: customColumnWidthGenarator(_col),
                      children: controller.list_ent_student_temp
                          .map((f) => TableRow(children: [
                                oneColumnCellBody(f.stId!),
                                oneColumnCellBody(f.name!),
                                oneColumnCellBody(f.roll!),
                                // oneColumnCellBody(f.roll!),
                                TableCell(
                                    verticalAlignment:
                                        TableCellVerticalAlignment.middle,
                                    child: InkWell(
                                      onTap: () {
                                        controller.selectedStudent.value = f;
                                        controller.txt_st_id.text = f.stId!;
                                        controller.isShowPopup.value = false;
                                        controller.loadAttr();
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Select',
                                            style: customTextStyle.copyWith(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: appColorLogoDeep,
                                                decoration:
                                                    TextDecoration.underline),
                                          ),
                                        ],
                                      ),
                                    ))
                              ]))
                          .toList(),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
_popUpClosebutton(McFeeCollectionController controller) =>
    !controller.isShowPopup.value
        ? const SizedBox()
        : Positioned(
            top: 14,
            right: 4,
            child: InkWell(
              onTap: () {
                controller.isShowPopup.value = false;
              },
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.black),
                child: const Icon(
                  Icons.close,
                  size: 16,
                  color: Colors.white,
                ),
              ),
            ));
List<int> _col = [30, 150, 30, 20];
