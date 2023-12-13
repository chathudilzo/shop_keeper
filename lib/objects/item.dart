
import 'package:hive/hive.dart';
part 'item.g.dart';

@HiveType(typeId: 0)
class Item extends HiveObject{

@HiveField(0)
late String name;

@HiveField(1)
late double count;

@HiveField(2)
late double unitPrice;

@HiveField(3)
late double kgPrice;

Item(this.name,this.count,this.unitPrice,this.kgPrice);

}