// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MoviesAdapter extends TypeAdapter<Movies> {
  @override
  final int typeId = 0;

  @override
  Movies read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Movies(
      title: fields[0] as String,
      imdb: fields[1] as String,
      year: fields[2] as String,
      image: fields[3] as String,
      movieId: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Movies obj) {
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
      ..write(obj.movieId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MoviesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
