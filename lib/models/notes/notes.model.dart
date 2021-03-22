import 'package:hive/hive.dart';
import 'package:guma/models/compilers/compiler.model.dart';

part 'notes.model.g.dart';

@HiveType(typeId: 0)
class NotesModel extends HiveObject {
  @HiveField(0)
  String? title;

  @HiveField(1)
  List<NotesCell>? cells = [];

  @HiveField(2)
  int? colorSet = 0;

  @HiveField(3)
  CompilerModel? compiler;

  NotesModel({this.title, this.cells, this.colorSet, this.compiler});

  static init() {
    Hive.registerAdapter(NotesModelAdapter());
    Hive.registerAdapter(NotesCellAdapter());
    Hive.registerAdapter(CompilerModelAdapter());
  }
}

@HiveType(typeId: 1)
class NotesCell {
  @HiveField(0)
  String? value;

  @HiveField(1)
  String? scriptResult;

  NotesCell({this.value, this.scriptResult});
}
