// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trust_profile_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TrustProfileModelAdapter extends TypeAdapter<TrustProfileModel> {
  @override
  final int typeId = 2;

  @override
  TrustProfileModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TrustProfileModel(
      trustName: fields[0] as String?,
      phoneNumber: fields[1] as String?,
      email: fields[2] as String?,
      careTakerName: fields[3] as String?,
      forWhom: fields[4] as String?,
      category: fields[5] as String?,
      doctorCount: fields[6] as String?,
      vehicleCount: fields[7] as String?,
      address1: fields[8] as String?,
      city: fields[9] as String?,
      pinCode: fields[10] as String?,
      accountNumber: fields[11] as String?,
      base64String: fields[12] as String?,
      password: fields[13] as String?,
      confirmPassword: fields[14] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, TrustProfileModel obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.trustName)
      ..writeByte(1)
      ..write(obj.phoneNumber)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.careTakerName)
      ..writeByte(4)
      ..write(obj.forWhom)
      ..writeByte(5)
      ..write(obj.category)
      ..writeByte(6)
      ..write(obj.doctorCount)
      ..writeByte(7)
      ..write(obj.vehicleCount)
      ..writeByte(8)
      ..write(obj.address1)
      ..writeByte(9)
      ..write(obj.city)
      ..writeByte(10)
      ..write(obj.pinCode)
      ..writeByte(11)
      ..write(obj.accountNumber)
      ..writeByte(12)
      ..write(obj.base64String)
      ..writeByte(13)
      ..write(obj.password)
      ..writeByte(14)
      ..write(obj.confirmPassword);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TrustProfileModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
