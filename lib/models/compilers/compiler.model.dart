import 'package:hive/hive.dart';

part 'compiler.model.g.dart';

@HiveType(typeId: 2)
class CompilerModel extends HiveObject {
  @HiveField(0)
  String? name;

  @HiveField(1)
  String? command;

  @HiveField(2)
  String? ext;

  static init() {
    Hive.registerAdapter(CompilerModelAdapter());
  }

  CompilerModel({this.name, this.command, this.ext});
}
