import 'package:flutter/cupertino.dart';
import 'package:guma/models/compilers/compiler.model.dart';

import 'database.controller.dart';

class CompilersController {
  CompilerModel compiler = CompilerModel();
  final formKey = GlobalKey<FormState>();

  String name(value) => compiler.name = value;

  String command(value) => compiler.command = value;

  String ext(value) => compiler.ext = value;

  getAll() {
    Iterable values = DatabaseController.instance.compilersBox!.values;

    List items = [CompilerModel(name: 'Texto', command: 'Non', ext: 'txt')];
    items.addAll(values);

    return items;
  }

  add() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      int res = await DatabaseController.instance.compilersBox!.add(compiler);
      if (res > 0) {
        return true;
      }
    }
    return false;
  }
}
