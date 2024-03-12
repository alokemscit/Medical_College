 
 

import 'package:agmc/config/colors.dart';
import 'package:flutter/material.dart';

class CustomPanel extends StatefulWidget {
  const CustomPanel({
    Key? key,
    required this.children,
    required this.title,
    this.isExpanded = true,
    this.borderRadius = 4.0,  this.splashColor=appColorPista,
  }) : super(key: key);

  final List<Widget> children;
  final Widget title;
  final bool isExpanded;
  final double borderRadius;
  final Color splashColor;
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
          splashColor:widget.splashColor,
          hoverColor:widget.splashColor,
          onTap: _toggleExpand,
          child: Container(
            decoration: _isExpanded? BoxDecoration(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              color: widget.splashColor,
              boxShadow: const [
                BoxShadow(
                  blurRadius: 3,
                  spreadRadius: 1,
                  color: Colors.white
                )
              ]
            ):null,
           // padding: const EdgeInsets.all(4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: widget.title,
                ),
                const SizedBox(
                  width: 4,
                ),
                RotationTransition(
                  turns: _animation,
                  child: Icon(
                      !_isExpanded ? Icons.arrow_drop_down : Icons.arrow_drop_up),
                ),
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
