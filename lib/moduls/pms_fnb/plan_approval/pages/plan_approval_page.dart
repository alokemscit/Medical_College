import 'package:agmc/widget/custom_datepicker.dart';

import '../../../../core/config/const.dart';
import '../controller/plan_approval_controller.dart';

class PlanApproval extends StatelessWidget {
  const PlanApproval({super.key});
  void disposeController() {
    try {
      Get.delete<PlanApprovalController>();
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    final PlanApprovalController controller = Get.put(PlanApprovalController());
    controller.context = context;
    return Obx(() => CommonBody2(
          controller,
          CustomTwoPanelWindow(
            leftPanelHeaderText: 'Plan List ::',
            rightPanelHeaderText: 'Plan Details',
            leftChildren: _leftPanl(controller),
            rightChildren: _rightPanl(controller),
            context: context,
            leftFlex: 4,
          ),
        ));
  }
}

List<Widget> _leftPanl(PlanApprovalController controller) => [
      Row(
        children: [
          Expanded(
              child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: customBoxDecoration,
            child: CustomGroupBox(
              
              groupHeaderText: 'Plan Info',
              child: Column(
                children: [
                  8.heightBox,
                  Row(
                    children: [
                      const CustomTextHeader(text: "From :"),
                      
                      4.widthBox,
                      CustomDatePicker(
                          width: 120,
                          isOnClickDate: true,
                          isBackDate: true,
                          isShowCurrentDate: true,
                          date_controller: controller.txt_fdate),
                      8.widthBox,
                      const CustomTextHeader(text:  "To :"),
                   
                      4.widthBox,
                      Flexible(
                          child: CustomDatePicker(
                              isOnClickDate: true,
                              width: 120,
                              isBackDate: true,
                              isShowCurrentDate: true,
                              date_controller: controller.txt_tdate)),
                    ],
                  ),
                  10.heightBox,
                  Row(
                    children: [
                      const CustomTextHeader(
                       text: "Type  :"
                      ),
                      4.widthBox,
                      Flexible(
                          child: CustomDropDown(
                        borderRadious: 4,
                        //  borderColor: Colors.black,
                        id: controller.selecTedTypeId.value,
                        list: controller.list_type
                            .map((element) => DropdownMenuItem<String>(
                                value: element.id, child: Text(element.name!)))
                            .toList(),
                        onTap: (v) {
                          controller.selecTedTypeId.value = v!;
                        },
                        width: 186,
                      )),
                      14.widthBox,
                      CustomButton(Icons.search, 'Show', () {
                        controller.viewPlanList();
                      }, Colors.black, appColorBlue, kBgLightColor),
                    ],
                  ),
                  8.heightBox,
                ],
              ),
            ),
          )),
        ],
      ),
      6.heightBox,
      Expanded(
        child: Container(
          decoration: customBoxDecoration,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Column(
            children: [
              8.heightBox,
              CustomTableHeaderWeb(
                colWidtList: _col,
                children: [
                  CustomTableClumnHeader("Plan No"),
                  CustomTableClumnHeader("Date"),
                  CustomTableClumnHeader("Note"),
                  CustomTableClumnHeader("Status", Alignment.center),
                  CustomTableClumnHeader("*", Alignment.center, false),
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Table(
                    columnWidths: customColumnWidthGenarator(_col),
                    border: CustomTableBorderNew,
                    children: controller.lis_plan_master
                        .map((element) => TableRow(
                                decoration:
                                    const BoxDecoration(color: Colors.white),
                                children: [
                                  CustomTableCellTableBody(
                                      element.pno,
                                      12.5,
                                      FontWeight.w600,
                                      Alignment.centerLeft,
                                      const EdgeInsets.all(6)),
                                  CustomTableCellTableBody(
                                      element.edate,
                                      12.5,
                                      FontWeight.w500,
                                      Alignment.centerLeft,
                                      const EdgeInsets.all(6)),
                                  CustomTableCellTableBody(
                                      element.note!,
                                      12.5,
                                      FontWeight.w500,
                                      Alignment.centerLeft,
                                      const EdgeInsets.all(6)),
                                  CustomTableCellTableBody(
                                      element.status,
                                      12.5,
                                      FontWeight.w500,
                                      Alignment.center,
                                      const EdgeInsets.all(6)),
                                  CustomTableEditCell(() {
                                    controller.selectedplanID.value =
                                        element.id;
                                  }, Icons.search_sharp)
                                ]))
                        .toList(),
                  ),
                ),
              )
            ],
          ),
        ),
      )
    ];

List<int> _col = [50, 50, 150, 50, 30];

List<Widget> _rightPanl(PlanApprovalController controller) => [
      Container(
        decoration: customBoxDecoration.copyWith(
            borderRadius: BorderRadius.circular(4)),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [RoundedButton(() {}, Icons.close, 13, Colors.black)],
            ),
           Padding(
             padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 4),
             child: CustomGroupBox(groupHeaderText: "Plan Details", child: Column(
              children: [
                   Row(
                       children: [
                         const CustomTextHeader(text:  "Plan No :"),
                       
                         8.widthBox,
                        
                       ],
                     ),
                     6.heightBox,
                     const Row(
                       children: [
                          CustomTextHeader(text:  "Date       :"),
                        
                       ],
                     ),
                     6.heightBox,
                     const Row(
                       children: [
                         CustomTextHeader(text:  "Note       :"),
                        
                       ],
                     ),
                     6.heightBox
              ],
             )),
           ),
           8.heightBox,
          ],
        ),
      ),
      // 12.heightBox,
      // Row(
      //   children: [
      //     Expanded(
      //       child: Container(
      //         decoration: customBoxDecoration,
      //         child: Padding(
      //           padding:
      //               const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      //           child: CustomGroupBox(
      //            groupHeaderText:  "Testing",
      //           child:   Column(
      //               crossAxisAlignment: CrossAxisAlignment.start,
      //               children: [
      //                 Text("Name"),
      //                 Text("Name"),
      //                 Text("Name"),
      //                 CustomTextBox(
      //                     caption: "Name",
      //                     controller: TextEditingController(),
      //                     onChange: (onChange) {})
      //               ],
      //             ),
      //           ),
      //         ),
      //       ),
      //     ),
      //   ],
      // )
    ];
