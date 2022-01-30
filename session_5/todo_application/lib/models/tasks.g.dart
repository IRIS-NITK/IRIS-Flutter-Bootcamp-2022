// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tasks.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TasksAdapter extends TypeAdapter<Tasks> {
  @override
  final int typeId = 2;

  @override
  Tasks read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Tasks(
      title: fields[0] as String?,
      isDone: fields[1] as bool?,
      listIndex: fields[2] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, Tasks obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.isDone)
      ..writeByte(2)
      ..write(obj.listIndex);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TasksAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
