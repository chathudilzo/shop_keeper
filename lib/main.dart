import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shop_keeper/controllers/item_controller.dart';
import 'package:shop_keeper/objects/item.dart';
import 'package:shop_keeper/screens/add_item_page.dart';

void main() async{
await Hive.initFlutter();
Hive.registerAdapter(ItemAdapter());

if(!Hive.isBoxOpen('itemBox')){
  await Hive.openBox<Item>('itemBox');
}

Get.put(ItemController());
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
      home: const ItemPage(),
    );
  }
}
