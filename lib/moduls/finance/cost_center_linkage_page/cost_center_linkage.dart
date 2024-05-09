import 'package:agmc/core/config/const_widget.dart';
import 'package:agmc/moduls/finance/cost_center_linkage_page/controller/cost_center_linkage_controller.dart';
 
 import '../../../core/config/const.dart';
import '../ledger_master_page/model/model_ledger_master.dart';

class CostCeneterLinkagePage extends StatelessWidget {
  const CostCeneterLinkagePage({super.key});
  void disposeController() {
    try {
      Get.delete<CostCenterLinkageController>();
    } catch (e) {
      // print('Error disposing EmployeeController: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    CostCenterLinkageController controller =
        Get.put(CostCenterLinkageController());
    controller.context = context;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Obx(() => CustomCommonBody(
            controller.isLoading.value,
            controller.isError.value,
            controller.errorMessage.value,
            _mainWidget(controller),
            _mainWidget(controller),
            _mainWidget(controller))),
      ),
    );
  }
}


_mainWidget( CostCenterLinkageController controller) =>
    controller.context.width > 1250
        ? _responsiveDesktop(controller) 
        : _responsiveNonDesktop(controller);

Widget _slList( CostCenterLinkageController controller) =>
    CustomAccordionContainer(
      height: 0,
      headerName: 'CC Under \\ ${controller.selectedLedger.value.cODE!} '
          ' - '
          ' ${controller.selectedLedger.value.nAME!}',
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: CustomSearchBox(
                        caption: "Search",
                        maxlength: 50,
                        controller: controller.txt_search,
                         onChange: (v) {
                          controller.search();
                        }),
                  )),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    RoundedButton(() {
                      controller.selectedLedger.value = ModelLedgerMaster();
                    }, Icons.undo),
                   // 16.widthBox,
                    //RoundedButton(() {}, Icons.save)
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: controller.isSlLoading.value
                        ? const SizedBox()
                        : Column(
                            children: [
                              // for(var i=0;i<100;i++)
                              //Text('data'),
                              Table(
                                border: CustomTableBorder(),
                                columnWidths:
                                    CustomColumnWidthGenarator([80, 200, 40]),
                                children: [
                                  CustomTableRowWithWidget([
                                    Text(
                                      "Code",
                                      style: customTextStyle.copyWith(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "Cost Center Name",
                                      style: customTextStyle.copyWith(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Center(
                                        child: Text(
                                      "Add",
                                      style: customTextStyle.copyWith(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                    ))
                                  ]),
                                  for (var i = 0;
                                      i < controller.cc_list_temp.length;
                                      i++)
                                    TableRow(
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                        ),
                                        children: [
                                          CustomTableCell2(
                                              controller.cc_list_temp[i].cODE!),
                                          CustomTableCell2(
                                              controller.cc_list_temp[i].nAME!),
                                          TableCell(
                                              verticalAlignment:
                                                  TableCellVerticalAlignment
                                                      .middle,
                                              child: Center(
                                                child: InkWell(
                                                  onTap: () => controller.add(
                                                      controller
                                                          .cc_list_temp[i]),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            4.0),
                                                    child: Container(
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50),
                                                            color:
                                                                appColorLogo),
                                                        child: const Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  2.0),
                                                          child: Icon(
                                                            Icons.add,
                                                            color: Colors.white,
                                                            size: 14,
                                                          ),
                                                        )),
                                                  ),
                                                ),
                                              ))
                                        ])
                                ],
                              ),
                            ],
                          ),
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );

Widget _chartAccount(
        CostCenterLinkageController controller, ModelLedgerMaster e) =>
    Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: _node(
          0,
          Row(
            children: [
              Text(
                '${e.cODE!} - ${e.nAME!}',
                style: customTextStyle.copyWith(
                    fontSize: 24, fontWeight: FontWeight.bold),
              ),
               10.widthBox,
               Text('(Chart of Acc)',
               style: _style())
            ],
          ),
          const SizedBox(),
          controller.ledger_list
              .where((p0) => p0.pARENTID == e.iD)
              .map((e) => _groupPart(controller, e))
              .toList()),
    );

Widget _groupPart(CostCenterLinkageController controller, ModelLedgerMaster e) =>
    Padding(
      padding: const EdgeInsets.only(bottom: 0),
      child: _node(
          26,
          Row(
            children: [
              Text('${e.cODE!} - ${e.nAME!}',
                  style: customTextStyle.copyWith(
                    fontSize: 20, fontWeight: FontWeight.bold),
              ),
               10.widthBox,
               Text('(Group)',
               style: _style())
            ],
          ),
          const SizedBox(),
          controller.ledger_list
              .where((p0) => p0.pARENTID == e.iD)
              .map(
                (e) => _subGroupPart(controller, e),
              )
              .toList()),
    );

  _style([Color fontColor= Colors.black])=>customTextStyle.copyWith(fontSize: 10,
               fontWeight: FontWeight.normal,color: fontColor,fontStyle: FontStyle.italic);

Widget _subGroupPart(CostCenterLinkageController controller, ModelLedgerMaster e) =>
    Padding(
      padding: const EdgeInsets.only(bottom: 0,),
      child: _node(
          26,
          Row(
            children: [
              Text('${e.cODE!} - ${e.nAME!}',
                  style: customTextStyle.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: appFontMuli
                    //color: appColorLogo,
                  )),
                   10.widthBox,
               Text('(Sub Group)',
               style: _style())
            ],
          ),
            const SizedBox(),
          controller.ledger_list
              .where((p0) => p0.pARENTID == e.iD)
              .map(
                (e) => _ledgerCategoryPart(controller, e),
              )
              .toList()),
    );

