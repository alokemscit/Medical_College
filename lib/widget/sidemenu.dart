// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:agmc/core/config/const.dart';
 
import 'package:agmc/core/config/responsive.dart';
 
import 'package:agmc/model/model_sub_menu.dart';

import 'package:agmc/moduls/admin/pagges/home_page/home_page.dart';
import 'package:agmc/moduls/admin/pagges/home_page/model/model_menu_list.dart';
import 'package:agmc/moduls/admin/pagges/login_page/login_page.dart';
 
import 'package:agmc/moduls/admin/pagges/login_page/notifires/aughtprovider.dart';
import 'package:agmc/core/shared/user_data.dart';
 

import 'package:flutter_bloc/flutter_bloc.dart';
 
 
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter/foundation.dart' show kIsWeb;

isExists(List<ItemModel> list, String id) {
  for (int i = 0; i < list.length; i++) {
    if (list[i].id == id) {
      return true;
    }
  }
  return false;
}

class SideMenu extends StatelessWidget {
  const SideMenu(
      {super.key,
      required this.module,
      required this.userDetailsForDrawer,
      required this.generateMenuItems,
      required this.fkey});
  final ModelModuleList module;
  final UserDetailsForDrawer userDetailsForDrawer;
  final GenerateMenuItems generateMenuItems;
  final GlobalKey<ScaffoldState> fkey;
  @override
  Widget build(BuildContext context) {
    //print('Calling 1');
    return Container(
      height: context.height,
      //padding: const EdgeInsets.only(top: kIsWeb ? 8 : 0),
      decoration: customBoxDecoration.copyWith(borderRadius: BorderRadiusDirectional.circular(0) ),
      
      


      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: kIsWeb ? 18 : 0, left: 6, right: 4),
               child: userDetailsForDrawer,
              ),
             // 4.heightBox,
            HomeLogOut(
              module: module,
              fkey: fkey,
            ),
            4.heightBox,
             Row(
               children: [
                 Expanded(child: Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 8),
                   child: Container(
                    color: appColorGrayDark.withOpacity(0.6),
                    height: 0.3,),
                 )),
               ],
             ),
          
            // const SizedBox(
            //   height: 6,
            // ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
              child: ModuleNameDisplay(module: module),
            ),
