import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:guma/controllers/compilers.controller.dart';
import 'package:guma/controllers/notes.controller.dart';
import 'package:guma/models/compilers/compiler.model.dart';
import 'package:guma/models/notes/notes.model.dart';
import 'package:guma/styles/colors.dart';

// ignore: must_be_immutable
class NoteBlockWidget extends StatefulWidget {
  NotesModel note;
  bool isEditing = false;
  NoteBlockWidget(this.note);
  dynamic? textActCompiler;
  @override
  _NoteBlockWidgetState createState() => _NoteBlockWidgetState();
}

class _NoteBlockWidgetState extends State<NoteBlockWidget> {
  TextEditingController textController = TextEditingController();
  FocusNode focusNode = FocusNode();
  Color? background;
  Color? normalText;
  @override
  void initState() {
    super.initState();
    bool init = false;
    List tempList = CompilersController().getAll();
    for (CompilerModel? comp in tempList) {
      if (widget.note.compiler!.name == comp!.name) {
        init = true;
      }
    }
    if (init == false) {
      widget.note.compiler = tempList[0];
      widget.note.save();
    }
  }

  @override
  Widget build(BuildContext context) {
    background = CustomColors.colorsSets[widget.note.colorSet!]['primary'];
    normalText = CustomColors.colorsSets[widget.note.colorSet!]['normal_text'];

    return Material(
      color: background,
      borderRadius: BorderRadius.circular(6),
      elevation: 5,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: TextFormField(
                      initialValue: "${widget.note.title}",
                      onFieldSubmitted: (value) {
                        widget.note.title = value;
                        widget.note.save();
                        setState(() {});
                      },
                      decoration: InputDecoration.collapsed(
                        hintText: "Insira um título",
                        hintStyle: TextStyle(
                          fontSize: 17,
                          color: normalText,
                        ),
                      ),
                      style: TextStyle(
                        fontSize: 17,
                        color: normalText,
                      ),
                    ),
                  ),
                  Container(
                    height: 35,
                    child: Material(
                      elevation: 0,
                      color: Colors.grey[900],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: BorderSide(
                            color: Colors.white12,
                          )),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: DropdownButton(
                          value: widget.note.compiler!.name,
                          dropdownColor: Colors.grey[900],
                          underline: Container(),
                          icon: Icon(
                            Icons.memory_rounded,
                            color: Colors.white70,
                          ),
                          style: GoogleFonts.firaMono(
                            color: Colors.white70,
                          ),
                          items: CompilersController()
                              .getAll()
                              .map<DropdownMenuItem<String>>((e) {
                            return DropdownMenuItem<String>(
                              value: e.name,
                              child: Text(
                                "${e.name}",
                                style: GoogleFonts.firaMono(
                                  color: Colors.white70,
                                ),
                              ),
                              onTap: () {
                                print(e);
                              },
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            for (CompilerModel? comp
                                in CompilersController().getAll()) {
                              if (value == comp!.name) {
                                widget.note.compiler = comp;
                                widget.note.save();
                              }
                            }
                            setState(() {});
                          },
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.delete_outline_rounded,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            backgroundColor: CustomColors.primaryColor,
                            title: Text(
                              "Deseja mesmo apagar este item?",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            actionsPadding: EdgeInsets.symmetric(vertical: 20),
                            actions: [
                              TextButton(
                                child: Text(
                                  "Sim",
                                  style: TextStyle(
                                    color: Colors.redAccent,
                                  ),
                                ),
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 0, vertical: 13),
                                ),
                                onPressed: () {
                                  widget.note.delete();
                                  Navigator.pushNamedAndRemoveUntil(
                                      context, '/home', (route) => false);
                                },
                              ),
                              TextButton(
                                child: Text(
                                  "Não",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 0, vertical: 13),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.more_vert,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
              ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(vertical: 5),
                itemCount: widget.note.cells!.length,
                itemBuilder: (context, int index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 8),
                    child: this.buildCell(index),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Flexible(
                      child: TextField(
                        minLines: 1,
                        maxLines: 25,
                        onChanged: (value) {
                          setState(() {});
                        },
                        controller: textController,
                        decoration: InputDecoration(
                          hintText: "Adicione Algo...",
                          hintStyle: TextStyle(
                            fontSize: 16,
                            color: normalText,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: BorderSide(
                              color: Colors.transparent,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: BorderSide(
                              color: Colors.greenAccent.withOpacity(0.5),
                            ),
                          ),
                        ),
                        style: TextStyle(
                          fontSize: 16,
                          color: normalText,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    textController.text == ''
                        ? Container()
                        : Padding(
                            padding: EdgeInsets.only(bottom: 8),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.greenAccent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 18, horizontal: 20)),
                              child: Text(
                                "Pronto",
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              onPressed: () {
                                String value = textController.text;
                                textController.text = '';
                                List e = widget.note.cells!;
                                widget.note.cells = [];

                                for (var item in e) {
                                  widget.note.cells!.add(item);
                                }
                                widget.note.cells!.add(NotesCell(value: value));
                                widget.note.save();
                                setState(() {});
                              },
                            ),
                          ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCell(int index) {
    Widget textInsert() {
      return TextFormField(
        onChanged: (value) {
          widget.note.cells![index].value = value;
          widget.note.save();
          setState(() {});
        },
        onTap: () {
          print("Tou");
        },
        onEditingComplete: () {
          print("Complete");
        },
        initialValue: widget.note.cells![index].value!,
        minLines: 1,
        maxLines: 25,
        decoration: InputDecoration(
          hintText: "Escreva...",
          hintStyle: widget.note.compiler!.name == 'Texto'
              ? GoogleFonts.nunitoSans(
                  fontSize: 16,
                  color: normalText,
                )
              : GoogleFonts.firaMono(
                  fontSize: 14,
                  color: normalText,
                ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide(
              color: Colors.transparent,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide(
              color: Colors.greenAccent.withOpacity(0.5),
            ),
          ),
        ),
        style: widget.note.compiler!.name == 'Texto'
            ? GoogleFonts.nunitoSans(
                fontSize: 16,
                color: normalText,
              )
            : GoogleFonts.firaMono(
                fontSize: 14,
                color: normalText,
              ),
      );
    }

    return GestureDetector(
      child: Row(
        children: [
          widget.note.compiler!.name == 'Texto'
              ? Container()
              : TextButton(
                  child: Icon(
                    Icons.play_circle_outline_rounded,
                    color: Colors.white70,
                  ),
                  style: TextButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 0, vertical: 15)),
                  onPressed: () async {
                    await NotesController().runCell(
                      widget.note.cells![index],
                      widget.note.compiler,
                      setState,
                    );
                  },
                ),
          SizedBox(
            width: 8,
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Material(
                  color: widget.note.compiler!.name == 'Texto'
                      ? background
                      : CustomColors.colorsSets[widget.note.colorSet!]['card'],
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                    side: BorderSide(color: Colors.white12),
                  ),
                  child: textInsert(),
                ),
                widget.note.cells![index].scriptResult == null
                    ? Container()
                    : SizedBox(
                        height: 10,
                      ),
                widget.note.cells![index].scriptResult == null
                    ? Container()
                    : this.buildResultScript(index)
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildResultScript(int index) {
    String? scriptText = widget.note.cells![index].scriptResult;
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Material(
                color: scriptText!.substring(scriptText.length - 1) == '0'
                    ? Colors.greenAccent.withOpacity(0.3)
                    : Colors.redAccent.withOpacity(0.3),
                elevation: 4,
                borderRadius: BorderRadius.circular(5),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    widget.note.cells![index].scriptResult!,
                    style: GoogleFonts.firaMono(
                      fontSize: 14,
                      color: normalText,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Positioned(
          right: 1,
          top: 1,
          child: IconButton(
            icon: Icon(
              Icons.close,
              size: 20,
            ),
            color: Colors.white38,
            onPressed: () {
              widget.note.cells![index].scriptResult = null;
              widget.note.save();
              setState(() {});
            },
          ),
        )
      ],
    );
  }

  buildTodoCell(NotesCell cell) {
    return Material(
      color: widget.note.compiler!.name == 'Texto'
          ? background
          : CustomColors.colorsSets[widget.note.colorSet!]['card'],
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
        side: BorderSide(color: Colors.white12),
      ),
      child: ListView.builder(
        itemCount: 0,
        itemBuilder: (context, index) => Container(),
      ),
    );
  }
}
