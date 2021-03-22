import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guma/styles/colors.dart';
import 'package:guma/views/home/widgets/home.widgets.dart';
import 'package:guma/views/notes/notes.view.dart';
import 'package:guma/views/settings/settings.view.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

List tabSelected = [
  true,
  false,
];

PageController pageController = PageController(initialPage: 0);

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    List titles = [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: ElevatedButton.icon(
              icon: Icon(Icons.add, color: Colors.black.withOpacity(0.7)),
              label: Text(
                "Novo Bloco",
                style: TextStyle(
                  color: Colors.black.withOpacity(0.7),
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(
                  primary: Colors.greenAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  elevation: 6,
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 18)),
              onPressed: () async {
                await addNewBlock(context);
                setState(() {});
              },
            ),
          ),
        ],
      ),
      Text(
        "Configurações",
        style: GoogleFonts.nunito(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
    ];
    int pos = 0;
    try {
      pos = pageController.page!.round();
    } catch (e) {
      pos = 0;
    }
    return Scaffold(
      backgroundColor: CustomColors.primaryColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: CustomColors.primaryColor,
        elevation: 0,
        title: titles[pos],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 90),
                child: PageView(
                  controller: pageController,
                  allowImplicitScrolling: false,
                  children: [
                    Center(child: NotesView()),
                    SettingsView(),
                  ],
                  onPageChanged: (index) {
                    tabSelected.setAll(0, [false, false]);
                    setState(() {
                      tabSelected[index] = true;
                    });
                  },
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Column(
                          children: [
                            barButtonModel(
                              'NOTAS',
                              Icons.notes_rounded,
                              tabSelected[0],
                              () {
                                pageController.jumpToPage(0);
                              },
                            ),
                            barButtonModel(
                              'AJUSTES',
                              Icons.settings,
                              tabSelected[1],
                              () {
                                pageController.jumpToPage(1);
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
