import 'package:agmc/core/config/const.dart';

import 'package:flutter_quill/flutter_quill.dart';

import '../../../../model/model_common.dart';
import '../../../../model/model_status.dart';
import '../model/model_doctor_master.dart';

import 'dart:convert';

class DoctorProfileSeupController extends GetxController with MixInController {
  var editDocID = ''.obs;
  var selectedDeptID = ''.obs;
  var imagePath = ''.obs;

  final TextEditingController txt_docid = TextEditingController();
  final TextEditingController txt_name = TextEditingController();
  final TextEditingController txt_designation = TextEditingController();
  final TextEditingController txt_speciality = TextEditingController();
  var list_department = <ModelCommon>[].obs;
  var list_doctor_master = <ModelDoctorMobMaster>[].obs;
  var list_doctor_temp = <ModelDoctorMobMaster>[].obs;

  var doc_list = <_ModelDoctorMaster>[].obs;
  var unit_list = <_ModelUnitMaster>[].obs;

  //final Rx<File> imageFile = File('').obs;
  QuillController qController = QuillController.basic();

  final TextEditingController txt_search = TextEditingController();

  var isUpdate = false.obs;
  var editImagePath = ''.obs;

  void search() {
    list_doctor_temp.clear();
    list_doctor_temp.addAll(list_doctor_master.where((e) =>
        e.docId == txt_search.text ||
        e.docName!.toUpperCase().contains(txt_search.text.toUpperCase())));
  }

  void deleteProfile(ModelDoctorMobMaster e) async {
    loader = CustomBusyLoader(context: context);
    loader.show();
    dialog = CustomAwesomeDialog(context: context);

    try {
      var x = await api.createLead([
        {"tag": "115", "p_docid": e.docId}
      ]);
      loader.close();
      ModelStatus s = await getStatusWithDialog(x, dialog);
      if (s.status == '1') {
        dialog
          ..dialogType = DialogType.success
          ..message = s.msg!
          ..show();
        list_doctor_master.removeWhere((e1) => e1.docId == e.docId);
        list_doctor_temp.clear();
        list_doctor_temp.addAll(list_doctor_master);
      }
    } catch (e) {
      loader.close();
      dialog
        ..dialogType = DialogType.warning
        ..message = 'Department required!'
        ..show();
    }
  }

  void loadFromMySql() async {
    // undo();
    if (txt_docid.text.isEmpty) {
      return;
    }
    var x = unit_list.where((e) => e.docId == txt_docid.text);
    //print(x.length);
    if (x.isNotEmpty) {
      //  print(x.first.unitId);
      selectedDeptID.value = x.first.unitId!;
    }

    var y = doc_list.where((e) => e.docid == txt_docid.text);
    if (y.isNotEmpty) {
      _ModelDoctorMaster k = y.first;

      txt_name.text = k.name == null ? "" : k.name!;
      txt_designation.text = k.designation == null ? "" : k.designation!;
      txt_speciality.text = k.speciality==null?"":k.speciality!;
      if (k.details != null) {
        var d = Document.fromHtml(k.details!);
        qController.document = d;
      }
      imagePath.value = 'https://www.asgaralihospital.com/storage/${k.image!}';
      isUpdate.value = true;
      // imagePath.value =
      // var img = await imageFileToBase64(imagePath.value);
      // print(img);
    }
  }

  void setEdit(ModelDoctorMobMaster e) async {
    if (e.des != null) {
      qController.document = Document.fromJson(jsonDecode(e.des!));
    }

    selectedDeptID.value = e.deptId!;
    txt_designation.text = e.desig!;
    txt_docid.text = e.docId!;
    txt_name.text = e.docName!;
    txt_speciality.text = e.special!;
    editDocID.value = e.docId!;
    imagePath.value =
        'https://web.asgaralihospital.com/pub/doc_image/${e.imagePath!}';
    isUpdate.value = false;
    editImagePath.value = e.imagePath!;
  }

  void undo() {
    qController.document = Document();
    //Document.fromDelta(Delta());
    txt_designation.text = '';
    txt_docid.text = '';
    txt_speciality.text = '';
    txt_name.text = '';
    //imageFile.value = File('');
    selectedDeptID.value = '';
    editDocID.value = '';
    imagePath.value = '';
    isUpdate.value = false;
    editImagePath.value = '';
  }

