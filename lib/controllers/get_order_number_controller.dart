import 'package:get/get.dart';

class GetOrderNumberController extends GetxController {
  String number = "";

  setNumber(String num) {
    number = num;
    update();
  }
}
