// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TasksAdapter extends TypeAdapter<Tasks> {
  @override
  final int typeId = 0;

  @override
  Tasks read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Tasks(
      name: fields[0] as String,
      dt: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Tasks obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.dt);
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
