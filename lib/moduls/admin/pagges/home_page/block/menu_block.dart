
import 'dart:async';

import 'package:agmc/core/config/const.dart';
import 'package:agmc/core/config/function.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemModel {
  final String id;
  final String name;
  ItemModel({required this.id, required this.name});
}

abstract class ItemMenuState {
  final List<ItemModel> menuitem;
  ItemMenuState({required this.menuitem});
}

class ItemMenuInit extends ItemMenuState {
  ItemMenuInit({required super.menuitem});
}

class ItemMenuAdded extends ItemMenuState {
  final String currentID;
  ItemMenuAdded({required super.menuitem, required this.currentID});
}

abstract class ItemMenuEvent {}

class ItemMenuAdd extends ItemMenuEvent {
  final ItemModel menuitem;
  ItemMenuAdd({required this.menuitem});
}

class ItemMenuDelete extends ItemMenuEvent {
  final ItemModel menuitem;
  ItemMenuDelete({required this.menuitem});
}

class MenuItemBloc extends Bloc<ItemMenuEvent, ItemMenuState> {
  MenuItemBloc() : super(ItemMenuInit(menuitem: [])) {
    on<ItemMenuAdd>(_addItem);
    on<ItemMenuDelete>(_deleteItem);
  }

  FutureOr<void> _addItem(ItemMenuAdd event, Emitter<ItemMenuState> emit) {
    state.menuitem.add(event.menuitem);
    // List<ItemModel> lst = [];
    //lst.add(event.menuitem);

    emit(ItemMenuAdded(menuitem: state.menuitem, currentID: event.menuitem.id));
  }

  FutureOr<void> _deleteItem(
      ItemMenuDelete event, Emitter<ItemMenuState> emit) {
    state.menuitem.removeWhere(
      (element) => element.id == event.menuitem.id,
    );
    emit(ItemMenuAdded(menuitem: state.menuitem, currentID: event.menuitem.id));
  }
}

abstract class CurrentIdState {
  final String id;
  CurrentIdState({required this.id});
}

class CurrentIDInit extends CurrentIdState {
  CurrentIDInit({required super.id});
}

class CurrentIDSet extends CurrentIdState {
  final String currentId;
  CurrentIDSet({required super.id, required this.currentId});
}

class CurrentIdDeleteState extends CurrentIdState {
  final String delid;
  CurrentIdDeleteState({required this.delid, required super.id});
}

abstract class CurrenIdEvent {
  final String id;

  CurrenIdEvent({required this.id});
}

class SetCurrentId extends CurrenIdEvent {
  SetCurrentId({required super.id});
}

class CurrentIDBloc extends Bloc<CurrenIdEvent, CurrentIdState> {
  CurrentIDBloc() : super(CurrentIDInit(id: "")) {
    on<CurrenIdEvent>((event, emit) {
      if (event is SetCurrentId) {
        //emit(CurrentIdDeleteState(delid: event.delid,id: event.id));

        emit(CurrentIDSet(id: event.id, currentId: event.id));
        //
      }
    });
  }
}

class MenubuttonCloseBlocBloc
    extends Bloc<MenubuttonCloseBlocEvent, MenubuttonCloseBlocState> {
  MenubuttonCloseBlocBloc()
      : super(MenubuttonCloseBlocInitial(isClose: false)) {
    on<MenubuttonCloseBlocEvent>((event, emit) {
      if (event is IsMenuClose) {
        emit(MenubuttonCloseBlocInitial(isClose: event.isClose));
        //  print(event.isHover.toString());
      }
      if (event is TabCloseFromOuterEvent) {
        // emit(TabCloseFromOuterState(isClose: true,context: event.context));
      //  print('Call event');

        List<ItemModel> list =
            event.context.read<MenuItemBloc>().state.menuitem;

        String i = event.context.read<CurrentIDBloc>().state.id;
        deleteController(i);
        event.context
            .read<MenuItemBloc>()
            .add(ItemMenuDelete(menuitem: ItemModel(id: i, name: '')));

        event.context.read<CurrentIDBloc>().add(SetCurrentId(
            id: mNextIndex(event.context.read<MenuItemBloc>().state.menuitem,
                list.indexOf(list.where((e) => e.id == i).first))));
      }
    });
  }
}

sealed class MenubuttonCloseBlocState {
  final bool isClose;

  // ignore: non_constant_identifier_names
  MenubuttonCloseBlocState({required this.isClose});
}

final class MenubuttonCloseBlocInitial extends MenubuttonCloseBlocState {
  MenubuttonCloseBlocInitial({required super.isClose});
}

final class TabCloseFromOuterState extends MenubuttonCloseBlocState {
  BuildContext context;
  TabCloseFromOuterState({required super.isClose, required this.context});
}

sealed class MenubuttonCloseBlocEvent {}

class IsMenuClose extends MenubuttonCloseBlocEvent {
  final bool isClose;
  IsMenuClose({required this.isClose});
}

class TabCloseFromOuterEvent extends MenubuttonCloseBlocEvent {
  BuildContext context;
  TabCloseFromOuterEvent(
    this.context,
  );
}
