// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'club_details.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ClubAdapter extends TypeAdapter<Club> {
  @override
  Club read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Club(
      fields[0] as String,
      fields[1] as String,
      fields[2] as String,
      fields[3] as bool,
      fields[4] as String,
      fields[5] as bool,
      fields[6] as bool,
      fields[9] as String,
      fields[7] as String,
      fields[8] as bool,
    )..isEvent = fields[10] as bool;
  }

  @override
  void write(BinaryWriter writer, Club obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.faq)
      ..writeByte(3)
      ..write(obj.hasGuestList)
      ..writeByte(4)
      ..write(obj.imageURL)
      ..writeByte(5)
      ..write(obj.isStarred)
      ..writeByte(6)
      ..write(obj.hasEntryFee)
      ..writeByte(7)
      ..write(obj.city)
      ..writeByte(8)
      ..write(obj.verified)
      ..writeByte(9)
      ..write(obj.entryFee)
      ..writeByte(10)
      ..write(obj.isEvent);
  }
}
