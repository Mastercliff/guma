import 'package:hive/hive.dart';
import 'package:guma/models/compilers/compiler.model.dart';
import 'package:guma/models/notes/notes.model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DatabaseController {
  DatabaseController._privateConstructor();

  static final DatabaseController _instance =
      DatabaseController._privateConstructor();

  static DatabaseController get instance => _instance;

  Box? notesBox;
  Box? compilersBox;

  Future init() async {
    try {
      await Hive.initFlutter('guma');
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future openNotesBox() async {
    try {
      NotesModel.init();
      notesBox = await Hive.openBox<NotesModel>('blocks');
      await this.openCompilersBox();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future openCompilersBox() async {
    try {
      compilersBox = await Hive.openBox<CompilerModel>('compilers');
      return true;
    } catch (e) {
      return false;
    }
  }
}
