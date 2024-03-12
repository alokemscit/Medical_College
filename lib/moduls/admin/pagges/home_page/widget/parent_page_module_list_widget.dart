// ignore: must_be_immutable
 

// ignore_for_file: use_super_parameters

import 'package:agmc/config/const.dart';

import 'package:agmc/config/responsive.dart';
import 'package:agmc/moduls/admin/pagges/home_page/home_page.dart';
import 'package:agmc/moduls/admin/pagges/home_page/model/model_menu_list.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';
 

// ignore: must_be_immutable
class ParentMainModuleListWidget extends StatelessWidget {
  List<ModelModuleList> list;
  ParentMainModuleListWidget({
    Key? key,
    required this.list,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Responsive(
        mobile: _mobile(list),
        tablet: _desktop(list, context),
        desktop: _desktop(list, context));
  }
}

_desktop(List<ModelModuleList> list, BuildContext context) {
  //Size size = context.size!;
  return Padding(
    padding: context.width <= 650
        ? const EdgeInsets.only(bottom: 45)
        : const EdgeInsets.only(bottom: 0),
    child: GridView.builder(
      itemCount: list.length,
      padding: const EdgeInsets.all(8.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: context.width <= 650
            ? 1
            : (context.width > 650 && context.width < 1200)
                ? 2
                : (context.width >= 1200 && context.width < 1730)
                    ? 3
                    : 4,
        childAspectRatio: 2.0,
        mainAxisSpacing: 25.0,
        crossAxisSpacing: 25.0,
      ),
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            borderRadius:BorderRadius.circular(15) ,
            onTap: () {
             print(list[index].id);
              Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => HomePage(
                      module: list[index],
                    ),
                  ));
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Container(
                alignment: Alignment.topLeft,
                decoration: BoxDecoration(
                  color: appColorBlue.withOpacity(0.01),
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border.all(
                        color: Colors.black87.withOpacity(0.3), width: 0.038),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 3,
                          spreadRadius: 1,
                          color: appColorLogo
                              .withOpacity(0.05)),
                      BoxShadow(
                          blurRadius: 10,
                          spreadRadius: 5,
                          color: const Color.fromARGB(255, 41, 241, 1)
                              .withOpacity(0.0215)),
                      
                    ]),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            // border: Border.all(color: Colors.black)
                          ),
                          child: Image(
                            image: AssetImage(
                                "assets/images/${list[index].img!}.png"),
                            height: context.width < 650
                                ? 40
                                : (context.width >= 1200 && context.width < 1600)
                                    ? 60
                                    : (context.width > 650 && context.width < 805)
                                        ? 50
                                        : 70,
                            width: context.width < 650
                                ? 30
                                : (context.width >= 1200 && context.width < 1600)
                                    ? 50
                                    : (context.width > 650 && context.width < 805)
                                        ? 40
                                        : 60,
                            fit: BoxFit.contain,
                            //color: Colors.amber,
                            colorBlendMode: BlendMode.srcIn,
                          )),
                      Text(
                        list[index].name!,
                        style: GoogleFonts.roboto(
                            fontSize: context.width < 650
                                ? 13
                                : (context.width > 650 && context.width < 805)
                                    ? 16
                                    : 20,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                            color: appColorLogoDeep),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Expanded(
                        child: Text(
                            list[index].desc!,
                            overflow: TextOverflow.clip,
                            style: GoogleFonts.roboto(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                                color: Colors.black),
                          ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    ),
  );
}

_mobile(List<ModelModuleList> list) => ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Container(
            decoration: customBoxDecoration.copyWith(border:Border.all(color: kHeaderolor.withOpacity(0.25)) ),
            margin: const EdgeInsets.only(bottom: 12,top: 4),
          
          
            child: InkWell(
               borderRadius:BorderRadius.circular(8),
            onTap: (){
              Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => HomePage(
                      module: list[index],
                    ),
                  ));
            },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadiusDirectional.circular(8),
                          //  color:Colors.blue,
                          boxShadow:  [
                            BoxShadow(
                              color: Colors.white.withOpacity(0.5),
                              spreadRadius: 0.5,
                              blurRadius: 10.5,
                              offset: const Offset(0, 0),
                            )
                          ]
                          ),
                          child: Center(
                            child: Image(
                              
                              image: AssetImage("assets/images/${list[index].img!}.png"),
                              width: 40,
                              height: 32,
                              color: kHeaderolor.withOpacity(0.8),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                const SizedBox(width: 8,),
                  Flexible(
                    child: Text(
                            list[index].name!,
                            style: customTextStyle.copyWith(fontSize: 18,fontWeight: FontWeight.w600, color: kHeaderolor,),
                          ),
                  )
                        
                        
                      ],
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      list[index].desc!,
                      overflow: TextOverflow.clip,
                      style: customTextStyle.copyWith(fontSize: 12,fontWeight: FontWeight.normal),),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
