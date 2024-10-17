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
  const CustomGroupBox(
      {super.key,
      required this.groupHeaderText,
      required this.child,
      this.textColor = Colors.black,
      this.borderWidth = 1,
      this.bgColor = kWebBackgroundColor,
      this.borderRadius = 6,
      this.ShadowColor = appColorGray200,
      this.padingvertical = 8});
  final String groupHeaderText;
  final Color textColor;
  final Color ShadowColor;
  final Widget child;
  final double borderWidth;
  final Color bgColor;
  final double borderRadius;
  final double padingvertical;
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
                    padding: EdgeInsets.symmetric(vertical: padingvertical),
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
  const CustomTextHeader(
      {super.key,
      required this.text,
      this.textSize = 13,
      this.textColor = Colors.black,
      this.fontweight = FontWeight.bold,
      this.width = 0});
  final String text;
  final double textSize;
  final Color textColor;
  final FontWeight fontweight;
  final double width;

  @override
  Widget build(BuildContext context) {
    return width == 0
        ? Text(
            text,
            style: customTextStyle.copyWith(
                fontWeight: fontweight, fontSize: textSize, color: textColor),
          )
        : SizedBox(
            width: width,
            child: Row(
              children: [
                Flexible(
                  child: Text(
                    text,
                    style: customTextStyle.copyWith(
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
        CustomTableHeaderWeb(
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

Widget CustomTabWithCheckBox(String text, bool isChcek, void Function() fun) =>
    InkWell(
      onTap: () {
        fun();
      },
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              color: isChcek ? appColorGrayDark : Colors.white,
              boxShadow: [
                BoxShadow(
                    color: appColorGrayDark.withOpacity(0.5),
                    spreadRadius: 0.1,
                    blurRadius: .1)
              ]),
          child: Row(
            children: [
              isChcek
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
              4.widthBox,
              CustomTextHeader(
                text: text,
                textSize: isChcek ? 11.5 : 11,
                textColor: isChcek ? Colors.white : appColorMint,
              ),
            ],
          )),
    );

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
