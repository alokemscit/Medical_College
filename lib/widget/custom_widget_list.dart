// ignore_for_file: public_member_api_docs, sort_constructors_first
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
      border: CustomTableBorderNew,
      columnWidths: CustomColumnWidthGenarator(colWidtList),
      children: [
        TableRow(
            decoration: CustomTableHeaderRowDecorationnew, children: children)
      ],
    );
  }
}


class CustomGroupBox extends StatelessWidget {
  CustomGroupBox(
      {super.key,
      this.groupHeaderText = '',
      required this.child,
      this.textColor = Colors.black,
      this.borderWidth = 1,
      this.bgColor = kWebBackgroundColor,
      this.borderRadius = 6,
      this.ShadowColor = appColorGray200,
      this.padingvertical = 8,
      this.height = 0,
      this.pading = const EdgeInsets.only(bottom: 4)});
  String groupHeaderText;
  Color textColor;
  Color ShadowColor;
  Widget child;
  double borderWidth;
  Color bgColor;
  double borderRadius;
  double padingvertical;
  double height;
  EdgeInsets pading;
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
                  height: height == 0 ? null : height,
                  padding: const EdgeInsets.only(left: 8, right: 8, top: 6),
                  decoration: customBoxDecoration.copyWith(
                    color: bgColor,
                    border: Border.all(
                      width: borderWidth,
                      color: appColorGrayDark.withOpacity(0.28),
                    ),
                    // color: kWebBackgroundColor,
                    boxShadow: [
                      const BoxShadow(
                          color: appColorGray200,
                          blurRadius: 6,
                          spreadRadius: 1)
                    ],
                    borderRadius:
                        BorderRadiusDirectional.circular(borderRadius),
                  ),
                  child: Padding(
                    padding: pading,
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
                    fontSize: 10.5,
                    fontFamily: appFontLato,
                    fontWeight: FontWeight.w500,
                    color: bgColor,
                    fontStyle: FontStyle.italic),
              ),
            )),
        Positioned(
            left: 6,
            top: 0.2,
            child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                //  color: bgColor,
                child: Text(
                  groupHeaderText,
                  style: customTextStyle.copyWith(
                      fontSize: 10.5,
                      fontWeight: FontWeight.w500,
                      fontFamily: appFontLato,
                      color: textColor,
                      fontStyle: FontStyle.italic),
                ))),
      ],
    );
  }
}

class CustomTextHeaderWithCaptinAndChild extends StatelessWidget {
  const CustomTextHeaderWithCaptinAndChild(
      {super.key,
      required this.caption,
      required this.child,
      this.textSize = 13,
      this.textColor = Colors.black,
      this.fontweight = FontWeight.w600,
      this.capWidth = 0,
      this.capTextFontSize = 13.5,
      this.capTextColor = Colors.black,
      this.capTextfontweight = FontWeight.bold,
      this.bgColor = appGrayWindowHover,
      this.minChildWidth = 0});

