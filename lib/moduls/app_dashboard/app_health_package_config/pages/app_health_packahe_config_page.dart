import '../../../../core/config/const.dart';
import '../controller/app_health_package_config_controller.dart';

class HealthPackageConfig extends StatelessWidget with MixinMethod {
  const HealthPackageConfig({super.key});

  @override
  Widget build(BuildContext context) {
    final HealthPackageConfigController controller =
        Get.put(HealthPackageConfigController());
    controller.context = context;
    return Obx(() => CommonBody3(
        controller,
        [
          Expanded(
              child: controller.context.width > 1050
                  ? Row(
                      children: [
                        Expanded(flex: 5, child: _left(controller)),
                        12.widthBox,
                        Expanded(flex: 4, child: _right(controller))
                      ],
                    )
                  : Column(
                      children: [
                        SizedBox(height: 250, child: _left(controller)),
                        controller.selectedPackageID.value != ''
                            ? 4.heightBox
                            : const SizedBox(),
                        Expanded(
                            child: SingleChildScrollView(
                                child: _right(controller)))
                      ],
                    ))
        ],
        'Health package Config'));
  }

  @override
  void disposeController() {
    Get.delete<HealthPackageConfigController>();
  }
}

Widget _left(HealthPackageConfigController controller) => CustomGroupBox(
    groupHeaderText: "Package List",
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Flexible(
                  child: CustomSearchBox(
                      caption: "Search",
                      width: 350,
                      controller: controller.txt_searchPackage,
                      onChange: (v) {
                        controller.searchPackage();
                      })),
            ],
          ),
          8.heightBox,
          CustomTableHeaderWeb(colWidtList: _colq, children: [
            CustomTableCell2("ID", true),
            CustomTableCell2("Name"),
            CustomTableCell2("Desc"),
            oneColumnCellBody("Rate", 12, Alignment.bottomRight),
            oneColumnCellBody("Disc. Rate", 12, Alignment.bottomRight),
            CustomTableCell2("*", true),
          ]),
          Expanded(
              child: SingleChildScrollView(
            child: Table(
              border: CustomTableBorderNew,
              columnWidths: customColumnWidthGenarator(_colq),
              children: controller.list_package_temp
                  .map((f) => TableRow(
                          decoration: BoxDecoration(
                              color: controller.selectedPackageID.value == f.id
                                  ? appColorPista.withOpacity(0.3)
                                  : Colors.white),
                          children: [
                            oneColumnCellBody(f.id!),
                            oneColumnCellBody(f.name!),
                            oneColumnCellBody(f.des!),
                            oneColumnCellBody(f.rate.toString()),
                            oneColumnCellBody(f.accRate.toString()),
                            CustomTableEditCell(() {
                              controller.selectedPackageID.value = f.id!;
                              controller.selectedPackageName.value = f.name!;
                              controller.isShow.value = false;
                              controller.loadConData(f.id!);
                            }, Icons.settings)
                          ]))
                  .toList(),
            ),
          ))
        ],
      ),
    ));
