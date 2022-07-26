import 'package:get/get.dart';

class TipsSearchController extends GetxController{

  var isSearching = Rx<bool>(false);
  var searchQuery = Rx<String?>(null);
  var trigger = Rx<bool>(false);

  void startSearching(String text){
    searchQuery.value=text;
  }


}