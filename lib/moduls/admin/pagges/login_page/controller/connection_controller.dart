 
 
import 'package:connectivity/connectivity.dart';
import 'package:get/get.dart';

class ConnectivityService extends GetxService {
  var connectionStatus = Rx<ConnectivityResult>(ConnectivityResult.none);

  var cnt = 0;
  @override
  void onInit() {
    cnt = 0;
    super.onInit();
    // Subscribe to connection changes
    Connectivity().onConnectivityChanged.listen((result) {
      //print('Connection status changed: $result');
      connectionStatus.value = result;
      // if (result == ConnectivityResult.none) {
      //   Get.offAll(() => const ConnectionErrorPage());
      // }

      //   Get.offAll(() => const ConnectionErrorPage());
      // }else{
      //   final userProvider = AuthProvider();
      //   await userProvider.loadUser();

      //   Get.offAll(() => userProvider.user == null
      //               ? const DefaultPage()
      //               : const MainHomePagae(),);
      // }
    });
  }

  bool get isConnected => connectionStatus.value != ConnectivityResult.none;

  void checkInternetConnection() async {
    ConnectivityResult result = await Connectivity().checkConnectivity();
    connectionStatus.value = result;
  }
}
