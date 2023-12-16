

import 'package:hive_flutter/adapters.dart';
import 'package:shop_keeper/objects/sell_item.dart';
part 'bill.g.dart';

@HiveType(typeId: 1)
class Bill extends HiveObject{

@HiveField(0)
String date;

@HiveField(1)
List<SellItem> sellItems;

@HiveField(2)
late double fullTotal;

@HiveField(3)
String payedStatus;

@HiveField(4)
String? buyerName;

@HiveField(5)
late double payedAmount;

Bill(this.date,this.sellItems,this.buyerName,this.payedStatus,this.payedAmount){
  fullTotal=calculateTotal();
}

double calculateTotal(){
 return fullTotal=sellItems.fold(0, (sum, sellItem) => sum+sellItem.itemTotal);

}

}