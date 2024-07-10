import 'package:agmc/widget/custom_datepicker.dart';

import '../../../../core/config/const.dart';
import '../controller/mc_acc_enroll_controller.dart';

class McAccountEnrollMent extends StatelessWidget {
  const McAccountEnrollMent({super.key});
  void disposeController() {
    try {
      Get.delete<McAccountEnrollMentController>();
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    final McAccountEnrollMentController controller =
        Get.put(McAccountEnrollMentController());
    controller.context = context;
    return Obx(() => CommonBody3(
        controller,
        [
          controller.context.width > 1050
              ? Expanded(
                  child: Row(
                  children: [
                    Expanded(flex: 5, child: _studentWidget(controller)),
                    8.widthBox,
                    Expanded(flex: 5, child: Obx(()=>_entitleListWidget(controller)))
                  ],
                ))
              : Expanded(
                  child: Column(
                    children: [
                      Expanded(flex: 4, child: _studentWidget(controller)),
                      8.heightBox,
                      Expanded(
                          flex: 5,
                          child: SingleChildScrollView(
                              child: Obx(()=>_entitleListWidget(controller))))
                    ],
                  ),
                )
        ],
        'Student Account Enrollment'));
  }
}

Widget _studentWidget(McAccountEnrollMentController controller) =>
    CustomGroupBox(
        groupHeaderText: "Student List",
        child: Column(
          children: [
            Row(
              children: [
                const CustomTextHeader(text: "Session : "),
                Flexible(
                    child: CustomDropDown(
                        id: controller.selectedSessionID.value,
                        width: 250,
                        list: controller.list_session
                            .map((f) => DropdownMenuItem<String>(
                                value: f.sessionId,
                                child: Text(
                                  f.SessionName!,
                                  style: customTextStyle.copyWith(fontSize: 12),
                                )))
                            .toList(),
                        onTap: (v) {
                          controller.selectedSessionID.value = v!;
                          controller.loadStudentMaster();
                        }))
              ],
            ),
            12.heightBox,
            CustomTableHeaderWeb(colWidtList: _col, children: [
              CustomTableCellTableBody('ID'),
              CustomTableCellTableBody('Roll'),
              CustomTableCellTableBody('Student Name'),
              CustomTableCellTableBody('Contact No'),
              CustomTableCellTableBody(
                  '*', 13, FontWeight.bold, Alignment.center),
            ]),
            Table(
              columnWidths: customColumnWidthGenarator(_col),
              border: CustomTableBorderNew,
              children: controller.list_student_temp
                  .map((f) => TableRow(
                          decoration: BoxDecoration(
                              color: controller.selectedStudentID.value ==
                                      f.sTUDENTID
                                  ? appColorPista.withOpacity(0.3)
                                  : Colors.white),
                          children: [
                            oneColumnCellBody(f.sTUDENTID!),
                            oneColumnCellBody(f.rOLL!),
                            oneColumnCellBody(f.sTUDENTFULLNAME!),
                            oneColumnCellBody(f.cONTACTNO!),
                            CustomTableEditCell(() {
                              controller.undo();
                              controller.selectedStudentID.value = f.sTUDENTID!;
                              controller.selectedStudentName.value =
                                  f.sTUDENTFULLNAME!;
                            }, Icons.settings, appColorBlue),
                          ]))
                  .toList(),
            )
          ],
        ));
List<int> _col = [50, 50, 150, 50, 20];
Widget _entitleListWidget(McAccountEnrollMentController controller) =>
    CustomGroupBox(
        groupHeaderText: "Entitled List",
        child: Column(
          children: [
            Stack(
              children: [
                controller.selectedStudentID.value == ''
                    ? const SizedBox()
                    : CustomGroupBox(
                        groupHeaderText: 'Student Info:',
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const CustomTextHeader(text: "ID        :  "),
                                Expanded(
                                    child: CustomTextHeader(
                                        text:
                                            controller.selectedStudentID.value,
                                        textColor: appColorLogoDeep)),
                              ],
                            ),
                            8.heightBox,
                            Row(
                              children: [
                                const CustomTextHeader(text: "Name :  "),
                                Expanded(
                                    child: CustomTextHeader(
                                        text: controller
                                            .selectedStudentName.value,
                                        textColor: appColorLogoDeep)),
                              ],
                            ),
                            4.heightBox,
                            const Row(
                              children: [
                                Expanded(
                                    child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 12),
                                  child: Divider(
                                    height: 3,
                                    color: appColorGray200,
                                  ),
                                ))
                              ],
                            ),
                            4.heightBox,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const CustomTextHeader(
                                        text: "Is Outstanding :"),
                                    Checkbox(
                                        value: controller.isOutStanding.value,
                                        onChanged: (v) {
                                          controller.isOutStanding.value = v!;
                                          if (v) {
                                            controller.generateOutStanding();
                                          }
                                        }),
                                  ],
                                ),
                                CustomButton(Icons.save, "Save", () {
                                  controller.save();
                                })
                              ],
                            ),
                            !controller.isOutStanding.value
                                ? const SizedBox()
                                : Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 4),
                                    child: CustomGroupBox(
                                        groupHeaderText: 'Outstanding Details',
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                const CustomTextHeader(
                                                    text: "Till Date : "),
                                                CustomDatePickerDropDown(
                                                    isBackDate: true,
                                                    isShowCurrentDate: true,
                                                    label: '',
                                                    date_controller: controller
                                                        .txt_till_date)
                                              ],
                                            ),
                                            8.heightBox,
                                            const Align(
                                                alignment: Alignment.centerLeft,
                                                child: CustomTextHeader(
                                                  text: "Amount Details : ",
                                                  textSize: 11,
                                                  fontweight: FontWeight.w500,
                                                )),
                                            const Row(
                                              children: [
                                                Expanded(
                                                    child: Divider(
                                                  height: 1,
                                                  color: appColorGray200,
                                                ))
                                              ],
                                            ),
                                            Align(
                                              alignment: Alignment.topLeft,
                                              child: SizedBox(
                                                width: 400,
                                                child: Column(
                                                  children: [
                                                    CustomTableHeaderWeb(
                                                        colWidtList: _col2,
                                                        children: [
                                                          CustomTableCell2(
                                                              "Head Name"),
                                                          oneColumnCellBody(
                                                              "Amount",
                                                              12,
                                                              Alignment
                                                                  .centerRight)
                                                        ]),
                                                    Table(
                                                      columnWidths:
                                                          customColumnWidthGenarator(
                                                              _col2),
                                                      border:
                                                          CustomTableBorderNew,
                                                      children: controller
                                                          .lis_temp_outstanding
                                                          .map((f) => TableRow(
                                                                  decoration:
                                                                      const BoxDecoration(
                                                                          color:
                                                                              Colors.white),
                                                                  children: [
                                                                    oneColumnCellBody(
                                                                        f.name!,
                                                                        12,
                                                                        Alignment
                                                                            .centerLeft,
                                                                        FontWeight
                                                                            .bold,
                                                                        const EdgeInsets
                                                                            .all(
                                                                            4),
                                                                        appGray50),
                                                                    TableCell(
                                                                        verticalAlignment:
                                                                            TableCellVerticalAlignment
                                                                                .middle,
                                                                        child:
                                                                            Row(
                                                                          children: [
                                                                            Expanded(
                                                                                child: CustomTextBox(
                                                                                    caption: '',
                                                                                    textInputType: TextInputType.number,
                                                                                    textAlign: TextAlign.end,
                                                                                    controller: f.txtController!,
                                                                                    onChange: (v) {
                                                                                      controller.Total();
                                                                                    })),
                                                                          ],
                                                                        )),
                                                                  ]))
                                                          .toList(),
                                                    ),
                                                    Table(
                                                      border:
                                                          CustomTableBorderNew,
                                                      columnWidths:
                                                          customColumnWidthGenarator(
                                                              _col2),
                                                      children: [
                                                        TableRow(
                                                            decoration:
                                                                const BoxDecoration(
                                                                    color:
                                                                        appColorGray200),
                                                            children: [
                                                              oneColumnCellBody(
                                                                  "Total : ",
                                                                  13,
                                                                  Alignment
                                                                      .topRight,
                                                                  FontWeight
                                                                      .bold),
                                                              oneColumnCellBody(
                                                                  controller
                                                                      .total
                                                                      .value,
                                                                  13,
                                                                  Alignment
                                                                      .topRight,
                                                                  FontWeight
                                                                      .bold),
                                                            ])
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        )),
                                  ),
                          ],
                        )),
                Positioned(
                    right: 4,
                    top: 12,
                    child: InkWell(
                      onTap: () {
                        controller.undo();
                      },
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: appColorGray200,
                          ),
                          padding: const EdgeInsets.all(4),
                          child: const Icon(
                            Icons.undo,
                            size: 22,
                            color: appColorBlue,
                          )),
                    )),
              ],
              ),
             
             controller.selectedStudentID.value!=''?const SizedBox():  Expanded(
               child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                     Flexible(child: CustomSearchBox(caption: "Search Entitled Student", width: 350, controller: controller.txt_search_entitled, onChange: (v){}))
                    ],),
                  12.heightBox,
                CustomTableHeaderWeb(colWidtList: _col3, children: [
                 CustomTableCellTableBody('ID'),
                  CustomTableCellTableBody('Name'),
                   CustomTableCellTableBody('Roll'),
                    CustomTableCellTableBody('Session'),
                     CustomTableCellTableBody('Opening Outstanding',13, FontWeight.bold,Alignment.centerRight),
                       CustomTableCellTableBody('*'),
                  ]),
               
                   Expanded(child: SingleChildScrollView(child: Table(
                    columnWidths: customColumnWidthGenarator(_col3),
                    border:  CustomTableBorderNew,
                    children: controller.list_ent_student_temp.map((f)=>TableRow(
                      decoration: const BoxDecoration(color: Colors.white),
                      children: [
                    oneColumnCellBody(f.stId!,12,Alignment.centerLeft,FontWeight.w400,const EdgeInsets.all(4),Colors.transparent,true),
                    oneColumnCellBody(f.name!), 
                    oneColumnCellBody(f.roll!),
                    oneColumnCellBody(f.ses!),
                     oneColumnCellBody(f.omt!.toString(),12,Alignment.centerRight),
                    CustomTableEditCell((){})
                    ])).toList() ,),))
               
                  ],
                ),
             ),
             
          ],
        ));
List<int> _col3 = [30, 150,30, 50, 60, 20];
List<int> _col2 = [150, 50];
