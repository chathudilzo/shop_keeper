import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:shop_keeper/objects/daily_sales.dart';
import 'package:shop_keeper/objects/sell_item.dart';

class DailySalesController extends GetxController{
  RxList<DailySales> allDailySalesList=<DailySales>[].obs;
  RxBool isLoading=false.obs;
   RxBool isDailyLoading=true.obs;
  late DailySales dailySales;

@override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchAllDailySalesLists();
  }


  Future<void>fetchAllDailySalesLists()async{
    isLoading.value=true;
    final box=await Hive.openBox<DailySales>('daily_sales');
    final allSales=box.values.toList();
    
    for(DailySales sales in allSales){
      //print(sales.date);
      //print(sales.salesData.map((e) => e.buyAmount));
    }


    allDailySalesList.clear();
    allDailySalesList.addAll(allSales);
    //print(allDailySalesList);
    isLoading.value=false;

  }


  void updateSalesData(List<SellItem> sellItems)async {
    fetchAllDailySalesLists();
   

    try{
      String date=DateFormat.yMMMd().format(DateTime.now());
final box=await Hive.openBox<DailySales>('daily_sales');
    DailySales? existingSalesList=allDailySalesList.isNotEmpty?
    allDailySalesList.firstWhere((
      dailySales) => dailySales.salesData.isNotEmpty && dailySales.date==date,orElse: ()=>DailySales(date, [])
      ):DailySales(date, []);

      if(existingSalesList.salesData.isNotEmpty){
        existingSalesList.updateSalesData(sellItems);
        existingSalesList.save();
      }else{
        DailySales newSales=DailySales(date, []);
        newSales.updateSalesData(sellItems);
        await box.add(newSales);
        newSales.save();
      }
      
      fetchAllDailySalesLists();
   // await box.close();
  }catch(error){
    print(error);
  }

}

Future<void> getDailySales(String date)async{

  print('Date:'+date);
  isLoading.value=true;
  isDailyLoading.value=true;
if(allDailySalesList.isNotEmpty){
  dailySales=allDailySalesList.firstWhere((dailySales) =>dailySales.salesData.isNotEmpty && dailySales.date==date,orElse:()=> DailySales(date, []));

}else{
  dailySales=DailySales(date, []);
}
print('dailySales:::: ${dailySales.salesData}');
isLoading.value=false;
isDailyLoading.value=false;
}
}