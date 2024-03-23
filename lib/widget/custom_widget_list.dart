// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:agmc/core/config/const.dart';
import 'package:agmc/moduls/admin/pagges/login_page/model/user_model.dart';
 
 
class PoppupMenu extends StatelessWidget {
  const PoppupMenu({super.key, required this.child, required this.menuList});
  final Widget? child;
  final List<PopupMenuItem> menuList;
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      
      itemBuilder: ((context) => menuList),
      child: child,
    );
  }
}


Widget headerAppLogo([String logo="logo_aamc.png",double width=180]) =>  Padding(
      padding: const EdgeInsets.only(left: 36, top: 30),
      child: Row(
        children: [
          Image(
            image: AssetImage(
              'assets/icons/$logo',
            ),
            fit: BoxFit.fill,
            height: 50,
            width: width,
          )
        ],
      ),
    );

RoundedButton(void Function() Function, IconData icon, [double iconSize = 18]) {
  bool b = true;
  return InkWell(
    onTap: () {
      if (b) {
        b = false;
        Function();
        Future.delayed(const Duration(seconds: 2), () {
          b = true;
        });
      }
    },
    child: Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
          color: kWebBackgroundDeepColor,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 1,
            ),
          ]),
      child: Icon(
        icon,
        size: iconSize,
        color: kWebHeaderColor,
      ),
    ),
  );
}

   
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
  