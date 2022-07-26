import 'package:get/get.dart';

class ScrollingController extends GetxController{

  var reachedThereshold = Rx<bool>(false);

  void toggle(){
    reachedThereshold.value = !reachedThereshold.value;
  }

}