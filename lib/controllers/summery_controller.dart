import 'package:get/get.dart';
import 'package:shop_keeper/objects/summary.dart';

class SummaryController extends GetxController{
RxList<Summary> allSummaryList=<Summary>[].obs;
RxBool isLoading=false.obs;
late Summary todaySummary;

@override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

  }

// Future<void>fetchSummery(String date){

// }

}