import 'dart:convert';

import 'package:lecteur_bible/calendrier/bouton_jour.dart';
import 'package:flutter/material.dart';
import 'package:lecteur_bible/models/themes.dart';
import 'package:flutter/services.dart';
import 'package:lecteur_bible/models/lirepassage.dart';

import '../models/lire_bible.dart';

// ignore: must_be_immutable
class Mois extends StatefulWidget {
  String fileName;

  Mois(this.fileName, {Key? key}) : super(key: key);

  // ignore: non_constant_identifier_names
  @override
  // ignore: library_private_types_in_public_api
  _MoisState createState() => _MoisState();
}

class _MoisState extends State<Mois> {
  @override
  void initState() {
    affichePassages(1);
    super.initState();
  }

  ListPassages listPassages = ListPassages(passages: []);
  BibleClass bibleClass = BibleClass();
  List<Books> allBooks = [];

  @override
  Widget build(BuildContext context) {
    double largeur = MediaQuery.of(context).size.width;
    //double hauteur = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: themeAppBarColor,
        title: Text(
          widget.fileName.toUpperCase(),
          style: TextStyle(
            fontSize: appBarTitleSize,
            color: appBarTitleColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: FutureBuilder<Object>(
          future: setTestament(bibleVersion.path),
          builder: (context, snapshot) {
            Widget myWidget = const Center(child: CircularProgressIndicator());
            if (snapshot.hasData) {
              allBooks = [
                ...bibleClass.listTestaments![0].listBooks!,
                ...bibleClass.listTestaments![1].listBooks!
              ];
              myWidget = Container(
                constraints: const BoxConstraints.expand(),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(imfont), fit: BoxFit.cover),
                  ),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.only(top: 4, bottom: 3),
                          child: Text(
                            textRandom,
                            style: TextStyle(
                              fontSize: textRandomSize,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              color: blancGris,
                            ),
                          ),
                        ),
                        Container(
                          width: largeur,
                          color: themeFontColor,
                          child: Opacity(
                            opacity: opc,
                            child: Center(
                              child: Wrap(
                                  spacing: 3,
                                  children: List.generate(
                                    listPassages.passages.length,
                                    (index) => SizedBox(
                                      width: largeur > 350 ? 70 : 50,
                                      child: Card(
                                        color: buttonMonthColor,
                                        child: TextButton(
                                          child: Text(
                                            listPassages.passages[index].title!,
                                            style: TextStyle(
                                              fontSize: buttonMonthTextSize,
                                              fontWeight: FontWeight.bold,
                                              color: appBarTitleColor,
                                            ),
                                          ),
                                          onPressed: () {
                                            affichePassages(1);
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (_) => BoutonJour(
                                                          listPassages
                                                              .passages[index],
                                                          monthName:
                                                              widget.fileName,
                                                          allBooks: allBooks,
                                                        )));
                                          },
                                        ),
                                      ),
                                    ),
                                  )),
                            ),
                          ),
                        ),
                      ]),
                ),
              );
            }
            return myWidget;
          }),
    );
  }

  void affichePassages(int pos) async {
    String jsonPhotos = await rootBundle.loadString(
        "assets/fichiers/mois/${widget.fileName.toLowerCase()}.json");
    final jsonResponse = json.decode(jsonPhotos);
    listPassages = ListPassages.fromJson(jsonResponse);
    setState(() {
      listPassages.passages.removeAt(0);
    });
  }

  Future<BibleClass> setTestament(String fichierJson) async {
    String jsonPage = await rootBundle.loadString(fichierJson);
    final jsonResponse = json.decode(jsonPage);
    bibleClass = BibleClass.fromJson(jsonResponse);
    return BibleClass.fromJson(jsonResponse);
  }
}
