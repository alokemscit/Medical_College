 
import 'package:agmc/core/config/const.dart';
import 'package:flutter/cupertino.dart';

 

class CustomPanel extends StatefulWidget {
  const CustomPanel({
    super.key,
    required this.children,
    required this.title,
    this.isExpanded = true,
    this.borderRadius = 4.0,
    this.splashColor = appColorPista,
    this.openIcon = Icons.folder_open_sharp,
    this.closeIcon = Icons.folder,
    this.isLeadingIcon = false,  this.iconColor=Colors.black87,  this.iconSize=18,  
    this.isSurfixIcon=true,  this.isSelectedColor=true,
  });

  final List<Widget> children;
  final Widget title;
  final bool isExpanded;
  final double borderRadius;
  final Color splashColor;
  final IconData openIcon;
  final IconData closeIcon;
  final bool isLeadingIcon;
  final bool isSurfixIcon;
  final bool isSelectedColor;
  final Color iconColor;
  final double iconSize;
  @override
  State<CustomPanel> createState() => _CustomPanelState();
}

class _CustomPanelState extends State<CustomPanel>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.isExpanded;
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _animation =
        CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn);
    if (_isExpanded) {
      _controller.value = 1.0;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
    if (_isExpanded) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          splashColor: widget.isSelectedColor? widget.splashColor:Colors.transparent,
          hoverColor: widget.isSelectedColor? widget.splashColor:Colors.transparent,
          onTap: _toggleExpand,
          child: Container(
            decoration: _isExpanded
                ? BoxDecoration(
                    borderRadius: BorderRadius.circular(widget.borderRadius),
                    color: widget.isSelectedColor? widget.splashColor:Colors.transparent,
                   
 
                    
                    boxShadow: const [
                        BoxShadow(
                            blurRadius: 3, spreadRadius: 1, color: Colors.white)
                      ])
                : null,
            // padding: const EdgeInsets.all(4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      widget.isLeadingIcon?Row(
                        children: [
                          Icon( _isExpanded? widget.openIcon:widget.closeIcon,size: widget.iconSize,color: widget.iconColor,),
                          6.widthBox,
                        ],
                      ):const SizedBox(),
                      widget.title,
                    ],
                  ),
                ),
                const SizedBox(
                  width: 4,
                ),
              widget.isSurfixIcon?   RotationTransition(
                  turns: _animation,
                  child:  Icon(!_isExpanded
                      ? Icons.arrow_drop_down
                      : Icons.arrow_drop_up),
                ):const SizedBox(),
              ],
            ),
          ),
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 200),
          curve: Curves.fastOutSlowIn,
          child: _isExpanded
              ? Column(children: widget.children)
              : SizedBox(height: 0),
        ),
      ],
    );
  }
}
