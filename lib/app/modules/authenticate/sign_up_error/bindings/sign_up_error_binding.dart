import 'package:get/get.dart';

import '../controllers/sign_up_error_controller.dart';

class SignUpErrorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignUpErrorController>(
      () => SignUpErrorController(),
    );
  }
}
