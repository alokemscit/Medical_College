 

import '../../../../core/config/const.dart';
import '../controller/diet_meal_plan_controller.dart';

class MealPlan extends StatelessWidget {
  const MealPlan({super.key});
  void disposeController() {
    try {
      Get.delete<MealPlanController>();
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    final MealPlanController controller = Get.put(MealPlanController());
    controller.context = context;
    return Obx(() => CommonBody2(controller, _mainWidget(controller)));
  }
}

_mainWidget(MealPlanController controller) => CustomAccordionContainer(
        isExpansion: false,
        headerName: "Weekly Paln",
        height: 0,
        bgColor: appGray100,
        children: [
          Expanded(
            child: controller.context.width > 1150
                ? _desktop(controller)
                : _mobile(controller),
          )
        ]);

_mobile(MealPlanController controller) => Column(
      children: [
        _mealItemType(controller),
        8.heightBox,
        _mealItem(controller),
      ],
    );

_desktop(MealPlanController controller) => Row(
      children: [
        _mealItemType(controller, 2),
        8.widthBox,
        _mealItem(controller, 6),
      ],
    );

_typeEntryPart(MealPlanController controller) => CustomGroupBox(
    groupHeaderText: "Select Type",
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: CustomDropDown(
                  labeltext: 'Diet Type',
                  id: controller.selectedDiedTypeID.value,
                  list: controller.list_diet_type
                      .map((element) => DropdownMenuItem<String>(
                          value: element.id, child: Text(element.name!)))
                      .toList(),
                  onTap: (v) {
                    controller.selectedDiedTypeID.value = v!;
                    controller.seletDietOrWeek();
                  },
                ),
              ),
              // 32.widthBox,
              // Expanded(
              //     flex: controller.context.width > 1150 ? 2 : 0,
              //     child: const SizedBox())
            ],
          ),
          12.heightBox,
          Row(
            children: [
              Expanded(
                child: CustomDropDown(
                  labeltext: 'Week Name',
                  id: controller.selectedWeekID.value,
                  list: controller.list_week
                      .map((element) => DropdownMenuItem<String>(
                          value: element.id, child: Text(element.name!)))
                      .toList(),
                  onTap: (v) {
                    controller.selectedWeekID.value = v!;
                    controller.seletDietOrWeek();
                  },
                ),
              ),
              //   32.widthBox,
              //  // RoundedButton(() {}, Icons.search),
              //   Expanded(
              //       flex: controller.context.width > 1150 ? 2 : 0,
              //       child: const SizedBox())
            ],
          ),
          12.heightBox,
          Row(
            children: [
              Expanded(
                child: CustomDropDown(
                  labeltext: 'Time',
                  id: controller.selectedTimeID.value,
                  list: controller.list_time
                      .map((element) => DropdownMenuItem<String>(
                          value: element.id, child: Text(element.name!)))
                      .toList(),
                  onTap: (v) {
                    controller.selectedTimeID.value = v!;
                    controller.seletDietOrWeek();
                  },
                ),
              ),
              8.widthBox,
              RoundedButton(() {}, Icons.search),
              // Expanded(
              //     flex: controller.context.width > 1150 ? 2 : 0,
              //     child: const SizedBox())
            ],
          ),
          8.heightBox,
        ],
      ),
    ));