List<int> _colq = [20, 150, 100, 50, 50, 20];
Widget _right(
  HealthPackageConfigController controller,
) =>
    controller.selectedPackageID.value == ''
        ? const SizedBox()
        : Stack(
            children: [
              CustomGroupBox(
                  groupHeaderText: "Attributes Config",
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const CustomTextHeader(text: "ID      :"),
                            8.widthBox,
                            CustomTextHeader(
                              text: controller.selectedPackageID.value,
                              textColor: appColorLogoDeep,
                            )
                          ],
                        ),
                        8.heightBox,
                        Row(
                          children: [
                            const CustomTextHeader(text: "Name :"),
                            8.widthBox,
                            CustomTextHeader(
                              text: controller.selectedPackageName.value,
                              textColor: appColorLogoDeep,
                            )
                          ],
                        ),
                        4.heightBox,
                        const Row(
                          children: [
                            Expanded(
                                flex: 6,
                                child: Divider(
                                  color: appColorBlue,
                                  height: 2,
                                )),
                            Expanded(flex: 4, child: SizedBox())
                          ],
                        ),
                        12.heightBox,
                        !controller.isShow.value
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      // print("object");
                                      controller.isShow.value = true;
                                    },
                                    child: Container(
                                        padding: const EdgeInsets.all(4),
                                        child: const Icon(
                                          Icons.add_circle,
                                          size: 24,
                                          color: appColorBlue,
                                        )),
                                  ),
                                  Flexible(
                                      child: CustomSearchBox(
                                          caption: "Search Attribute",
                                          width: 450,
                                          controller: controller.txt_searchAttr,
                                          onChange: (v) {})),
                                ],
                              )
                            : const SizedBox(),
                        AnimatedOpacity(
                            opacity: controller.isShow.value ? 1.0 : 0.0,
                            duration: const Duration(milliseconds: 600),
                            child: _popup(controller)),
                        8.heightBox,
                        CustomTableHeaderWeb(colWidtList: _col3, children: [
                          CustomTableCell2("ID", true),
                          CustomTableCell2("Name"),
                          CustomTableCell2("^", true),
                          CustomTableCell2("*", true),
                        ]),
                        Expanded(
                            child: SingleChildScrollView(
                          child: Table(
                            border: CustomTableBorderNew,
                            columnWidths: customColumnWidthGenarator(_col3),
                            children: controller.list_con_data_temp
                                .map((f) => TableRow(
                                      decoration: const BoxDecoration(
                                          color: Colors.white),
                                      children: [
                                        oneColumnCellBody(
                                            f.aid!, 12, Alignment.center),
                                        oneColumnCellBody(f.name!),
                                        controller.list_con_data_temp
                                                    .indexOf(f) ==
                                                0
                                            ? const SizedBox()
                                            : CustomTableEditCell(() {
                                                controller.inedxChange(f);
                                              }, Icons.arrow_upward),
                                        CustomTableEditCell(() {
                                          f.sl != ''
                                              ? CustomCupertinoAlertWithYesNo(
                                                  controller.context,
                                                  const Text(
                                                    "Are you sure for remove?",
                                                    style: TextStyle(
                                                        color: Colors.red),
                                                  ),
                                                  Text(
                                                    f.name!,
                                                    style: customTextStyle,
                                                  ), () {
                                                  controller.remove(
                                                      f.aid!, true, f.pid!);
                                                }, () {})
                                              : controller.remove(
                                                  f.aid!, false, f.pid!);
                                        }, Icons.delete, Colors.red),
                                      ],
                                    ))
                                .toList(),
                          ),
                        ))
                      ],
                    ),
                  )),
              Positioned(
                  top: 16,
                  right: 6,
                  child: MouseRegion(
                    onHover: (event) {},
                    child: InkWell(
                      onTap: () {
                        controller.undo();
                      },
                      child: Container(
                          //  duration: const Duration(milliseconds: 300),
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: appColorGrayDark),
                          child: const Icon(
                            Icons.undo,
                            color: appColorGray200,
                            size: 18,
                          )),
                    ),
                  )),
              Positioned(
                  bottom: 8,
                  right: 8,
                  child: controller.list_con_data_temp.isEmpty
                      ? const SizedBox()
                      : CustomButton(Icons.save, "Save", () {
                          controller.saveAttr();
                        })),
            ],
          );

List<int> _col2 = [20, 150, 20];

List<int> _col3 = [20, 150, 20, 20];

Widget _popup(HealthPackageConfigController controller) => Container(
      height: controller.isShow.value ? 350 : 0,
      // width: 450,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          color: appGray50,
          boxShadow: const [
            BoxShadow(
              blurRadius: 4,
              spreadRadius: .05,
              color: appColorGrayDark,
            )
          ]),

      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: InkWell(
                  onTap: () {
                    controller.isShow.value = false;
                  },
                  child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                      child: const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 16,
                      )),
                ),
              )
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: CustomGroupBox(
                  groupHeaderText: "Attribute list",
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Flexible(
                              child: CustomSearchBox(
                                  caption: "Search",
                                  width: 300,
                                  controller: controller.txt_searchAttr2,
                                  onChange: (v) {
                                    controller.searchPopUpAttr();
                                  })),
                        ],
                      ),
                      4.heightBox,
                      CustomTableHeaderWeb(colWidtList: _col2, children: [
                        CustomTableCell2("ID", true),
                        CustomTableCell2("Name"),
                        CustomTableCell2("*", true),
                      ]),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Table(
                            border: CustomTableBorderNew,
                            columnWidths: customColumnWidthGenarator(_col2),
                            children: controller.list_attr_temp
                                .map((f) => TableRow(
                                        decoration: const BoxDecoration(
                                            color: Colors.white),
                                        children: [
                                          oneColumnCellBody(f.id!),
                                          oneColumnCellBody(f.name!),
                                          CustomTableEditCell(() {
                                            controller.add(
                                                controller
                                                    .selectedPackageID.value,
                                                f.id!,
                                                f.name!);
                                          }, Icons.add)
                                        ]))
                                .toList(),
                          ),
                        ),
                      )
                    ],
                  )),
            ),
          ),
          8.heightBox,
        ],
      ),
    );
