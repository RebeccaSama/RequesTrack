import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InitPreferences extends GetxController {

  late SharedPreferences prefs;
  
  @override
  void onInit() {
    super.onInit();

    initialize();
  }

  void initialize() async {
    prefs = await SharedPreferences.getInstance();
  }
}