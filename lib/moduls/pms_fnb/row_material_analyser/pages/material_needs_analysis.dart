import 'package:agmc/core/config/const_widget.dart';

import '../../../../core/config/const.dart';
import '../controller/material_needs_analysis_controller.dart';

class MaterialNeedsAnalysis extends StatelessWidget {
  const MaterialNeedsAnalysis({super.key});

  void disposeController() {
    try {
      Get.delete<MaterialNeedsAnalysisController>();
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    final MaterialNeedsAnalysisController controller =
        Get.put(MaterialNeedsAnalysisController());
    controller.context = context;
    return Obx(() => CommonBody(
          controller,
          _mainWidget(controller),
          _mainWidget(controller),
          _mainWidget(controller),
        ));
  }
}

Widget _mainWidget(MaterialNeedsAnalysisController controller) =>
    controller.context.width > 1000
        ? Row(
            children: [
              Expanded(flex: 4, child: _masterPanel(controller)),
              8.widthBox,
              Expanded(flex: 6, child: _iteEntryPanel(controller))
            ],
          )
        : Column(
            children: [
               Expanded(flex: 4, child: _masterPanel(controller)),
              8.heightBox,
              Expanded(flex: 6, child: _iteEntryPanel(controller))
            ],
          );

Widget _masterPanel(MaterialNeedsAnalysisController controller) =>
    CustomAccordionContainer(headerName: "Planed Item Details", height: 0,isExpansion: false, children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Container(
          // padding: EdgeInsets.all(8),
          decoration: customBoxDecoration,
        ),
      )
    ]);
Widget _iteEntryPanel(MaterialNeedsAnalysisController controller) =>
    CustomAccordionContainer(headerName: "Raw Materials Details", height: 0,isExpansion: false, children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Container(
          // padding: EdgeInsets.all(8),
          decoration: customBoxDecoration,
        ),
      )
    ]);
