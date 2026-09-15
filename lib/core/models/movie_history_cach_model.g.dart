// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_history_cach_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MovieCacheModelAdapter extends TypeAdapter<MovieCacheModel> {
  @override
  final int typeId = 1;

  @override
  MovieCacheModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MovieCacheModel(
      id: fields[0] as int,
      rating: fields[2] as double,
      image: fields[1] as String,
      openAt: fields[3] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, MovieCacheModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.image)
      ..writeByte(2)
      ..write(obj.rating)
      ..writeByte(3)
      ..write(obj.openAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MovieCacheModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
