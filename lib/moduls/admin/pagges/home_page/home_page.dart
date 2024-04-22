// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:agmc/core/config/const.dart';
import 'package:agmc/core/config/responsive.dart';
import 'package:agmc/core/config/router.dart';
import 'package:agmc/moduls/admin/pagges/home_page/model/model_menu_list.dart';
import 'package:agmc/moduls/admin/pagges/home_page/widget/login_user_image_and_details.dart';
import 'package:agmc/moduls/admin/pagges/home_page/widget/parent_background_widget.dart';

import 'package:agmc/widget/menubutton.dart';
import 'package:agmc/widget/sidemenu.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
 

import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

// ignore: must_be_immutable

// ignore: non_constant_identifier_names
NextIndex(List<ItemModel> list, int index) {
  if (list.length > 1) {
    ItemModel k = list[list.length - 1 > index ? (index + 1) : (index - 1)];
    return k.id;
  }
  return '';
}

List<SingleChildWidget> _provider(BuildContext context) => [
      BlocProvider(
        create: (context) => MenuItemBloc(),
      ),
      BlocProvider(
        create: (context) => CurrentIDBloc(),
      ),
      BlocProvider(create: (constext) => MenubuttonCloseBlocBloc()),
      // BlocProvider(
      //     create: (context) =>
      //         LoginBloc(Provider.of<AuthProvider>(context, listen: false))),
    ];

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  final ModelModuleList module;
  const HomePage({super.key, required this.module});
  @override
  Widget build(BuildContext context) {
    final List<SingleChildWidget> providers = _provider(context);

    return MultiProvider(
      providers: providers,
      child: Scaffold(
        backgroundColor: kWebBackgroundDeepColor,
        body: Stack(
          children: [
            const ParentPageBackground(imageOpacity: 0.03),
            HomePagebodyWidget(module: module),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class HomePagebodyWidget extends StatelessWidget {
  HomePagebodyWidget({
    super.key,
    required this.module,
  });
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ModelModuleList module;

  @override
  Widget build(BuildContext context) {
    var sidemenu = SideMenu(
      module: module,
      userDetailsForDrawer: const UserDetailsForDrawer(),
      generateMenuItems: GenerateMenuItems(
        mid: module.id.toString(),
        fkey: _scaffoldKey,
      ),
      fkey: _scaffoldKey,
    );
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Responsive(
          mobile: _mobile(_scaffoldKey, sidemenu, module),
          tablet: constraints.maxWidth > 750
              ? DesktopWidget(module: module, sidemenu: sidemenu)
              : _mobile(_scaffoldKey, sidemenu, module),
          desktop: DesktopWidget(module: module, sidemenu: sidemenu),
        );
      },
    );
  }
}

Widget _mobile(
  GlobalKey<ScaffoldState> scaffoldKey,
  SideMenu sidemenu,
  ModelModuleList module,
) {
  return Scaffold(
    key: scaffoldKey,
    drawer: MyDrawer(
      sidemenu: sidemenu,
    ),
    appBar: PreferredSize(
      preferredSize:
          const Size.fromHeight(65), //const Size.fromHeight(kToolbarHeight),
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: AppBarMobile(fkey: scaffoldKey),
      ),
    ),

    body: TabAndBodyWidget(
      moduleId: module.id.toString(),
    ),
    //     body: TabAndBodyWidget(
    //   module: module,
    // ),
  );
}

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key, required this.sidemenu});
  final SideMenu sidemenu;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: sidemenu,
    );
  }
}

class AppBarMobile extends StatelessWidget {
  final GlobalKey<ScaffoldState> fkey;

  const AppBarMobile({super.key, required this.fkey});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // bottom:
      backgroundColor: kWebBackgroundDeepColor,
      leading: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            // print("object");
            fkey.currentState?.openDrawer();
          },
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadiusDirectional.circular(12),
            ),
            child: const Center(
              child: Icon(
                Icons.menu,
                color: kWebHeaderColor,
              ),
            ),
          )),
      actions: const [
        Padding(
          padding: EdgeInsets.only(right: 8, bottom: 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(child: LoginUsersImageAndDetails()),
            ],
          ),
        ),
      ],
    );
  }
}

