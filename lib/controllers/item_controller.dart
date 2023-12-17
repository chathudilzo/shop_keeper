import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../objects/item.dart';

class ItemController extends GetxController{
  RxBool isLoading=false.obs;
RxList<Item> itemList=<Item>[].obs;


@override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchItems();
  }

Future<void>addItem(Item item)async{
  final box=await Hive.openBox<Item>('itemBox');
  await box.add(item);

  fetchItems();

}


  Future<void> fetchItems()async{
    isLoading.value=true;
    final box=await Hive.openBox<Item>('itemBox');
    itemList.value=box.values.toList();
    isLoading.value=false;
    for(Item item in itemList){
      print(item.name);
      print(item.count);
      print(item.unitPrice);
      print(item.kgPrice);
    }
  }

  Future<void>deleteItem(Item item)async{
    final box=await Hive.openBox<Item>('itemBox');
    int index=itemList.indexWhere((element) => element.name==item.name);
    await box.delete(item.key);

    fetchItems();

  }

}