_typeTablePart(MealPlanController controller) => Expanded(
      child: CustomGroupBox(
          groupHeaderText: "Diet List",
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Table(
                  border: CustomTableBorderNew,
                  columnWidths: customColumnWidthGenarator(_col1),
                  children: [
                    TableRow(
                        decoration: CustomTableHeaderRowDecorationnew,
                        children: [
                          CustomTableClumnHeader("ID", Alignment.center),
                          CustomTableClumnHeader(
                            "Name",
                            Alignment.centerLeft,
                          ),
                          CustomTableClumnHeader(
                            "Set",
                            Alignment.center,
                          ),
                        ])
                  ],
                ),
                Expanded(
                  child: ListView(
                    children: [
                      Table(
                        columnWidths: customColumnWidthGenarator(_col1),
                        border: CustomTableBorderNew,
                        children: controller.lis_diet_master
                            .map((element) => TableRow(
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      //  border: Border(left: BorderSide(color: appColorGrayDark,),right:  BorderSide(color: appColorGrayDark))
                                    ),
                                    children: [
                                      oneColumnCellBody(
                                          element.id!, 12, Alignment.center),
                                      oneColumnCellBody(element.name!, 12,
                                          Alignment.centerLeft),
                                      CustomTableEditCell(() {
                                        controller.selectedDietName.value =
                                            element.name!;
                                        controller.selectedDietID.value =
                                            element.id!;
                                      }, Icons.link),
                                    ]))
                            .toList(),
                      )
                    ],
                  ),
                )
              ],
            ),
          )),
    );

_mealItemType(MealPlanController controller, [int flex = 4]) => Expanded(
    flex: flex,
    child: CustomGroupBox(
        bgColor: appGray100,
        groupHeaderText: "",
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              _typeEntryPart(controller),
              8.heightBox,
              _typeTablePart(controller),
            ],
          ),
        )));

List<int> _col2 = [30, 80, 100, 30, 30];
List<int> _col1 = [30, 150, 30];


_mealItem(MealPlanController controller, [int flex = 5]) => Expanded(
    flex: flex,
    child: controller.selectedDietID.value == ''
        ? const SizedBox()
        : CustomGroupBox(
            bgColor: appGray100,
            groupHeaderText: "",
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                children: [
                  Column(
                    children: [
                      _categoryEntryPart(controller),
                      8.heightBox,
                      Expanded(
                        child: _categoryTablePart(controller),
                      )
                    ],
                  ),
                  Positioned(
                      top: 0,
                      right: 0,
                      child: RoundedButton(() {
                        controller.selectedDietID.value = '';
                      }, Icons.close, 14, Colors.black)),
                  Positioned(
                      right: 16,
                      bottom: 10,
                      child: CustomButton(Icons.save, 'Save', () {}))
                ],
              ),
            )));

List<int> _colh = [30, 30, 30, 90, 60];

_categoryTablePart(MealPlanController controller) => CustomGroupBox(
    groupHeaderText: "Item List",
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          Table(
            border: CustomTableBorderNew,
             columnWidths: customColumnWidthGenarator(_colh),
            children: [
              TableRow(
                  decoration: CustomTableHeaderRowDecorationnew,
                  children:  [
                    
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Center(child: Text("Rice",style: customTextStyle,)),),
                    TableCell( 
                      
                      verticalAlignment: TableCellVerticalAlignment.middle,
                       child: Center(child: Text("Roti/Bread",style: customTextStyle,)),),
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Center(child: Text("Dal",style: customTextStyle,)),),
                       
                        TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [Expanded(child: Container(
                                decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black, width: 0.5))),
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Center(child: Text("Non-Veg",style: customTextStyle,)),
                                )))],
                            ),
                            Row(
                            children: [
                              Expanded(child: Container(
                                decoration: const BoxDecoration(border: Border(right: BorderSide(color: Colors.black,width: 0.5))),
                                child: Center(child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text("Fish",style: customTextStyle,),
                              )))),
                              Expanded(child: Container(
                                decoration: const BoxDecoration(border: Border(right: BorderSide(color: Colors.black,width: 0.5))),
                                child: Center(child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text("Conti Fish",style: customTextStyle,),
                              )))),
                              Expanded(child: Center(child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text("Chicken",style: customTextStyle,),
                              )))
                            ],
                            )
                          ],
                        )),

                  TableCell(child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [Expanded(child: 
                              Container(
                                decoration: const BoxDecoration(border: Border(bottom: BorderSide(
        color: Colors.black,  
        width: 0.5,         
      ),)),
                                child: Center(child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text("Veg",style: customTextStyle,),
                                ))))],
                            ),
                            Row(
                            children: [
                              Expanded(child: Container(
                                decoration: const BoxDecoration(border:Border(right: BorderSide(
        color: Colors.black,  
        width: 0.5,         
      ),)),
                                child: Center(child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text("Veg-1",style: customTextStyle,),
                                )))),
                              Expanded(child: Center(child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text("Veg-2",style: customTextStyle,),
                              ))),
                             
                            ],
                            )
                          ],
                        )),


                  ])
            ],
          ),


