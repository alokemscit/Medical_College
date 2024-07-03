import '../../../../core/config/const.dart';
import '../controller/mc_default_setup_controller.dart';

class McDefaultSetup extends StatelessWidget {
  const McDefaultSetup({super.key});
  void disposeController() {
    try {
      Get.delete<McDefaultSetupController>();
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    final McDefaultSetupController controller =
        Get.put(McDefaultSetupController());
    controller.context = context;
    return Obx(() => CommonBody3(
        controller,
        [_topPanel(controller), 8.heightBox, _defaultFee(controller)],
        'Default Setup'));
  }
}

Widget _defaultFee(McDefaultSetupController controller) => Expanded(
      child: Row(
        children: [
          Flexible(
              child: SizedBox(
            width: 800,
            child: Stack(
              children: [
                CustomGroupBox(
                    groupHeaderText: "Default Fee",
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomDropDown(
                            id: controller.selectedFeeTypeID.value,
                            list: controller.list_payment_type
                                .map((f) => DropdownMenuItem<String>(
                                    value: f.id,
                                    child: Text(
                                      f.name!,
                                      style: customTextStyle.copyWith(
                                          fontSize: 12),
                                    )))
                                .toList(),
                            width: 150,
                            labeltext: 'Fee Type',
                            onTap: (v) {
                              controller.selectedFeeTypeID.value = v!;
                              controller.load();
                            }),
                        12.heightBox,
                        CustomTableHeaderWeb(colWidtList: _col, children: [
                          CustomTableClumnHeader("ID"),
                          CustomTableClumnHeader("Type"),
                          CustomTableClumnHeader("Fee Head Name"),
                          CustomTableClumnHeader("Amount"),
                          CustomTableClumnHeader("Chk", Alignment.center),
                        ]),
                        Expanded(
                            child: SingleChildScrollView(
                                child: Obx(() => Table(
                                      border: CustomTableBorderNew,
                                      columnWidths:
                                          customColumnWidthGenarator(_col),
                                      children: controller.list_fee_master_temp
                                          .map((f) => TableRow(
                                                  decoration:
                                                      const BoxDecoration(
                                                          color: Colors.white),
                                                  children: [
                                                    oneColumnCellBody(f.id!),
                                                    oneColumnCellBody(f.name!),
                                                    oneColumnCellBody(
                                                        f.typeName!),
                                                    TableCell(
                                                        verticalAlignment:
                                                            TableCellVerticalAlignment
                                                                .middle,
                                                        child: Row(
                                                          children: [
                                                            Expanded(
                                                                child: f.amt!),
                                                          ],
                                                        )),
                                                    TableCell(
                                                        verticalAlignment:
                                                            TableCellVerticalAlignment
                                                                .middle,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Checkbox(
                                                                value: f.isChk,
                                                                onChanged: (v) {
                                                                  controller
                                                                      .updateCheck(
                                                                          f,
                                                                          v!);
                                                                })
                                                          ],
                                                        )),
                                                  ]))
                                          .toList(),
                                    ))))
                      ],
                    )),
                controller.list_fee_master_temp.isEmpty
                    ? const SizedBox()
                    : Positioned(
                        bottom: 8,
                        right: 8,
                        child: CustomButton(Icons.update, "Update", () {
                          controller.save();
                          // controller.list_fee_master_temp.forEach((x) {
                          //   print(x.amount!);
                          // });
                        }))
              ],
            ),
          ))
        ],
      ),
    );

List<int> _col = [20, 80, 180, 50, 30];

Widget _topPanel(McDefaultSetupController controller) => Row(
      children: [
        Flexible(
          child: SizedBox(
            width: 300,
            child: CustomGroupBox(
                groupHeaderText: "Setup",
                child: Column(
                  children: [
                    Row(
                      children: [
                        const CustomTextHeader(
                            text: "Default Collection Day :"),
                        Expanded(
                            child: CustomDropDown(
                                id: null, list: [], onTap: (v) {}))
                      ],
                    ),
                    8.heightBox,
                    Row(
                      children: [
                        const CustomTextHeader(
                            text: "Penalty Percentage :     "),
                        CustomTextBox(
                            caption: '',
                            maxlength: 3,
                            textInputType: TextInputType.number,
                            controller: TextEditingController(),
                            onChange: (v) {})
                      ],
                    ),
                    8.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CustomButton(Icons.save, "Save", () {}),
                      ],
                    ),
                    8.heightBox,
                  ],
                )),
          ),
        )
      ],
    );
