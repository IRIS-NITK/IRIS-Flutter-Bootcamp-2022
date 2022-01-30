// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lists.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ListsAdapter extends TypeAdapter<Lists> {
  @override
  final int typeId = 1;

  @override
  Lists read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Lists(
      title: fields[0] as String?,
      desc: fields[1] as String?,
      listDate: fields[2] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, Lists obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.desc)
      ..writeByte(2)
      ..write(obj.listDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ListsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
