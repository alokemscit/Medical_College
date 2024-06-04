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
            
             SizedBox(
             
              width: 700,
               child: SingleChildScrollView(
                 child: Column(
                 
                  children: [
                  controller.context.width > 1050
                      ? Row(
                          children: [
                             _imagePart(controller),
                            8.widthBox,
                           Flexible(child:    _entryPart(controller),)
                           
                          
                          ],
                        )
                      : Column(
                          children: [
                            _imagePart(controller),
                            8.heightBox,
                            _entryPart(controller),
                          ],
                        ),
                       Align(
                         alignment: Alignment.topLeft,
                         child: _descPart(controller),)
                 ],),
               ),
             ),
                 
                controller.context.width>1320?  Expanded(
                 
                  child: Row(
                    children: [
                    8.widthBox,   Expanded(child: CustomGroupBox(groupHeaderText: "Doctor List", child: Column(children: [],))),
                    ],
                  )):const SizedBox()
            ],),
          )
          
        ]);
// 
_descPart(DoctorProfileSeupController controller) => SizedBox(
      width: 700,
      height: 400,
      child: CustomGroupBox(
          groupHeaderText: "Description",
          child: Column(
            children: [

 
 

              
            ],
          )),
    );

_imagePart(DoctorProfileSeupController controller) => const SizedBox(
      width: 240,
      height: 270,
      child: CustomGroupBox(
          groupHeaderText: "Photo",
          child: Column(
            children: [],
          )),
    );

_entryPart(DoctorProfileSeupController controller) => SizedBox(
      width: 450,
      height: 270,
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
                    const Icon(
                      Icons.search,
                      size: 22,
                      color: appColorLogoDeep,
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
                            controller: controller.txt_designation,
                            onChange: (v) {})),
                  ],
                ),
                10.heightBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomButton(Icons.save,
                        controller.editDocID.value == '' ? "Save" : "Update",
                        () {
                      // controller.saveUpdate();
                    }),
                    controller.editDocID.value == ''
                        ? const SizedBox()
                        : InkWell(
                            onTap: () {
                              controller.txt_name.text = '';
                              controller.editDocID.value = '';
                            },
                            child: Container(
                                padding: const EdgeInsets.all(8),
                                child: const Icon(
                                  Icons.undo,
                                  size: 18,
                                )),
                          )
                  ],
                ),
              ],
            ),
          )),
    );
