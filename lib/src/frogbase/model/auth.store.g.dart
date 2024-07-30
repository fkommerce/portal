// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth.store.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AuthStoreAdapter extends TypeAdapter<AuthStore> {
  @override
  final int typeId = 4;

  @override
  AuthStore read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AuthStore(
      storeId: fields[0] as String,
      managementId: fields[1] as String,
      accessToken: fields[2] as String,
      refreshToken: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, AuthStore obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.storeId)
      ..writeByte(1)
      ..write(obj.managementId)
      ..writeByte(2)
      ..write(obj.accessToken)
      ..writeByte(3)
      ..write(obj.refreshToken);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthStoreAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