  final String caption;
  final Widget child;
  final double capWidth;
  final double capTextFontSize;
  final Color capTextColor;
  final Color bgColor;
  final FontWeight capTextfontweight;
  final double minChildWidth;
  final double textSize;
  final Color textColor;
  final FontWeight fontweight;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 28),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: bgColor,
            border: Border.all(color: Colors.black, width: 0.1)),
        child: Row(
          children: [
            Container(
              padding:
                  const EdgeInsets.only(left: 4, right: 2, top: 2, bottom: 2),
              child: capWidth == 0
                  ? Text(
                      caption,
                      style: customTextStyle.copyWith(
                          fontFamily: appFontLato,
                          fontWeight: capTextfontweight,
                          fontSize: capTextFontSize,
                          color: capTextColor),
                    )
                  : SizedBox(
                      width: capWidth,
                      child: Flexible(
                        child: Text(
                          caption,
                          style: customTextStyle.copyWith(
                              fontFamily: appFontLato,
                              fontWeight: capTextfontweight,
                              fontSize: capTextFontSize,
                              color: capTextColor),
                        ),
                      ),
                    ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  //borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: Colors.black, width: 0.1)),
              child: ConstrainedBox(
                  constraints:
                      BoxConstraints(minHeight: 28, minWidth: minChildWidth),
                  child: Align(alignment: Alignment.centerLeft, child: child)),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomTextHeaderWithCaptinAndValue extends StatelessWidget {
  const CustomTextHeaderWithCaptinAndValue(
      {super.key,
      required this.caption,
      required this.text,
      this.textSize = 13,
      this.textColor = Colors.black,
      this.fontweight = FontWeight.w600,
      this.capWidth = 0,
      this.capTextFontSize = 13.5,
      this.capTextColor = Colors.black,
      this.capTextfontweight = FontWeight.bold,
      this.isSelectable = false});

  final String caption;
  final String text;
  final double capWidth;
  final double capTextFontSize;
  final Color capTextColor;
  final FontWeight capTextfontweight;
  final bool isSelectable;

  final double textSize;
  final Color textColor;
  final FontWeight fontweight;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          //borderRadius: BorderRadius.circular(4),
          color: Colors.white,
          border: Border.all(color: appColorGrayDark, width: 0.2)),
      child: Row(
        children: [
          Container(
            color: appColorGrayDark.withOpacity(0.1),
            padding:
                const EdgeInsets.only(left: 4, right: 6, top: 2, bottom: 2),
            child: capWidth == 0
                ? Text(
                    caption,
                    style: customTextStyle.copyWith(
                        fontFamily: appFontLato,
                        fontWeight: capTextfontweight,
                        fontSize: capTextFontSize,
                        color: capTextColor),
                  )
                : SizedBox(
                    width: capWidth,
                    child: Flexible(
                      child: Text(
                        caption,
                        style: customTextStyle.copyWith(
                            fontFamily: appFontLato,
                            fontWeight: capTextfontweight,
                            fontSize: capTextFontSize,
                            color: capTextColor),
                      ),
                    ),
                  ),
          ),
          // 4.widthBox,
          // Text(":",
          //     style: customTextStyle.copyWith(
          //         fontWeight: capTextfontweight, fontSize: capTextFontSize, color: capTextColor),),
          //8.widthBox,
          Container(
            padding: const EdgeInsets.only(left: 4, right: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
            ),
            child: isSelectable
                ? SelectableText(
                    text,
                    style: customTextStyle.copyWith(
                        fontFamily: appFontLato,
                        fontWeight: fontweight,
                        fontSize: textSize,
                        color: textColor),
                  )
                : Text(
                    text,
                    style: customTextStyle.copyWith(
                        fontFamily: appFontLato,
                        fontWeight: fontweight,
                        fontSize: textSize,
                        color: textColor),
                  ),
          ),
        ],
      ),
    );
  }
}

class CustomTextHeader extends StatelessWidget {
  const CustomTextHeader(
      {super.key,
      required this.text,
      this.textSize = 13,
      this.textColor = Colors.black,
      this.fontweight = FontWeight.bold});
  final String text;
  final double textSize;
  final Color textColor;
  final FontWeight fontweight;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: customTextStyle.copyWith(
          fontFamily: appFontOpenSans,
          fontWeight: fontweight,
          fontSize: textSize,
          color: textColor),
    );
  }
}

Widget CommonBody3(dynamic controller, List<Widget> children,
        [String title = '',
        Color bgColor = kWebBackgroundColor,
        EdgeInsets padding =
            const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 1)]) =>
    CommonBody2(
        controller,
        CustomAccordionContainer(
          headerName: title,
          height: 0,
          bgColor: bgColor,
          isExpansion: false,
          pading: padding,
          children: children,
        ),
        padding);

Widget CommonMainWidgetTwo2(Widget left, Widget right, BuildContext context,
        [int colFlex1 = 4, int colFlex2 = 5]) =>
    context.screenWidth > 1150
        ? Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [left, 8.widthBox, Expanded(child: right)],
            ),
          )
        : Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                colFlex1 == 0
                    ? const SizedBox()
                    : Expanded(flex: colFlex1, child: left),
                colFlex1 == 0 ? const SizedBox() : 8.heightBox,
                colFlex2 == 0
                    ? const SizedBox()
                    : Expanded(flex: colFlex2, child: right)
              ],
            ),
          );