8.heightBox,
       Row(
               children: [
                 Expanded(child: Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 8),
                   child: Container(
                    color: appColorGrayDark.withOpacity(0.5),
                    height: 0.2,),
                 )),
               ],
             ),

            Expanded(
              child: SingleChildScrollView(
                child:  Padding(padding:  const EdgeInsets.symmetric(horizontal: 6, vertical: 4), 

                child:  generateMenuItems
                
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class GenerateMenuItems extends StatelessWidget {
  const GenerateMenuItems({super.key, required this.mid, required this.fkey});
  final String mid;
  final GlobalKey<ScaffoldState> fkey;
  @override
  Widget build(BuildContext context) {
    String? currentID;
    return  

    FutureBuilder(
        future:  get_sub_menu_data_list(mid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              List<Menu> list = snapshot.data!;
              return BlocBuilder<MenuItemBloc, ItemMenuState>(
                builder: (context, state) {
                  if (state is ItemMenuAdded) {
                    currentID = state.currentID;
                    // print("Menu id "+currentID!);
                  }
    
                  return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(list.length, (index) {
                        return ExpansionTile(
                            //   initiallyExpanded: true,
                            dense:false,
                            maintainState: true,
                            shape: const Border(),
                            leading: null, // Add your leading icon
                            trailing: null,
                            title: Container(
                                padding: const EdgeInsets.all(0),
                                // decoration: BoxDecoration(
                                //   borderRadius: BorderRadius.circular(8),
                                //   color:
                                //       const Color.fromARGB(255, 197, 197, 197)
                                //           .withOpacity(0.09),
                                // ),
                                child: Text(
                                  list[index].name!,
                                  style: GoogleFonts.titilliumWeb(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                )),
                            tilePadding: EdgeInsets.zero,
                                              
                            //  leading: const Icon(Icons.insert_emoticon),
                            // childrenPadding: EdgeInsets.only(left: 4),
                            children: list[index].smenu!.map((e) {
                              return BlocBuilder<CurrentIDBloc,
                                  CurrentIdState>(
                                builder: (context, state11) {
                                  if (state11 is CurrentIDSet) {
                                    currentID = state11.currentId;
                                  }
                                  return Container(
                                    
                                    color:Colors.white,
                                       // kBgColorG, //kWebBackgroundColor.withOpacity(0.8),
                                    child: ListTile(
                                      dense: false,
                                      contentPadding: EdgeInsets.zero,
                                      horizontalTitleGap: 0,
                                      trailing: const SizedBox(),
                                      
                                              
                                      title: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8, top: 0, bottom: 0),
                                        child: Stack(
                                          children: [
                                            AnimatedPositioned(
                                              duration: const Duration(
                                                  microseconds: 300),
                                              left: currentID ==
                                                      e.smId.toString()
                                                  ? 0
                                                  : 300,
                                              curve: Curves.bounceInOut,
                                              top: 0,
                                              child: Container(
                                                height: 100,
                                                width: 255,
                                                decoration: BoxDecoration(
                                                    color: currentID ==
                                                            e.smId.toString()
                                                        ? kBgDarkColor
                                                        : Colors.transparent,
                                                    boxShadow: [
                                                      BoxShadow(
                                                          blurRadius: 0.5,
                                                          spreadRadius: 10,
                                                          color:
                                                              kWebHeaderColor
                                                                  .withOpacity(
                                                                      0.05))
                                                    ]),
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Icon(Icons.arrow_right),
                                                const SizedBox(
                                                  width: 6,
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    e.smName!,
                                                    style: GoogleFonts.roboto(
                                                        fontSize: 12,
                                                        fontWeight: currentID !=
                                                                e.smId
                                                                    .toString()
                                                            ? FontWeight.w600
                                                            : FontWeight
                                                                .bold),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      onTap: () {
                                        fkey.currentState?.closeDrawer();
                                        final itemList = state.menuitem;
                                        if (!isExists(
                                            itemList, e.smId.toString())) {
                                          // ignore: non_constant_identifier_names
                                          if (Responsive.isMobile(context)) {
                                            itemList.clear();
                                          }
                                          // ignore: non_constant_identifier_names
                                          final Item = ItemModel(
                                              id: e.smId.toString(),
                                              name: e.smName.toString());
                                          context.read<MenuItemBloc>().add(
                                              ItemMenuAdd(menuitem: Item));
                                        }
                                        context
                                            .read<CurrentIDBloc>()
                                            .add(SetCurrentId(
                                              id: e.smId.toString(),
                                            ));
                                      },
                                    ),
                                  );
                                },
                              );
                            }).toList());
                      }));
                },
              );
            } else {
              return const SizedBox();
            }
          } else {
            return const CircularProgressIndicator(); // Display a loading indicator while fetching the image
          }
        });
  }
}

class CustomExpansionTile extends StatefulWidget {
  final Color backgroundColor;
  final Widget title;
  final List<Widget> children;

  const CustomExpansionTile({
    super.key,
    required this.backgroundColor,
    required this.title,
    this.children = const <Widget>[],
  });

  @override
  // ignore: library_private_types_in_public_api
  _CustomExpansionTileState createState() => _CustomExpansionTileState();
}

class _CustomExpansionTileState extends State<CustomExpansionTile> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.backgroundColor,
      child: ExpansionTile(
        maintainState: true,
        shape: const Border(),
        onExpansionChanged: (bool isExpanded) {
          setState(() {
            _isExpanded = isExpanded;
          });
        },
        title: widget.title,
        tilePadding: EdgeInsets.zero,
        leading: Container(
          color: widget.backgroundColor,
          child: Icon(
            _isExpanded ? Icons.expand_less : Icons.expand_more,
            color: Colors.white,
          ),
        ),
        trailing: Container(
          color: widget.backgroundColor,
          child: Icon(
            _isExpanded ? Icons.expand_less : Icons.expand_more,
            color: Colors.white,
          ),
        ),
        children: widget.children,
      ),
    );
  }
}

class ModuleNameDisplay extends StatelessWidget {
  const ModuleNameDisplay({
    super.key,
    required this.module,
  });

  final ModelModuleList module;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Column(
        //   children: [
        //     Padding(
        //       padding: const EdgeInsets.all(2.0),
        //       child: Container(
        //         height: 0.5,
        //         color: Colors.black12.withOpacity(0.1),
        //       ),
        //     )
        //   ],
        // ),
        8.heightBox,
        Text(
          module.name!,
          style: customTextStyle.copyWith( color:  appColorGrayDark,fontSize: 12.5,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic)
          // GoogleFonts.bungeeInline(
          //     fontSize: 10.5,
          //     fontWeight: FontWeight.w100,
          //     //fontStyle: FontStyle.italic,
          //     color: appColorLogoDeep),
        ),
        // const SizedBox(
        //   height: 15,
        // ),
        // Column(
        //   children: [
        //     Padding(
        //       padding: const EdgeInsets.all(8.0),
        //       child: Container(
        //         height: 1,
        //         color: Colors.black12.withOpacity(0.1),
        //       ),
        //     )
        //   ],
        // ),
      ],
    );
  }
}

