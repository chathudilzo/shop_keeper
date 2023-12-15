// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sell_item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SellItemAdapter extends TypeAdapter<SellItem> {
  @override
  final int typeId = 3;

  @override
  SellItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SellItem(
      fields[0] as String,
      fields[1] as double,
      fields[2] as double,
      fields[3] as double,
    )..itemTotal = fields[4] as double;
  }

  @override
  void write(BinaryWriter writer, SellItem obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.kgPrice)
      ..writeByte(2)
      ..write(obj.unitPrice)
      ..writeByte(3)
      ..write(obj.buyAmount)
      ..writeByte(4)
      ..write(obj.itemTotal);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SellItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
