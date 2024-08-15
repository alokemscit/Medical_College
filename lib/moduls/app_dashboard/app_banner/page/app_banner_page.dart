import '../../../../core/config/const.dart';
import '../controller/app_banner_controller.dart';

class AppBanner extends StatelessWidget {
  const AppBanner({super.key});
  void disposeController() {
    try {
      Get.delete<AppBannerController>();
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    final AppBannerController controller = Get.put(AppBannerController());
    controller.context = context;
    return Obx(() => CommonBody2(controller, _mainWidget(controller)));
  }
}

_mainWidget(AppBannerController controller) => CustomAccordionContainer(
        headerName: "App Banner",
        height: 0,
        isExpansion: false,
        children: [
          controller.context.width > 850
              ? Expanded(
                  child: Row(
                  children: [
                    SizedBox(
                      width: 650,
                      child: _panelColumn(controller),
                    )
                  ],
                ))
              : Expanded(child: _panelColumn(controller))
        ]);

_panelColumn(AppBannerController controller) => Column(
      children: [
        CustomGroupBox(
            groupHeaderText: "Entry",
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Stack(
                        children: [
                          Container(
                            height: 246,
                            width: 500,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.white,
                                boxShadow: const [
                                  BoxShadow(
                                      spreadRadius: 1,
                                      blurRadius: 5,
                                      color: appColorGray200)
                                ]),
                            child: Column(
                              children: [
                                controller.imagePath.value != ''
                                    ? Flexible(
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: Image.network(
                                            //controller.imageFile.value.path,
                                            controller.imagePath.value,
                                            //  width: 100.0, // Adjust width as needed
                                            //height: 100.0,
                                            fit: BoxFit
                                                .fill, // Adjust height as needed
                                          ),
                                        ),
                                      )
                                    : const Expanded(
                                        child: Center(
                                          child: Icon(
                                            Icons.people_alt_sharp,
                                            size: 52,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                              ],
                            ),
                          ),
                          Positioned(
                            bottom: 4,
                            left: 0,
                            right: 0,
                            child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  " Image Size Ratio (600px:140px)",
                                  style: customTextStyle.copyWith(
                                      fontSize: 11, color: kHeaderolor),
                                )),
                          ),
                          Positioned(
                              bottom: 4,
                              right: 4,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  InkWell(
                                    onTap: () async {
                                      var file = await getImage();

                                      if (file != null) {
                                        // ignore: use_build_context_synchronously

                                        // controller.imageFile.value = file;
                                        controller.imagePath.value = file.path;
                                        controller.isUpdate.value = true;
                                        controller.editImagePath.value =
                                            file.path;

                                        //controller.isUpdate.value = true;
                                        // econtroller.isImageUpdate.value = true;
                                      }
                                    },
                                    child: Container(
                                        padding: const EdgeInsets.all(4),
                                        decoration:
                                            customBoxDecoration.copyWith(
                                                borderRadius:
                                                    BorderRadiusDirectional
                                                        .circular(50),
                                                color: appColorLogoDeep),
                                        child: const Icon(
                                          Icons.photo,
                                          color: appColorGrayLight,
                                          size: 18,
                                        )),
                                  )
                                ],
                              ))
                        ],
                      ),
                      8.heightBox,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          controller.imagePath.value == ''
                              ? const SizedBox()
                              : Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        controller.imagePath.value = '';
                                        controller.editBannnerID.value = '';
                                        controller.isUpdate.value = false;
                                        controller.editImagePath.value = '';
                                      },
                                      child: Container(
                                          padding: const EdgeInsets.all(8),
                                          child: const Icon(Icons.undo)),
                                    ),
                                    12.widthBox
                                  ],
                                ),
                          CustomButton(Icons.save, controller.editBannnerID.value==''? "Save":"Update", () {
                            controller.saveUpdateBanner();
                          })
                        ],
                      )
                    ],
                  ),
                )
              ],
            )),
        8.heightBox,
        Expanded(
          child: CustomGroupBox(
              groupHeaderText: "Banner List",
              child: Column(
                children: [
                  Table(
                    border: CustomTableBorderNew,
                    columnWidths: customColumnWidthGenarator(_col),
                    children: [
                      TableRow(
                        decoration: CustomTableHeaderRowDecorationnew,
                        children: [
                          CustomTableClumnHeader("Is"),
                          CustomTableClumnHeader("Banned"),
                          CustomTableClumnHeader("*")
                        ],
                      ),
                    ],
                  ),
                  Expanded(
                      child: SingleChildScrollView(
                    child: Table(
                      border: CustomTableBorderNew,
                      columnWidths: customColumnWidthGenarator(_col),
                      children: controller.list_banner
                          .map((f) => TableRow(
                                  decoration:
                                      const BoxDecoration(color: Colors.white),
                                  children: [
                                    TableCell(
                                        verticalAlignment:
                                            TableCellVerticalAlignment.middle,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Center(
                                              child: Text(
                                            f.id!,
                                            style: customTextStyle.copyWith(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500),
                                          )),
                                        )),
                                    TableCell(
                                        verticalAlignment:
                                            TableCellVerticalAlignment.middle,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            child: Image.network(
                                              'https://web.asgaralihospital.com/pub/app_banner/${f.name!}',
                                              width:
                                                  300.0, // Adjust width as needed
                                              height: 120.0,
                                              fit: BoxFit
                                                  .cover, // Adjust height as needed
                                            ),
                                          ),
                                        )),
                                    TableCell(
                                        verticalAlignment:
                                            TableCellVerticalAlignment.middle,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  controller.editBanner(f);
                                                },
                                                child: Container(
                                                    padding:
                                                        const EdgeInsets.all(4),
                                                    child: const Icon(
                                                      Icons.edit,
                                                      color: appColorBlue,
                                                      size: 16,
                                                    )),
                                              ),
                                              8.heightBox,
                                              InkWell(
                                                onTap: () {
                                                  CustomCupertinoAlertWithYesNo(
                                                      controller.context,
                                                      Text(
                                                        "Are you Sure to delete?",
                                                        style: customTextStyle
                                                            .copyWith(
                                                                color:
                                                                    Colors.red),
                                                      ),
                                                      ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        child: Image.network(
                                                          'https://web.asgaralihospital.com/pub/app_banner/${f.name!}',
                                                          width:
                                                              150.0, // Adjust width as needed
                                                          height: 65.0,
                                                          fit: BoxFit
                                                              .cover, // Adjust height as needed
                                                        ),
                                                      ),
                                                      () {}, () {
                                                    controller.deleteBanner(f);
                                                  });
                                                },
                                                child: Container(
                                                    padding:
                                                        const EdgeInsets.all(4),
                                                    child: const Icon(
                                                      Icons.delete,
                                                      color: Colors.red,
                                                      size: 16,
                                                    )),
                                              )
                                            ],
                                          ),
                                        )),
                                  ]))
                          .toList(),
                    ),
                  ))
                ],
              )),
        ),
      ],
    );
List<int> _col = [20, 150, 30];
