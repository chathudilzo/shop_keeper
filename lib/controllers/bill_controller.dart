import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:shop_keeper/objects/summary.dart';

import '../objects/bill.dart';

class BillController extends GetxController{
  RxList<Bill> todayBills=<Bill>[].obs;
  RxBool isLoading=false.obs;
  RxBool isBilling=false.obs;
  Rx<Summary> todaySummary=Summary(DateFormat.yMMMd().format(DateTime.now()), 0, 0, 0).obs;


  

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
    if(todayBills.isNotEmpty){
      double total=0;
      double income=0;
      double depth=0;
      for(int i=0;i<todayBills.length;i++){
        total+=todayBills[i].fullTotal;
        income+=todayBills[i].payedAmount;
        depth+=todayBills[i].fullTotal-todayBills[i].payedAmount;

      }
      todaySummary.value.date=date;
      todaySummary.value.total=total;
      todaySummary.value.income=income;
      todaySummary.value.depth=depth;
    }
    isLoading.value=false;
  }
}