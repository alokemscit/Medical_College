
import '../core/config/const.dart';

class CustomAccordianCaption extends StatefulWidget {
  CustomAccordianCaption({
    super.key,
    required this.text,
    this.backgroundColor = kWebHeaderColor,
    this.boxShadoColor = Colors.black38,
    this.textColor = Colors.black,
    void Function(bool)? onTap,
    this.isisExpansion = true,
  }) : onTap = onTap ?? ((bool b) {});
  final String text;
  final Color backgroundColor;
  final Color boxShadoColor;
  final Color textColor;
  final bool isisExpansion;
  final void Function(bool) onTap;

  @override
  State<CustomAccordianCaption> createState() =>
      __customAccordianCaptionState();
}

class __customAccordianCaptionState extends State<CustomAccordianCaption> {
  bool isOpen = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.backgroundColor.withOpacity(0.01),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
        //border: Border(left: BorderSide(width: 0.2)),
        //border: Border.all(color: Colors.black38, width: 0.1),
        boxShadow: [
          BoxShadow(
              color: widget.boxShadoColor.withOpacity(0.1),
              blurRadius: 1.05,
              spreadRadius: 0.1)
        ],
      ),
      width: double.infinity,
      child: widget.isisExpansion
          ? InkWell(
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
                          fontSize: 12,
                          fontStyle: FontStyle.italic,
                          //decoration: TextDecoration.underline,
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
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 6, bottom: 8, top: 2),
                  child: Text(
                    widget.text,
                    style: customTextStyle.copyWith(
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                        // decoration: TextDecoration.underline,
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
      this.isExpansion = true,  this.bgColor=kWebBackgroundColor});
  final String headerName;

  final List<Widget> children;
  final double height;
  final bool isExpansion;
  final Color bgColor;

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
          CustomAccordianCaption(
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
                  width: double.infinity,
                  decoration: CustomCaptionDecoration().copyWith(
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(4),
                        bottomRight: Radius.circular(4)),
                    color: widget.bgColor,
                  ),
                  height: b ? 0 : widget.height,
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: widget.children,
                      )))
              : b
                  ? const SizedBox()
                  : Expanded(
                      child: Container(
                          width: double.infinity,
                          decoration: CustomCaptionDecoration().copyWith(
                            borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(4),
                                bottomRight: Radius.circular(4)),
                            color: widget.bgColor,
                          ),
                          //height: height,
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: widget.children,
                              ))),
                    )
        ]);
  }
}
