import '../../../../core/config/const.dart';
import '../controller/mc_fees_head_controller.dart';

class McFeesHeadMaster extends StatelessWidget {
  const McFeesHeadMaster({super.key});
  void disposeController() {
    try {
      Get.delete<McFeesHeadMasterController>();
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    final McFeesHeadMasterController controller =
        Get.put(McFeesHeadMasterController());
    controller.context = context;

    return Obx(() => CommonBody3(
        controller,
        [
          Expanded(
            child: Row(
              children: [
                Flexible(
                  child: SizedBox(
                    width: 750,
                    child: Column(
                      children: [
                        _entryPart(controller),
                        8.heightBox,
                        Expanded(child: _tablePatr(controller)),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
        'Fees Head Master'));
  }
}

List<int> _col = [25, 80, 180, 40];
Widget _tablePatr(McFeesHeadMasterController controller) => CustomGroupBox(
    // bgColor: appGray50,
    groupHeaderText: 'Fees head list',
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Flexible(
                child: CustomSearchBox(
                    caption: "Search",
                    width: 460,
                    controller: controller.txt_search,
                    onChange: (v) {}))
          ],
        ),
        8.heightBox,
        CustomTableHeaderWeb(colWidtList: _col, children: [
          oneColumnCellBody("ID", 12, Alignment.center, FontWeight.bold),
          oneColumnCellBody("Type", 12, Alignment.centerLeft, FontWeight.bold),
          oneColumnCellBody("Name", 12, Alignment.centerLeft, FontWeight.bold),
          oneColumnCellBody("*", 12, Alignment.center, FontWeight.bold),
        ]),
        Expanded(
            child: SingleChildScrollView(
          child: Table(
            border: CustomTableBorderNew,
            columnWidths: customColumnWidthGenarator(_col),
            children: controller.list_fee_master_temp
                .map((f) => TableRow(
                        decoration: BoxDecoration(
                          color: controller.editID.value != f.id
                              ? Colors.white
                              : appColorPista.withOpacity(0.3),
                        ),
                        children: [
                          CustomTableCell2(f.id, true),
                          CustomTableCell2(f.typeName),
                          CustomTableCell2(f.name),
                          TableCell(
                              child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 6),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                InkWell(
                                  onTap: () {
                                    controller.edit(f);
                                  },
                                  child: Container(
                                      decoration: BoxDecoration(
                                          // color: appColorGray200,
                                          borderRadius:
                                              BorderRadiusDirectional.circular(
                                                  50)),
                                      padding: const EdgeInsets.all(4),
                                      child: const Icon(
                                        Icons.edit,
                                        size: 16,
                                        color: appColorBlue,
                                      )),
                                ),
                                Flexible(
                                  child: InkWell(
                                    onTap: () {
                                      CustomCupertinoAlertWithYesNo(
                                          controller.context,
                                          Text(
                                            "Are you sure for deleting ",
                                            style: customTextStyle.copyWith(
                                                color: Colors.red),
                                          ),
                                          Text(f.name!, style: customTextStyle),
                                          () {}, () {
                                        controller.delete(f);
                                      });
                                    },
                                    child: Container(
                                        decoration: BoxDecoration(
                                            //  color: Colors.red,
                                            borderRadius:
                                                BorderRadiusDirectional
                                                    .circular(50)),
                                        padding: const EdgeInsets.all(4),
                                        child: const Icon(
                                          Icons.close,
                                          size: 18,
                                          color: Colors.red,
                                        )),
                                  ),
                                ),
                              ],
                            ),
                          ))
                        ]))
                .toList(),
          ),
        ))
      ],
    ));

Widget _entryPart(McFeesHeadMasterController controller) => CustomGroupBox(
    //bgColor: appGray50,
    groupHeaderText: 'Entry',
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              CustomDropDown(
                  id: controller.selectedPaymentType.value,
                  width: 250,
                  labeltext: 'Payment Type',
                  list: controller.list_payment_type
                      .map((f) => DropdownMenuItem<String>(
                          value: f.id, child: Text(f.name!)))
                      .toList(),
                  onTap: (v) {
                    controller.selectedPaymentType.value = v!;
                    controller.loadData();
                  })
            ],
          ),
          8.heightBox,
          Row(
            children: [
              Expanded(
                  child: CustomTextBox(
                      caption: "Name",
                      maxlength: 150,
                      controller: controller.txt_name,
                      onChange: (v) {})),
              8.widthBox,
              CustomButton(
                  Icons.save, controller.editID.value == '' ? "Save" : "Update",
                  () {
                controller.seave();
              }),
              controller.editID.value == ''
                  ? const SizedBox()
                  : Row(
                      children: [
                        12.widthBox,
                        InkWell(
                          onTap: () {
                            controller.undo();
                          },
                          child: Container(
                              padding: const EdgeInsets.all(4),
                              child: const Icon(
                                Icons.undo,
                                color: appColorBlue,
                                size: 22,
                              )),
                        )
                      ],
                    )
            ],
          ),
          8.heightBox,
        ],
      ),
    ));
//Widget _mainWidget(McFeesHeadMasterController controller)