class DesktopWidget extends StatelessWidget {
  const DesktopWidget({
    super.key,
    required this.module,
    required this.sidemenu,
  });
  final SideMenu sidemenu;
  final ModelModuleList module;

  @override
  Widget build(BuildContext context) {
    // print('Secon-----------  widget');
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //Drawer Menu Item

        // DrawerWithBackArrow(module: module),

        BlocBuilder<MenubuttonCloseBlocBloc, MenubuttonCloseBlocState>(
          builder: (context, state) {
            bool b = false;
            if (state is MenubuttonCloseBlocInitial) {
              b = state.isClose;
            }

            double ss = b == true ? 0 : 220;
            //print(ss);
            return AnimatedSize(
              curve: Curves.easeIn,
              //  vsync: this,
              duration: const Duration(milliseconds: 150),
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: ss),
                //      //  // child:
                child: Stack(
                  children: [
                    sidemenu,
                    const ArrowBackPositioned(),
                  ],
                ),
              ),
            );
          },
        ),

        Expanded(
            child: TabAndBodyWidget(
          moduleId: module.id.toString(),
        )),
      ],
    );
  }
}

// void _disposePage(int pageIndex) {
//     // Do any cleanup or resource disposal related to the page at the given index
//     // For example, if your page has a StatefulWidget, you can call its dispose method
//     // You may need to maintain a list of your pages' states to call their dispose methods

//     // For demonstration purposes, assuming MyPage is a StatefulWidget
//     final GlobalKey<_MyPageState> key = _pageKeys[pageIndex];
//     key.currentState?.dispose();
//   }

class TabAndBodyWidget extends StatelessWidget {
  const TabAndBodyWidget({super.key, required this.moduleId});
  final String moduleId;
  @override
  Widget build(BuildContext context) {
    //print('Render Main Body ..........main00000000');
    // Size size = MediaQuery.of(context).size;
    return context.width < 650
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const DrawerBackIconWithTabEvent(),
              Expanded(
                child: BlocBuilder<CurrentIDBloc, CurrentIdState>(
                    builder: (context, state) {
                  var id = state.id;

                  Get.reset();
                  Get.deleteAll();
                  // print(id);
                  //Get.to(getPage(module, id));
                  if (id.trim() == '' )  {
                   // print(moduleId);
                  return  getDashBoard(moduleId);
                  }
                  return getPage(id);
                }),
              )
            ],
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const DrawerBackIconWithTabEvent(),
              Expanded(
                child: BlocBuilder<CurrentIDBloc, CurrentIdState>(
                    builder: (context, state) {
                  var id = state.id;

                  print('A-------------' + id);
                  if (id.trim() == '' )  {
                   // print(moduleId);
                  return  getDashBoard(moduleId);
                  }
                  return getPage(id);
                }),
              )
            ],
          );
  }
}

class DrawerBackIconWithTabEvent extends StatelessWidget {
  const DrawerBackIconWithTabEvent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    bool b = Responsive.isMobile(context);
    return  b?const SizedBox():Container(
      //margin: EdgeInsets.only(top: 100),
      color: b ? Colors.transparent : kWebBackgroundDeepColor,
      width: double.infinity,
      height: 28,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const DrawerMenueIcon(),
          SizedBox(
            width: b
                ? context.width
                : context.width  - 252,
            child: b?const SizedBox():  const SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child:  TabMenuWithEvent(),
            ),
          ),
        ],
      ),
    );
  }
}

