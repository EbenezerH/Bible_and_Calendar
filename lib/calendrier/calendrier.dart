import 'dart:convert';
import 'package:lecteur_bible/models/lire_bible.dart';
import 'package:lecteur_bible/models/lirepassage.dart';
import 'package:lecteur_bible/calendrier/mois.dart';
import 'package:flutter/material.dart';
import 'package:lecteur_bible/models/themes.dart';
import 'package:flutter/services.dart';
import 'package:lecteur_bible/widgets/my_drawer.dart';

import '../bible/bible.dart';

class Calendrier extends StatefulWidget {
  const Calendrier({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _EcranAccueilEtat createState() => _EcranAccueilEtat();
}

class _EcranAccueilEtat extends State<Calendrier> {
  @override
  void initState() {
    //setTestament(versionBible);
    super.initState();
  }

  String? ancientest1;
  String? ancientest2;
  String? nouveautest;
  BibleClass bibleClass = BibleClass();
  List<Books> allBooks = [];
  double hauteur = 0;
  double largeur = 0;

  @override
  Widget build(BuildContext context) {
    final double hauteur = MediaQuery.of(context).size.height;
    final double largeur = MediaQuery.of(context).size.width;
    setState(() {
      largeur;
      hauteur;
    });

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: myappbar("CBAF APB"),
      drawer: const MyDrawer(),
      body: WillPopScope(
        onWillPop: () => _onWillPop(context, _buildExitDialog(context)),
        child: SizedBox(
          height: hauteur / 1.11,
          child: DecoratedBox(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(imfontp), fit: BoxFit.cover),
            ),
            child: Container(
              color: darkMode == true ? Colors.black54 : Colors.black12,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      color: parentBgColor,
                      height: dateSize * 1.5,
                      width: largeur / 1.02,
                      margin: const EdgeInsets.only(bottom: 10, right: 15),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              color: childBgColor,
                              child: Text(
                                formatDate(),
                                style: TextStyle(
                                    color: bibleTextColor,
                                    fontSize: dateSize,
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FontStyle.italic),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ]),
                    ),
                    Expanded(
                      flex: 19,
                      child: Container(
                        width: largeur / 1.02,
                        margin: const EdgeInsets.only(bottom: 10, top: 5),
                        color: titleBgColor,
                        child: Center(
                            child: FutureBuilder<Object>(
                                future: setTestament(bibleVersion.path),
                                builder: (context, snapshot) {
                                  Widget myWidget =
                                      const CircularProgressIndicator();

                                  if (snapshot.hasData) {
                                    allBooks = [
                                      ...bibleClass
                                          .listTestaments![0].listBooks!,
                                      ...bibleClass
                                          .listTestaments![1].listBooks!
                                    ];
                                    myWidget = hauteur < 350
                                        ? Container()
                                        : largeur > 350
                                            ? Wrap(
                                                alignment: WrapAlignment.center,
                                                runSpacing: 10,
                                                children: [
                                                    SizedBox(
                                                      width: hauteur > largeur
                                                          ? 300
                                                          : 180,
                                                      child: Column(
                                                        children: [
                                                          titlePass(
                                                              "Ancien Testament I"),
                                                          textPass(
                                                              context,
                                                              ancientest1,
                                                              textSize),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: hauteur > largeur
                                                          ? 300
                                                          : 180,
                                                      child: Column(
                                                        children: [
                                                          titlePass(
                                                              "Ancien Testament II"),
                                                          textPass(
                                                              context,
                                                              ancientest2,
                                                              textSize),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: hauteur > largeur
                                                          ? 300
                                                          : 180,
                                                      child: Column(
                                                        children: [
                                                          titlePass(
                                                              "Nouveau Testament"),
                                                          textPass(
                                                              context,
                                                              nouveautest,
                                                              textSize),
                                                        ],
                                                      ),
                                                    ),
                                                  ])
                                            : Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                    width: hauteur > largeur
                                                        ? 300
                                                        : 180,
                                                    child: Row(
                                                      children: [
                                                        titlePass("AT I "),
                                                        textPass(context,
                                                            ancientest1, 16),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: hauteur > largeur
                                                        ? 300
                                                        : 180,
                                                    child: Row(
                                                      children: [
                                                        titlePass("AT II"),
                                                        textPass(context,
                                                            ancientest2, 16),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: hauteur > largeur
                                                        ? 300
                                                        : 180,
                                                    child: Row(
                                                      children: [
                                                        titlePass(" NT  "),
                                                        textPass(context,
                                                            nouveautest, 16),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              );
                                  }
                                  return myWidget;
                                })),
                      ),
                    ),
                    Container(
                      width: largeur,
                      constraints: BoxConstraints(
                          minHeight: 100,
                          maxHeight: largeur > 350
                              ? hauteur > largeur
                                  ? 350
                                  : 200
                              : 210),
                      color: titleBgColor,
                      child: Center(
                        child: Wrap(
                            spacing: 1,
                            children: List.generate(
                              text.length,
                              (index) => SizedBox(
                                width: largeur > 350 ? 110 : 100,
                                child: Opacity(
                                  opacity: opac,
                                  child: Card(
                                    margin:
                                        EdgeInsets.all(largeur > 350 ? 4 : 2),
                                    color: buttonColor,
                                    child: TextButton(
                                      child: Text(
                                        text[index],
                                        style: TextStyle(
                                          fontSize:
                                              responsiveSize(buttonTextSize),
                                          fontWeight: FontWeight.bold,
                                          color: const Color(0xffeeeeee),
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    months[index]));
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            )),
                      ),
                    ),
                    Expanded(flex: 1, child: Container())
                  ]),
            ),
          ),
        ),
      ),
    );
  }

  Opacity textPass(BuildContext context, pass, double size) {
    return Opacity(
      opacity: opac1,
      child: Card(
        color: themeFontColor,
        child: TextButton(
          child: SizedBox(
            width: 200,
            child: Text(
              afficheCaland(pass.toString(), allBooks),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: size,
                fontWeight: FontWeight.bold,
                color: bibleTextColor,
              ),
            ),
          ),
          onPressed: () {
            getPassageRef(context, pass.toString(), allBooks);
          },
        ),
      ),
    );
  }

  Container titlePass(title) {
    return Container(
      padding: const EdgeInsets.all(3),
      margin: const EdgeInsets.only(bottom: 3),
      color: titleBgColor,
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            fontSize: titleSize,
            fontStyle: FontStyle.italic,
            color: darkMode == true ? const Color(0xffbbbbbb) : noire,
          ),
        ),
      ),
    );
  }

  responsiveSize(size) {
    double responSize;
    largeur > 350 ? responSize = size : responSize = size * 0.85;

    return responSize;
  }

  allBooksList() {
    List<Books> allBooks = [
      ...bibleClass.listTestaments![0].listBooks!,
      ...bibleClass.listTestaments![1].listBooks!
    ];
    return allBooks;
  }

  Future<BibleClass> setTestament(String fichierJson) async {
    String jsonPage = await rootBundle.loadString(fichierJson);
    final jsonResponse = json.decode(jsonPage);
    bibleClass = bibleClass = BibleClass.fromJson(jsonResponse);
    return bibleClass = BibleClass.fromJson(jsonResponse);
  }

  List<Widget> months = [
    Mois("janvier"),
    Mois("fevrier"),
    Mois("mars"),
    Mois("avril"),
    Mois("mai"),
    Mois("juin"),
    Mois("juillet"),
    Mois("aout"),
    Mois("septembre"),
    Mois("octobre"),
    Mois("novembre"),
    Mois("decembre"),
  ];
  List<String> text = [
    "Janvier",
    "Février",
    "Mars",
    "Avril",
    "Mai",
    "Juin",
    "Juillet",
    "Août",
    "Septembre",
    "Octobre",
    "Novembre",
    "Décembre",
  ];

  void affichePassages(String mois, int pos) async {
    String jsonPhotos = await rootBundle.loadString(mois);
    final jsonResponse = json.decode(jsonPhotos);
    ListPassages listPassages = ListPassages.fromJson(jsonResponse);
    ancientest1 = listPassages.passages[pos].text_1;
    ancientest2 = listPassages.passages[pos].text_2;
    nouveautest = listPassages.passages[pos].text_3;
    setState(() {});
  }

  String formatDate() {
    final int todayYear = DateTime.now().year;
    final int todayMonth = DateTime.now().month;
    final int todayDay = DateTime.now().day;
    String monthLetter = '';
    setState(() {
      if (todayMonth == 1) {
        affichePassages('assets/fichiers/mois/janvier.json', todayDay);
        monthLetter = 'Janvier';
      } else if (todayMonth == 2) {
        affichePassages('assets/fichiers/mois/fevrier.json', todayDay);
        monthLetter = 'Février';
      } else if (todayMonth == 3) {
        affichePassages('assets/fichiers/mois/mars.json', todayDay);
        monthLetter = 'Mars';
      } else if (todayMonth == 4) {
        affichePassages('assets/fichiers/mois/avril.json', todayDay);
        monthLetter = 'Avril';
      } else if (todayMonth == 5) {
        affichePassages('assets/fichiers/mois/mai.json', todayDay);
        monthLetter = 'Mai';
      } else if (todayMonth == 6) {
        affichePassages('assets/fichiers/mois/juin.json', todayDay);
        monthLetter = 'Juin';
      } else if (todayMonth == 7) {
        affichePassages('assets/fichiers/mois/juillet.json', todayDay);
        monthLetter = 'Juillet';
      } else if (todayMonth == 8) {
        affichePassages('assets/fichiers/mois/aout.json', todayDay);
        monthLetter = 'Août';
      } else if (todayMonth == 9) {
        affichePassages('assets/fichiers/mois/septembre.json', todayDay);
        monthLetter = 'Septembre';
      } else if (todayMonth == 10) {
        affichePassages('assets/fichiers/mois/octobre.json', todayDay);
        monthLetter = 'Octobre';
      } else if (todayMonth == 11) {
        affichePassages('assets/fichiers/mois/novembre.json', todayDay);
        monthLetter = 'Novembre';
      } else if (todayMonth == 12) {
        affichePassages('assets/fichiers/mois/decembre.json', todayDay);
        monthLetter = 'Décembre';
      }
    });
    return "$todayDay  $monthLetter  $todayYear";
  }

  AlertDialog _buildExitDialog(BuildContext context) {
    return AlertDialog(
      backgroundColor: themeFontColor,
      title: Text('Confirmation', style: TextStyle(color: themeTextColor)),
      content: Text("Voulez-vous quitter l'application ?",
          style: TextStyle(color: themeTextColor)),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('Non', style: TextStyle(fontSize: 17)),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            SystemChannels.platform.invokeMethod('SystemNavigator.pop');
            //Navigator.of(context).pop(true);
          },
          child: const Text('Oui', style: TextStyle(fontSize: 17)),
        ),
      ],
    );
  }
}

AppBar myappbar(String texte) {
  return AppBar(
    backgroundColor: themeAppBarColor,
    foregroundColor: appBarTitleColor,
    centerTitle: true,
    title: Text(
      texte,
      style: TextStyle(
          fontSize: appBarTitleSize,
          fontWeight: FontWeight.bold,
          color: appBarTitleColor),
    ),
    elevation: 0.0,
    actions: <Widget>[
      IconButton(
        icon: const Icon(Icons.share),
        iconSize: 25.0,
        color: appBarTitleColor,
        onPressed: () {},
      ),
    ],
  );
}

String afficheCaland(String passage, List<Books> allBooks) {
  String caland = "";
  int indexLivre;
  if (passage.contains("_")) {
    indexLivre = int.parse(passage.split("_")[0]);
    String passage2 = passage.split("_")[1];
    passage2 = passage2.replaceAll(r"-", " à ");
    passage2 = passage2.replaceAll(r"~", " et ");
    caland = "${allBooks[indexLivre - 1].text!} $passage2";
  } else {
    indexLivre = int.parse(passage);
    caland = allBooks[indexLivre - 1].text!;
  }
  return caland;
}

getPassageRef(context, String passage, List<Books> allBooks) {
  int livre;
  List debut = [];
  List fin = [];

  if (passage.contains("_")) {
    livre = int.parse(passage.split("_")[0]);
    String chapVer = passage.replaceAll(r' ', '').split("_")[1];
    if (chapVer.contains("-")) {
      String debPass = chapVer.split("-")[0];
      String finPass = chapVer.split("-")[1];
      if (debPass.contains(":")) {
        debut = debPass.split(":");
        fin = finPass.split(":");
      } else {
        debut.add(debPass);
        fin.add(finPass);
      }
    } else if (chapVer.contains("~")) {
      String debPass = chapVer.split("~")[0];
      String finPass = chapVer.split("~")[1];
      if (debPass.contains(":")) {
        debut = debPass.split(":");
        fin = finPass.split(":");
      } else {
        debut.add(debPass);
        fin.add(finPass);
      }
    } else {
      debut.add(chapVer);
      fin.add(chapVer);
    }
  } else {
    livre = int.parse(passage);
  }

  Books book = allBooks[livre - 1];
  Chapters chapter =
      book.listChapters![debut.isNotEmpty ? int.parse(debut[0]) - 1 : 1];
  Verses verse =
      chapter.listVerses![debut.length > 1 ? int.parse(debut[1]) - 1 : 0];

  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              Bible(book: book, chapitre: chapter, versets: verse)));
}

Future<bool> _onWillPop(BuildContext context, Widget function) async {
  bool? exitResult;
  exitResult = await showDialog(
    context: context,
    builder: (context) => function,
  );

  return exitResult ?? false;
}
