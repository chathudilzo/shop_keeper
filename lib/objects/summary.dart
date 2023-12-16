

import 'package:hive_flutter/adapters.dart';
part 'summary.g.dart';
@HiveType(typeId: 4)
class Summary extends HiveObject{
@HiveField(0)
String date;

@HiveField(1)
double total;

@HiveField(2)
double income;

@HiveField(3)
double depth;

Summary(this.date,this.total,this.income,this.depth);


}