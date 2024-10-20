import '../../../../core/config/const.dart';
import '../controller/production_process_controller.dart';

class ProductionProcess extends StatelessWidget {
  const ProductionProcess({super.key});
  void disposeController() {
    try {
      Get.delete<ProductionProcessController>();
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    final ProductionProcessController controller =
        Get.put(ProductionProcessController());
    controller.context = context;
    return CommonBody2(controller,
     CustomTwoPanelWindow(leftPanelHeaderText: "Plan list",
      rightPanelHeaderText: "Material Details", leftChildren: const [], rightChildren: const [], context: context));
  }
}
