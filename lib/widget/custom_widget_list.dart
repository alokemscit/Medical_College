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

Widget headerAppLogo([String logo = "logo_aamc.png", double width = 180]) =>
    Padding(
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

RoundedButton(void Function() Function, IconData icon,
    [double iconSize = 18, Color iconColor = kWebHeaderColor]) {
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
        color: iconColor,
      ),
    ),
  );
}

Widget user_login_details(User_Model user, Function() onTap) => Column(
      children: [
        14.heightBox,
        ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: user.iMAGE == ''
              ? Image.asset(
                  "assets/icons/media-user.png",
                  fit: BoxFit.fill,
                  height: 38,
                  width: 38,
                )
              : Image.memory(
                  height: 38,
                  width: 38,
                  base64Decode(user.iMAGE!),
                  fit: BoxFit.contain, // Adjust the fit according to your needs
                ),
        ),
        Text(
          user.eMPNAME!,
          style: customTextStyle.copyWith(
              fontWeight: FontWeight.bold, fontSize: 12),
        ),
        Text(
          user.dSGNAME!,
          style: customTextStyle.copyWith(
              fontWeight: FontWeight.w400, fontSize: 10),
        ),
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  child: Text(
                    "Log Out",
                    style: customTextStyle.copyWith(
                        fontWeight: FontWeight.w800,
                        fontSize: 9,
                        color: appColorLogoDeep),
                  ),
                )),
          ),
        ),
      ],
    );

class CustomTwoPanelWindow extends StatelessWidget {
  final String leftPanelHeaderText;
  final String rightPanelHeaderText;
  final List<Widget> leftChildren;
  final List<Widget> rightChildren;
  final BuildContext context;
  final int leftFlex;
  final int rightFlex;
  final double leftPanelHeight;
  final double roghtPanelHeight;
  final double minDesktopWidth;
  final bool isLeftPanelExtention;
  final bool isRighttPanelExtention;
  final EdgeInsets pading;
  const CustomTwoPanelWindow({
    super.key,
    required this.leftPanelHeaderText,
    required this.rightPanelHeaderText,
    required this.leftChildren,
    required this.rightChildren,
    this.leftFlex = 5,
    this.rightFlex = 5,
    required this.context,
    this.leftPanelHeight = 0,
    this.roghtPanelHeight = 0,
    this.minDesktopWidth = 1000,
    this.isLeftPanelExtention = false,
    this.isRighttPanelExtention = false,
    this.pading = const EdgeInsets.all(0.0),
  });

  @override
  Widget build(BuildContext context) {
    return context.width > minDesktopWidth
        ? Row(
            children: [
              leftFlex == 0
                  ? const SizedBox()
                  : Expanded(
                      flex: leftFlex,
                      child: CustomAccordionContainer(
                          headerName: leftPanelHeaderText,
                          height: leftPanelHeight,
                          isExpansion: isLeftPanelExtention,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: pading,
                                child: Column(
                                  children: leftChildren,
                                ),
                              ),
                            )
                          ])),
              rightFlex == 0 ? const SizedBox() : 8.widthBox,
              rightFlex == 0
                  ? const SizedBox()
                  : Expanded(
                      flex: rightFlex,
                      child: CustomAccordionContainer(
                          headerName: rightPanelHeaderText,
                          height: roghtPanelHeight,
                          isExpansion: isRighttPanelExtention,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: pading,
                                child: Column(
                                  children: rightChildren,
                                ),
                              ),
                            )
                          ])),
            ],
          )
        : Column(
            children: [
              leftFlex == 0
                  ? const SizedBox()
                  : Expanded(
                      flex: leftFlex,
                      child: CustomAccordionContainer(
                          headerName: leftPanelHeaderText,
                          height: leftPanelHeight,
                          isExpansion: isLeftPanelExtention,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: pading,
                                child: Column(
                                  children: leftChildren,
                                ),
                              ),
                            )
                          ])),
              rightFlex == 0 ? const SizedBox() : 8.heightBox,
              rightFlex == 0
                  ? const SizedBox()
                  : Expanded(
                      flex: rightFlex,
                      child: CustomAccordionContainer(
                          headerName: rightPanelHeaderText,
                          height: roghtPanelHeight,
                          isExpansion: isRighttPanelExtention,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: pading,
                                child: Column(
                                  children: rightChildren,
                                ),
                              ),
                            )
                          ])),
            ],
          );
  }
}

