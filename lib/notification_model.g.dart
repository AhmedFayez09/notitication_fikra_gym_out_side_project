// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NotificationModelAdapter extends TypeAdapter<NotificationModel> {
  @override
  final int typeId = 1;

  @override
  NotificationModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NotificationModel(
      id: fields[0] as String?,
      sendType: fields[1] as String?,
      title: fields[2] as String?,
      text: fields[3] as String?,
      url: fields[4] as String?,
      imageFullLink: fields[5] as String?,
      activeFromDate: fields[6] as String?,
      activeToDate: fields[7] as String?,
      active: fields[8] as String?,
      warehousesIds: (fields[9] as List?)?.cast<String>(),
      repeated: fields[10] as String?,
      imageBase64: fields[12] as String?,
      isDeleted: fields[11] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, NotificationModel obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.sendType)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.text)
      ..writeByte(4)
      ..write(obj.url)
      ..writeByte(5)
      ..write(obj.imageFullLink)
      ..writeByte(6)
      ..write(obj.activeFromDate)
      ..writeByte(7)
      ..write(obj.activeToDate)
      ..writeByte(8)
      ..write(obj.active)
      ..writeByte(9)
      ..write(obj.warehousesIds)
      ..writeByte(10)
      ..write(obj.repeated)
      ..writeByte(11)
      ..write(obj.isDeleted)
      ..writeByte(12)
      ..write(obj.imageBase64);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotificationModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
