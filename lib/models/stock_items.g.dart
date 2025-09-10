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
      productImage: fields[0] as Uint8List?,
      productName: fields[1] as String,
      marketPrice: fields[2] as double,
      profitMargin: fields[3] as double,
    );
  }

  @override
  void write(BinaryWriter writer, StockItems obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.productImage)
      ..writeByte(1)
      ..write(obj.productName)
      ..writeByte(2)
      ..write(obj.marketPrice)
      ..writeByte(3)
      ..write(obj.profitMargin);
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
