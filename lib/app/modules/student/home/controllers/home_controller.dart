import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var drawerVisible = false.obs;
  var itemDrawerVisible = false.obs;
  var light = true.obs;
  Rx<ScrollPhysics> enableScroll = Rx(const AlwaysScrollableScrollPhysics());

  Rx<List> listRequest = Rx([]);

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
