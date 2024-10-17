// ignore_for_file: camel_case_types

import 'package:asgar_ali_hospital/constant/const.dart';
 


class _customAccordianCaption extends StatefulWidget {
  _customAccordianCaption({
    required this.text,
    void Function(bool)? onTap,  this.isisExpansion=true,
  }) : onTap = onTap ?? ((bool b) {});
  final String text;
  final Color backgroundColor;
  final Color boxShadoColor;
  final Color textColor;
  final bool isisExpansion;
  final void Function(bool) onTap;

  @override
  State<_customAccordianCaption> createState() =>
      __customAccordianCaptionState();
}

class __customAccordianCaptionState extends State<_customAccordianCaption> {
  bool isOpen = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.backgroundColor.withOpacity(0.13),
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(8), topRight: Radius.circular(8)),
        //border: Border.all(color: Colors.black38, width: 0.1),
        boxShadow: [
          BoxShadow(
              color: widget.boxShadoColor.withOpacity(0.1),
              blurRadius: 1.05,
              spreadRadius: 0.1)
        ],
      ),
      width: double.infinity,
      child: widget.isisExpansion?
      
      
      InkWell(
        onTap: () {
          widget.onTap(!isOpen);
          // controller.isOpen.value = !controller.isOpen.value;
          setState(() {
            isOpen = !isOpen;
          });
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 6, bottom: 8, top: 2),
              child: Text(
                widget.text,
                style: customTextStyle.copyWith(
                    fontSize: 13,
                    fontStyle: FontStyle.italic,
                    decoration: TextDecoration.underline,
                    decorationColor: widget.textColor,
                    color: widget.textColor),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: InkWell(
                onTap: () {
                  widget.onTap(!isOpen);
                  // controller.isOpen.value = !controller.isOpen.value;
                  setState(() {
                    isOpen = !isOpen;
                  });
                },
                child: Icon(
                  isOpen
                      ? Icons.keyboard_arrow_down_sharp
                      : Icons.keyboard_arrow_up_sharp,
                  color: widget.textColor,
                  size: 24,
                ),
              ),
            )
          ],
        ),
      ):Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 6, bottom: 8, top: 2),
              child: Text(
                widget.text,
                style: customTextStyle.copyWith(
                    fontSize: 13,
                    fontStyle: FontStyle.italic,
                    decoration: TextDecoration.underline,
                    decorationColor: widget.textColor,
                    color: widget.textColor),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.only(right: 8),
            //   child: InkWell(
            //     onTap: () {
            //       widget.onTap(!isOpen);
            //       // controller.isOpen.value = !controller.isOpen.value;
            //       setState(() {
            //         isOpen = !isOpen;
            //       });
            //     },
            //     child: Icon(
            //       isOpen
            //           ? Icons.keyboard_arrow_down_sharp
            //           : Icons.keyboard_arrow_up_sharp,
            //       color: widget.textColor,
            //       size: 24,
            //     ),
            //   ),
            // )
          ],
        ),
    );
  }
}

class CustomAccordionContainer extends StatefulWidget {
  const CustomAccordionContainer(
      {super.key,
      required this.headerName,
      required this.children,
      this.height = 350,
      this.isExpansion = true});
  final String headerName;
  final List<Widget> children;
  final double height;
  final bool isExpansion;

  @override
  State<CustomAccordionContainer> createState() =>
      _CustomAccordionContainerState();
}

class _CustomAccordionContainerState extends State<CustomAccordionContainer> {
  bool b = false;

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _customAccordianCaption(
            isisExpansion: widget.isExpansion,
            text: widget.headerName,
            onTap: (a) {
              setState(() {
                b = a;
              });
            },
          ),
          widget.height > 0
              ? Container(
                  decoration: CustomCaptionDecoration().copyWith(
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(4),
                        bottomRight: Radius.circular(4)),
                    color: kBgLightColor,
                  ),
                  height: b ? 0 : widget.height,
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: widget.children,
                      )))
              : b
                  ? const SizedBox()
                  : Expanded(
                      child: Container(
                          decoration: CustomCaptionDecoration().copyWith(
                            borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(4),
                                bottomRight: Radius.circular(4)),
                            color: appColorLogo,
                          ),
                          //height: height,
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: widget.children,
                              ))),
                    )
        ]);
  }
}



// AccordionContainer(String headerName, List<Widget> children,
//         [double height = 350]) =>
//     Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//            _customAccordianCaption(text: headerName,),
        
//         height>0?  Container(
//               decoration: CustomCaptionDecoration().copyWith(
//                 borderRadius: const BorderRadius.only(
//                     bottomLeft: Radius.circular(4),
//                     bottomRight: Radius.circular(4)),
//                 color: kWebBackgroundDeepColor,
//               ),
//               height: height,
//               child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Column(
//                     children: children,
//                   ))):Expanded(
//             child: Container(
//                 decoration: CustomCaptionDecoration().copyWith(
//                   borderRadius: const BorderRadius.only(
//                       bottomLeft: Radius.circular(4),
//                       bottomRight: Radius.circular(4)),
//                     color: kWebBackgroundDeepColor,
//                 ),
//                 //height: height,
//                 child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Column(
//                       children: children,
//                     ))),
//           )


//         ]);
