// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'locale_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LocaleProfileAdapter extends TypeAdapter<LocaleProfile> {
  @override
  final int typeId = 1;

  @override
  LocaleProfile read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return LocaleProfile.bengali;
      case 1:
        return LocaleProfile.english;
      default:
        return LocaleProfile.bengali;
    }
  }

  @override
  void write(BinaryWriter writer, LocaleProfile obj) {
    switch (obj) {
      case LocaleProfile.bengali:
        writer.writeByte(0);
        break;
      case LocaleProfile.english:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocaleProfileAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
