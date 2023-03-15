import 'package:flutter/material.dart';
import 'package:lecteur_bible/bible/bible.dart';
import 'package:lecteur_bible/models/lire_bible.dart';
import 'package:lecteur_bible/models/themes.dart';

// ignore: must_be_immutable
class SelectionVerset extends StatelessWidget {
  Books livre;
  Chapters chapitre;
  SelectionVerset(this.livre, {Key? key, required this.chapitre})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double hauteur = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: themeAppBarColor,
          title: Text(
            "Versets/${livre.text!} ${chapitre.id}",
            style: TextStyle(color: appBarTitleColor),
          )),
      body: Container(
        color: themeFontColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 40,
              width: double.maxFinite,
              padding: const EdgeInsets.only(top: 10, left: 10),
              decoration: const BoxDecoration(
                  border:
                      Border(bottom: BorderSide(width: 1, color: Colors.blue))),
              child: Text(
                "${livre.text} ${chapitre.id}",
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              height: hauteur - 160,
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Wrap(
                    runSpacing: 10,
                    children:
                        List.generate(chapitre.listVerses!.length, (index) {
                      return GestureDetector(
                        onTap: () {
                          backToCalendarDay = false;
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Bible(
                                      book: livre,
                                      chapitre: chapitre,
                                      versets: chapitre.listVerses![index])));
                        },
                        child: Container(
                          width: 50,
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
                            chapitre.listVerses![index].id.toString(),
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          )),
                        ),
                      );
                    })),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
