import 'package:agmc/core/config/const.dart';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomTextBox extends StatelessWidget {
  final String caption;
  final double width;
  final int maxlength;
  final TextEditingController controller;
  final TextInputType? textInputType;
  final int? maxLine;
  final double? height;
  final TextAlign? textAlign;

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
  final void Function(String v) onChange;
  final void Function(String) onSubmitted;
  final void Function() onEditingComplete;
  final FocusNode? focusNode;
  final bool isCapitalization;
  final bool iSAutoCorrected;
  final Color disableBackColor;
  final Color fillColor;
  final String hintText;
  final FontWeight fontWeight;

  CustomTextBox(
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
      this.fontColor = Colors.black,
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
      this.disableBackColor = appColorGrayLight,
      this.surfixIconColor = appColorLogo,
      void Function(String)? onSubmitted,
      void Function()? onEditingComplete,
      this.focusNode,
      this.fontWeight=FontWeight.w500,
      this.hintText = '',
      this.fillColor = Colors.white,
      this.isCapitalization = false,
      this.iSAutoCorrected = false})
      : onSubmitted = onSubmitted ?? ((String v) {}),
        onEditingComplete = onEditingComplete ?? (() {});

  @override
  Widget build(BuildContext context) {
    bool isObsText = false;
    return BlocProvider(
      create: (context) => PasswordShowBloc(),
      child: Container(
        //padding: EdgeInsets.zero,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadious),
          color: isDisable ? disableBackColor : Colors.white,
          // boxShadow: [
          //   BoxShadow(blurRadius: 0, spreadRadius: 0.01, color: borderColor)
          // ]
        ),
        //  padding: const EdgeInsets.only(top: 4),
        // color: Colors.amber,
        width: width,
        height: height,

        // padding: const EdgeInsets.only(bottom: 12),
        // color:Colors.amber, // const Color.fromARGB(255, 255, 255, 255),
        child: BlocBuilder<PasswordShowBloc, PasswordIconState>(
          builder: (context, state) {
            if (state is PasswordIconShowState) {
              isObsText = state.isShow;
            }
            return TextField(
              textDirection: textAlign == TextAlign.right
                  ? TextDirection.rtl
                  : TextDirection.ltr,
              autocorrect: iSAutoCorrected,
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
              obscureText: !isObsText ? isPassword : false,
              inputFormatters: isCapitalization
                  ? [upperCaseTextFormatter()]
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
              style: TextStyle(
                  fontFamily: "Muli",
                  fontSize: 13,
                  fontWeight: fontWeight,
                  color: fontColor),
              textAlignVertical: TextAlignVertical.center,

              textAlign: textAlign!,
              decoration: InputDecoration(
                  fillColor: !isDisable
                      ? fillColor
                      : Colors
                          .white70, // Color.fromARGB(255, 253, 253, 255), //Colors.white,
                  filled: isFilled,
                  labelText: caption,
                  labelStyle: TextStyle(
                      color: labelTextColor,
                      fontWeight: FontWeight.w300,
                      fontSize: 13),
                  hintText: hintText,
                  hintStyle: TextStyle(
                      color: hintTextColor.withOpacity(0.3),
                      fontWeight: FontWeight.w300),
                  counterText: '',
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(borderRadious),
                    borderSide: BorderSide(
                        color: enabledBorderColor.withOpacity(0.8),
                        width: enabledBorderwidth),
                  ),
                  border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.all(Radius.circular(borderRadious)),
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
                  suffixIcon: isPassword
                      ? InkWell(
                          onTap: () {
                            context
                                .read<PasswordShowBloc>()
                                .add(PasswordShowSetEvent(isShow: !isObsText));
                          },
                          child: Icon(
                            !isObsText
                                ? Icons.visibility_off
                                : Icons.visibility,
                            size: 20,
                            color: surfixIconColor,
                          ),
                        )
                      : null,
                  contentPadding: const EdgeInsets.only(
                      bottom: 8,
                      left: 6,
                      right: 6) //.symmetric(vertical: 8, horizontal: 6),
                  ),
              controller: controller,
            );
          },
        ),
      ),
    );
  }
}

class upperCaseTextFormatter extends TextInputFormatter {
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

abstract class PasswordIconState {}

class PasswordIconInitState extends PasswordIconState {
  final bool isShow;
  PasswordIconInitState({required this.isShow});
}

class PasswordIconShowState extends PasswordIconState {
  final bool isShow;
  PasswordIconShowState({required this.isShow});
}

abstract class PasswordShowEvent {}

class PasswordShowSetEvent extends PasswordShowEvent {
  final bool isShow;
  PasswordShowSetEvent({required this.isShow});
}

class PasswordShowBloc extends Bloc<PasswordShowEvent, PasswordIconState> {
  PasswordShowBloc() : super(PasswordIconInitState(isShow: false)) {
    on<PasswordShowSetEvent>((event, emit) {
      emit(PasswordIconShowState(isShow: event.isShow));
    });
  }
}
