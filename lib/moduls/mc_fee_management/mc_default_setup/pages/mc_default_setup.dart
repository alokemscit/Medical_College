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
        [
          // _topPanel(controller), 8.heightBox,
          _leftPanel(controller)
        ],
        'Default Setup'));
  }
}

Widget _leftPanel(McDefaultSetupController controller) => Flexible(
      child: SizedBox(
        width: 600,
        child: Stack(
          children: [
            CustomGroupBox(
                groupHeaderText: "Default Fees Setup",
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: Row(
                        children: [
                          Checkbox(
                              value: controller.isRegular.value,
                              onChanged: (v) {
                                controller.isRegular.value = v!;
                                controller.LoadFeeConfig(
                                    controller.selectedTabIndex.value);
                              }),
                          Text(
                            'Regular',
                            style: customTextStyle.copyWith(
                                fontSize: controller.isRegular.value?12: 11, color: appColorMint),
                          ),
                          12.widthBox,
                          Checkbox(
                              value: !controller.isRegular.value,
                              onChanged: (v) {
                                controller.isRegular.value = !v!;
                                controller.LoadFeeConfig(
                                    controller.selectedTabIndex.value);
                              }),
                          Text(
                            'Poor Quata',
                            style: customTextStyle.copyWith(
                                fontSize: !controller.isRegular.value?12: 11, color: appColorMint),
                          )
                        ],
                      ),
                    ),
                    Obx(() => Row(
                          children: controller.list_tab
                              .map((f) => Padding(
                                    padding: const EdgeInsets.only(right: 1),
                                    child: CustomTabWithCheckBox(
                                       text:  f.name!,
                                     isCheck:    controller.selectedTabIndex.value ==
                                            f.id, fun:  () {
                                      controller.LoadFeeConfig(f.id!);
                                      // controller.selectedTabIndex.value = f.id!;
                                      //  print('Abc');
                                    }),
                                  ))
                              .toList(),
                        )),
                    12.heightBox,
                    CustomTableHeaderWeb(colWidtList: _col, children: [
                      CustomTableClumnHeader("ID", Alignment.center),

                      CustomTableClumnHeader("Fee Head Name"),
                      CustomTableClumnHeader("Amount", Alignment.centerRight),
                      // CustomTableClumnHeader("Chk", Alignment.center),
                    ]),
                    Expanded(
                        child: SingleChildScrollView(
                            child: Obx(() => Table(
                                  border: CustomTableBorderNew,
                                  columnWidths:
                                      customColumnWidthGenarator(_col),
                                  children: controller.list_fee_master_temp
                                      .map((f) => TableRow(
                                              decoration: const BoxDecoration(
                                                  color: Colors.white),
                                              children: [
                                                oneColumnCellBody(f.id!, 12,
                                                    Alignment.center),
                                                oneColumnCellBody(
                                                  f.name!,
                                                  13,
                                                  Alignment.centerLeft,
                                                  FontWeight.bold,
                                                ),
                                                TableCell(
                                                    verticalAlignment:
                                                        TableCellVerticalAlignment
                                                            .fill,
                                                    child: CustomTextBox(
                                                        caption: '',
                                                        maxlength: 20,
                                                        textAlign:
                                                            TextAlign.end,
                                                        textInputType:
                                                            TextInputType
                                                                .number,
                                                        controller: f.amt!,
                                                        onChange: (v) {
                                                          controller.getTotal();
                                                        })),
                                              ]))
                                      .toList(),
                                )))),
                    controller.gTotal.value == '0'
                        ? const SizedBox()
                        : const Divider(
                            color: appColorGrayDark,
                            height: 1,
                          ),
                    controller.gTotal.value == '0'
                        ? const SizedBox()
                        : Table(
                            columnWidths: customColumnWidthGenarator(_col),
                            children: [
                              TableRow(
                                  decoration:
                                      const BoxDecoration(color: kBgColorG),
                                  children: [
                                    const TableCell(child: SizedBox()),
                                    TableCell(
                                        verticalAlignment:
                                            TableCellVerticalAlignment.middle,
                                        child: Align(
                                            alignment: Alignment.centerRight,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 4,
                                                      horizontal: 2),
                                              child: Text(
                                                "Grand Total",
                                                style: customTextStyle.copyWith(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.bold,
                                                    color: appColorMint),
                                              ),
                                            ))),
                                    TableCell(
                                        verticalAlignment:
                                            TableCellVerticalAlignment.middle,
                                        child: Align(
                                            alignment: Alignment.centerRight,
                                            child: Text(
                                              controller.gTotal.value,
                                              style: customTextStyle.copyWith(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold,
                                                  color: appColorMint),
                                            ))),
                                  ])
                            ],
                          ),
                    40.heightBox,
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
      ),
    );

// Widget _tabCheck(String text, bool isChcek, void Function() fun) => InkWell(
//       onTap: () {
//         fun();
//       },
//       child: Container(
//           padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//           decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(2),
//               color: isChcek ? appColorGrayDark : Colors.white,
//               boxShadow: [
//                 BoxShadow(
//                     color: appColorGrayDark.withOpacity(0.5),
//                     spreadRadius: 0.1,
//                     blurRadius: .1)
//               ]),
//           child: Row(
//             children: [
//               isChcek
//                   ? const Icon(
//                       Icons.check_box_outlined,
//                       color: Colors.white,
//                       size: 22,
//                     )
//                   : const Icon(
//                       Icons.check_box_outline_blank,
//                       color: appColorGrayDark,
//                       size: 22,
//                     ),
//               4.widthBox,
//               CustomTextHeader(
//                 text: text,
//                 textSize: isChcek ? 11.5 : 11,
//                 textColor: isChcek ? Colors.white : appColorMint,
//               ),
//             ],
//           )),
//     );

List<int> _col = [20, 180, 50];

// Widget _topPanel(McDefaultSetupController controller) => Row(
//       children: [
//         Flexible(
//           child: SizedBox(
//             width: 300,
//             child: CustomGroupBox(
//                 groupHeaderText: "Setup",
//                 child: Column(
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         const CustomTextHeader(
//                             text: "Last Coll Day of the month :"),
//                         CustomTextBox(
//                             caption: '',
//                             maxlength: 2,
//                             textAlign: TextAlign.center,
//                             textInputType: TextInputType.number,
//                             controller: TextEditingController(),
//                             onChange: (v) {})
//                       ],
//                     ),
//                     8.heightBox,
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         CustomButton(Icons.save, "Save", () {}),
//                       ],
//                     ),
//                     8.heightBox,
//                   ],
//                 )),
//           ),
//         )
//       ],
//     );