Table(
  border: CustomTableBorderNew,
  columnWidths: customColumnWidthGenarator(_colh),
  children: [
  TableRow(
     decoration: const BoxDecoration(color: Colors.white),
    children: [
                TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Center(child: Text("Rice",style: customTextStyle,)),),

                       TableCell( 
                      
                      verticalAlignment: TableCellVerticalAlignment.middle,
                       child: Center(child: Text("Roti/Bread",style: customTextStyle,)),),

                         TableCell( 
                      
                      verticalAlignment: TableCellVerticalAlignment.middle,
                       child: Center(child: Text("Dal",style: customTextStyle,)),),

                  TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child:  Row(
                            children: [
                              Expanded(child: Container(
                                decoration: const BoxDecoration(border: Border(right: BorderSide(color: Colors.black,width: 0.5))),
                                child: Center(child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text("Fish",style: customTextStyle,),
                              )))),
                              Expanded(child: Container(
                                decoration: const BoxDecoration(border: Border(right: BorderSide(color: Colors.black,width: 0.5))),
                                child: Center(child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text("Conti Fish",style: customTextStyle,),
                              )))),
                              Expanded(child: Center(child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text("Chicken",style: customTextStyle,),
                              )))
                            ])),

TableCell(child:   Row(
                            children: [
                              Expanded(child: Container(
                                decoration: const BoxDecoration(border:Border(right: BorderSide(
        color: Colors.black,  
        width: 0.5,         
      ),)),
                                child: Center(child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text("Veg-1",style: customTextStyle,),
                                )))),
                              Expanded(child: Center(child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text("Veg-2",style: customTextStyle,),
                              ))),
                             
                            ],
                            )
                        
                        ),
                            


    ]
  )
  ],
),


  Expanded(
    child: ListView(
     // scrollDirection: Axis.horizontal,
      children: controller.list_chart.map((element)=>
      Row(
        children: [
          Text(element.id!),
          Text(element.name!),
          Row(children: element.menu.map((e)=>Row( children: [CustomDropDown(id: e.id, list: [], onTap: (v){}) ], ),).toList(),)
        ],
      )
      ).toList()
    ),
  )

          // Expanded(
          //   child: ListView(
          //     children: [
          //       Table(
          //         columnWidths: customColumnWidthGenarator(_col2),
          //         border: CustomTableBorderNew,
          //         children: [
          //           for (var i = 0; i < 100; i++)
          //             TableRow(
          //                 decoration: const BoxDecoration(color: Colors.white),
          //                 children: [
          //                   oneColumnCellBody("ID", 12, Alignment.center),
          //                   oneColumnCellBody("Type"),
          //                   oneColumnCellBody("Name"),
          //                   oneColumnCellBody("ID", 12, Alignment.center),
          //                   oneColumnCellBody("ID", 12, Alignment.center),
          //                 ]),
          //         ],
          //       )
          //     ],
          //   ),
          // )
        ],
      ),
    ));

_categoryEntryPart(MealPlanController controller) => CustomGroupBox(
    groupHeaderText: "Item Entry",
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              const CustomTextHeader(text: "ID        :"),
              6.widthBox,
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                color: appColorPista,
                child: CustomTextHeader(
                  text: controller.selectedDietID.value,
                  textColor: appColorGrayDark,
                ),
              ),
            ],
          ),
          6.heightBox,
          Row(
            children: [
              const CustomTextHeader(text: "Name :"),
              6.widthBox,
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                color: appColorPista,
                child: CustomTextHeader(
                  text: controller.selectedDietName.value,
                  textColor: appColorGrayDark,
                ),
              ),
            ],
          ),
          2.heightBox,
          const Divider(
            color: appColorGrayDark,
            thickness: 0.1,
          ),
        ],
      ),
    ));
