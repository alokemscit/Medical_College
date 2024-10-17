import 'package:asgar_ali_hospital/constant/const.dart';
import 'package:asgar_ali_hospital/pages/main_home_page/main_home_page.dart';
import 'package:get/get.dart';
import 'dart:async';

class DefaultPageController extends GetxController {
  late BuildContext context;
  PageController pageController = PageController();
  var currentPage = 0.obs;

  Timer? _timer;
  final List<String> imageUrls = slider_imageUrls;
  void startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (currentPage < imageUrls.length - 1) {
        currentPage++;
      } else {
        currentPage.value = 0;
      }
      pageController.animateToPage(
        currentPage.value,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOutCubic,
      );
    });
  }

  void gotoMainPage() {
   _timer?.cancel();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const MainHomePagae()),
      
    );
    currentPage.value = 0;
    imageUrls.clear();
    pageController.dispose();
  }

  @override
  void onInit() {
    super.onInit();
    startAutoScroll();
    print('default page called');
  }

  @override
  void onClose() {
    //print("Dispose call");
   _timer?.cancel();
    currentPage.value = 0;
    imageUrls.clear();
    pageController.dispose();
  }
}
