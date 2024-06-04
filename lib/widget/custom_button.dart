// ignore_for_file: non_constant_identifier_names

import 'package:agmc/core/config/const.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget CustomButton(@required IconData icon, @required String caption,
    @required Function onClick,
    [Color textColor = appColorGrayLight,
    Color iconColor = appColorGrayLight,
    Color buttonColor = appColorIndigoA100]) {
  bool isClick = false;
  return BlocProvider(
    create: (context) => _ClickBloc(),
    child: MouseRegion(
      cursor: SystemMouseCursors.click,
      child: BlocBuilder<_ClickBloc, _state>(
        builder: (context, state) {
          if (state is _clickState) {
            isClick = state.isClick;
          }
          return InkWell(
            borderRadius: BorderRadius.circular(8),
            mouseCursor: MouseCursor.defer,
            splashColor: buttonColor.withBlue(100),
            //hoverColor: buttonColor.withOpacity(2),
            onTap: () {
              //isClick = true;
              context.read<_ClickBloc>().add(_clickEvent(isClick: true));
              onClick();
              Future.delayed(const Duration(milliseconds:600), () {
               context.read<_ClickBloc>().add(_clickEvent(isClick: false));
              });
              //Get.to(() => const MainPage());
              // Get.delete<DefaultPageController>();
              // controller.gotoMainPage();
            },
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 600),
              opacity: isClick ? 0.3 : 1.0,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: buttonColor,
                    boxShadow: [
                      BoxShadow(
                          spreadRadius: 0,
                          blurRadius: 3,
                          color: Colors.black.withOpacity(0.25))
                    ]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    caption.text
                        .fontFamily(appFontMuli)
                        .color(textColor)
                        .sm
                        .fontWeight(FontWeight.w400)
                        .make(),
                    8.widthBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(0),
                          child: Icon(
                            icon,
                            size: 14,
                            color: iconColor,
                          ),
                        ),
                        //4.widthBox,
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    ),
  );
}

abstract class _state {}

class _clickState extends _state {
  final bool isClick;
  _clickState({required this.isClick});
}

abstract class _event {}

class _clickEvent extends _event {
  final bool isClick;
  _clickEvent({required this.isClick});
}

class _ClickBloc extends Bloc<_event, _state> {
  _ClickBloc() : super(_clickState(isClick: false)) {
    on<_event>((event, emit) {
      if (event is _clickEvent) {
        emit(_clickState(isClick: event.isClick));
        //  print(event.isHover.toString());
      }
    });
  }
}
