import 'dart:io';

import 'package:agmc/core/config/const.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill/quill_delta.dart';

import 'package:quill_html_converter/quill_html_converter.dart';

import '../../../../model/model_common.dart';
import '../../../../model/model_status.dart';
import '../model/model_doctor_master.dart';
import 'package:http/http.dart' as http;

class DoctorProfileSeupController extends GetxController with MixInController {
  var editDocID = ''.obs;
  var selectedDeptID = ''.obs;
  final TextEditingController txt_docid = TextEditingController();
  final TextEditingController txt_name = TextEditingController();
  final TextEditingController txt_designation = TextEditingController();
  final TextEditingController txt_speciality = TextEditingController();
  var list_department = <ModelCommon>[].obs;
  var list_doctor_master = <ModelDoctorMobMaster>[].obs;
  var list_doctor_temp = <ModelDoctorMobMaster>[].obs;

  final Rx<File> imageFile = File('').obs;
  QuillController qController = QuillController.basic();

  final TextEditingController txt_search = TextEditingController();

  void setEdit(ModelDoctorMobMaster e) async {
    selectedDeptID.value = e.deptId!;
    txt_designation.text = e.desig!;
    txt_docid.text = e.docId!;
    txt_name.text = e.deptName!;
    txt_speciality.text = e.special!;
    editDocID.value = e.docId!;
    // imageFile.value =
    //     File('https://web.asgaralihospital.com/pub/doc_image/${e.imagePath!}');
    // String url =
    //     'https://web.asgaralihospital.com/pub/doc_image/${e.imagePath!}';

    // final response = await http.get(Uri.parse(url));

    // if (response.statusCode == 200) {
    //   // Create a temporary file to store the downloaded data
    //   var tempDir = await Directory.systemTemp.createTemp('download');
    //   var tempFilePath = '${tempDir.path}/downloaded_file';
    //   // imageFile.value = File(tempFilePath);
    // }
  }

  void saveUpdateData() async {
    loader = CustomBusyLoader(context: context);
    dialog = CustomAwesomeDialog(context: context);
    loader.show();
    try {
      if (selectedDeptID.value == '') {
        loader.close();
        dialog
          ..dialogType = DialogType.warning
          ..message = 'Department required!'
          ..show();
        return;
      }
      if (txt_docid.text == '') {
        loader.close();
        dialog
          ..dialogType = DialogType.warning
          ..message = 'Please eneter valid Doctor ID!'
          ..show();
        return;
      }

      if (txt_designation.text == '') {
        loader.close();
        dialog
          ..dialogType = DialogType.warning
          ..message = 'Designation required!'
          ..show();
        return;
      }

      if (txt_speciality.text == '') {
        loader.close();
        dialog
          ..dialogType = DialogType.warning
          ..message = 'Speciality required!'
          ..show();
        return;
      }

      if (imageFile.value.path == '') {
        loader.close();
        dialog
          ..dialogType = DialogType.warning
          ..message = 'Please select Profile Image'
          ..show();
        return;
      }

      var img = await imageFileToBase64(imageFile.value.path);
      //   print(img);

      var x = await api.createLead([
        {"path": "doc_image", "img": img}
      ], "save_image");
      //  print(x);
      ModelStatus st = x.map((e) => ModelStatus.fromJson(e)).first;
      //print(st.msg!);

      if (st.status.toString() == "1") {
        //doc_id in int, dep_id in int,p_name in varchar2, p_desig in varchar2, p_speciality in varchar2, p_image in varchar2,p_desc in clob

        // print({
        //   "tag": "112",
        //     "doc_id": txt_docid.text.trim(),
        //     "dep_id ": selectedDeptID.value,
        //     "p_name": txt_name.text,
        //     "p_desig": txt_designation.text,
        //     "p_speciality": txt_speciality.text,
        //     "p_image": st.msg,
        //     "p_desc": qController.document.toDelta().toHtml()
        // });
        var html = qController.document.toDelta().toHtml();
        x = await api.createLead([
          {
            "tag": "112",
            "doc_id": txt_docid.text.trim(),
            "dep_id ": selectedDeptID.value,
            "p_name": txt_name.text,
            "p_desig": txt_designation.text,
            "p_speciality": txt_speciality.text,
            "p_image": st.msg,
            "p_desc": html
          }
        ]);
        loader.close();
        ModelStatus ss = await getStatusWithDialog(x, dialog);

        if (ss.status == "1") {
          dialog
            ..dialogType = DialogType.success
            ..message = ss.msg!
            ..show();
          if (editDocID.value != '') {
         list_doctor_master.removeWhere((e) => e.docId == txt_docid.text);
          }

          list_doctor_master.add(
            ModelDoctorMobMaster(
                deptId: selectedDeptID.value,
                deptName: list_department
                    .where((c) => c.id == selectedDeptID.value)
                    .first
                    .name,
                des: html,
                desig: txt_designation.text,
                docId: txt_docid.text,
                docName: txt_name.text,
                imagePath: st.msg!,
                special: txt_speciality.text),
          );
          list_doctor_temp.clear();
          list_doctor_temp.addAll(list_doctor_master);

          // var d = Document.fromHtml('');
           qController.document.delete(0, qController.document.length);
          //Document.fromDelta(Delta());
          txt_designation.text = '';
          txt_docid.text = '';
          txt_speciality.text = '';
          imageFile.value = File('');
          selectedDeptID.value = '';
          editDocID.value = '';


        }

        //print(x);
      } else {
        loader.close();
      }

//  var x = qController.document.toDelta();
//                           final html = x.toHtml();

      // print(html);

//save_image
//  var path1 = objData[0]["path"].ToString();
//                 var img = objData[0]["img"].ToString();

      // api.createLead([{}]);
    } catch (e) {
      loader.close();
      dialog
        ..dialogType = DialogType.error
        ..message = e.toString()
        ..show();
    }
  }

  @override
  void onInit() async {
    isLoading.value = true;
    api = data_api();
    try {
      var x = await api.createLead([
        {"tag": "110"}
      ]);
      if (x != [] ||
          x.map((e) => ModelStatus.fromJson(e)).first.status != '3') {
        list_department.addAll(x.map((e) => ModelCommon.fromJson(e)));
      }

      x = await api.createLead([
        {"tag": "113"}
      ]);
      if (x != [] ||
          x.map((e) => ModelStatus.fromJson(e)).first.status != '3') {
        list_doctor_master
            .addAll(x.map((e) => ModelDoctorMobMaster.fromJson(e)));
        list_doctor_temp.addAll(list_doctor_master);
      }
      //list_doctor_master
      isLoading.value = false;
      // print(list_department.length);
    } catch (e) {
      isError.value = true;
      errorMessage.value = e.toString();
      isLoading.value = false;
    }
    super.onInit();
  }
}
