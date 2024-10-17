// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:agmc/core/config/const.dart';
 
import 'package:flutter_bloc/flutter_bloc.dart';

 

class MenuButton extends StatelessWidget {
  final bool isCrossButton;
  final String text;
  final Function() buttonClick;
  final Function() crossButtonClick;
  final Color color;
  final Color textColor;
  final bool isSelected;
  final double borderRadius;
  const MenuButton({
    super.key,
    required this.isCrossButton,
    required this.text,
    required this.buttonClick,
    required this.crossButtonClick,
    this.color =kWebBackgroundDeepColor, //const Color.fromARGB(255, 248, 248, 248),
    this.isSelected = false,
    this.textColor = const Color.fromARGB(255, 58, 56, 56),
    this.borderRadius=4,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MenubuttonBlocBloc(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          BlocBuilder<MenubuttonBlocBloc, MenubuttonBlocState>(
            builder: (context, state) {
              return Container(
                margin: const EdgeInsets.all(0),
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                    color: isSelected ? kSecondaryColor : color,
                    borderRadius: BorderRadius.circular(borderRadius),
                    border: Border.all(color: Colors.black38, width: 0.05),
                    // boxShadow: [
                    //   BoxShadow(
                    //       color: Colors.black38.withOpacity(0.3),
                    //       blurRadius: 0.05,
                    //       spreadRadius: 0.1)
                    // ]
                    //  boxShadow: const [
                    //   BoxShadow(
                    //       blurRadius: 0.0, spreadRadius: 0.1, offset: Offset(0, 0))
                    // ]
                    ),
                child: Row(
                  children: [
                    InkWell(
                      onTap: buttonClick,
                      child: Text(
                        text,
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: state.isHover == true
                                ? const Color.fromARGB(255, 100, 130, 143)
                                : textColor,
                            backgroundColor: Colors.transparent),
                      ),
                    ),
                    isCrossButton
                        ? Container(
                            //color: Colors.red,
                            margin: const EdgeInsets.only(left: 4),
                            child: InkWell(
                              onTap: crossButtonClick,
                              onHover: (value) {
                                context
                                    .read<MenubuttonBlocBloc>()
                                    .add(SetHoverStatus(isHover: value));
                                //  print(value.toString());
                              },
                              child: Icon(
                                Icons.close_outlined,
                                size: 18,
                                weight: 0.1,
                                color: state.isHover == true
                                    ? const Color.fromARGB(255, 218, 38, 32)
                                    : Colors.black,
                              ),
                            ),
                          )
                        : const SizedBox(),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class MenubuttonBlocBloc
    extends Bloc<MenubuttonBlocEvent, MenubuttonBlocState> {
  MenubuttonBlocBloc() : super(const MenubuttonBlocInitial(false)) {
    on<MenubuttonBlocEvent>((event, emit) {
      if (event is SetHoverStatus) {
        emit(MenubuttonBlocInitial(event.isHover));
        //  print(event.isHover.toString());
      }
    });
  }
}

sealed class MenubuttonBlocState {
  final bool isHover;
  const MenubuttonBlocState(this.isHover);
}

final class MenubuttonBlocInitial extends MenubuttonBlocState {
  const MenubuttonBlocInitial(super.isHover);
}

sealed class MenubuttonBlocEvent {}

class SetHoverStatus extends MenubuttonBlocEvent {
  final bool isHover;
  SetHoverStatus({required this.isHover});
}
