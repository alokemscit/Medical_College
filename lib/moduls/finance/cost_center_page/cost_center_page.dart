import 'package:agmc/core/config/const.dart';
import 'controller/cost_center_controller.dart';

class ConstcenterPage extends StatelessWidget {
  const ConstcenterPage({super.key});
  void disposeController() {
    try {
      Get.delete<CostcenterController>();
    } catch (e) {
      // print('Error disposing EmployeeController: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    CostcenterController controller = Get.put(CostcenterController());
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

_desktop(CostcenterController controller) => CustomAccordionContainer(
        headerName: "Cost Center Master",
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

_tablePartList(CostcenterController controller) => Padding(
      padding: const EdgeInsets.all(8.0),
      child: CustomAccordionContainer(
        headerName: 'Cost Center List',
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

_tablePart(CostcenterController controller) => Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Table(
                columnWidths: CustomColumnWidthGenarator([50, 120, 140,  40]),
                children: [
                  CustomTableRowWithWidget([
                   Text("Code",style: customTextStyle.copyWith(fontSize: 12,fontWeight: FontWeight.bold),),
                    Text("Cost Center Name",style: customTextStyle.copyWith(fontSize: 12,fontWeight: FontWeight.bold),),
                    Text( "Description",style: customTextStyle.copyWith(fontSize: 12,fontWeight: FontWeight.bold),),
                    Center(child: Text("Action",style: customTextStyle.copyWith(fontSize: 12,fontWeight: FontWeight.bold),))
                  ]),
                  for (var i = 0;
                      i < controller.list_costcenter_temp.length;
                      i++)
                    TableRow(
                        decoration: BoxDecoration(
                            color: controller.editId ==
                                    controller.list_costcenter_temp[i].iD
                                ? appColorPista
                                : Colors.white),
                        children: [
                          CustomTableCell2(
                              controller.list_costcenter_temp[i].cODE!),
                          CustomTableCell2(
                              controller.list_costcenter_temp[i].nAME!),
                          CustomTableCell2(controller
                                      .list_costcenter_temp[i].dESCRIPTION ==
                                  null
                              ? ''
                              : controller.list_costcenter_temp[i].dESCRIPTION!),
                           
                          CustomTableEditCell(() {
                            controller.edit(controller.list_costcenter_temp[i]);
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

_entryPart(CostcenterController controller) {
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
                headerName: "Cost Center",
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
                                    caption: "Cost Center Name",
                                    maxlength: 150,
                                    controller: controller.txt_name,
                                    onChange: (v) {})),
                            
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
