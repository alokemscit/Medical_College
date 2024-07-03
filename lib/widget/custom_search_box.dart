// ignore_for_file: public_member_api_docs, sort_constructors_first

//import 'package:flutter/material.dart';
import 'package:agmc/core/config/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
 

class CustomSearchBox extends StatelessWidget {
  final String caption;
  final double width;
  final int maxlength;
  final TextEditingController controller;
  final TextInputType? textInputType;
  final int? maxLine;
  final double? height;
  final TextAlign? textAlign;
  final Function(String value) onChange;
  //final Function(RawKeyEvent event) onKey;
  final double borderRadious;
  final Color fontColor;
  final Color borderColor;
  final bool isPassword;
  final bool isFilled;
  final bool isReadonly;
  final bool isDisable;
  final Color hintTextColor;
  final Color labelTextColor;

  final Color focusedBorderColor;
  final double focusedBorderWidth;
  final Color enabledBorderColor;
  final double enabledBorderwidth;
  final Color surfixIconColor;
  final void Function(String) onSubmitted;
  final void Function() onEditingComplete;
  final FocusNode? focusNode;
  final bool isCapitalization;
  final void Function() onTap;

  CustomSearchBox(
      {super.key,
      required this.caption,
      this.width = 65,
      this.maxlength = 100,
      required this.controller,
      this.textInputType = TextInputType.text,
      this.maxLine = 1,
      this.height = 28,
      this.textAlign = TextAlign.start,
      required this.onChange,
      this.borderRadious = 2.0,
      this.fontColor = Colors.black87,
      this.borderColor = Colors.black,
      this.isPassword = false,
      this.isFilled = false,
      this.isReadonly = false,
      this.isDisable = false,
      this.hintTextColor = Colors.black,
      this.labelTextColor = Colors.black87,
      this.focusedBorderColor = Colors.black,
      this.focusedBorderWidth = 0.3,
      this.enabledBorderColor = Colors.grey,
      this.enabledBorderwidth = 0.4,
      this.surfixIconColor = appColorLogo,
      void Function(String)? onSubmitted,
      void Function()? onEditingComplete,
      void Function()? onTap,
      this.focusNode,
      this.isCapitalization = false})
      : onSubmitted = onSubmitted ?? ((String v) {}),
        onEditingComplete = onEditingComplete ?? (() {}),
        onTap = onTap ?? (() {});
   

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadious),
          color:   Colors.white,
          // boxShadow: [
          //   BoxShadow(blurRadius: 0, spreadRadius: 0.01, color: borderColor)
          // ]
          ),
      //  padding: const EdgeInsets.only(top: 4),
      // color: Colors.amber,
    
      // padding: const EdgeInsets.only(bottom: 12),
      // color:Colors.amber, // const Color.fromARGB(255, 255, 255, 255),
    
      child: TextField(
        
        onTap:()=> onTap,
        textCapitalization: isCapitalization == true
            ? TextCapitalization.characters
            : TextCapitalization.none,
        focusNode: focusNode,
        enabled: !isDisable,
        readOnly: isReadonly,
        onChanged: (value) => onChange(value),
        onSubmitted: (v) {
          onSubmitted(v);
        },
    
        onEditingComplete: () {
          // print("12121");
          onEditingComplete();
        },
        keyboardType: textInputType,
        // obscureText: !isObsText ? isPassword : false,
        inputFormatters: isCapitalization
            ? [UpperCaseTextFormatter()]
            : textInputType == TextInputType.multiline
                ? []
                : textInputType == TextInputType.emailAddress
                    ? []
                    : textInputType == TextInputType.text
                        ? []
                        : [
                            textInputType == TextInputType.number
                                ? FilteringTextInputFormatter.allow(
                                    RegExp(r'^\d+\.?\d*'))
                                : FilteringTextInputFormatter.digitsOnly
                          ],
        maxLength: maxlength,
        // canRequestFocus : false,
        maxLines: maxLine,
        //   textCapitalization : TextCapitalization.none,
        // keyboardType: TextInputType.number,
        style: TextStyle( fontFamily: "Muli",
          fontSize: 13, fontWeight: FontWeight.w500, color: fontColor),
        textAlignVertical: TextAlignVertical.center,
    
        textAlign: textAlign!,
        decoration: InputDecoration(
          fillColor: !isDisable
              ? Colors.white
              : Colors
                  .white70, // Color.fromARGB(255, 253, 253, 255), //Colors.white,
          filled: isFilled,
          labelText: caption,
          labelStyle: TextStyle(
              color: labelTextColor, fontWeight: FontWeight.w300, fontSize: 13),
          hintStyle:
              TextStyle(color: hintTextColor, fontWeight: FontWeight.w300),
          counterText: '',
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadious),
            borderSide: BorderSide(
                color: enabledBorderColor.withOpacity(0.8),
                width: enabledBorderwidth),
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(borderRadious)),
              borderSide: const BorderSide(color: Colors.white)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadious),
            borderSide: BorderSide(
                color: focusedBorderColor, width: focusedBorderWidth),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadious),
            borderSide: BorderSide(
                color: enabledBorderColor, width: enabledBorderwidth),
          ),
          prefixIcon: Icon(
            Icons.search_rounded,
            size: 20,
            color: surfixIconColor,
          ),
           contentPadding: const EdgeInsets.only(
                      bottom: 8,
                      left: 6,
                      right: 6) 
        ),
        controller: controller,
      ),
    );
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
