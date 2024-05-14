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
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            decoration: customBoxDecoration,
            child: Column(
              children: [
                8.heightBox,
                Row(
                  children: [
                    Text(
                      "From :",
                      style:
                          customTextStyle.copyWith(fontWeight: FontWeight.bold),
                    ),
                    4.widthBox,
                    CustomDatePicker(
                        width: 120,
                        isBackDate: true,
                        isShowCurrentDate: true,
                        date_controller: TextEditingController()),
                    8.widthBox,
                    Text(
                      "To :",
                      style:
                          customTextStyle.copyWith(fontWeight: FontWeight.bold),
                    ),
                    4.widthBox,
                    Flexible(
                        child: CustomDatePicker(
                            width: 120,
                            isBackDate: true,
                            isShowCurrentDate: true,
                            date_controller: TextEditingController())),
                  ],
                ),
                10.heightBox,
                Row(
                  children: [
                    Text(
                      "Type  :",
                      style:
                          customTextStyle.copyWith(fontWeight: FontWeight.bold),
                    ),
                    4.widthBox,
                    Flexible(
                        child: CustomDropDown(
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
                    CustomButton(Icons.search, 'Show', () {}, Colors.black,
                       appColorBlue, kBgLightColor),
                  ],
                ),
                8.heightBox,
              ],
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
              const Expanded(
                child: SingleChildScrollView(),
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
      ),
    ];
