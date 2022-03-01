// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'partner_information_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PartnerInformationResponseAdapter
    extends TypeAdapter<PartnerInformationResponse> {
  @override
  final int typeId = 0;

  @override
  PartnerInformationResponse read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PartnerInformationResponse(
      bus: fields[0] as Bus,
      drivers: (fields[1] as List)?.cast<Drivers>(),
      device: fields[2] as Device,
    );
  }

  @override
  void write(BinaryWriter writer, PartnerInformationResponse obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.bus)
      ..writeByte(1)
      ..write(obj.drivers)
      ..writeByte(2)
      ..write(obj.device);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PartnerInformationResponseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class BusAdapter extends TypeAdapter<Bus> {
  @override
  final int typeId = 1;

  @override
  Bus read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Bus(
      id: fields[0] as String,
      matricula: fields[1] as String,
      operator: fields[2] as Operator,
    );
  }

  @override
  void write(BinaryWriter writer, Bus obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.matricula)
      ..writeByte(2)
      ..write(obj.operator);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class OperatorAdapter extends TypeAdapter<Operator> {
  @override
  final int typeId = 2;

  @override
  Operator read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Operator(
      id: fields[0] as String,
      name: fields[1] as String,
      operatorType: fields[2] as String,
      transportType: fields[3] as String,
      enableManualRate: fields[4] as bool,
      priceNormal: fields[5] as int,
      priceSpecial: fields[6] as int,
      rates: (fields[7] as List)?.cast<Rates>(),
    );
  }

  @override
  void write(BinaryWriter writer, Operator obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.operatorType)
      ..writeByte(3)
      ..write(obj.transportType)
      ..writeByte(4)
      ..write(obj.enableManualRate)
      ..writeByte(5)
      ..write(obj.priceNormal)
      ..writeByte(6)
      ..write(obj.priceSpecial)
      ..writeByte(7)
      ..write(obj.rates);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OperatorAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class RatesAdapter extends TypeAdapter<Rates> {
  @override
  final int typeId = 3;

  @override
  Rates read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Rates(
      description: fields[0] as String,
      price: fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Rates obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.description)
      ..writeByte(1)
      ..write(obj.price);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RatesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DriversAdapter extends TypeAdapter<Drivers> {
  @override
  final int typeId = 4;

  @override
  Drivers read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Drivers(
      id: fields[0] as String,
      names: fields[1] as String,
      lastNames: fields[2] as String,
      photoUrl: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Drivers obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.names)
      ..writeByte(2)
      ..write(obj.lastNames)
      ..writeByte(3)
      ..write(obj.photoUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DriversAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DeviceAdapter extends TypeAdapter<Device> {
  @override
  final int typeId = 5;

  @override
  Device read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Device(
      id: fields[0] as String,
      mac: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Device obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.mac);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DeviceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
