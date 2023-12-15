import 'package:hive_flutter/hive_flutter.dart';

part 'sell_item.g.dart';

@HiveType(typeId: 3)
class SellItem extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  double kgPrice;

  @HiveField(2)
  double unitPrice;

  @HiveField(3)
  double buyAmount;

  @HiveField(4)
  late double itemTotal;

  SellItem(this.name, this.kgPrice, this.unitPrice, this.buyAmount) {
    itemTotal = calculateTotal();
  }

  double calculateTotal() {
    var price = unitPrice == 0 ? kgPrice / 1000 : unitPrice;
    return buyAmount * price;
  }
}
