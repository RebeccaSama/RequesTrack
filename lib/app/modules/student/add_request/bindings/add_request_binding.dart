import 'package:get/get.dart';

import '../controllers/add_request_controller.dart';

class AddRequestBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddRequestController>(
      () => AddRequestController(),
    );
  }
}
