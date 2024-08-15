 
import 'package:flutter_quill/flutter_quill.dart';

import '../../../../core/config/const.dart';
import '../controller/doc_profile_setup_controller.dart';

class DoctorProfileSeup extends StatelessWidget {
  const DoctorProfileSeup({super.key});
  void disposeController() {
    try {
      Get.delete<DoctorProfileSeupController>();
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    final DoctorProfileSeupController controller =
        Get.put(DoctorProfileSeupController());
    controller.context = context;
    // print(context.width);
    return Obx(() => CommonBody2(controller, _mainWidget(controller)));
  }
}

_mainWidget(DoctorProfileSeupController controller) => CustomAccordionContainer(
        headerName: "Doctor Profile",
        height: 0,
        isExpansion: false,
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Flexible(

                // child:
                controller.context.width > 955
                    ? _topPart(controller)
                    : Flexible(child: _topPart(controller)),
                // ),
                controller.context.width > 1320
                    ? _tablePart(controller)
                    : const SizedBox()
              ],
            ),
          )
        ]);

_topPart(DoctorProfileSeupController controller) => SizedBox(
      width: 700,
      child: SingleChildScrollView(
        child: Column(
          children: [
            controller.context.width > 1050
                ? Row(
                    children: [
                      _imagePart(controller),
                      8.widthBox,
                      Flexible(
                        child: _entryPart(controller),
                      )
                    ],
                  )
                : Column(
                    children: [
                      _imagePart(controller),
                      8.heightBox,
                      _entryPart(controller),
                    ],
                  ),
            _descPart(controller)
          ],
        ),
      ),
    );
_tablePart(DoctorProfileSeupController controller) => Expanded(
        child: Row(
      children: [
        8.widthBox,
        Expanded(
            child: CustomGroupBox(
                groupHeaderText: "Doctor List",
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CustomSearchBox(
                            width: 300,
                            caption: "Search",
                            controller: controller.txt_search,
                            onChange: (v) {
                              controller.search();
                            }),
                      ],
                    ),
                    8.heightBox,
                    Table(
                      border: CustomTableBorderNew,
                      columnWidths: customColumnWidthGenarator(_col),
                      children: [
                        TableRow(
                            decoration: CustomTableHeaderRowDecorationnew,
                            children: [
                              //30,100,50,50,50,20
                              CustomTableClumnHeader("ID", Alignment.center),
                              CustomTableClumnHeader(
                                "Name",
                                Alignment.centerLeft,
                              ),
                              CustomTableClumnHeader(
                                "Photo",
                                Alignment.centerLeft,
                              ),
                              CustomTableClumnHeader(
                                "Designation",
                                Alignment.centerLeft,
                              ),

                              CustomTableClumnHeader(
                                "Department",
                                Alignment.centerLeft,
                              ),
                              CustomTableClumnHeader(
                                "*",
                                Alignment.center,
                              ),
                            ])
                      ],
                    ),
                    Expanded(
                        child: SingleChildScrollView(
                      child: Table(
                        border: CustomTableBorderNew,
                        columnWidths: customColumnWidthGenarator(_col),
                        children: controller.list_doctor_temp
                            .map((f) => TableRow(
                                    decoration: const BoxDecoration(
                                        color: Colors.white),
                                    children: [
                                      _customCell(f.docId, true),
                                      _customCell(f.docName),
                                      TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              child: Image.network(
                                                'https://web.asgaralihospital.com/pub/doc_image/${f.imagePath!}',
                                                width:
                                                    50.0, // Adjust width as needed
                                                height: 60.0,
                                                fit: BoxFit
                                                    .fitHeight, // Adjust height as needed
                                              ),
                                            ),
                                          )),
                                      _customCell(f.desig),
                                      _customCell(f.deptName),
                                      TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  controller.setEdit(f);
                                                },
                                                child: Container(
                                                    padding:
                                                        const EdgeInsets.all(4),
                                                    child: const Icon(
                                                      Icons.edit,
                                                      color: appColorLogoDeep,
                                                      size: 16,
                                                    )),
                                              ),
                                              8.widthBox,
                                              InkWell(
                                                onTap: () {
                                                  CustomCupertinoAlertWithYesNo(
                                                      controller.context,
                                                      Text(
                                                        "Are you sure you want to delete?",
                                                        style: customTextStyle
                                                            .copyWith(
                                                                color:
                                                                    Colors.red),
                                                      ),
                                                      Text(
                                                          "Doctor profile of ${f.docName!}"),
                                                      () {}, () {
                                                    controller.deleteProfile(f);
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
                                          )),
                                    ]))
                            .toList(),
                      ),
                    )),
                    // Text(  extractPlainText(jsonDecode('[{"insert":"Description for testing\\n\\n"},{"insert":"A","attributes":{"list":"ordered","underline":true}},{"insert":"\\n","attributes":{"list":"ordered"}},{"insert":"b","attributes":{"bold":true}},{"insert":"\\n","attributes":{"list":"ordered"}},{"insert":"c     ","attributes":{"italic":true}},{"insert":"\\n","attributes":{"list":"ordered"}},{"insert":"Datas from "},{"insert":"xyz","attributes":{"color":"#FF3F51B5"}},{"insert":"\\n\\n\\n"}]'))
                    // )
                  ],
                ))),
      ],
    ));

