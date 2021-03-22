import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guma/controllers/compilers.controller.dart';
import 'package:guma/models/compilers/compiler.model.dart';

CompilersController compilersController = CompilersController();

Widget compilersModel(CompilerModel compiler, setState) {
  return Material(
    color: Colors.grey[900],
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(6),
      side: BorderSide(color: Colors.white12),
    ),
    elevation: 1,
    child: Padding(
      padding: EdgeInsets.all(15),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(
              compiler.name!,
              style: GoogleFonts.nunito(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              compiler.command!,
              style: GoogleFonts.nunito(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              "${compiler.ext}",
              style: GoogleFonts.nunito(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
          ),
          TextButton(
            child: Icon(
              Icons.remove,
              color: Colors.white,
            ),
            onPressed: () {
              compiler.delete();
              setState(() {});
            },
          )
        ],
      ),
    ),
  );
}

Widget buildInserNewComipler() {
  compilersController = CompilersController();
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
    child: Material(
      borderRadius: BorderRadius.circular(6),
      color: Colors.transparent,
      child: Padding(
        padding: EdgeInsets.all(17),
        child: Form(
          key: compilersController.formKey,
          child: Row(
            children: [
              Flexible(
                child: TextFormField(
                  onSaved: compilersController.name,
                  decoration: InputDecoration(
                    fillColor: Colors.grey[900],
                    filled: true,
                    hintText: 'Nome',
                    hintStyle: TextStyle(color: Colors.white38),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: Colors.white38),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: Colors.white60),
                    ),
                  ),
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                  validator: (value) {
                    for (CompilerModel comp in CompilersController().getAll()) {
                      if (value == comp.name) {
                        return 'Este nome já existe';
                      }
                    }
                    if (value!.isEmpty) {
                      return 'Insira o nome';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(width: 40),
              Flexible(
                child: TextFormField(
                  onSaved: compilersController.command,
                  decoration: InputDecoration(
                    fillColor: Colors.grey[900],
                    filled: true,
                    hintText: 'Comando',
                    hintStyle: TextStyle(color: Colors.white38),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: Colors.white38),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: Colors.white60),
                    ),
                  ),
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Insira o comando';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(width: 40),
              Flexible(
                child: TextFormField(
                  onSaved: compilersController.ext,
                  decoration: InputDecoration(
                    fillColor: Colors.grey[900],
                    filled: true,
                    hintText: 'Extensão',
                    hintStyle: TextStyle(color: Colors.white38),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: Colors.white38),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: Colors.white60),
                    ),
                  ),
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Insira a extensão';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
