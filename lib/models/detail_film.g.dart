// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_film.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DetailFilmAdapter extends TypeAdapter<DetailFilm> {
  @override
  final int typeId = 0;

  @override
  DetailFilm read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DetailFilm(
      id: fields[0] as int,
      url: fields[1] as String,
      name: fields[2] as String,
      genres: (fields[3] as List).cast<String>(),
      rating: fields[4] as double,
      summary: fields[5] as String,
      imgUrl: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, DetailFilm obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.url)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.genres)
      ..writeByte(4)
      ..write(obj.rating)
      ..writeByte(5)
      ..write(obj.summary)
      ..writeByte(6)
      ..write(obj.imgUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DetailFilmAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
