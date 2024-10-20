// import 'package:agmc/core/config/const.dart';

// import '../../../../model/model_common.dart';
// import '../../../../model/model_status.dart';
// import '../../diet_category/model/model_diet_master.dart';

// class MealPlanController extends GetxController with MixInController {
//   var selectedDiedTypeID = ''.obs;
//   var selectedDietID = ''.obs;
//   var selectedDietName = ''.obs;

//   var selectedWeekID = ''.obs;
//   var selectedTimeID = ''.obs;

//   var isPopup = true.obs;

//   var list_diet_type = <ModelCommon>[].obs;

//   var list_week = <ModelCommon>[].obs;

//   var lis_diet_master = <ModelDietMaster>[].obs;

//   var list_time = <ModelCommon>[].obs;

//   var list_menu = <_menu>[].obs;

//   var list_chart = <_chart>[].obs;

  

//   void seletDietOrWeek() async {
//     lis_diet_master.clear();
//     loader = CustomBusyLoader(context: context);
//     if (selectedDiedTypeID.value != '' &&
//         selectedWeekID.value != '' &&
//         selectedTimeID.value != '') {
//       loader.show();
//       selectedDietID.value = '';
//       var x = await api.createLead([
//         {"tag": "97", "p_type_id": selectedDiedTypeID.value}
//       ]);
//       // print(x);
//       lis_diet_master.addAll(x.map((e) => ModelDietMaster.fromJson(e)));

//       // lis_diet_master.forEach((element) => {
//       //   listLunch.add({"id":element.id,"name":element.name!,})
//       // });
//       list_menu.add(_menu(id: "2", value: ""));
//       list_menu.add(_menu(id: "", value: ""));
//       list_menu.add(_menu(id: "13", value: ""));
//       list_menu.add(_menu(id: "14", value: ""));
//       list_menu.add(_menu(id: "17", value: ""));
//       list_menu.add(_menu(id: "16", value: ""));
//       list_menu.add(_menu(id: "3", value: ""));
//       list_menu.add(_menu(id: "15", value: ""));

//       lis_diet_master.forEach((element) {
//         list_chart
//             .add(_chart(id: element.id, name: element.name, menu: list_menu));
//       });

//       loader.close();
//     }
//   }

//   @override
//   void onInit() async {
//     isError.value = false;
//     isLoading.value = true;
//     api = data_api();
//     try {
//       var x = await api.createLead([
//         {"tag": "96"}
//       ]);
//       if (x == [] ||
//           x.map((e) => ModelStatus.fromJson(e)).first.status == '3') {
//         return;
//       }
//       list_diet_type.addAll(x.map((e) => ModelCommon.fromJson(e)));

//       x = await api.createLead([
//         {"tag": "103"}
//       ]);
//       list_week.addAll(x.map((e) => ModelCommon.fromJson(e)));

//       x = await api.createLead([
//         {"tag": "104"}
//       ]);
//       list_time.addAll(x.map((e) => ModelCommon.fromJson(e)));

//       isLoading.value = false;
//     } catch (e) {
//       isLoading.value = false;
//       isError.value = true;
//       errorMessage.value = e.toString();
//     }
//     super.onInit();
//   }
// }

// class _menu {
//   final String? id;
//   final String? value;
//   _menu({required this.id, required this.value});
// }

// class _chart {
//   final String? id;
//   final String? name;
//   final List<_menu> menu;
//   _chart({required this.id, required this.name, required this.menu});
// }
