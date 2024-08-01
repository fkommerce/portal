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
      managementId: fields[0] as String,
      accessToken: fields[1] as String,
      refreshToken: fields[2] as String,
      storeIds: (fields[3] as List).cast<String>(),
      selectedStoreId: fields[4] as String,
      selectedBranchId: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, AuthStore obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.managementId)
      ..writeByte(1)
      ..write(obj.accessToken)
      ..writeByte(2)
      ..write(obj.refreshToken)
      ..writeByte(3)
      ..write(obj.storeIds)
      ..writeByte(4)
      ..write(obj.selectedStoreId)
      ..writeByte(5)
      ..write(obj.selectedBranchId);
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
