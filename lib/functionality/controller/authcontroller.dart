import 'package:get/get.dart';

class AuthController extends GetxController{
  RxBool passVisibility = RxBool(true);
  RxBool isLoading = RxBool(false);
  RxString username = ''.obs;
}