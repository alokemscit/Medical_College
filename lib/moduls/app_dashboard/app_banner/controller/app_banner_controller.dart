import 'package:agmc/core/config/const.dart';
import 'package:agmc/model/model_common.dart';
import 'package:agmc/model/model_status.dart';

class AppBannerController extends GetxController with MixInController {
  var imagePath = ''.obs;
  var isUpdate = false.obs;
  var editBannnerID = ''.obs;
  var editImagePath = ''.obs;
  // ignore: non_constant_identifier_names
  var list_banner = <ModelCommon>[].obs;

  void deleteBanner(ModelCommon e) async {
    loader = CustomBusyLoader(context: context);
    dialog = CustomAwesomeDialog(context: context);
    loader.show();
    try {
      var x = await api.createLead([
        {"tag": "118", "p_id": e.id}
      ]);
      loader.close();
      ModelStatus s = await getStatusWithDialog(x, dialog);
      if (s.status == '1') {
        dialog
          ..dialogType = DialogType.success
          ..message = s.msg!
          ..show();
        list_banner.removeWhere((f) => f.id == e.id);
      }
    } catch (e) {
      loader.close();
      dialog
        ..dialogType = DialogType.error
        ..message = e.toString()
        ..show();
    }
  }

  void editBanner(ModelCommon e) {
    editBannnerID.value = e.id!;
    imagePath.value =
        'https://web.asgaralihospital.com/pub/app_banner/${e.name!}';
    isUpdate.value = false;
    editImagePath.value = e.name!;
  }

  void saveUpdateBanner() async {
    loader = CustomBusyLoader(context: context);

    dialog = CustomAwesomeDialog(context: context);

    if (imagePath.value == '') {
      dialog
        ..dialogType = DialogType.warning
        ..message = 'Banner Image Required!'
        ..show();
      return;
    }
    loader.show();
    await Future.delayed(const Duration(microseconds: 300));
    try {
      ModelStatus st = ModelStatus();
      List x;
      if (isUpdate.value) {
        var img = await imageFileToBase64(imagePath.value);
        // print(img);

        x = await api.createLead([
          {"path": "app_banner", "img": img}
        ], "save_image");
        //  print(x);
        st = x.map((e) => ModelStatus.fromJson(e)).first;
      } else {
        st = ModelStatus(id: "", status: "1", msg: ' ');
      }

      //p_id in int,p_image
      x = await api.createLead([
        {
          "tag": "116",
          "p_id": editBannnerID.value != '' ? editBannnerID.value : "0",
          "p_image": st.msg!
        }
      ]);
      loader.close();
      ModelStatus s = await getStatusWithDialog(x, dialog);
      if (s.status == '1') {
        dialog
          ..dialogType = DialogType.success
          ..message = s.msg!
          ..show();
        if (editBannnerID.value != '') {
          list_banner.removeWhere((e) => e.id == editBannnerID.value);
        }
        list_banner.insert(
            0,
            ModelCommon(
                id: s.id!,
                name: isUpdate.value ? st.msg! : editImagePath.value));
        editBannnerID.value = '';
        isUpdate.value = false;
        imagePath.value = '';
        editImagePath.value = '';
      }
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
    api = data_api();
    isLoading.value = true;
    try {
      var x = await api.createLead([
        {"tag": "117"}
      ]);
      if (x != [] ||
          x.map((e) => ModelStatus.fromJson(e)).first.status != "3") {
        list_banner.addAll(x.map((e) => ModelCommon.fromJson(e)));
      }

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      isError.value = true;
      errorMessage.value = e.toString();
    }
    super.onInit();
  }
}