class CustomRoundedButton extends StatelessWidget {
  const CustomRoundedButton({
    super.key,
    required this.iconColor,
    required this.icon,
    required this.bgColor,
    required this.iconSize,
    required this.onTap,
  });

  final Color iconColor;
  final IconData icon;
  final Color bgColor;
  final double iconSize;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    bool isTapped = false;

    return InkWell(
      onTap: () {
        if (!isTapped) {
          isTapped = true;
          onTap();
          Future.delayed(const Duration(seconds: 2), () {
            isTapped = false;
          });
        }
      },
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Icon(
          icon,
          color: iconColor,
          size: iconSize,
        ),
      ),
    );
  }
}

class CustomCloseButtonRounded extends StatelessWidget {
  const CustomCloseButtonRounded({
    super.key,
    this.iconColor = Colors.white,
    this.icon = Icons.close,
    this.bgColor = appColorGrayDark,
    this.iconSize = 16,
    required this.onTap,
  });

  final Color iconColor;
  final IconData icon;
  final Color bgColor;
  final double iconSize;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return CustomRoundedButton(
      iconColor: iconColor,
      icon: icon,
      bgColor: bgColor,
      iconSize: iconSize,
      onTap: onTap,
    );
  }
}

class CustomFilterButtonRounded extends StatelessWidget {
  const CustomFilterButtonRounded({
    super.key,
    this.iconColor = appColorBlue,
    this.icon = Icons.filter_alt,
    this.bgColor = Colors.transparent,
    this.iconSize = 18,
    required this.onTap,
  });

  final Color iconColor;
  final IconData icon;
  final Color bgColor;
  final double iconSize;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return CustomRoundedButton(
      iconColor: iconColor,
      icon: icon,
      bgColor: bgColor,
      iconSize: iconSize,
      onTap: onTap,
    );
  }
}

class CustomUndoButtonRounded extends StatelessWidget {
  const CustomUndoButtonRounded({
    super.key,
    this.iconColor = appColorBlue,
    this.icon = Icons.undo,
    this.bgColor = appColorGray200,
    this.iconSize = 18,
    required this.onTap,
  });

  final Color iconColor;
  final IconData icon;
  final Color bgColor;
  final double iconSize;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return CustomRoundedButton(
      iconColor: iconColor,
      icon: icon,
      bgColor: bgColor,
      iconSize: iconSize,
      onTap: onTap,
    );
  }
}

class CustomTableGenerator extends StatelessWidget {
  const CustomTableGenerator({
    super.key,
    required this.colWidtList,
    required this.childrenHeader,
    required this.childrenTableRowList,
    this.isBodyScrollable = true,
  });
  final bool isBodyScrollable;
  final List<int> colWidtList;
  final List<Widget> childrenHeader;
  final List<TableRow> childrenTableRowList;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
      childrenHeader.isEmpty?const SizedBox():  CustomTableHeaderWeb(
            colWidtList: colWidtList, children: childrenHeader),
        isBodyScrollable
            ? Expanded(
                child: SingleChildScrollView(
                child: Table(
                  border: CustomTableBorderNew,
                  columnWidths: customColumnWidthGenarator(colWidtList),
                  children: childrenTableRowList,
                ),
              ))
            : Table(
                border: CustomTableBorderNew,
                columnWidths: customColumnWidthGenarator(colWidtList),
                children: childrenTableRowList,
              )
      ],
    );
  }
}