class UserDetailsForDrawer extends StatelessWidget {
  const UserDetailsForDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 14,bottom: 8),
     // decoration:customBoxDecoration.copyWith(borderRadius: BorderRadiusDirectional.circular(0)),
      //  BoxDecoration(
      //     color: kWebBackgroundDeepColor,
      //     borderRadius: BorderRadiusDirectional.circular(2),
      //     boxShadow: const [
      //       BoxShadow(
      //           color: kWebBackgroundColor,
      //           spreadRadius: 5.5,
      //           blurRadius: 5.2,
      //           offset: Offset(0, 0))
      //     ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: DataStaticUser.img == ''
                    ? Image.asset(
                        "assets/icons/media-user.png",
                        fit: BoxFit.fill,
                        height: 30,
                        width: 30,
                      )
                    : Image.memory(
                        height: 30,
                        width: 30,
                        base64Decode(DataStaticUser.img!),
                        fit: BoxFit
                            .contain, // Adjust the fit according to your needs
                      ),
              ),
              const SizedBox(
                width: 4,
              ),
              const HomeLoginUserDetails(),
            ],
          ),
          8.heightBox,
          // Column(
          //   children: [
          //     Padding(
          //       padding: const EdgeInsets.symmetric(horizontal: 6),
          //       child: Container(
          //         height: 1,
          //         color: Colors.black12.withOpacity(0.1),
          //       ),
          //     )
          //   ],
          // ),
        ],
      ),
    );
  }
}

class HomeLoginUserDetails extends StatelessWidget {
  const HomeLoginUserDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 140, maxHeight: 30),
          child: Text(
            DataStaticUser.name,
            style: GoogleFonts.headlandOne(
                fontSize: 12, fontWeight: FontWeight.w600),
          ),
        ),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 140, maxHeight: 14),
          child: Text(
            DataStaticUser.dgname,
            style: const TextStyle(fontSize: 10.5, fontWeight: FontWeight.w400),
          ),
        ),
        //SizedBox(height: 2,)
      ],
    );
  }
}

class HomeLogOut extends StatelessWidget {
  const HomeLogOut({
    super.key,
    required this.module,
    required this.fkey,
  });

  final ModelModuleList module;
  final GlobalKey<ScaffoldState> fkey;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 4),
      padding: const EdgeInsets.only(left: 6, right: 12, top: 4, bottom: 4),
      // decoration:
      //     const BoxDecoration(color: kWebBackgroundDeepColor, boxShadow: [
      //   BoxShadow(
      //     color: kWebBackgroundColor,
      //     blurRadius: 10.5,
      //     spreadRadius: 1.5,
      //     offset: Offset(0, 0),
      //   )
      // ]),
      // width: 200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
              onTap: () async {
                await AuthProvider().logout();
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    ));
                Get.deleteAll();
              },
              child:  Text(
                'Log out',
                style: customTextStyle.copyWith(fontSize: 11,
                    fontStyle: FontStyle.italic,
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold)
              )),
          InkWell(
            //style: ButtonStyle(textStyle: TextStyle()) ),
            onTap: () {
              // context.read<LoginBloc>().add(LogOutEvent());
              // if (Responsive.isMobile(context)) {
              fkey.currentState?.closeDrawer();
              // }
              Navigator.pop(context);
              Get.reset();
              Get.deleteAll();
            },
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                  color: kWebBackgroundDeepColor.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: const [
                    BoxShadow(
                        spreadRadius: 0.5,
                        blurRadius: 50.1,
                        color: kWebBackgroundDeepColor)
                  ]),
              child: Text('< Back To Main',
                  style: customTextStyle.copyWith(
                      color:appColorPrimary, fontSize: 9,fontWeight: FontWeight.w600)),
            ),
          ),
        ],
      ),
    );
  }
}