class TabMenuWithEvent extends StatelessWidget {
  const TabMenuWithEvent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MenuItemBloc, ItemMenuState>(
      builder: (context, state) {
        if (state is ItemMenuAdded && state.menuitem.isNotEmpty) {
          final itemList = state.menuitem;
          return BlocBuilder<CurrentIDBloc, CurrentIdState>(
            builder: (context1, state1) {
              return  ListView.builder(
                  padding: const EdgeInsets.only(left: 2),
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: itemList.length,
                  itemBuilder: (context, index) {
                    final ItemModel menuitem = itemList[index];
                    return MenuButton(
                      isSelected: false,
                      // state1.id != menuitem.id ? true : false,
                      isCrossButton: true,
                      text: menuitem.name,
                      buttonClick: () {
                        //  print('b');
                        context1
                            .read<CurrentIDBloc>()
                            .add(SetCurrentId(id: menuitem.id));
                          //print(state1.id);
                        //print(menuitem.id);
                      },
                      crossButtonClick: () {
                        // Get.reset();
                        // Get.deleteAll();

                        // try {

                        //   var x = getPage(menuitem.id);
                        //   var methods = getMethods(x);
                        //   methods.forEach((method) {
                        //     method();
                        //   });

                        //  // print(t);
                        // } catch (e) {
                        //   print(e.toString());
                        // }

                        // deleteController(menuitem.id);
                        var menuid = menuitem.id;
                        context
                            .read<MenuItemBloc>()
                            .add(ItemMenuDelete(menuitem: menuitem));

                        context1
                            .read<CurrentIDBloc>()
                            .add(SetCurrentId(id: NextIndex(itemList, index)));

                        // Future.delayed(const Duration(milliseconds: 3000));

                        Future.delayed(const Duration(microseconds: 100), () {
                          deleteController(menuid);
                        });
                      },
                      color: state1.id.trim() != menuitem.id.trim()
                          ? kSecondaryColor
                          : const Color.fromARGB(255, 255, 255, 255),
                      textColor: state1.id.trim() != menuitem.id.trim()
                          ? Colors.black.withOpacity(0.8)
                          : const Color.fromARGB(255, 1, 114, 108),
                    );
                  });
            },
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}

void deleteController(String id) {
  try {
    var x = getPage(id);
    var methods = getMethods(x);
    methods.forEach((method) {
      method();
    });

    // print(t);
  } catch (e) {
    print(e.toString());
  }
}

List<Function> getMethods(x) {
  return [x.disposeController];
}

class DrawerMenueIcon extends StatelessWidget {
  const DrawerMenueIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MenubuttonCloseBlocBloc, MenubuttonCloseBlocState>(
      builder: (context, state) {
        return state.isClose
            ? InkWell(
                onTap: () {
                  context
                      .read<MenubuttonCloseBlocBloc>()
                      .add(IsMenuClose(isClose: !state.isClose));
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                  child: Icon(
                    Icons.menu_sharp,
                    size: 22,
                  ),
                ),
              )
            : const SizedBox();
      },
    );
  }
}

class ArrowBackPositioned extends StatelessWidget {
  const ArrowBackPositioned({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    //final MenuCloseController yourController = Get.put(MenuCloseController());
    return Positioned(
        top: 1,
        right: 1,
        child: BlocBuilder<MenubuttonCloseBlocBloc, MenubuttonCloseBlocState>(
          builder: (context, state) {
            return InkWell(
              onTap: () {
                context
                    .read<MenubuttonCloseBlocBloc>()
                    .add(IsMenuClose(isClose: !state.isClose));
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 4),
                child: Icon(
                  Icons.arrow_back_ios,
                  size: 18,
                  color: Colors.grey,
                ),
              ),
            );
          },
        ));
  }
}

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
  ItemMenuInit({required List<ItemModel> menuitem}) : super(menuitem: menuitem);
}

class ItemMenuAdded extends ItemMenuState {
  final String currentID;
  ItemMenuAdded({required List<ItemModel> menuitem, required this.currentID})
      : super(menuitem: menuitem);
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
    state.menuitem.remove(event.menuitem);
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

sealed class MenubuttonCloseBlocEvent {}

class IsMenuClose extends MenubuttonCloseBlocEvent {
  final bool isClose;
  IsMenuClose({required this.isClose});
}
