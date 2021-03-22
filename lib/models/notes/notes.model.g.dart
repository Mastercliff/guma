// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notes.model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NotesModelAdapter extends TypeAdapter<NotesModel> {
  @override
  final int typeId = 0;

  @override
  NotesModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NotesModel(
      title: fields[0] as String?,
      cells: (fields[1] as List?)?.cast<NotesCell>(),
      colorSet: fields[2] as int?,
      compiler: fields[3] as CompilerModel?,
    );
  }

  @override
  void write(BinaryWriter writer, NotesModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.cells)
      ..writeByte(2)
      ..write(obj.colorSet)
      ..writeByte(3)
      ..write(obj.compiler);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotesModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class NotesCellAdapter extends TypeAdapter<NotesCell> {
  @override
  final int typeId = 1;

  @override
  NotesCell read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NotesCell(
      value: fields[0] as String?,
      scriptResult: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, NotesCell obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.value)
      ..writeByte(1)
      ..write(obj.scriptResult);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotesCellAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
