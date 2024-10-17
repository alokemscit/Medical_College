import 'package:asgar_ali_hospital/constant/const.dart';
import 'package:asgar_ali_hospital/custom_widget/custom_textbox.dart';
import 'package:asgar_ali_hospital/pages/online_payment/controller/online_payment_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';


class OnlinePaymentPage extends StatelessWidget {
  const OnlinePaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    OnlinePaymentController controller =Get.put(OnlinePaymentController());
    controller.context=context;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              40.heightBox,
              _backButton(context),
               18.heightBox,
               Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  
                  6.heightBox,
                  _descripton(),
                  6.heightBox,
                  _swithbox(controller),
                ],
               )
            ]))
    );
  }
}

Widget _swithbox(OnlinePaymentController controller)=>Column(
  children: [
Obx(() => 
Row(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "For Admitted Patient",
                  style: customTextStyle.copyWith(fontSize: 12,color:  controller.isIPD.value?appColorLogoDeep:Colors.black),
                ),
                SizedBox(
                  //  color: Colors.red,
                  height: 30, //set desired REAL HEIGHT
                  width: 55, //set desired REAL WIDTH
                  child: Transform.scale(
                    transformHitTests: false,
                    scale: .5,
                    child: CupertinoSwitch(
                      value: controller.isIPD.value,
                      onChanged: (value) {
                      //  controller.isHCN.value = value;
                        controller.isIPD.value=value;
                        controller.resetField();
                      },
                      activeColor: appColorLogo,
                    ),
                  ),
                ),



         Text(
                  "For OPD Patient",
                  style: customTextStyle.copyWith(fontSize: 12,color: !controller.isIPD.value?appColorLogoDeep:Colors.black),
                ),
                SizedBox(
                  //  color: Colors.red,
                  height: 30, //set desired REAL HEIGHT
                  width: 55, //set desired REAL WIDTH
                  child: Transform.scale(
                    transformHitTests: false,
                    scale: .5,
                    child: CupertinoSwitch(
                      value: !controller.isIPD.value,
                      onChanged: (value) {
                      //  controller.isHCN.value = value;
                         
                         controller.isIPD.value=!value;
                         controller.resetField();
                         
                      },
                      activeColor: appColorLogo,
                    ),
                  ),
                ),


              ],
            ),
   ),
   12.heightBox,
   Obx(() => _patientDetails(controller),),


 
  ],


);


Widget _patientDetails(OnlinePaymentController controller)=>Column(
  children: [
 Row(
   children: [
     Expanded(
      flex: 5,
      child: CustomTextBox(caption: "HCN", 
      maxlength: 11,
      isCapitalization: true,
      controller: controller.txt_hcn, onChange:(v){})),
      6.widthBox,
       Expanded(
        flex: 5,
        child: 
       controller.isIPDfound.value?  CustomTextBox(caption: "Admission No", maxLine: 11, controller: controller.txt_regno, onChange:(v){}):const SizedBox(),
        )
   ],
 ),
 
controller.isCorrectHCN.value?  Row(
    children: [
    Expanded(child: CustomTextBox(
      maxlength: 100,
      caption: "Name", controller: controller.txt_name, onChange:(v){})),
    ],
  ):const SizedBox(),
  
   controller.isIPDfound.value?  Row(
      children: [
        Expanded(child: CustomTextBox(caption: "Bed & Wsrd No",maxlength: 120, controller: controller.txt_ward, onChange:(v){})),
      ],
    ):const SizedBox(),
    controller.isCorrectHCN.value? Row(
       children: [
         Expanded(child: CustomTextBox(caption: "Address", maxlength: 120, controller: controller.txt_address, onChange:(v){})),
       ],
     ):const SizedBox(),
      Row(
        children: [
          Expanded(
            flex: 5,
            child: CustomTextBox(caption: "Mobile No", maxlength: 11, textInputType: TextInputType.phone, controller: controller.txt_mob, onChange:(v){})),
            6.widthBox,
            const Expanded(
              flex: 5,
              child: SizedBox())
        ],
      ),
  ],
);



Widget _descripton()=>Column(children: [
  Row(
    children: [
      Text("Terms & Condition",style: customTextStyle.copyWith(fontSize: 16,fontWeight: FontWeight.w600),),
    ],
  ),
                  const Row(
                    children: [
                      Expanded(
                        child: Divider(
                          height: 1,
                          color: appColorGrayDark,
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text("* Applicable for Registrade Patient in Asgar Ali Hospital",
                      style: customTextStyle.copyWith(fontSize: 9,fontWeight: FontWeight.w500),)
                    ],
                  ),
                   Row(
                    children: [
                      Text("*",
                      style: customTextStyle.copyWith(fontSize: 9,fontWeight: FontWeight.w500),),
                      Text(" No refund will be allow after completingthe payment",
                      style: customTextStyle.copyWith(fontSize: 9,fontWeight: FontWeight.w500),)
                    ],
                  ),
                  Row(
                    children: [
                      Text("*",
                      style: customTextStyle.copyWith(fontSize: 9,fontWeight: FontWeight.w500),),
                      Text(" Bank charge 2.25%",
                      style: customTextStyle.copyWith(fontSize: 9,fontWeight: FontWeight.w500),)
                    ],
                  ),
                  8.heightBox,
                  Row(
                    children: [
                      Checkbox(value: true, onChanged: (v){},
                      fillColor: WidgetStateProperty.resolveWith<Color?>(
    (Set<WidgetState> states) {
      // Define the color based on the checkbox state
      if (states.contains(WidgetState.selected)) {
        // Color when the checkbox is selected
        return appColorLogo; // Change this to the desired color
      }
      // Color when the checkbox is not selected
      return Colors.grey; // Change this to the desired color
    },
                      )
                      ),
                      4.widthBox,
                      Text("I Accept the Terms & Condition",
                      style: customTextStyle.copyWith(fontSize: 11,fontWeight: FontWeight.w500,color:appColorLogo),)
                    ],
                  ),
                   Row(
                    children: [
                      Expanded(
                        child: Divider(
                          height: 0.6,
                          color: appColorGrayDark.withOpacity(0.5),
                        ),
                      )
                    ],
                  ),
],);

Widget _backButton(BuildContext context) => Row(
      children: [
        InkWell(
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: () {
              Navigator.pop(context);
              Get.delete<OnlinePaymentController>();
            },
            child: Container(
              color: Colors.transparent,
              padding: const EdgeInsets.only(right: 50, top: 8, bottom: 4),
              // ignore: prefer_const_constructors
              child: Icon(Icons.arrow_back_sharp),
            )),
      ],
    );