Widget CustomRadioButton(@required int val, @required dynamic controller,
        @required String caption,
        [Function()? fun]) =>
    Row(
      children: [
        SizedBox(
          width: 12,
          height: 12,
          child: Radio(
            value: val,
            groupValue: controller.selectedRadioValue.value,
            onChanged: (value) {
              controller.selectedRadioValue.value = value as int;
              if (fun != null) {
                fun();
              }
            },
            visualDensity:
                const VisualDensity(horizontal: -4.0, vertical: -4.0),
          ),
        ),
        6.widthBox,
        Text(
          caption,
          style: customTextStyle.copyWith(
              fontSize: controller.selectedRadioValue.value == val ? 13 : 12,
              fontWeight: controller.selectedRadioValue.value == val
                  ? FontWeight.bold
                  : FontWeight.w500,
              color: controller.selectedRadioValue.value == val
                  ? appColorBlue
                  : Colors.black),
        ),
      ],
    );

Widget CustomSaveUpdateButtonWithUndo(bool isUpdate,
        [void Function()? saveupdate,
        void Function()? undo,
        bool isAlwaysSave = false,
        String savebuttonName = 'Save']) =>
    Row(
      children: [
        CustomButton(isUpdate && !isAlwaysSave ? Icons.update : Icons.save,
            isUpdate && !isAlwaysSave ? "Update" : savebuttonName, () {
          if (saveupdate != null) {
            saveupdate();
          }
          // controller.saveUpdateUnit();
        }, Colors.black, appColorMint, kBgColorG),
        !isUpdate
            ? const SizedBox()
            : Row(
                children: [
                  6.widthBox,
                  CustomUndoButtonRounded(
                    onTap: () {
                      if (undo != null) {
                        undo();
                      }
                    },
                    bgColor: Colors.transparent,
                    iconSize: 22,
                    iconColor: appColorMint,
                  )
                ],
              ),
      ],
    );

// Widget CustomTabWithCheckBox(String text, bool isChcek, void Function() fun) =>
//     InkWell(
//       onTap: () {
//         fun();
//       },
//       child: Container(
//           padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//           decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(2),
//               color: isChcek ? appColorGrayDark : Colors.white,
//               boxShadow: [
//                 BoxShadow(
//                     color: appColorGrayDark.withOpacity(0.5),
//                     spreadRadius: 0.1,
//                     blurRadius: .1)
//               ]),
//           child: Row(
//             children: [
//               isChcek
//                   ? const Icon(
//                       Icons.check_box_outlined,
//                       color: Colors.white,
//                       size: 22,
//                     )
//                   : const Icon(
//                       Icons.check_box_outline_blank,
//                       color: appColorGrayDark,
//                       size: 22,
//                     ),
//               4.widthBox,
//               CustomTextHeader(
//                 text: text,
//                 textSize: isChcek ? 11.5 : 11,
//                 textColor: isChcek ? Colors.white : appColorMint,
//               ),
//             ],
//           )),
//     );

// ignore: must_be_immutable
class CustomTableCellx extends StatelessWidget {
  String text;
  double fontSize;
  Alignment alignment;
  FontWeight? fontWeight;
  EdgeInsets? padding;
  Color bgColor;
  bool isSelectable;
  Color fontColor;
  bool isTextTuncate;
  Function()? onTap;
  Function()? onHover;
  Function()? onExit;

  CustomTableCellx(
      {super.key,
      required this.text,
      this.fontSize = 12,
      this.alignment = Alignment.centerLeft,
      this.fontWeight = FontWeight.w400,
      this.padding = const EdgeInsets.all(4),
      this.bgColor = Colors.transparent,
      this.isSelectable = false,
      this.fontColor = Colors.black,
      this.onTap,
      this.onHover,
      this.onExit,
      this.isTextTuncate = false});
  @override
  Widget build(BuildContext context) {
    return TableCell(
      verticalAlignment: TableCellVerticalAlignment.middle,
      child: MouseRegion(
        onHover: (_) {
          // Handle the mouse hovering over the row
          if (onHover != null) {
            onHover!();
          }
        },
        onExit: (_) {
          // Handle the mouse exiting the row
          if (onExit != null) {
            onExit!();
          }
        },
        child: onTap == null
            ? _buildContent()
            : InkWell(
                onTap: () {
                  if (onTap != null) {
                    onTap!();
                  }
                },
                child: _buildContent(),
              ),
      ),
    );
  }

