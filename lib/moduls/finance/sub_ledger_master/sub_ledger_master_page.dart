// ignore_for_file: non_constant_identifier_names

import 'package:agmc/moduls/finance/sub_ledger_master/controller/sub_ledger_controller.dart';


import '../../../core/config/const.dart';

class SubLedgerMaster extends StatelessWidget {
  const SubLedgerMaster({super.key});
  void disposeController() {
    try {
      Get.delete<SubLedgerController>();
    } catch (e) {
      // print('Error disposing EmployeeController: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    SubLedgerController controller = Get.put(SubLedgerController());
    controller.context = context;
    print(controller.context.height);
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Obx(() => CustomCommonBody(
          controller.isLoading.value,
          controller.isError.value,
          controller.errorMessage.value,
          _desktop(controller),
          _desktop(controller),
          _desktop(controller))),
    );
  }
}

_desktop(SubLedgerController controller) => CustomAccordionContainer(
        headerName: "Sub Legder Master",
        height: 0,
        isExpansion: false,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(children: [
                _entryPart(controller),
                _tablePartList(controller),
              ]),
            ),
          )

          // _entryPart(controller),
          //_tablePartList(controller),
        ]);

_tablePartList(SubLedgerController controller) => Padding(
      padding: const EdgeInsets.all(8.0),
      child: CustomAccordionContainer(
        headerName: 'Sub Ledger List',
        height: controller.context.height < 440
            ? 200
            : controller.context.height - 330,
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                    flex: 5,
                    child: CustomSearchBox(
                        caption: "Search",
                        controller: controller.txt_search,
                        onChange: (v) {
                          controller.search();
                        })),
                controller.context.width > 1200
                    ? const Expanded(flex: 5, child: SizedBox())
                    : const SizedBox(),
              ],
            ),
          ),
          _tablePart(controller),
        ],
      ),
    );

_tablePart(SubLedgerController controller) => Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Table(
                columnWidths: CustomColumnWidthGenarator([50, 120, 140, 80, 30]),
                children: [
                  CustomTableRow([
                    "Code",
                    "Sub Ledger Name",
                    "Description",
                    "Is Bill by Bill",
                    "Action"
                  ]),
                  
                  for (var i = 0;
                      i < controller.list_subledger_temp.length;
                      i++)
                    TableRow(
                        decoration: BoxDecoration(
                            color: controller.editId ==
                                    controller.list_subledger_temp[i].iD
                                ? appColorPista
                                : Colors.white),
                        children: [
                          CustomTableCell2(
                              controller.list_subledger_temp[i].cODE!),
                          CustomTableCell2(
                              controller.list_subledger_temp[i].nAME!),
                          CustomTableCell2(controller
                                      .list_subledger_temp[i].dESCRIPTION ==
                                  null
                              ? ''
                              : controller.list_subledger_temp[i].dESCRIPTION!),
                          CustomTableCell2(
                              controller.list_subledger_temp[i].iSBILLBYBILL ==
                                      '1'
                                  ? "Yes"
                                  : "No"),
                          CustomTableEditCell(() {
                            controller.edit(controller.list_subledger_temp[i]);
                          })
                        ])
                ],
                border: CustomTableBorder(),
              )
            ],
          ),
        ),
      ),
    );

_entryPart(SubLedgerController controller) {
  bool b = false;
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      children: [
        Expanded(
            flex: 5,
            child: CustomAccordionContainer(
                isExpansion: false,
                height: 150,
                headerName: "Sub Ledger",
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            CustomTextBox(
                                caption: "Code",
                                isReadonly: true,
                                isDisable: true,
                                disableBackColor: appColorGrayLight,
                                maxlength: 10,
                                width: 100,
                                controller: controller.txt_code,
                                onChange: (C) {}),
                            4.widthBox,
                            Expanded(
                                child: CustomTextBox(
                                    caption: "Sub Ledger Name",
                                    maxlength: 150,
                                    controller: controller.txt_name,
                                    onChange: (v) {})),
                            Row(
                              children: [
                                Checkbox(
                                    value: controller.isBillByBill.value,
                                    onChanged: (v) {
                                      controller.isBillByBill.value = v!;
                                    }),
                                4.widthBox,
                                Text(
                                  "Is Bill By Bill",
                                  style: customTextStyle.copyWith(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            )
                          ],
                        ),
                        4.heightBox,
                        Row(
                          children: [
                            Expanded(
                                child: CustomTextBox(
                                    caption: "Description",
                                    maxlength: 150,
                                    controller: controller.txt_desc,
                                    onChange: (v) {})),
                          ],
                        ),
                        10.heightBox,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            CustomButton(Icons.undo, "Undo", () {
                              controller.undo();
                            }, Colors.white, Colors.white, appColorGrayDark),
                            18.widthBox,
                            CustomButton(Icons.save, "Save", () async {
                              if (!b) {
                                b = true;
                                controller.save();
                                Future.delayed(const Duration(seconds: 2), () {
                                  b = false;
                                });
                              }
                            })
                          ],
                        )
                      ],
                    ),
                  )
                ])),
        controller.context.width > 1200
            ? const Expanded(flex: 5, child: SizedBox())
            : const SizedBox(),
      ],
    ),
  );
}
