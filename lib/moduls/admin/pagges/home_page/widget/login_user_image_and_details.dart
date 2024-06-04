import 'dart:convert';
import 'dart:typed_data';

 
import 'package:agmc/core/config/const.dart';
 
import 'package:agmc/moduls/admin/pagges/login_page/login_page.dart';
import 'package:agmc/moduls/admin/pagges/login_page/notifires/aughtprovider.dart';
import 'package:agmc/core/shared/user_data.dart';
import 'package:flutter/material.dart';

 
 
class LoginUsersImageAndDetails extends StatelessWidget {
  const LoginUsersImageAndDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Uint8List bytes = base64Decode(DataStaticUser.img!);

    return Row(
      //mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
       
      children: [
        
        ClipRRect(
          borderRadius: BorderRadiusDirectional.circular(50),
          child: Image.memory(
            bytes,
            fit: BoxFit.contain,
            height: 38, width: 38, // Adjust the fit according to your needs
          ),
        ),
        
        const SizedBox(
          width: 4,
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
         crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints( maxHeight: 15),
              child: Text(
                DataStaticUser.name.trim(),
                style: customTextStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w600),
              ),
            ),
            
            ConstrainedBox(
              constraints: const BoxConstraints( maxHeight: 14),
              child: Text(
                DataStaticUser.dgname,
                style: customTextStyle.copyWith(fontSize: 11,
                  fontWeight: FontWeight.w400),
              ),
            ),
    
            // const SizedBox(width: 2,),
            6.heightBox,
            InkWell(
                onTap: () async{
                   await AuthProvider().logout();
                      Navigator.pushReplacement(
                     context,
                     MaterialPageRoute(builder: (context) => const LoginPage()),
                      );
                      Get.deleteAll();
                },
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: appColorBlue.withOpacity(0.3),
                    ),
                    child: Text(
                      'Log out',
                      style: TextStyle(
                          color: Color.fromARGB(255, 51, 1, 138),
                          fontSize: 10,
                          fontWeight: FontWeight.w800),
                    )))
          ],
        )
      ],
    );
  }
}
