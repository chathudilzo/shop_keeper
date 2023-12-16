import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../objects/bill.dart';

class BillController extends GetxController{
  RxList<Bill> todayBills=<Bill>[].obs;
  RxBool isLoading=false.obs;
  RxBool isBilling=false.obs;


  

  Future<void>addBill(Bill bill)async{
    isBilling.value=true;
    final box=await Hive.openBox<Bill>('billBox');
    await box.add(bill);
    isBilling.value=false;
  }

  Future<void>fetchBills(String date)async{
    isLoading.value=true;
    final box=await Hive.openBox<Bill>('billBox');
    final filteredBills=box.values.toList().where((bill) => bill.date==date).toList();

    todayBills.value=filteredBills;
    isLoading.value=false;
  }
}