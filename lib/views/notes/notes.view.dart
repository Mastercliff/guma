import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:guma/controllers/database.controller.dart';
import 'package:guma/controllers/notes.controller.dart';
import 'package:guma/models/notes/notes.model.dart';
import 'package:guma/views/notes/widgets/notes.widget.dart';

class NotesView extends StatefulWidget {
  @override
  _NotesViewState createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: DatabaseController.instance.openNotesBox(),
      builder: (context, snp) {
        if (!snp.hasData) {
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.white),
            ),
          );
        }

        List<NotesModel> notesList = NotesController().getAll();

        return StaggeredGridView.countBuilder(
          primary: true,
          crossAxisCount: 6,
          itemCount: notesList.length,
          itemBuilder: (BuildContext context, int index) {
            NotesModel note = notesList[index];
            return Draggable(
              data: index,
              child: DragTarget(
                builder: (context, conInt, reject) {
                  return NoteBlockWidget(note);
                },
                onAccept: (data) {
                  print("Receive");
                },
              ),
              feedback: RotationTransition(
                turns: AlwaysStoppedAnimation(5 / 360),
                child: Container(
                  width: 400,
                  child: NoteBlockWidget(note),
                ),
              ),
              childWhenDragging: Container(
                height: 100,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white30,
                    style: BorderStyle.solid,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            );
          },
          staggeredTileBuilder: (int index) => new StaggeredTile.fit(
            2,
          ),
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        );
      },
    );
  }
}
