import 'package:asgar_ali_hospital/constant/const.dart';
 
import 'package:asgar_ali_hospital/pages/login_page/auth_provider/auth-provider.dart';
import 'package:asgar_ali_hospital/pages/main_home_page/connection_error_page.dart';
import 'package:asgar_ali_hospital/pages/main_home_page/controller/connection_controller.dart';
import 'package:asgar_ali_hospital/pages/main_home_page/main_home_page.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'pages/default_page/default_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final userProvider = AuthProvider();
  await userProvider.loadUser();

  runApp(MyApp(
    userProvider: userProvider,
  ));
}

class MyApp extends StatelessWidget {
  final AuthProvider userProvider;
  MyApp({super.key, required this.userProvider});
  final ConnectivityService connectivityService =
      Get.put(ConnectivityService());
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.black,
        statusBarBrightness: Brightness.dark));

        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
          create: (context) => userProvider,
        ),
      ],
      child: Consumer<AuthProvider>(
        builder: (context, AuthProvider authNotifier, child) {
          return GetMaterialApp(
              debugShowCheckedModeBanner: false,
              title: appName,
              theme: ThemeData(
                appBarTheme:
                    const AppBarTheme(backgroundColor: Colors.transparent),
                scaffoldBackgroundColor: kBgLightColor,

                //brightness:Brightness.dark,
                colorScheme: ColorScheme.fromSeed(seedColor: appColorPista),
                useMaterial3: true,
              ),
              home: Obx(() {
               // print("Listiner1111");

                if (!connectivityService.isConnected) {
                 
                  return const ConnectionErrorPage();
                } else {
                  return userProvider.user == null
                      ? const DefaultPage()
                      : const MainHomePagae();
                }
              }));
        },
      ),
    );
  }
}
