import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lecteur_bible/models/preferences.dart';
import 'package:lecteur_bible/models/themes.dart';
import 'package:lecteur_bible/calendrier/calendrier.dart';

import '../models/lire_bible.dart';

class Parametre extends StatefulWidget {
  const Parametre({Key? key}) : super(key: key);

  @override
  State<Parametre> createState() => _ParametreState();
}

class _ParametreState extends State<Parametre> {
  @override
  void initState() {
    //versionsList[2].available = true;
    super.initState();
  }

  bool fontFamilyVisibility = false;
  bool versionsVisibility = false;
  bool modified = false;

  @override
  Widget build(BuildContext context) {
    double largeur = MediaQuery.of(context).size.width;
    double hauteur = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
          backgroundColor: themeAppBarColor,
          title: Text(
            "Paramètre",
            style: TextStyle(color: appBarTitleColor),
          )),
      //drawer : mybody(),
      body: WillPopScope(
        onWillPop: () => _onWillPop(),
        child: Container(
          constraints: const BoxConstraints.expand(),
          padding: const EdgeInsets.symmetric(horizontal: 15),
          color: themeFontColor,
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: <
              Widget>[
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: themeFontColor,
                  boxShadow: const [BoxShadow(spreadRadius: 1, blurRadius: 2)],
                  borderRadius:
                      const BorderRadius.vertical(bottom: Radius.circular(10))),
              height: hauteur > largeur ? 150 : 80,
              child: SingleChildScrollView(
                child: FutureBuilder<BibleClass>(
                  future: setTestament(bibleVersion.path),
                  builder: (context, snapshot) {
                    Widget testText =
                        const Center(child: CircularProgressIndicator());
                    if (snapshot.hasData) {
                      List<Verses> passagesVerses = snapshot
                          .data!
                          .listTestaments![0]
                          .listBooks![0]
                          .listChapters![0]
                          .listVerses!
                          .sublist(0, 4);
                      testText = Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:
                              List.generate(passagesVerses.length, (index) {
                            return RichText(
                              text: TextSpan(children: [
                                WidgetSpan(
                                    child: Container(
                                  //color: Colors.red,
                                  padding: const EdgeInsets.all(0),
                                  child: Text(
                                    passagesVerses[index].id.toString(),
                                    style: TextStyle(
                                        fontFamily: fontFamily,
                                        color: Colors.blueAccent,
                                        fontWeight: FontWeight.w500,
                                        fontSize: policeSize),
                                  ),
                                )),
                                const TextSpan(text: "  "),
                                TextSpan(
                                  text: passagesVerses[index].text,
                                  style: TextStyle(
                                      fontFamily: fontFamily,
                                      fontSize: policeSize,
                                      color: bibleTextColor),
                                ),
                              ]),
                            );
                          }));
                    }
                    return testText;
                  },
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 15),
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 1,
                              color: const Color.fromARGB(255, 161, 159, 159)),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Thème Sombre",
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                color: themeTextColor),
                          ),
                          Switch(
                            value: darkMode,
                            onChanged: (value) {
                              setState(() {
                                darkMode = value;
                                modified = true;
                                reloadTheme();
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          versionsVisibility = !versionsVisibility;
                          fontFamilyVisibility = false;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 1,
                                color:
                                    const Color.fromARGB(255, 161, 159, 159)),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10))),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Version de Bible",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500,
                                      color: themeTextColor),
                                ),
                                Text(
                                  bibleVersion.name,
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontStyle: FontStyle.italic,
                                      color: themeTextColor),
                                )
                              ],
                            ),
                            Visibility(
                              visible: versionsVisibility,
                              child: Center(
                                child: SingleChildScrollView(
                                  child: Container(
                                    color: themeFontColor,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: Wrap(
                                        runSpacing: 10,
                                        children: List.generate(
                                            versionsList.length, (index) {
                                          return GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                chooseVersion(index);
                                                versionsList[index].available ==
                                                        true
                                                    ? bibleVersion.name =
                                                        versionsList[index].name
                                                    : bibleVersion.name;
                                                modified = true;
                                              });
                                            },
                                            child: Container(
                                              width: largeur > 350 ? 160 : 140,
                                              height: 40,
                                              margin: const EdgeInsets.only(
                                                  left: 5, right: 5),
                                              decoration: BoxDecoration(
                                                  color: versionsList[index]
                                                              .available ==
                                                          true
                                                      ? Colors.blue
                                                      : Colors.grey,
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  5),
                                                          topRight:
                                                              Radius.circular(
                                                                  15),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  15)),
                                                  boxShadow: const [
                                                    BoxShadow(
                                                        offset: Offset(-2, 2),
                                                        blurRadius: 1,
                                                        spreadRadius: 1)
                                                  ]),
                                              child: Center(
                                                  child: Text(
                                                versionsList[index].name,
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                            ),
                                          );
                                        })),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 1,
                              color: const Color.fromARGB(255, 161, 159, 159)),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10))),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Taille de la police",
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                    color: themeTextColor),
                              ),
                              Text(
                                policeSize.toString(),
                                style: TextStyle(
                                    fontSize: 17,
                                    fontStyle: FontStyle.italic,
                                    color: themeTextColor),
                              )
                            ],
                          ),
                          Slider(
                            value: policeSize,
                            min: 15,
                            max: 45,
                            divisions: 30,
                            onChanged: (value) {
                              setState(() {
                                policeSize = value;
                                addDoubleToSF("policeSize", value);
                                modified = true;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          fontFamilyVisibility = !fontFamilyVisibility;
                          versionsVisibility = false;
                        });
                      },
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1,
                                    color: const Color.fromARGB(
                                        255, 161, 159, 159)),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Police",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500,
                                      color: themeTextColor),
                                ),
                                Text(
                                  fontFamily,
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontStyle: FontStyle.italic,
                                      color: themeTextColor),
                                )
                              ],
                            ),
                          ),
                          Visibility(
                              visible: fontFamilyVisibility,
                              child: Column(
                                children: List.generate(
                                  fontsList.length,
                                  (index) => GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        fontFamily = fontsList[index];
                                      });
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(top: 3),
                                      child: Text(
                                        fontsList[index],
                                        style: TextStyle(
                                            fontSize: 17,
                                            color: themeTextColor,
                                            fontFamily: fontsList[index]),
                                      ),
                                    ),
                                  ),
                                ),
                              ))
                        ],
                      ),
                    ),
                    // Container(
                    //   color: blanc,
                    //   child: RichText(
                    //       text: TextSpan(
                    //           style: TextStyle(fontSize: 18, color: noire),
                    //           children: markdownColor(
                    //               "*Ah Jésus* lui répondit : *Laisse faire maintenant*, car il est convenable que *nous accomplissions ainsi tout ce qui est juste.* Et Jean ne lui résista plus. *Jésus-Christ est vivant. Amen!"))),
                    // )
                  ],
                ),
              ),
            ),
            // Text(
            //   "Jésus-Christ est vivant. Amen!",
            //   style: TextStyle(fontSize: policeSize, fontFamily: "Font1"),
            // ),
            // Text(
            //   "Jésus-Christ est vivant. Amen!",
            //   style: TextStyle(fontSize: policeSize, fontFamily: "Font2"),
            // ),
            // Text(
            //   "Jésus-Christ est vivant. Amen!",
            //   style: TextStyle(fontSize: policeSize, fontFamily: "Font3"),
            // ),
            // Text(
            //   "Jésus-Christ est vivant. Amen!",
            //   style: TextStyle(fontSize: policeSize, fontFamily: "Font4"),
            // ),
            // Text(
            //   "Jésus-Christ est vivant. Amen!",
            //   style: TextStyle(fontSize: policeSize, fontFamily: "Font7"),
            // ),
            // Text(
            //   "Jésus-Christ est vivant. Amen!",
            //   style: TextStyle(fontSize: policeSize, fontFamily: "Font8"),
            // ),
            // Text(
            //   "Jésus-Christ est vivant. Amen!",
            //   style: TextStyle(fontSize: policeSize, fontFamily: "Font10"),
            // ),
            // Text(
            //   "Jésus-Christ est vivant. Amen!",
            //   style: TextStyle(fontSize: policeSize, fontFamily: "Font11"),
            // ),
            // Text(
            //   "Jésus-Christ est vivant. Amen!",
            //   style: TextStyle(fontSize: policeSize, fontFamily: "Font12"),
            // ),
          ]),
        ),
      ),
    );
  }

  List<InlineSpan> markdownColor(String text) {
    List<InlineSpan> formatedTest = [];
    String toSearch = "*";
    int text2index = -1;

    while (text.contains(toSearch)) {
      String t1 = text.substring(0, text.indexOf(toSearch));
      if (text2index == -1) {
        text2index = text.indexOf(toSearch);
        formatedTest.add(
          TextSpan(text: t1),
        );
      } else {
        String t2 = text.substring(0, text.indexOf(toSearch));
        formatedTest.add(TextSpan(
            text: t2,
            style: const TextStyle(
                color: Colors.red, fontWeight: FontWeight.w500)));

        text2index = -1;
      }
      String t3 = text.substring(text.indexOf(toSearch) + toSearch.length);

      text = t3;
    }
    //formatedTest.add(TextSpan(text: text));
    if (text2index != -1) {
      formatedTest
          .add(TextSpan(text: text, style: TextStyle(color: Colors.red)));
    } else {
      formatedTest.add(TextSpan(text: text));
    }
    print(text2index);

    return formatedTest;
  }

  void chooseVersion(int index) {
    switch (index) {
      case 0:
        addIntToSF("bibleVersion", 0);
        bibleVersion = versionsList[0];
        break;
      case 1:
        addIntToSF("bibleVersion", 1);
        bibleVersion = versionsList[1];
        break;
      case 2:
        if (versionsList[2].available) {
          //addIntToSF("bibleVersion", 2);
          //bibleVersion = versionsList[2];
        } else {
          commingSoon(context, versionsList[2].name);
        }
        break;
      case 3:
        if (versionsList[3].available) {
          //bibleVersion = versionsList[3];
        } else {
          commingSoon(context, versionsList[3].name);
        }
        break;
      case 4:
        if (versionsList[4].available) {
          //bibleVersion = versionsList[4];
        } else {
          commingSoon(context, versionsList[4].name);
        }
        break;
      case 5:
        if (versionsList[5].available) {
          //bibleVersion = versionsList[5];
        } else {
          commingSoon(context, versionsList[5].name);
        }
        break;
      case 6:
        if (versionsList[6].available) {
          //bibleVersion = versionsList[6];
        } else {
          commingSoon(context, versionsList[6].name);
        }
        break;
      case 7:
        if (versionsList[7].available) {
          //bibleVersion = versionsList[7];
        } else {
          commingSoon(context, versionsList[7].name);
        }
        break;
    }
  }

  Future<BibleClass> setTestament(String fichierJson) async {
    String jsonPage = await rootBundle.loadString(fichierJson);
    final jsonResponse = json.decode(jsonPage);

    return BibleClass.fromJson(jsonResponse);
  }

  Future<bool> _onWillPop() async {
    bool? exitResult;
    if (modified && rechargementCompris == false) {
      exitResult = await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: themeFontColor,
            title:
                Text('Rechargement', style: TextStyle(color: themeTextColor)),
            content: Text("Vous serez redirigé vers la page d'accueil",
                style: TextStyle(color: themeTextColor)),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  rechargementCompris = true;
                  addBoolToSF("rechargementCompris", true);
                  Navigator.of(context).pop();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Calendrier(),
                      ));
                },
                child: const Text("Compris, Ne plus \nafficher ce message",
                    style: TextStyle(fontSize: 17)),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Calendrier(),
                      ));
                },
                child: const Text('Ok', style: TextStyle(fontSize: 17)),
              ),
            ],
          );
        },
      );
    } else {
      exitResult = true;
    }
    return exitResult ?? false;
  }
}

