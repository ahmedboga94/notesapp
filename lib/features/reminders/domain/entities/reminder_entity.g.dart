// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reminder_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ReminderEntityAdapter extends TypeAdapter<ReminderEntity> {
  @override
  final int typeId = 1;

  @override
  ReminderEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ReminderEntity(
      title: fields[0] as String,
      subTitle: fields[1] as String,
      dateTime: fields[2] as String,
      color: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, ReminderEntity obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.subTitle)
      ..writeByte(2)
      ..write(obj.dateTime)
      ..writeByte(3)
      ..write(obj.color);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReminderEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
