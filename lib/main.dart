import 'package:agmc/core/config/const.dart';
import 'package:agmc/moduls/admin/pagges/login_page/login_page.dart';
import 'package:agmc/moduls/admin/pagges/login_page/notifires/aughtprovider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
 
import 'package:provider/provider.dart';

import 'moduls/admin/pagges/home_page/parent_page.dart';
import 'moduls/admin/pagges/login_page/controller/connection_controller.dart';


void main() async {


  
  WidgetsFlutterBinding.ensureInitialized();
   Get.reset();
   Get.deleteAll();
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
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<AuthProvider>(
            create: (context) => userProvider,
          ),
        ],
        child: Consumer<AuthProvider>(
            builder: (context, AuthProvider authNotifier, child) {
              
              return  GetMaterialApp(
      //           ocalizationsDelegates: const [
      //   GlobalMaterialLocalizations.delegate,
      //   GlobalWidgetsLocalizations.delegate,
      // ],
      supportedLocales: const [
        Locale('en', 'GB'), // Define the supported locale
      ],

            scrollBehavior: kIsWeb? CustomScrollBehavior():null,
        debugShowCheckedModeBanner: false,
        title: appName,
        theme: ThemeData(
          fontFamily: 'OpenSans',
          appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent),
          scaffoldBackgroundColor: kBgLightColor,
          //colorScheme: ColorScheme.fromSeed(seedColor: appColorPista),
          colorScheme: const ColorScheme.light(primary: kWebHeaderColor),
          buttonTheme:
          const ButtonThemeData(textTheme: ButtonTextTheme.primary),
          primaryColor: kWebHeaderColor,
          useMaterial3: true,
          ),
             home:  
               userProvider.user != null
                ? const ParentPage()
                 
                : const LoginPage(),
             
             );
                 
          }));

   
  }
}