class CustomFilterButton extends StatelessWidget {
  const CustomFilterButton(
      {super.key,
      this.icon = const Icon(
        Icons.filter_alt,
        size: 18,
        color: appColorBlue,
      ),
      required this.onTap,
      this.size = const Size(20, 28)});
  final Icon icon;
  final Function() onTap;
  final Size size;

  @override
  Widget build(BuildContext context) {
    bool b = false;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          if (!b) {
            b = true;
            onTap();
            Future.delayed(const Duration(seconds: 2), () {
              b = false;
            });
          }
        },
        child: SizedBox(
            height: size.height, width: size.width, child: Center(child: icon)),
      ),
    );
  }
}

class CustomTableHeaderWeb extends StatelessWidget {
  const CustomTableHeaderWeb(
      {super.key, required this.colWidtList, required this.children});
  final List<int> colWidtList;
  final List<Widget> children;
  @override
  Widget build(BuildContext context) {
    return Table(
      // border: CustomTableBorderNew ,
      columnWidths: CustomColumnWidthGenarator(colWidtList),
      children: [
        TableRow(
            decoration: CustomTableHeaderRowDecorationnew.copyWith(
                color: kBgColorG,
                borderRadius: const BorderRadiusDirectional.only(
                    topStart: Radius.circular(4), topEnd: Radius.circular(4))),
            children: children)
      ],
    );
  }
}

class CustomGroupBox extends StatelessWidget {
  const CustomGroupBox(
      {super.key,
      required this.groupHeaderText,
      required this.child,
      this.textColor = Colors.black,
      this.borderWidth = 0.6,
      this.bgColor = kWebBackgroundColor,
      this.borderRadius = 3});
  final String groupHeaderText;
  final Color textColor;
  final Widget child;
  final double borderWidth;
  final Color bgColor;
  final double borderRadius;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Container(
                  padding: const EdgeInsets.only(left: 8, right: 8, top: 12),
                  decoration: customBoxDecoration.copyWith(
                    color: bgColor,
                    border: Border.all(
                      width: borderWidth,
                      color: appColorGrayDark.withOpacity(0.28),
                    ),
                    // color: kWebBackgroundColor,
                    borderRadius:
                        BorderRadiusDirectional.circular(borderRadius),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: child,
                  ),
                ),
              ),
            ),
          ],
        ),
        Positioned(
            left: 6,
            top: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              //  padding: EdgeInsets.symmetric(horizontal: 6),
              // width: 100,
              height: borderWidth,
              color: bgColor,
              child: Text(
                groupHeaderText,
                style: customTextStyle.copyWith(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: bgColor,
                    fontStyle: FontStyle.italic),
              ),
            )),
        Positioned(
            left: 6,
            top: 0.5,
            child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                //  color: bgColor,
                child: Text(
                  groupHeaderText,
                  style: customTextStyle.copyWith(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: textColor,
                      fontStyle: FontStyle.italic),
                ))),
      ],
    );
  }
}

class CustomTextHeader extends StatelessWidget {
  const CustomTextHeader({
    super.key,
    required this.text,
    this.textSize = 13,
    this.textColor = Colors.black,
    this.fontweight=FontWeight.bold
  });
  final String text;
  final double textSize;
  final Color textColor;
  final FontWeight fontweight;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: customTextStyle.copyWith(
          fontWeight: fontweight, fontSize: textSize, color: textColor),
    );
  }
}
