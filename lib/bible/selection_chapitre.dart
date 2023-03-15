import 'package:flutter/material.dart';
import 'package:lecteur_bible/models/lire_bible.dart';
import 'package:lecteur_bible/models/themes.dart';
import 'selection_verset.dart';

// ignore: must_be_immutable
class SelectionChapitre extends StatelessWidget {
  Books livre;
  SelectionChapitre(this.livre, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double hauteur = MediaQuery.of(context).size.height;
    //double largeur = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: themeAppBarColor,
          title: Text(
            "Chapitres/${livre.text!}",
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
              child: Text(
                livre.text!,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue),
              ),
            ),
            Container(height: 1, color: Colors.blue),
            Container(
              height: hauteur - 150,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Wrap(
                    runSpacing: 10,
                    children:
                        List.generate(livre.listChapters!.length, (index) {
                      return GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SelectionVerset(
                                      livre,
                                      chapitre: livre.listChapters![index],
                                    ))),
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
                            livre.listChapters![index].id.toString(),
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
