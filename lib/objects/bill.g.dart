// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bill.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BillAdapter extends TypeAdapter<Bill> {
  @override
  final int typeId = 1;

  @override
  Bill read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Bill(
      fields[0] as String,
      (fields[1] as List).cast<SellItem>(),
      fields[4] as String?,
      fields[3] as String,
      fields[5] as double,
    )..fullTotal = fields[2] as double;
  }

  @override
  void write(BinaryWriter writer, Bill obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.sellItems)
      ..writeByte(2)
      ..write(obj.fullTotal)
      ..writeByte(3)
      ..write(obj.payedStatus)
      ..writeByte(4)
      ..write(obj.buyerName)
      ..writeByte(5)
      ..write(obj.payedAmount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BillAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
