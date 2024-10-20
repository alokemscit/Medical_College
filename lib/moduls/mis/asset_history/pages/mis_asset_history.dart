import 'package:flutter/cupertino.dart';

import '../../../../core/config/const.dart';
import '../controller/mis_asset_history_controller.dart';
 

class MisAssetHistory extends StatelessWidget {
  const MisAssetHistory({super.key});
  void disposeController() {
    try {
      Get.delete<MisAssetHistoryController>();
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    final MisAssetHistoryController controller =
        Get.put(MisAssetHistoryController());
    controller.context = context;
    return Obx(() => CommonBody3(
        controller,
        [
          Expanded(
              child: context.width > 1050
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: const BoxDecoration(color: Colors.white),
                          width: 350,
                          height: double.infinity,
                          child: CustomGroupBox(
                              bgColor: Colors.white,
                              padingvertical: 2,
                              groupHeaderText: 'Item Group',
                              child: _tree_box(controller)),
                        ),
                        4.widthBox,
                        Expanded(child: _itemListPanel(controller))
                      ],
                    )
                  : Column(
                      children: [
                        SizedBox(
                          height: 350,
                          child: CustomGroupBox(
                              groupHeaderText: '',
                              child: _tree_box(controller)),
                        ),
                        Expanded(child: _itemListPanel(controller))
                      ],
                    )),
          8.heightBox,
        ],
        'Asset history::'));
  }
}

_itemListPanel(MisAssetHistoryController controller) => CustomGroupBox(
      padingvertical: 0,
      groupHeaderText: 'Item List',
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Flexible(
                  child: CustomSearchBox(
                    width: 450,
                    controller: controller.txt_search,
                    onChange: (value) {
                      controller.search();
                    },
                  ),
                ),
                controller.list_asset_temp.isEmpty
                    ? const SizedBox()
                    : Row(
                        children: [
                          4.widthBox,
                          InkWell(
                            onTap: () {
                              controller.print_table();
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(4.0),
                              child: Icon(
                                Icons.print_sharp,
                                color: appColorBlue,
                                size: 24,
                              ),
                            ),
                          ),
                        ],
                      )
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder(
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                      child:
                          CupertinoActivityIndicator()); // Show loading indicator while processing
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return CustomTableGenerator(colWidtList: const [
                    25,
                    25,
                    25,
                    25,
                    35,
                    20,
                    50,
                    60
                  ], childrenHeader: [
                    CustomTableColumnHeaderBlack('GRN. No'),
                    CustomTableColumnHeaderBlack('GRN. Date'),
                    CustomTableColumnHeaderBlack('Chalan No'),
                    CustomTableColumnHeaderBlack('Chalan. Date'),
                    CustomTableColumnHeaderBlack('Batch No'),
                    CustomTableColumnHeaderBlack('Item Code'),
                    CustomTableColumnHeaderBlack('Item Name'),
                    CustomTableColumnHeaderBlack('Supplier Name'),
                  ], childrenTableRowList: [

                    ...snapshot.data!
 
                  ]);
                }
              },
              future: controller.generateTableRows(controller.list_asset_temp),
            ),
          ),
        ],
      ),
    );


Widget _tree_box(MisAssetHistoryController controller) => ListView(
      children: [
        ...controller.list_mgroup.map((f) => _node(
                0,
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Text(
                    f.name!,
                    style: customTextStyle.copyWith(color: appColorMint),
                  ),
                ),
                const SizedBox(),
                [
                  ...(controller.list_group.where((e) => e.code == f.id))
                      .map((a) => Row(
                            children: [
                            
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 26.0, top: 1.5, bottom: 1.5),
                                child: InkWell(
                                  onTap: () {
                                    controller.setGroup(a.id!);
                                  },
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.arrow_right,
                                        size:
                                            controller.selectedGroupID.value ==
                                                    a.id
                                                ? 22
                                                : 18,
                                        color:
                                            controller.selectedGroupID.value ==
                                                    a.id
                                                ? appColorLogoDeep
                                                : Colors.black,
                                      ),
                                      4.widthBox,
                                      Text(
                                        a.name!,
                                        style: customTextStyle.copyWith(
                                            fontSize: controller.selectedGroupID
                                                        .value ==
                                                    a.id
                                                ? 13
                                                : 12,
                                            fontWeight: FontWeight.w600,
                                            color: controller.selectedGroupID
                                                        .value ==
                                                    a.id
                                                ? appColorLogoDeep
                                                : Colors.black),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ))
                ]))
      ],
    );

Widget _node(@required double leftPad, @required Widget name,
        @required Widget event, @required List<Widget> children) =>
    Padding(
      padding: EdgeInsets.only(left: leftPad),
      child: CustomPanel(
        isSelectedColor: false,
        isSurfixIcon: false,
        isLeadingIcon: true,
        isExpanded: false,
        title: Expanded(
          child: Row(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Flexible(child: name), 15.widthBox, event],
          ),
        ),

        /// Ledger-------
        children: children,
      ),
    );
 