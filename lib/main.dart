import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shop_keeper/controllers/bill_controller.dart';
import 'package:shop_keeper/controllers/daily_sales_controller.dart';
import 'package:shop_keeper/controllers/item_controller.dart';
import 'package:shop_keeper/objects/daily_sales.dart';
import 'package:shop_keeper/objects/item.dart';
import 'package:shop_keeper/objects/summary.dart';
import 'package:shop_keeper/screens/add_item_page.dart';
import 'package:shop_keeper/screens/home_page.dart';

import 'objects/bill.dart';
import 'objects/sell_item.dart';

void main() async{
await Hive.initFlutter();
Hive.registerAdapter(ItemAdapter());
Hive.registerAdapter(BillAdapter());
Hive.registerAdapter(DailySalesAdapter());
Hive.registerAdapter(SellItemAdapter());
Hive.registerAdapter(SummaryAdapter());

if(!Hive.isBoxOpen('itemBox')){
  await Hive.openBox<Item>('itemBox');
}
if(!Hive.isBoxOpen('billBox')){
  await Hive.openBox<Bill>('billBox');
}

Get.put(ItemController());
Get.put(BillController());
Get.put(DailySalesController());


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