/*
void commingSoon(BuildContext context, String versionName){
  showDialog(
    context: context,
    builder: (context) {
      return _buildNotificationDialog(context, versionName);
    },
  );
}
AlertDialog _buildNotificationDialog(BuildContext context, String versionName) {
  return AlertDialog(
    backgroundColor: themeFontColor,
    title: const Text('Téléchargement', style: TextStyle(color: Colors.blue)),
    content: Text("Les frais de données seront appliqués.Voulez-vous téléchager",
        style: TextStyle(color: themeTextColor, fontSize: 18)),
    actions: <Widget>[
      TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Text('la version $versionName', style: const TextStyle(fontSize: 17)),
      ),
      TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Text("Toutes les versions", style: TextStyle(fontSize: 17)),
      ),
      TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Text("Annuler", style: TextStyle(fontSize: 17)),
      ),
    ],
  );
}
*/

void commingSoon(BuildContext context, String versionName) {
  showDialog(
    context: context,
    builder: (context) {
      return _buildNotificationDialog(context);
    },
  );
  Timer(const Duration(seconds: 2), () {
    Navigator.of(context).pop();
  });
}

WillPopScope _buildNotificationDialog(BuildContext context) {
  return WillPopScope(
    onWillPop: () async {
      return false;
    },
    child: AlertDialog(
      backgroundColor: themeFontColor,
      title: const Text('Bientôt disponible',
          style: TextStyle(color: Colors.blue)),
      content: Text("Fonctionnalité en cours de développement.",
          style: TextStyle(color: themeTextColor, fontSize: 18)),
    ),
  );
}

List fontsList = [
  "Roboto",
  "Font1",
  "Font2",
  "Font3",
  "Font4",
  "Font7",
  "Font8",
  "Font9",
  "Font10",
  "Font11",
  "Font12",
];
