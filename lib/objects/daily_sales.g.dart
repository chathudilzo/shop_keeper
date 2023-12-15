// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_sales.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DailySalesAdapter extends TypeAdapter<DailySales> {
  @override
  final int typeId = 2;

  @override
  DailySales read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DailySales(
      fields[0] as String,
      (fields[1] as List).cast<SellItem>(),
    );
  }

  @override
  void write(BinaryWriter writer, DailySales obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.salesData);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DailySalesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