  _buildContent() => Row(children: [
        Expanded(
          child: Container(
              decoration: BoxDecoration(
                  color: bgColor,
                  border: const Border(
                      right: BorderSide(color: appColorGrayDark, width: 0.5))),
              padding: padding,
              child: Align(
                  alignment: alignment,
                  child: isSelectable
                      ? SelectableText(text,
                          style: customTextStyle.copyWith(
                              fontSize: fontSize,
                              fontWeight: fontWeight,
                              overflow:
                                  isTextTuncate ? TextOverflow.ellipsis : null,
                              color: fontColor))
                      : Tooltip(
                          message: isTextTuncate ? text : '',
                          child: Text(
                            text,
                            style: customTextStyle.copyWith(
                                fontSize: fontSize,
                                fontWeight: fontWeight,
                                color: fontColor,
                                overflow: isTextTuncate
                                    ? TextOverflow.ellipsis
                                    : null),
                          ),
                        ))),
        ),
      ]);
}

class mCustomSearchWithRightSideIconButton extends StatelessWidget {
  final TextEditingController controller;
  final bool isShorwRightButton;
  final IconData icon;
  final double iconSize;
  final Color iconColor;
  final double searchBoxWidth;
  final MainAxisAlignment Alignment;
  final String hintText;
  final Function(String)? onChange;
  final Function()? onButtonClick;

  const mCustomSearchWithRightSideIconButton(
      {super.key,
      required this.controller,
      this.isShorwRightButton = false,
      this.icon = Icons.print,
      this.iconSize = 18,
      this.iconColor = appColorLogoDeep,
      this.searchBoxWidth = 450,
      this.Alignment = MainAxisAlignment.end,
      this.hintText = 'Search...',
      this.onChange,
      this.onButtonClick});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Flexible(
            child: CustomSearchBox(
                width: searchBoxWidth,
                caption: hintText,
                controller: controller,
                onChange: (v) {
                  if (onChange != null) {
                    onChange!(v);
                  }
                })),
        !isShorwRightButton
            ? const SizedBox()
            : Row(
                children: [
                  8.widthBox,
                  InkWell(
                    onTap: () {
                      if (onButtonClick != null) {
                        onButtonClick!();
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Icon(
                        icon,
                        size: iconSize,
                        color: iconColor,
                      ),
                    ),
                  )
                ],
              )
      ],
    );
  }
}

class CustomTabWithCheckBox extends StatefulWidget {
  String text;
  bool isCheck;
  bool isCheckBox;
  void Function() fun;

  CustomTabWithCheckBox({
    required this.text,
    required this.isCheck,
    required this.fun,
    this.isCheckBox = false,
  });

  @override
  _CustomTabWithCheckBoxState createState() => _CustomTabWithCheckBoxState();
}

