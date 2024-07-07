import 'package:flutter/material.dart';
import 'package:get/get.dart';

class KeluargaWrapperController extends GetxController {
  late PageController pageController;

  RxInt currentPage = 1.obs;

  void goToTab(int page) {
    currentPage.value = page;
    pageController.jumpToPage(page);
  }

  void animateToTab(int page) {
    currentPage.value = page;
    pageController.animateToPage(page,
        duration: const Duration(milliseconds: 300), curve: Curves.bounceIn);
  }

  @override
  void onInit() {
    pageController = PageController(initialPage: 1);
    super.onInit();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
