
import 'package:agmc/core/config/const.dart';

import '../../share_widget/lab_share_widget.dart';
import '../controller/lab_outsource_result_finalized_controller.dart';

class OutSourceResultFinalize extends StatelessWidget {
  const OutSourceResultFinalize({
    super.key,
  });
  void disposeController() {
    try {
      Get.delete<OutSourceResultFinalizeController>();
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    final OutSourceResultFinalizeController controller =
        Get.put(OutSourceResultFinalizeController());
    controller.context = context;

    return Obx(() => CommonBody3(
        controller,
        [
          _mainwidget(controller),
        ],
        'Outsourcing Result Verify::'));
  }
}

Widget _mainwidget(OutSourceResultFinalizeController controller) => Expanded(
      child: controller.context.width > 1350
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _leftPanel(controller),
                4.widthBox,
                _rightPanel(controller),
              ],
            )
          : Column(
              children: [
                !controller.isShowLeftPanel.value
                    ? const SizedBox()
                    : Expanded(flex: 4, child: _leftPanel(controller)),
                _rightPanel(controller)
              ],
            ),
    );

Widget _rightPanel(OutSourceResultFinalizeController controller) =>
    controller.selected_mrr.value.mrId == null
        ? const SizedBox()
        : Expanded(
            flex: 6,
            child: lab_widget().lab_rightPanel(controller, 'Save to Finalize'));

Widget _leftPanel(OutSourceResultFinalizeController controller) =>
     lab_widget().lab_leftPanel(
        controller,
        controller.context.width,
        lab_widget().lab_treeview(
            controller.context,
            controller.list_mrr_master_temp,
            controller.list_test_data_temp,
            controller.selected_mrr.value, controller));
