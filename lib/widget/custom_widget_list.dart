// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:agmc/config/const.dart';
import 'package:agmc/moduls/admin/pagges/login_page/model/user_model.dart';
 
 

Widget headerAppLogo() => const Padding(
      padding: EdgeInsets.only(left: 36, top: 30),
      child: Row(
        children: [
          Image(
            image: AssetImage(
              'assets/icons/aamc_logo.png',
            ),
            fit: BoxFit.fill,
            height: 55,
            width: 300,
          )
        ],
      ),
    );



   
 Widget user_login_details(User_Model user,Function() onTap)=>Column(
      children: [
        14.heightBox,
        ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: user.iMAGE==''?Image.asset("assets/icons/media-user.png",
          fit: BoxFit.fill,
          height: 38,
            width: 38,
          ) : Image.memory(
            height: 38,
            width: 38,
           base64Decode(user.iMAGE!),
          fit: BoxFit.contain, // Adjust the fit according to your needs
         ),
        ),
        Text(user.eMPNAME!,style: customTextStyle.copyWith(fontWeight: FontWeight.bold,fontSize: 12),),
        Text(user.dSGNAME!,style: customTextStyle.copyWith(fontWeight: FontWeight.w400,fontSize: 10),),
        4.heightBox,
        InkWell(
          onTap: () => onTap(),
          borderRadius: BorderRadius.circular(4),
          splashColor: appColorLogo,
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadiusDirectional.circular(4),
                color: appColorLogo.withOpacity(0.1),
                
              ),
              child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 2),
              child: Text("Log Out",style: customTextStyle.copyWith(fontWeight: FontWeight.w800,fontSize: 9,color: appColorLogoDeep),),
            )),
          ),
        ),
      ],
    );
  