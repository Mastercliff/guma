// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'compiler.model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CompilerModelAdapter extends TypeAdapter<CompilerModel> {
  @override
  final int typeId = 2;

  @override
  CompilerModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CompilerModel(
      name: fields[0] as String?,
      command: fields[1] as String?,
      ext: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, CompilerModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.command)
      ..writeByte(2)
      ..write(obj.ext);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CompilerModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