Widget _ledgerCategoryPart(CostCenterLinkageController controller, ModelLedgerMaster e) =>
    Padding(
      padding: const EdgeInsets.only(bottom: 0),
      child: _node(
          26,
          Row(
            children: [
              Text('${e.cODE!} - ${e.nAME!}',
                  style: customTextStyle.copyWith(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    fontFamily: appFontMuli,
                   // color: kTextColor,
                  )),
                   10.widthBox,
               Text('(Ledger Category)',
               style: _style())
            ],
          ),
           const SizedBox(),
         
          controller.ledger_list
              .where((p0) => p0.pARENTID == e.iD)
              .map(
                (e) => _ledgerPart(controller,e),
              )
              .toList()),
    );


Widget _ledgerPart(
        CostCenterLinkageController controller, ModelLedgerMaster e) =>
    Padding(
      padding: const EdgeInsets.only(
        left: 22,
      ),
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.arrow_right),
                        4.widthBox,
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    '${e.cODE!} - ${e.nAME!}',
                                    overflow: TextOverflow.ellipsis,
                                    style: customTextStyle.copyWith(
                    fontSize: 14, fontWeight: FontWeight.bold),
              ),
               10.widthBox,
               Text('(Ledger)',
               style: _style(appColorBlue))
                                ],
                              ),
                               Expanded(
                                    child: Container(
                                      height: 1,
                                      color: appColorGray200,
                                    ),
                                  )
                            ],
                          ),
                        ),
                      ],
                    ),
                    ...controller.link_list_temp
                        .where((p0) => p0.gLID == e.iD)
                        .map((e11) => Padding(
                              padding: const EdgeInsets.only(left: 24),
                              child: Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      CustomCupertinoAlertWithYesNo(
                                          controller.context,
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Icon(
                                                Icons.warning,
                                                size: 18,
                                                color: appColorGrayDark,
                                              ),
                                              4.widthBox,
                                              const Text("Are You Sure?")
                                            ],
                                          ),
                                          const Text(
                                              "Are you sure to remove sub ledger?"),
                                          () {}, () {
                                        controller.deleteCC(e11);
                                      });
                                    },
                                    child: const Padding(
                                      padding: EdgeInsets.all(4.0),
                                      child: Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                        size: 15,
                                      ),
                                    ),
                                  ),
                                  6.widthBox,
                                  Row(
                                    children: [
                                      Text(e11.cCCode == null
                                          ? ''
                                          : e11.cCCode!,style: customTextStyle.copyWith(fontSize: 13,fontWeight: FontWeight.bold,fontFamily: appFontMuli,color: appColorLogoDeep)),
                                      const Text(' - ',style: TextStyle(color: appColorLogoDeep),),
                                      Text(
                                        e11.cCNAME!,
                                        overflow: TextOverflow.ellipsis,
                                        style: customTextStyle.copyWith(fontSize: 13,fontWeight: FontWeight.bold,fontFamily: appFontMuli,color: appColorLogoDeep)
                                      ),
                                    ],
                                  ),
                                  
                                ],
                              ),
                            ))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 8, top: 0, bottom: 8, right: 25),
                child:  PoppupMenu(
                    menuList: [
                      PopupMenuItem(
                        child: const ListTile(
                          title: Text("Add Cost Center"),
                          trailing: Icon(Icons.edit_rounded),
                        ),
                        onTap: () async {
                          // Future.delayed(Duration(seconds: 1));
                          controller.selectedLedger.value = e;
                          controller.loadCC(e);
                        },
                      ),
                    ],
                    child: const Icon(
                      Icons.construction_sharp,
                      size: 18,
                      color: appColorPrimary,
                    )),
              )
            ],
          ),
        ),
      ),
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [name, event],
            ),
          ),

          /// Ledger-------
          children: children,
        ));

_responsiveDesktop(CostCenterLinkageController controller) => Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 5,
          child: CustomAccordionContainer(
            // crossAxisAlignment: CrossAxisAlignment.start,
            headerName: 'Chart of Account (CC Linkage)',
            height: 0,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(children: controller.ledger_list
                    .where((p0) => p0.pARENTID == '0')
                    .map((e) => _chartAccount(controller, e))
                    .toList(),),
                ),
              )
                ]
          ),
        ),
        8.widthBox,
        Expanded(
          flex: 4,
          child: controller.selectedLedger.value.iD == null
              ? const SizedBox()
              : _slList(controller),
        )
      ],
    );

_responsiveNonDesktop(CostCenterLinkageController controller) =>
    CustomAccordionContainer(
      headerName: "Cost Center Linkage",
      height: 0,
      children: [
        Expanded(
          child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Column(
                children: controller.ledger_list
                    .where((p0) => p0.pARENTID == '0')
                    .map((e) => _chartAccount(controller, e))
                    .toList(),
              ),
              controller.selectedLedger.value.iD == null
                  ? const SizedBox()
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 500,
                        child: _slList(controller),
                      ),
                    )
            ]),
          ),
        ),
      ],
    );
