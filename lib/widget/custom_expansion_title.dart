 
 
import 'package:agmc/core/config/colors.dart';
import 'package:flutter/material.dart';

class CustomExpansionTitle extends StatelessWidget {
  const CustomExpansionTitle({
    super.key,
    required this.title,
    required this.children,
    this.isExpanded = false,
    this.istrailing=true,
  });

  final Widget title;
  final List<Widget> children;
  final bool isExpanded;
  final bool istrailing;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      collapsedBackgroundColor:Colors.transparent,
      backgroundColor: Colors.transparent,
      maintainState: true,
      initiallyExpanded: isExpanded,
      shape: Border.all(color: Colors.transparent),
      trailing: istrailing? const Icon(Icons.arrow_right_sharp, color: appColorPista):const SizedBox(),
      // leading: const Icon(Icons.arrow_right_sharp),
      tilePadding: EdgeInsets.zero,
      childrenPadding: EdgeInsets.zero,
      // collapsedShape:Border.all(color: kHeaderolor,width: 0.3),
      title: Container(
        
        padding: EdgeInsets.zero,
        margin: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: title,
        ),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  children: children,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