class _CustomTabWithCheckBoxState extends State<CustomTabWithCheckBox> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.fun();
      },
      child: MouseRegion(
        onEnter: (_) {
          setState(() {
            _isHovered = true;
          });
        },
        onExit: (_) {
          setState(() {
            _isHovered = false;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(8),
              bottomLeft: Radius.circular(8),
            ),
            color: widget.isCheck
                ? appColorMint
                : (_isHovered ? appGrayWindowHover : Colors.white),
            boxShadow: [
              BoxShadow(
                color: appColorGrayDark.withOpacity(0.5),
                spreadRadius: 0.5,
                blurRadius: 1,
              ),
            ],
          ),
          child: Row(
            children: [
              if (widget.isCheckBox)
                Row(
                  children: [
                    widget.isCheck
                        ? const Icon(
                            Icons.check_box_outlined,
                            color: Colors.white,
                            size: 22,
                          )
                        : const Icon(
                            Icons.check_box_outline_blank,
                            color: appColorGrayDark,
                            size: 22,
                          ),
                    const SizedBox(width: 4),
                  ],
                ),
              CustomTextHeader(
                text: widget.text,
                textSize: widget.isCheck ? 11.5 : 11,
                textColor: widget.isCheck
                    ? Colors.white
                    : (_isHovered ? Colors.black : appColorMint),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget CommonBodyWithToolBar(
    dynamic controller,
    List<Widget> children,
    // List<CustomTool>? childrenTool,
    Function(ToolMenuSet? type)? toolClick,
    [Color bgColor = kWebBackgroundColor,
    EdgeInsets padding =
        const EdgeInsets.only(left: 2, right: 2, top: 0, bottom: 1)]) {
  // Create a GlobalKey to access _CustomToolBarState
  // GlobalKey<_CustomToolBarState> toolBarKey = GlobalKey<_CustomToolBarState>();
  if (controller.list_tool.isEmpty) {
    controller.list_tool.addAll(Custom_Tool_List());
   // print('Called Here');
    }
  return Scaffold(
    backgroundColor: bgColor,
    body: CommonBody2(
      controller,
      Column(
        children: [
          // Pass the key to the CustomToolBarClass
          CustomTooBar(
            // toolbarKey: toolBarKey,
            // controller.list_tool.isEmpty?
            //controller.list_tool.addAll(Custom_Tool_List()),
            controller.list_tool,
            toolClick,
          ),
          ...children,
        ],
      ),
      padding,
    ),
  );
}

Widget CustomTooBar(
        [List<CustomTool>? list, Function(ToolMenuSet? type)? fun]) =>
    Row(
      children: [
        Expanded(
          child: Container(
            height: 30,
            decoration: const BoxDecoration(
                color: kWebBackgroundDeepColor,
                boxShadow: [
                  BoxShadow(
                      color: appColorGrayDark,
                      spreadRadius: 0.05,
                      blurRadius: .5)
                ]),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children:  list!.map((f) => f
                  ..onTap = () {
                    if (fun != null) {
                      fun(f.menu); // Use the passed key
                    }
                  }).toList(),
              
            ),
          ),
        )
      ],
    );

Widget _customHorizontalDivider(
        [double height = 10, Color color = appColorGrayDark]) =>
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      child: Container(
        height: height,
        width: 0.5,
        decoration: BoxDecoration(color: color),
      ),
    );

class CustomTool extends StatefulWidget {
  @override
  _HoverToolState createState() => _HoverToolState();
  final ToolMenuSet? menu;
  bool isHovered;
  bool isDisable;
  Function()? onTap;
  CustomTool(
      {super.key,
      this.menu,
      this.isHovered = true,
      this.isDisable = false,
      this.onTap});
}

class _HoverToolState extends State<CustomTool> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    // print(widget.isDisable.toString() + widget.menu.toString());
    return widget.menu == ToolMenuSet.divider
        ? _customHorizontalDivider()
        : widget.menu == ToolMenuSet.none
            ? const SizedBox()
            : MouseRegion(
                onEnter: (_) => setState(() {
                  if (widget.isHovered || !widget.isDisable) {
                    _isHovered = true;
                  }
                }),
                onExit: (_) => setState(() {
                  if (widget.isHovered || !widget.isDisable) {
                    _isHovered = false;
                  }
                }),
                cursor: !widget.isDisable
                    ? SystemMouseCursors.click
                    : SystemMouseCursors.basic,
                child: GestureDetector(
                  onTap: () {
                    if (widget.onTap != null && !widget.isDisable) {
                      widget.onTap!();
                    }
                    if (widget.menu == ToolMenuSet.close && !widget.isDisable) {
                      mCloseTab(context);
                    }
                  },
                  child: AnimatedContainer(
                    duration:
                        const Duration(milliseconds: 300), // Animation duration
                    decoration: BoxDecoration(
                        color: _isHovered && !widget.isDisable
                            ? appGrayWindowHover
                            : kWebBackgroundDeepColor,
                        borderRadius:
                            BorderRadius.circular(4) // Change color on hover
                        ),

                    padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 6), // Optional padding for better appearance
                    child: Row(
                      children: [
                        Icon(
                          _getIcon(widget.menu!),
                          size: 18,
                          color: !widget.isDisable
                              ? appBlackColor
                              : (_isHovered && !widget.isDisable)
                                  ? appBlackColor
                                  : widget.isDisable
                                      ? appDisableTextColor
                                      : appColorGrayDark,
                        ),
                        Text(
                          _getText(widget.menu!),
                          style: customTextStyle.copyWith(
                            fontFamily: appFontMuli,
                            fontSize: 11,
                            color: widget.isDisable
                                ? appDisableTextColor
                                : appBlackColor,
                            fontWeight: _isHovered && !widget.isDisable
                                ? FontWeight.bold
                                : FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
  }
}

enum ToolMenuSet {
  file,
  save,
  update,
  delete,
  edit,
  close,
  show,
  print,
  search,
  undo,
  divider,
  none,
  approve,
  cancel,
  post
}

IconData _getIcon(ToolMenuSet toolMenuSet) {
  switch (toolMenuSet) {
    case ToolMenuSet.save:
      return Icons.save;
    case ToolMenuSet.update:
      return Icons.update;
    case ToolMenuSet.delete:
      return Icons.delete;
    case ToolMenuSet.edit:
      return Icons.edit;
    case ToolMenuSet.close:
      return Icons.close;
    case ToolMenuSet.show:
      return Icons.visibility;
    case ToolMenuSet.print:
      return Icons.print;
    case ToolMenuSet.search:
      return Icons.search;
    case ToolMenuSet.file:
      return Icons.file_copy_sharp;
    case ToolMenuSet.undo:
      return Icons.undo;
    case ToolMenuSet.approve:
      return Icons.approval;
    case ToolMenuSet.post:
      return Icons.post_add;
    case ToolMenuSet.cancel:
      return Icons.cancel_rounded;

    default:
      return Icons.help_outline; // Default icon
  }
}

// Function to map enum to text
String _getText(ToolMenuSet toolMenuSet) {
  switch (toolMenuSet) {
    case ToolMenuSet.save:
      return 'Save';
    case ToolMenuSet.update:
      return 'Update';
    case ToolMenuSet.delete:
      return 'Delete';
    case ToolMenuSet.edit:
      return 'Edit';
    case ToolMenuSet.close:
      return 'Close';
    case ToolMenuSet.show:
      return 'Show';
    case ToolMenuSet.print:
      return 'Print';
    case ToolMenuSet.search:
      return 'Search';
    case ToolMenuSet.file:
      return 'New';
    case ToolMenuSet.undo:
      return 'Undo';
    case ToolMenuSet.approve:
      return 'Approve';
    case ToolMenuSet.post:
      return 'Post';
    case ToolMenuSet.cancel:
      return 'Cancel';

    default:
      return 'Unknown'; // Default text
  }
}

class CustomButtonIconText extends StatefulWidget {
  String text;
  IconData? icon;
  Function()? onTap;

  CustomButtonIconText(
      {Key? key, required this.text, this.icon = Icons.add, this.onTap})
      : super(key: key);

  @override
  _AddButtonState createState() => _AddButtonState();
}

class _AddButtonState extends State<CustomButtonIconText> {
  bool _isHovered = false;
  bool _isPressed = false;
  bool _b = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) {
          setState(() {
            _isPressed = false;
          });

          if (widget.onTap != null) {
            if (!_b) {
              widget.onTap!();
              _b = true;
            }
            Future.delayed(const Duration(milliseconds: 600), () {
              _b = false;
            });
          }
        },
        onTapCancel: () => setState(() => _isPressed = false),
        child: Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
              decoration: BoxDecoration(
                color: _isPressed
                    ? appColorGrayDark.withOpacity(0.4)
                    : (_isHovered
                        ? appGrayWindowHover
                        : appColorGrayDark.withOpacity(0.08)),
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: appColorGrayDark.withOpacity(0.08),
                    spreadRadius: _isHovered ? 1.0 : 0.2,
                    blurRadius: _isHovered ? 3 : .1,
                  ),
                ],
              ),
              child: Row(
                children: [
                  Icon(
                    widget.icon,
                    color: _isHovered ? appColorMint : appBlackColor,
                    size: 16,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    widget.text,
                    style: customTextStyle.copyWith(
                      color: _isHovered ? appColorMint : appBlackColor,
                      fontSize: 10.5,
                      fontWeight: FontWeight.w800,
                      fontFamily: appFontOpenSans,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomTextHeaderWithCaptinAndWidget extends StatelessWidget {
  CustomTextHeaderWithCaptinAndWidget({
    super.key,
    required this.caption,
    this.child = const SizedBox(),
    this.capWidth = 0,
    this.capTextFontSize = 12.5,
    this.capTextColor = Colors.black,
    this.capTextfontweight = FontWeight.bold,
  });

  String caption;
  Widget child;
  double capWidth;
  double capTextFontSize;
  Color capTextColor;
  FontWeight capTextfontweight;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.only(left: 4, right: 6, top: 2, bottom: 2),
          child: capWidth == 0
              ? Text(
                  caption,
                  style: customTextStyle.copyWith(
                      fontFamily: appFontLato,
                      fontWeight: capTextfontweight,
                      fontSize: capTextFontSize,
                      color: capTextColor),
                )
              : SizedBox(
                  width: capWidth,
                  child: Row(
                    children: [
                      Flexible(
                        child: Text(
                          caption,
                          style: customTextStyle.copyWith(
                              fontFamily: appFontLato,
                              fontWeight: capTextfontweight,
                              fontSize: capTextFontSize,
                              color: capTextColor),
                        ),
                      ),
                    ],
                  ),
                ),
        ),
        Text(
          ':',
          style: customTextStyle.copyWith(
              fontFamily: appFontLato,
              fontWeight: capTextfontweight,
              fontSize: capTextFontSize,
              color: capTextColor),
        ),
        2.widthBox,
        Expanded(
          child: Container(
              padding: const EdgeInsets.only(left: 4, right: 12),
              child: Row(
                children: [
                  child,
                ],
              )),
        ),
      ],
    );
  }
}



class ScrollableTabsWithArrows extends StatefulWidget {
  final List<CustomTabWithCheckBox> children;

  const ScrollableTabsWithArrows({super.key, required this.children});

  @override
  _ScrollableTabsWithArrowsState createState() =>
      _ScrollableTabsWithArrowsState();
}

class _ScrollableTabsWithArrowsState extends State<ScrollableTabsWithArrows> {
  final ScrollController _scrollController = ScrollController();
  bool _isOverflowing = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkOverflow();
    });
    _scrollController.addListener(() {
      setState(() {}); // Update arrows' visibility on scroll
    });
  }

  void _checkOverflow() {
    if (_scrollController.hasClients) {
      final double maxScrollExtent = _scrollController.position.maxScrollExtent;
      setState(() {
        _isOverflowing = maxScrollExtent > 0;
      });
    }
  }

  void _scrollLeft() {
    _scrollController.animateTo(
      _scrollController.offset - 100, // Adjust the scroll distance as needed
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  void _scrollRight() {
    _scrollController.animateTo(
      _scrollController.offset + 100, // Adjust the scroll distance as needed
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: SingleChildScrollView(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                child: Wrap(
                  children: widget.children,
                ),
              ),
            ),
            if (_isOverflowing && _scrollController.position.pixels > 0) // Show left arrow when scrolled
              Positioned(
                left: 0,
                top: 0,
                bottom: 0,
                child: InkWell(
                  onTap: _scrollLeft,
                  child: const Icon(Icons.arrow_left,color: appBlackColor,),
                  
                ),
              ),
            if (_isOverflowing && _scrollController.position.pixels < _scrollController.position.maxScrollExtent) // Show right arrow when not fully scrolled
              Positioned(
                right: 0,
                top: 0,
                bottom: 0,
                  child:  InkWell(
                  onTap:   _scrollRight,
                  child: const Icon(Icons.arrow_right,color: appBlackColor,)),
                 
                ),
             
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