_customCell(String? text, [bool isCenter = false]) => TableCell(
      verticalAlignment: TableCellVerticalAlignment.middle,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Align(
            alignment: isCenter ? Alignment.center : Alignment.centerLeft,
            child: Text(
              text!,
              style: customTextStyle.copyWith(
                  fontSize: 12, fontWeight: FontWeight.w600),
            )),
      ),
    );

List<int> _col = [20, 100, 20, 50, 50, 20];

_descPart(DoctorProfileSeupController controller) => SizedBox(
      width: 700,
      height: 500,
      child: CustomGroupBox(
          groupHeaderText: "Description",
          child: Column(
            children: [
              QuillToolbar.simple(
                configurations: QuillSimpleToolbarConfigurations(
                  decoration: customBoxDecoration.copyWith(color: kBgColorG),
                  toolbarIconAlignment: WrapAlignment.start,
                  toolbarIconCrossAlignment: WrapCrossAlignment.start,
                  showDirection: false,
                  showSearchButton: false,
                  showSubscript: false,
                  showSuperscript: false,
                  showClipboardCut: false,
                  showClipboardCopy: false,
                  showClipboardPaste: false,
                  showCodeBlock: false,
                  showQuote: false,
                  showIndent: false,
                  showLink: false,
                  showDividers: false,
                  showListCheck: false,
                  showInlineCode: false,
                  showClearFormat: false,
                  showUndo: false,
                  showRedo: false,
                  showHeaderStyle: false,
                  controller: controller.qController,
                ),
              ),
              Expanded(
                child: Container(
                  decoration: customBoxDecoration.copyWith(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4)),
                  child: QuillEditor.basic(
                    configurations: QuillEditorConfigurations(
                      controller: controller.qController,
                      //  readOnly: false,
                      // sharedConfigurations: const QuillSharedConfigurations(
                      //   locale: Locale('en'),
                      // ),
                    ),
                  ),
                ),
              )
            ],
          )),
    );

_imagePart(DoctorProfileSeupController controller) => SizedBox(
      width: 240,
      height: 290,
      child: CustomGroupBox(
          groupHeaderText: "Photo",
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Obx(() {
                return controller.imagePath.value != ''
                    ? Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            //controller.imageFile.value.path,
                            controller.imagePath.value,
                            //  width: 100.0, // Adjust width as needed
                            //height: 100.0,
                            fit: BoxFit.fitHeight, // Adjust height as needed
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
                      );
              }),
              Row(
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
                        // econtroller.isImageUpdate.value = true;
                      }
                    },
                    child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: customBoxDecoration.copyWith(
                            borderRadius: BorderRadiusDirectional.circular(50),
                            color: appColorLogoDeep),
                        child: const Icon(
                          Icons.photo,
                          color: appColorGrayLight,
                          size: 18,
                        )),
                  )
                ],
              )
            ],
          )),
    );

_entryPart(DoctorProfileSeupController controller) => SizedBox(
      width: 450,
      height: 290,
      child: CustomGroupBox(
          groupHeaderText: "Entry",
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                        child: CustomDropDown(
                            labeltext: "Select Department",
                            id: controller.selectedDeptID.value,
                            list: controller.list_department
                                .map((f) => DropdownMenuItem<String>(
                                    value: f.id,
                                    child: Text(
                                      f.name!,
                                      style: customTextStyle.copyWith(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500),
                                    )))
                                .toList(),
                            onTap: (v) {
                              controller.selectedDeptID.value = v!;
                            })),
                  ],
                ),
                10.heightBox,
                Row(
                  children: [
                    CustomTextBox(
                        caption: "Doc ID",
                        width: 120,
                        maxlength: 4,
                        textInputType: TextInputType.number,
                        controller: controller.txt_docid,
                        onChange: (v) {}),
                    6.widthBox,
                    InkWell(
                      onTap: () {
                        controller.loadFromMySql();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        child: const Icon(
                          Icons.search,
                          size: 22,
                          color: appColorLogoDeep,
                        ),
                      ),
                    )
                  ],
                ),
                10.heightBox,
                Row(
                  children: [
                    Expanded(
                        child: CustomTextBox(
                            caption: "Name",
                            controller: controller.txt_name,
                            onChange: (v) {})),
                  ],
                ),
                10.heightBox,
                Row(
                  children: [
                    Expanded(
                        child: CustomTextBox(
                            caption: "Designation",
                            controller: controller.txt_designation,
                            onChange: (v) {})),
                  ],
                ),
                10.heightBox,
                Row(
                  children: [
                    Expanded(
                        child: CustomTextBox(
                            caption: "Speciality",
                            controller: controller.txt_speciality,
                            onChange: (v) {})),
                  ],
                ),
                8.heightBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomButton(Icons.save,
                        controller.editDocID.value == '' ? "Save" : "Update",
                        () {
                      controller.saveUpdateData();
                    }),
                    controller.editDocID.value == ''
                        ? const SizedBox()
                        : InkWell(
                            onTap: () {
                              //  controller.txt_name.text = '';
                              //controller.editDocID.value = '';
                              controller.undo();
                            },
                            child: Container(
                                padding: const EdgeInsets.all(6),
                                child: const Icon(
                                  Icons.undo,
                                  size: 18,
                                )),
                          )
                  ],
                )
              ],
            ),
          )),
    );