  void saveUpdateData() async {
    loader = CustomBusyLoader(context: context);
    loader.show();
    dialog = CustomAwesomeDialog(context: context);

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

      if (imagePath.value == '') {
        loader.close();
        dialog
          ..dialogType = DialogType.warning
          ..message = 'Please select Profile Image'
          ..show();
        return;
      }
      ModelStatus st = ModelStatus();
      List x;
      if (isUpdate.value) {
        var img = await imageFileToBase64(imagePath.value);
        // print(img);

        x = await api.createLead([
          {"path": "doc_image", "img": img}
        ], "save_image");
        //  print(x);
        st = x.map((e) => ModelStatus.fromJson(e)).first;
      } else {
        st = ModelStatus(id: "", status: "1", msg: '');
      }
      //print(st.msg!);

      if (st.status.toString() == "1") {
        var json = jsonEncode(qController.document.toDelta().toJson());
        // print(json);

        x = await api.createLead([
          {
            "tag": "112",
            "doc_id": txt_docid.text.trim(),
            "dep_id ": selectedDeptID.value,
            "p_name": txt_name.text,
            "p_desig": txt_designation.text,
            "p_speciality": txt_speciality.text,
            "p_image": st.msg,
            "p_desc": json
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
          // print(imagePath.value);
          list_doctor_master.add(
            ModelDoctorMobMaster(
                deptId: selectedDeptID.value,
                deptName: list_department
                    .where((c) => c.id == selectedDeptID.value)
                    .first
                    .name,
                des: json,
                desig: txt_designation.text,
                docId: txt_docid.text,
                docName: txt_name.text,
                imagePath: isUpdate.value ? st.msg! : editImagePath.value,
                special: txt_speciality.text),
          );
          list_doctor_temp.clear();
          list_doctor_temp.addAll(list_doctor_master);

          // var d = Document.fromHtml('');
          qController.document = Document();
          //Document.fromDelta(Delta());
          txt_designation.text = '';
          txt_docid.text = '';
          txt_speciality.text = '';
          txt_name.text = '';
          //  imageFile.value = File('');
          selectedDeptID.value = '';
          editDocID.value = '';
          imagePath.value = '';
        }

        //print(x);
      } else {
        loader.close();
      }
    } catch (e) {
      loader.close();
      dialog
        ..dialogType = DialogType.error
        ..message = e.toString()
        ..show();
    }
  }

  // String extractPlainText(List<dynamic> delta) {
  //   return delta
  //       .where((item) =>
  //           item is Map<String, dynamic> && item.containsKey('insert'))
  //       .map((item) => item['insert'])
  //       .where((insert) => insert is String)
  //       .join();
  // }

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

//x=await api.createLead({})

      x = await api.createLead([
        {"tag": "114"}
      ]);
      unit_list.addAll(x.map((e) => _ModelUnitMaster.fromJson(e)));
      print(unit_list.length);
      x = await api.get_mysql_doctor();
      doc_list.addAll(x.map((e) => _ModelDoctorMaster.fromJson(e)));
      //  print(doc_list.length);
      // print(list_department.length);
    } catch (e) {
      isError.value = true;
      errorMessage.value = e.toString();
      isLoading.value = false;
    }
    super.onInit();
  }
}

class _ModelDoctorMaster {
  String? docid;
  String? name;
  String? designation;
  String? speciality;
  String? image;
  String? details;
  String? unitID;

  _ModelDoctorMaster(
      {this.docid,
      this.name,
      this.designation,
      this.speciality,
      this.image,
      this.details,
      this.unitID});

  _ModelDoctorMaster.fromJson(Map<String, dynamic> json) {
    docid = json['docid'].toString();
    name = json['name'];
    designation = json['designation'];
    speciality = json['speciality'];
    image = json['image'];
    details = json['details'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['docid'] = this.docid;
    data['designation'] = this.designation;
    data['speciality'] = this.speciality;
    data['image'] = this.image;
    data['details'] = this.details;
    return data;
  }
}

class _ModelUnitMaster {
  String? docId;
  String? unitId;

  _ModelUnitMaster({this.docId, this.unitId});

  _ModelUnitMaster.fromJson(Map<String, dynamic> json) {
    docId = json['doc_id'];
    unitId = json['unit_id'];
  }
}
