 

import '../../../core/config/const.dart';
import '../../../model/model_common.dart';
import '../diet_mealplan/model/model_meal_plan_config.dart';

Future<void> Diet_Get_DietType(
    data_api api, List<ModelCommon> list ) async {
  try {
   await mLoadModel_All(
          api,
          [
            {"tag": "15"}
          ],
          list,
          (x) => ModelCommon.fromJson(x),"getdata_ipd");
  } catch (e) {
    throw Exception('Error occurred while loading model: $e');
  }
}

Future<void> Diet_Get_DietWeek(
    data_api api, List<ModelCommon> list ) async {
  try {
   await mLoadModel_All(
          api,
          [
            {"tag": "16"}
          ],
          list,
          (x) => ModelCommon.fromJson(x),"getdata_ipd");
  } catch (e) {
    throw Exception('Error occurred while loading model: $e');
  }
}
Future<void> Diet_Get_DietTime(
    data_api api, List<ModelCommon> list ) async {
  try {
    await mLoadModel_All(
          api,
          [
            {"tag": "17"}
          ],
          list,
          (x) => ModelCommon.fromJson(x),"getdata_ipd");
  } catch (e) {
    throw Exception('Error occurred while loading model: $e');
  }
}
Future<void> Diet_Get_NurseStation(
    data_api api, List<ModelCommon> list ) async {
  try {
    await mLoadModel_All(
          api,
          [
            {"tag": "18"}
          ],
          list,
          (x) => ModelCommon.fromJson(x),"getdata_ipd");
  } catch (e) {
    throw Exception('Error occurred while loading model: $e');
  }
}

Future<void> Diet_Get_DietConfigData(
    data_api api, List<ModelPlanConfiguedData> list ) async {
  try {
    await mLoadModel_All(
          api,
          [
            {"tag": "12"}
          ],
          list,
          (x) => ModelPlanConfiguedData.fromJson(x),"getdata_ipd");
  } catch (e) {
    throw Exception('Error occurred while loading model: $e');
  }
}