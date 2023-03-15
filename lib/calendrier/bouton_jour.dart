// ignore_for_file: avoid_unnecessary_containers
import 'package:flutter/material.dart';
import 'package:lecteur_bible/models/lire_bible.dart';
import 'package:lecteur_bible/models/lirepassage.dart';
import 'package:lecteur_bible/models/themes.dart';

import 'calendrier.dart';

class BoutonJour extends StatefulWidget {
  final Passages passages;
  final String monthName;
  final List<Books> allBooks;

  const BoutonJour(this.passages,
      {Key? key, required this.monthName, required this.allBooks})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _BoutonJourState createState() => _BoutonJourState();
}

class _BoutonJourState extends State<BoutonJour> {
  @override
  Widget build(BuildContext context) {
    final double hauteur = MediaQuery.of(context).size.height;
    final double largeur = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeAppBarColor,
        title: Center(
            child: Text(
          "${widget.passages.title} ${widget.monthName}",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: appBarTitleColor,
          ),
        )),
      ),
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/image1.jpg"), fit: BoxFit.cover),
        ),
        child: Container(
          height: hauteur,
          width: largeur,
          color: darkMode == true ? Colors.black54 : Colors.transparent,
          child: Center(
            child: Container(
              child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      //SizedBox(height: 10),
                      SizedBox(
                        height: 125,
                        width: largeur / 1.2,
                        child: Column(children: [
                          const Card(
                            color: Colors.white38,
                            child: Center(
                              child: Text(
                                "Ancien Testament I",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              backToCalendarDay = true;
                              getPassageRef(context, widget.passages.text_1,
                                  widget.allBooks);
                            },
                            child: Opacity(
                                opacity: 0.8,
                                child: Container(
                                  color: Colors.blue,
                                  margin: const EdgeInsets.only(bottom: 20),
                                  height: 70,
                                  child: Center(
                                    child: Text(
                                      afficheCaland(widget.passages.text_1,
                                          widget.allBooks),
                                      style: const TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                )),
                          ),
                        ]),
                      ),
                      SizedBox(
                        height: 125,
                        width: largeur / 1.2,
                        child: Column(
                          children: [
                            Card(
                              color: Colors.white38,
                              child: Container(
                                child: const Center(
                                  child: Text(
                                    "Ancien Testament II",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                backToCalendarDay = true;
                                getPassageRef(context, widget.passages.text_2,
                                    widget.allBooks);
                              },
                              child: Opacity(
                                  opacity: 0.8,
                                  child: Container(
                                    color: Colors.blue,
                                    margin: const EdgeInsets.only(bottom: 20),
                                    height: 70,
                                    child: Center(
                                      child: Text(
                                        afficheCaland(widget.passages.text_2,
                                            widget.allBooks),
                                        style: const TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 125,
                        width: largeur / 1.2,
                        child: Column(
                          children: [
                            Card(
                              color: Colors.white38,
                              child: Container(
                                child: const Center(
                                  child: Text(
                                    "Nouveau Testament",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                backToCalendarDay = true;
                                getPassageRef(context, widget.passages.text_3,
                                    widget.allBooks);
                              },
                              child: Opacity(
                                  opacity: 0.8,
                                  child: Container(
                                    color: Colors.blue,
                                    height: 70,
                                    child: Center(
                                      child: Text(
                                        afficheCaland(widget.passages.text_3,
                                            widget.allBooks),
                                        style: const TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
