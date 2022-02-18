// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tasksmodel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class tasksAdapter extends TypeAdapter<tasks> {
  @override
  final int typeId = 0;

  @override
  tasks read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return tasks()
      ..title = fields[0] as String
      ..titledesc = fields[1] as String
      ..deadline = fields[2] as DateTime;
  }

  @override
  void write(BinaryWriter writer, tasks obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.titledesc)
      ..writeByte(2)
      ..write(obj.deadline);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is tasksAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
