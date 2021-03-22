import 'dart:convert';
import 'dart:io';

import 'package:guma/controllers/database.controller.dart';
import 'package:guma/models/compilers/compiler.model.dart';
import 'package:guma/models/notes/notes.model.dart';
import 'package:path_provider/path_provider.dart';

class NotesController {
  add(NotesModel model) {
    DatabaseController.instance.notesBox!.add(model);
  }

  getAll() {
    Iterable values = DatabaseController.instance.notesBox!.values;

    return values.toList();
  }

  runCell(NotesCell cell, CompilerModel? compiler, setState) async {
    String dir = (await getTemporaryDirectory()).path;

    File temp = new File('$dir/temp.${compiler!.ext}');

    await temp.writeAsBytes(utf8.encode(cell.value!));
    Process.run('${compiler.command}', ['$dir/temp.${compiler.ext}'])
        .then((value) {
      print(value.exitCode);
      if (value.stdout != '') {
        setState(() {
          cell.scriptResult = value.stdout + "\nExit code ${value.exitCode}";
        });
      } else {
        setState(() {
          cell.scriptResult = value.stderr + "\nExit code ${value.exitCode}";
        });
      }
    });
  }

  deleteBox() async {
    await DatabaseController.instance.notesBox!.deleteFromDisk();
  }
}
