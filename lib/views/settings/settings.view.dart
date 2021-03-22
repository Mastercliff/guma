import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guma/controllers/compilers.controller.dart';
import 'package:guma/controllers/database.controller.dart';
import 'package:guma/models/compilers/compiler.model.dart';
import 'package:guma/views/settings/widgets/settings.widget.dart';

class SettingsView extends StatefulWidget {
  @override
  _SettingsViewState createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  bool addCompilerIsShow = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "Compiladores",
                style: GoogleFonts.nunito(
                  color: Colors.white,
                  fontSize: 17,
                ),
              ),
              SizedBox(
                width: 30,
              ),
              Expanded(
                child: Divider(
                  color: Colors.white24,
                  height: 1,
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    'Nome',
                    style: GoogleFonts.nunito(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    'Comando',
                    style: GoogleFonts.nunito(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    'Extensão',
                    style: GoogleFonts.nunito(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ),
                TextButton(
                  child: Container(),
                  onPressed: () {},
                )
              ],
            ),
          ),
          FutureBuilder(
              future: DatabaseController.instance.openCompilersBox(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(
                          Colors.white70,
                        ),
                        strokeWidth: 3,
                      ),
                    ),
                  );
                }

                List compilersList = CompilersController().getAll();
                return ListView.builder(
                  itemCount: compilersList.length,
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(vertical: 10),
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return Container();
                    }
                    CompilerModel compiler = compilersList[index];
                    return Padding(
                      padding: EdgeInsets.only(bottom: 8),
                      child: compilersModel(compiler, setState),
                    );
                  },
                );
              }),
          addCompilerIsShow ? buildInserNewComipler() : Container(),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  icon: Icon(
                    addCompilerIsShow ? Icons.check : Icons.add,
                    color: Colors.black.withOpacity(0.8),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    primary: Colors.greenAccent,
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 15),
                  ),
                  label: Text(
                    addCompilerIsShow ? "Pronto" : "Adicionar",
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.8),
                    ),
                  ),
                  onPressed: () async {
                    var res = false;
                    addCompilerIsShow
                        ? res = await compilersController.add()
                        : setState(() {
                            addCompilerIsShow = true;
                          });
                    print(res);
                    if (res == true) {
                      setState(() {
                        addCompilerIsShow = false;
                      });
                    }
                  },
                ),
                addCompilerIsShow ? SizedBox(width: 15) : Container(),
                addCompilerIsShow
                    ? ElevatedButton.icon(
                        icon: Icon(
                          Icons.close,
                          color: Colors.black.withOpacity(0.8),
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          primary: Colors.redAccent,
                          padding: EdgeInsets.symmetric(
                              vertical: 16, horizontal: 15),
                        ),
                        label: Text(
                          "Cancelar",
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.8),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            addCompilerIsShow = false;
                          });
                        },
                      )
                    : Container(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
