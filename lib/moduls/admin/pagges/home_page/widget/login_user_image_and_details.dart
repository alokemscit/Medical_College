import 'dart:convert';
import 'dart:typed_data';

import 'package:agmc/core/config/colors.dart';
import 'package:agmc/moduls/admin/pagges/home_page/controller/parent_page_controller.dart';
import 'package:agmc/moduls/admin/pagges/login_page/login_page.dart';
import 'package:agmc/moduls/admin/pagges/login_page/notifires/aughtprovider.dart';
import 'package:agmc/core/shared/user_data.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginUsersImageAndDetails extends StatelessWidget {
  const LoginUsersImageAndDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Uint8List bytes = base64Decode(DataStaticUser.img!);

    return Padding(
      padding: const EdgeInsets.only(right: 8, top: 4, bottom: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ClipRRect(
            borderRadius: BorderRadiusDirectional.circular(50),
            child: Image.memory(
              bytes,
              fit: BoxFit.contain,
              height: 38, width: 38, // Adjust the fit according to your needs
            ),
          ),
          // CustomCachedNetworkImage(
          //   height: 55,
          //   width: 55,
          //   img: DataStaticUser.img! ,
          // ),
          const SizedBox(
            width: 4,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 160, maxHeight: 13),
                child: Text(
                  DataStaticUser.name,
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(8)),
                constraints: const BoxConstraints(maxWidth: 160, maxHeight: 15),
                child: Padding(
                  padding: const EdgeInsets.only(top: 3),
                  child: Text(
                    DataStaticUser.dgname,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),

              // const SizedBox(width: 2,),
              InkWell(
                  onTap: () async{
                     await AuthProvider().logout();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
    Get.deleteAll();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: appColorBlue.withOpacity(0.3),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(2.0),
                          child: Text(
                            'Log out',
                            style: TextStyle(
                                color: Color.fromARGB(255, 51, 1, 138),
                                fontSize: 10,
                                fontWeight: FontWeight.w800),
                          ),
                        )),
                  ))
            ],
          )
        ],
      ),
    );
  }
}
