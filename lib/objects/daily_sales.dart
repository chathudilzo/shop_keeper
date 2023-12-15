

import 'package:hive_flutter/adapters.dart';
import 'package:shop_keeper/objects/sell_item.dart';
part 'daily_sales.g.dart';

@HiveType(typeId: 2)
class DailySales extends HiveObject{

@HiveField(0)
String date;

@HiveField(1)
List<SellItem> salesData;

DailySales(this.date,this.salesData);

void updateSalesData(List<SellItem> sellItems){
  for(SellItem sellItem in sellItems){
    bool itemExists=false;

    for(SellItem existingItem in salesData){
      if(existingItem.name==sellItem.name){
        itemExists=true;
        existingItem.buyAmount+=sellItem.buyAmount;
        existingItem.itemTotal+=sellItem.itemTotal;
        break;
      }
    }
    if(!itemExists){
      salesData.add(sellItem);
    }
  }

}

}