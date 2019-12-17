// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EventAdapter extends TypeAdapter<Event> {
  @override
  Event read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Event(
      fields[0] as String,
      fields[1] as bool,
      fields[2] as String,
      fields[3] as String,
      fields[4] as bool,
      fields[5] as int,
      fields[6] as int,
      fields[7] as bool,
      fields[8] as bool,
      fields[9] as bool,
      fields[10] as bool,
      fields[11] as String,
      fields[12] as String,
      (fields[13] as List)?.cast<String>(),
      fields[14] as String,
      fields[15] as String,
      fields[16] as String,
      fields[17] as bool,
    )
      ..dateTime = fields[18] as DateTime
      ..isEvent = fields[19] as bool;
  }

  @override
  void write(BinaryWriter writer, Event obj) {
    writer
      ..writeByte(20)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.hasPrice)
      ..writeByte(2)
      ..write(obj.price)
      ..writeByte(3)
      ..write(obj.city)
      ..writeByte(4)
      ..write(obj.hasAgeRestriction)
      ..writeByte(5)
      ..write(obj.ageRestriction)
      ..writeByte(6)
      ..write(obj.likes)
      ..writeByte(7)
      ..write(obj.isStarred)
      ..writeByte(8)
      ..write(obj.isInviteOnly)
      ..writeByte(9)
      ..write(obj.hasAlcohol)
      ..writeByte(10)
      ..write(obj.byob)
      ..writeByte(11)
      ..write(obj.genre)
      ..writeByte(12)
      ..write(obj.venue)
      ..writeByte(13)
      ..write(obj.dj)
      ..writeByte(14)
      ..write(obj.faq)
      ..writeByte(15)
      ..write(obj.description)
      ..writeByte(16)
      ..write(obj.imageURL)
      ..writeByte(17)
      ..write(obj.verified)
      ..writeByte(18)
      ..write(obj.dateTime)
      ..writeByte(19)
      ..write(obj.isEvent);
  }
}
