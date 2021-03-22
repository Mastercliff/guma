import 'package:flutter/material.dart';
import 'package:guma/controllers/database.controller.dart';
import 'package:guma/styles/colors.dart';

class SplashView extends StatefulWidget {
  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  bool isLoading = true;
  @override
  void initState() {
    super.initState();

    DatabaseController.instance.init().then(
      (value) {
        if (value == true) {
          Navigator.restorablePushNamedAndRemoveUntil(
            context,
            '/home',
            (route) => false,
          );
        } else {
          setState(() {
            isLoading = false;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isLoading
                ? CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.white),
                  )
                : Text(
                    "Não foi possível inicializar as configurações",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
