// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_items.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StockItemsAdapter extends TypeAdapter<StockItems> {
  @override
  final int typeId = 0;

  @override
  StockItems read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StockItems(
      productId: fields[0] as String,
      productImage: fields[1] as Uint8List?,
      productName: fields[2] as String,
      marketPrice: fields[3] as double,
      profitMargin: fields[4] as double,
      stockItem: fields[5] as int,
    );
  }

  @override
  void write(BinaryWriter writer, StockItems obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.productId)
      ..writeByte(1)
      ..write(obj.productImage)
      ..writeByte(2)
      ..write(obj.productName)
      ..writeByte(3)
      ..write(obj.marketPrice)
      ..writeByte(4)
      ..write(obj.profitMargin)
      ..writeByte(5)
      ..write(obj.stockItem);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StockItemsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
