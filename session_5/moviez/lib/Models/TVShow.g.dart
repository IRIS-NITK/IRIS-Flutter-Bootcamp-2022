// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TVShow.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TVShowsAdapter extends TypeAdapter<TVShows> {
  @override
  final int typeId = 1;

  @override
  TVShows read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TVShows(
      title: fields[0] as String,
      imdb: fields[1] as String,
      year: fields[2] as String,
      image: fields[3] as String,
      showId: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, TVShows obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.imdb)
      ..writeByte(2)
      ..write(obj.year)
      ..writeByte(3)
      ..write(obj.image)
      ..writeByte(4)
      ..write(obj.showId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TVShowsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
