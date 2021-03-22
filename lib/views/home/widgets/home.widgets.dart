import 'package:flutter/material.dart';
import 'package:guma/controllers/notes.controller.dart';
import 'package:guma/models/compilers/compiler.model.dart';
import 'package:guma/models/notes/notes.model.dart';
import 'package:guma/styles/colors.dart';

Widget barButtonModel(String title, IconData icon, isSelected, func) {
  return Padding(
    padding: EdgeInsets.only(bottom: 5),
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.grey[900],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
          side: BorderSide(
              color: isSelected
                  ? Colors.greenAccent.withOpacity(0.6)
                  : Colors.transparent,
              width: 2),
        ),
        elevation: 10,
      ),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 18, horizontal: 13),
        child: Icon(
          icon,
          color:
              isSelected ? Colors.greenAccent.withOpacity(0.6) : Colors.white70,
        ),
      ),
      onPressed: func,
    ),
  );
}

addNewBlock(context) async {
  TextEditingController textController = TextEditingController();
  await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
      backgroundColor: CustomColors.primaryColor,
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 10, bottom: 5),
            child: TextFormField(
              controller: textController,
              decoration: InputDecoration.collapsed(
                hintText: "Insira um título",
                hintStyle: TextStyle(
                  fontSize: 17,
                  color: Colors.white60,
                ),
              ),
              style: TextStyle(
                fontSize: 17,
                color: Colors.white60,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 15, bottom: 5),
            child: TextButton.icon(
              icon: Icon(
                Icons.create_new_folder_outlined,
                color: Colors.greenAccent,
              ),
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
              ),
              label: Text(
                "Criar",
                style: TextStyle(
                  color: Colors.greenAccent,
                ),
              ),
              onPressed: () {
                NotesController().add(
                  NotesModel(
                    title: textController.text,
                    cells: [],
                    colorSet: 0,
                    compiler: CompilerModel(
                      name: 'Texto',
                      command: 'Non',
                      ext: 'txt',
                    ),
                  ),
                );
                Navigator.pop(context);
              },
            ),
          )
        ],
      ),
    ),
  );
}
