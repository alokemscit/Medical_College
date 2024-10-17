 
import 'package:agmc/moduls/finance/fin_dashboard/chart.dart';
import 'package:intl/intl.dart';

import '../../../core/config/const.dart';
import 'controller/fin_dashboard_controller.dart';

class FinDashBoard extends StatelessWidget {
  const FinDashBoard({super.key});
  void disposeController() {
    try {
      Get.delete<FinDashBoardContrller>();
    } catch (e) {
      //
    }
  }

  @override
  Widget build(BuildContext context) {
    FinDashBoardContrller controller = Get.put(FinDashBoardContrller());
    controller.context = context;
    //print(context.height);
    return Scaffold(
      backgroundColor: Colors.white,
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

_mainWidget(FinDashBoardContrller controller) {
   String monthName = '${DateFormat('MMMM').format(DateTime.now())} ${DateTime.now().year}';
 // print(monthName);
  Widget pendingApp = Expanded(
      child: CardTile(
    monthName: 'Appril 2024',
    icon: Icons.schedule,
    iconBgColor: appColorLogoDeep,
    mainTitle: 'Voucher Approval Pending',
    totalText: '520',
    onTap: () {},
  ));

  Widget totalSale = Expanded(
      child: CardTile(
    monthName: monthName,
    icon: Icons.local_offer_rounded,
    iconBgColor: appColorLogoDeep,
    mainTitle: 'Sale Voucher',
    totalText: '520',
    onTap: () {},
  ));

  Widget totalPurchase = Expanded(
      child: CardTile(
    monthName: monthName,
    icon: Icons.shopping_cart,
    iconBgColor: appColorLogoDeep,
    mainTitle: 'Purchase Voucher',
    totalText: '520',
    onTap: () {},
  ));
  Widget totalPayment = Expanded(
      child: CardTile(
    monthName: monthName,
    icon: Icons.attach_money_outlined,
    iconBgColor: appColorLogoDeep,
    mainTitle: 'Payment Voucher',
    totalText: '520',
    onTap: () {
      //  print('object');
    },
  ));
  return SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Row(
        
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Finance Dashboards :: " ,style: customTextStyle.copyWith(fontSize: 11,),),
            //8.widthBox,
            Text(controller.companyName.value,style: customTextStyle.copyWith(fontSize: 10,fontStyle: FontStyle.italic,color: appColorLogoDeep),)
          ],
        ),
        8.heightBox,
          controller.context.width < 650
              ? Column(
                  children: [
                    Row(
                      children: [
                        pendingApp,
                      ],
                    ),
                    8.heightBox,
                    Row(
                      children: [
                        totalSale,
                      ],
                    ),
                    8.heightBox,
                    Row(
                      children: [
                        totalPurchase,
                      ],
                    ),
                    8.heightBox,
                    Row(
                      children: [
                        totalPayment,
                      ],
                    ),
                  ],
                )
              : controller.context.width >= 650 &&
                      controller.context.width <= 1200
                  ? Column(
                      children: [
                        Row(
                          children: [
                            pendingApp,
                            8.widthBox,
                            totalSale,
                          ],
                        ),
                        8.heightBox,
                        Row(
                          children: [
                            totalPurchase,
                            8.widthBox,
                            totalPayment,
                          ],
                        ),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        pendingApp,
                        22.widthBox,
                        totalSale,
                        22.widthBox,
                        totalPurchase,
                        22.widthBox,
                        totalPayment,
                        //18.widthBox,
                      ],
                    ),
                    const Row(
                      children: [
                        Expanded(
                          flex: 5,
                          child: SizedBox(
                            height: 400,
                            
                            child: LineChartSample1()),
                        ),
                        Expanded(
                          flex: 5,
                          child: SizedBox())
                      ],
                    )


        ],
      ),
    ),
  );
}

class CardTile extends StatelessWidget {
  final String monthName;
  final IconData icon;
  final Color iconBgColor;
  final String totalText;
  final String mainTitle;
  final Function onTap;
  const CardTile(
      {super.key,
      required this.monthName,
      required this.icon,
      required this.iconBgColor,
      required this.mainTitle,
      required this.totalText,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    //final _media = MediaQuery.of(context).size;
    return FittedBox(
      child: SizedBox(
        height: 110,
        width: 300,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            Material(
              // elevation: 1,
              color: Colors.white,
              shadowColor: Colors.grey,
              borderRadius: BorderRadius.circular(4),
              child: Container(
                decoration:  BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        const BorderRadiusDirectional.all(Radius.circular(4)),
                    boxShadow: [
                      // const BoxShadow(
                      //   color: appColorGray200,
                      //   blurRadius: 3,
                      //   spreadRadius: 2,
                      //   //offset: Offset(-5, 0)
                      // ),

                      BoxShadow(
                  color: Colors.blue.withOpacity(0.1), // Water shadow color with transparency
                  spreadRadius: 0.5,
                  blurRadius: 10,
                  offset: const Offset(0, 3), // Shadow position (x, y)
                ),
                    ]),
                height: 99,
                width: 300,
                padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Align(
                        alignment: Alignment.topRight,
                        child: FittedBox(
                          child: Text(
                            mainTitle,
                            style: customTextStyle.copyWith(
                                fontFamily: appFontMuli,
                                fontSize: 11,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w600,
                                color: appColorGrayDark),
                            //style: cardTileSubText,
                          ),
                        )),
                    // 2.heightBox,
                    Divider(
                      thickness: 0.5,
                      color: appColorGrayDark.withOpacity(0.5),
                    ),
                    4.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Month : ",
                          style: customTextStyle.copyWith(
                              fontSize: 12,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                          // style: cardTileTitleText,
                        ),
                        Expanded(
                          child: Container(
                            height: 0.5,
                            color: appColorGray200,
                          ),
                        ),
                        Text(
                          monthName,
                          style: customTextStyle.copyWith(
                              fontSize: 11.5,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total   : ",
                          style: customTextStyle.copyWith(
                              fontSize: 12,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        ),
                        Expanded(
                          child: Container(
                            height: 0.5,
                            color: appColorGray200,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            onTap();
                          },
                          child: Text(
                            totalText,
                            style: customTextStyle.copyWith(
                                fontSize: 11,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w600,
                                decoration: TextDecoration.underline,
                                color: Colors.black87),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration:  BoxDecoration(
                    color:  Colors.white, 
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(4),
                        topRight: Radius.circular(4)),
                    boxShadow: [
                      BoxShadow(
                           color: Colors.blue.withOpacity(0.1),  // Water shadow color with transparency
                  spreadRadius: 0.5,
                  blurRadius: 15,
                          offset: const Offset(-2, -3)),
                      const BoxShadow(
                          color: Colors.white,
                          blurRadius: 3,
                          spreadRadius: 1,
                          offset: Offset(2, 3)),
                    ]),
                child: Icon(
                  icon,
                  size: 24,
                  color: iconBgColor.withOpacity(0.8),
                ),
              ),
            ),

   Positioned(
    top: 11,
    left: 30,
    child: Container(
    
    height: 22,
    width: 10,
    color: Colors.white,
   ))

          ],
        ),
      ),
    );
  }
}
