import 'package:agmc/core/config/const_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../../../core/config/const.dart';
import '../controller/goods_formula_setup_controller.dart';

class GoodsFormulaSetup extends StatelessWidget {
  const GoodsFormulaSetup({super.key});
  void disposeController() {
    try {
      Get.delete<GoodsFormulaSetupController>();
    } catch (e) {}
  }

  //GoodsFormulaSetupController controller;
  @override
  Widget build(BuildContext context) {
    final GoodsFormulaSetupController controller =
        Get.put(GoodsFormulaSetupController());
    controller.context = context;
    return CommonBody(
      mobile: _commonWidget(controller),
      tablet: _commonWidget(controller),
      desktop: _commonWidget(controller),
      controller: controller,
    );
  }
}

Widget _commonWidget(GoodsFormulaSetupController controller) =>
    controller.context.width > 1000
        ? Row(
            children: [
              Expanded(flex: 4, child: _foodItemList(controller)),
              8.widthBox,
              Expanded(flex: 6, child: _setupList(controller))
            ],
          )
        : Column(
            children: [
              Expanded(flex: 6, child: _foodItemList(controller)),
              8.heightBox,
              Expanded(flex: 4, child: _setupList(controller))
            ],
          );

Widget _foodItemList(GoodsFormulaSetupController controller,
        [double height = 0]) =>
    CustomAccordionContainer(
        headerName: "List Of Finished Goods",
        height: height,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(2),
              child: Container(
                decoration: customBoxDecoration,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                              child: CustomSearchBox(
                                borderRadious: 4,
                                  caption: "Item Search",
                                  controller: TextEditingController(),
                                  onChange: (v) {}))
                        ],
                      ),
                      10.heightBox,
                      Table(
                        border: CustomTableBorderNew,
                        columnWidths: customColumnWidthGenarator(_col),
                        children: [TableRow(
                          decoration: CustomTableHeaderRowDecorationnew,
                          children: [
Padding(padding: const EdgeInsets.all(4),
child: CustomTableCell("Code",customTextStyle.copyWith(fontSize: 14,fontWeight: FontWeight.bold)),),
                            Padding(padding: const EdgeInsets.all(4),
child: CustomTableCell("Name",customTextStyle.copyWith(fontSize: 14,fontWeight: FontWeight.bold)),),
                            Padding(padding: const EdgeInsets.all(4),
child: CustomTableCell("Status",customTextStyle.copyWith(fontSize: 14,fontWeight: FontWeight.bold)),),
Padding(padding: const EdgeInsets.all(4),
child: Align( alignment: Alignment.center, child: CustomTableCell("*",customTextStyle.copyWith(fontSize: 14,fontWeight: FontWeight.bold)),) ,),
                            
                            
                            
                            

                          ]
                        )],
                      ),


                     Expanded(child: SingleChildScrollView(
                       child: Table(
                          border: CustomTableBorderNew,
                          columnWidths: customColumnWidthGenarator(_col),
                          children: [
                            //tableBodyGenerator(_col, TableRow() ),
                            
                          ],
                       ),
                     ))

                     

                    ],
                  ),
                ),
              ),
            ),
          )
        ]);

List<int> _col = [80,150,50,30];

Widget _setupList(GoodsFormulaSetupController controller,
        [double height = 0]) =>
    CustomAccordionContainer(
        headerName: "Formula With Raw Materials", height: height, children: []);
