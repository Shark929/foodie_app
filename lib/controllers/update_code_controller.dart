import 'package:get/get.dart';

class UpdateController extends GetxController {
  RxInt count = 0.obs;
  UpdateController({
    var count,
  });
  void increment() {
    count++;
  }

  RxInt updateNum(RxInt num) {
    count = num;

    return count;
  }
}
