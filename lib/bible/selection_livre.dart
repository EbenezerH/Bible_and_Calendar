import 'package:flutter/material.dart';
import 'package:lecteur_bible/models/themes.dart';
import '../models/lire_bible.dart';

import 'selection_chapitre.dart';

// ignore: must_be_immutable
class SelectionLivre extends StatefulWidget {
  BibleClass bibleClass;
  SelectionLivre({Key? key, required this.bibleClass}) : super(key: key);

  @override
  State<SelectionLivre> createState() => _SelectionLivreState();
}

class _SelectionLivreState extends State<SelectionLivre> {
  @override
  void initState() {
    super.initState();
  }

  List<Books> booksList1 = [];
  List<Books> booksList2 = [];
  bool ancienTestVisible = true;
  bool nouveauTestVisible = true;

  @override
  Widget build(BuildContext context) {
    double largeur = MediaQuery.of(context).size.width;

    booksList1 = widget.bibleClass.listTestaments![0].listBooks!;
    booksList2 = widget.bibleClass.listTestaments![1].listBooks!;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeAppBarColor,
        actions: [
          SizedBox(
            width: largeur / 5,
            child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateColor.resolveWith(
                        (states) => themeAppBarColor)),
                child: Text(
                  "Tout",
                  style: TextStyle(color: appBarTitleColor),
                ),
                onPressed: () {
                  setState(() {
                    ancienTestVisible = true;
                    nouveauTestVisible = true;
                  });
                }),
          ),
          SizedBox(
            width: largeur / 5,
            child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateColor.resolveWith(
                        (states) => themeAppBarColor)),
                child: Text(
                  "AT",
                  style: TextStyle(color: appBarTitleColor),
                ),
                onPressed: () {
                  setState(() {
                    ancienTestVisible = true;
                    nouveauTestVisible = false;
                  });
                }),
          ),
          SizedBox(
            width: largeur / 5,
            child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateColor.resolveWith(
                        (states) => themeAppBarColor)),
                child: Text(
                  "NT",
                  style: TextStyle(color: appBarTitleColor),
                ),
                onPressed: () {
                  setState(() {
                    ancienTestVisible = false;
                    nouveauTestVisible = true;
                  });
                }),
          ),
          IconButton(
            icon: const Icon(Icons.search),
            iconSize: 25.0,
            color: appBarTitleColor,
            onPressed: () {},
          ),
          const SizedBox(width: 5)
        ],
      ),
      body: Container(
        color: themeFontColor,
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              color: themeFontColor,
              padding: const EdgeInsets.symmetric(vertical: 10),
              margin: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                children: [
                  Visibility(
                    visible: ancienTestVisible,
                    child: Wrap(
                        runSpacing: 10,
                        children: List.generate(booksList1.length, (index) {
                          return GestureDetector(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SelectionChapitre(
                                          booksList1[index],
                                        ))),
                            child: Container(
                              width: largeur > 350 ? 160 : 140,
                              height: 40,
                              margin: const EdgeInsets.only(left: 5, right: 5),
                              decoration: const BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(5),
                                      topRight: Radius.circular(15),
                                      bottomLeft: Radius.circular(15)),
                                  boxShadow: [
                                    BoxShadow(
                                        offset: Offset(-2, 2),
                                        blurRadius: 1,
                                        spreadRadius: 1)
                                  ]),
                              child: Center(
                                  child: Text(
                                booksList1[index].text!.split(" ").length > 2
                                    ? booksList1[index].text!.split(" ")[0]
                                    : booksList1[index].text!,
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              )),
                            ),
                          );
                        })),
                  ),
                  const SizedBox(height: 15),
                  Visibility(
                    visible: nouveauTestVisible,
                    child: Wrap(
                        runSpacing: 10,
                        children: List.generate(booksList2.length, (index) {
                          return GestureDetector(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SelectionChapitre(
                                          booksList2[index],
                                        ))),
                            child: Container(
                              width: largeur > 350 ? 160 : 140,
                              height: 40,
                              margin: const EdgeInsets.only(left: 5, right: 5),
                              decoration: const BoxDecoration(
                                  color: Color(0xefa080ff),
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(5),
                                      topRight: Radius.circular(15),
                                      bottomLeft: Radius.circular(15)),
                                  boxShadow: [
                                    BoxShadow(
                                        offset: Offset(-2, 2),
                                        blurRadius: 1,
                                        spreadRadius: 1)
                                  ]),
                              child: Center(
                                  child: Text(
                                booksList2[index].text!.split(" ").length > 2
                                    ? booksList2[index].text!.split(" ")[0]
                                    : booksList2[index].text!,
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              )),
                            ),
                          );
                        })),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
