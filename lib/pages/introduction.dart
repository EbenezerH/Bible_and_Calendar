import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lecteur_bible/models/themes.dart';
import 'package:lecteur_bible/calendrier/calendrier.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Introduction extends StatefulWidget {
  const Introduction({Key? key}) : super(key: key);

  @override
  State<Introduction> createState() => _IntroductionState();
}

class _IntroductionState extends State<Introduction> {
  @override
  void initState() {
    getPreferences();
    Timer(const Duration(milliseconds: 2000), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const Calendrier(),
          ));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    checkSystemTheme(context);

    return Container(
      color: const Color.fromARGB(255, 3, 17, 94),
      child: Center(
        child: Container(
          height: 100,
          width: 140,
          decoration: const BoxDecoration(
              //border: Border.all(width: 2, color: Colors.red),
              borderRadius: BorderRadius.all(Radius.circular(20)),
              image: DecorationImage(
                  image: AssetImage("assets/images/icone.jpg"))),
        ),
      ),
    );
  }

  void getPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    double? policeSizeShare = prefs.getDouble("policeSize");
    policeSizeShare == null ? policeSize = 18 : policeSize = policeSizeShare;

    int? bibleVersionIndex = prefs.getInt("bibleVersion");
    bibleVersionIndex == null
        ? bibleVersion = versionsList[0]
        : bibleVersion = versionsList[bibleVersionIndex];

    bool? rechargementComprisShare = prefs.getBool("rechargementCompris");
    rechargementComprisShare == null
        ? rechargementCompris = false
        : rechargementCompris = rechargementComprisShare;
  }
}
