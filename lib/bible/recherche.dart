import 'package:flutter/material.dart';
import 'package:lecteur_bible/bible/bible.dart';
import 'package:lecteur_bible/models/lire_bible.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../models/themes.dart';

class Recherche extends StatefulWidget {
  final BibleClass bibleClass;
  const Recherche(this.bibleClass, {Key? key}) : super(key: key);

  @override
  State<Recherche> createState() => _RechercheState();
}

enum Filtre { debut, fin, tout }

class _RechercheState extends State<Recherche> {
  @override
  void initState() {
    allBooks = [
      ...widget.bibleClass.listTestaments![0].listBooks!,
      ...widget.bibleClass.listTestaments![1].listBooks!
    ];
    //FocusNode().requestFocus();
    focusNode.requestFocus();

    super.initState();
  }

  TextEditingController controller = TextEditingController();
  ItemScrollController controlScroll = ItemScrollController();
  final FocusNode focusNode = FocusNode();
  List<Books> allBooks = [];
  List<Books> researchList = [];
  List<Books> booksList = [];
  List<Chapters> chaptersList = [];
  List<Verses> versesList = [];
  List<List<InlineSpan>> formatedVerse = [];
  List<InlineSpan> formatedTest = [];

  @override
  Widget build(BuildContext context) {
    double largeur = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        automaticallyImplyLeading: false,
        title: SizedBox(
          height: 80,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 30,
                //padding: EdgeInsets.symmetric(horizontal: 10),
                child: TextFormField(
                  maxLines: 1,
                  controller: controller,
                  focusNode: focusNode,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: themeTextColor,
                  ),
                  decoration: InputDecoration(
                      labelStyle: const TextStyle(color: Colors.white),
                      icon: const Icon(Icons.search),
                      suffixIcon: GestureDetector(
                          onTap: () {
                            controller.clear();
                          },
                          child: const Icon(Icons.close)),
                      border: const OutlineInputBorder(
                          borderSide: BorderSide(),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15.0),
                              bottomRight: Radius.circular(15.0))),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15.0),
                              bottomRight: Radius.circular(15.0))),
                      focusColor: blanc),
                  cursorColor: blanc,
                  onChanged: (value) {
                    setState(() {
                      researchList.isEmpty
                          ? researchList = allBooks
                          : researchList = researchList;
                      rechercher();
                    });
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: largeur / 5,
                    child: ElevatedButton(
                        child: Text(
                          "Tout",
                          style: TextStyle(color: themeTextColor),
                        ),
                        onPressed: () {
                          setState(() {
                            researchList = allBooks;
                            rechercher();
                          });
                        }),
                  ),
                  SizedBox(
                    width: largeur / 5,
                    child: ElevatedButton(
                        child: Text(
                          "AT",
                          style: TextStyle(color: themeTextColor),
                        ),
                        onPressed: () {
                          setState(() {
                            researchList =
                                widget.bibleClass.listTestaments![0].listBooks!;
                            rechercher();
                          });
                        }),
                  ),
                  SizedBox(
                    width: largeur / 5,
                    child: ElevatedButton(
                        child: Text(
                          "NT",
                          style: TextStyle(color: themeTextColor),
                        ),
                        onPressed: () {
                          setState(() {
                            researchList =
                                widget.bibleClass.listTestaments![1].listBooks!;
                            rechercher();
                          });
                        }),
                  ),
                  const SizedBox(width: 5),
                  ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        "Test",
                        style: TextStyle(color: themeTextColor),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
      body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Container(
            color: themeFontColor,
            child: Column(
              children: [
                Container(
                  height: 30,
                  padding: const EdgeInsets.only(top: 5),
                  //color: Color.fromARGB(217, 28, 127, 232),
                  child: Text(
                    "${versesList.length} résultat${versesList.length > 1 ? "s" : ""}",
                    style: TextStyle(fontSize: 15, color: themeTextColor),
                  ),
                ),
                Expanded(
                    child: SizedBox(
                        child: ScrollablePositionedList.builder(
                            padding: const EdgeInsets.only(bottom: 100),
                            itemScrollController: controlScroll,
                            itemCount: versesList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Bible(
                                            book: booksList[index],
                                            chapitre: chaptersList[index],
                                            versets: versesList[index]),
                                      ));
                                },
                                child: Container(
                                  color:
                                      // widget.chapitre.listVerses![index].isSelected ==
                                      //         true
                                      //     ? selectedColor
                                      //     :
                                      Colors.transparent,
                                  margin: const EdgeInsets.only(
                                      top: 8, left: 8, right: 8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${booksList[index].text} ${chaptersList[index].id} v ${versesList[index].id}",
                                        style: TextStyle(
                                            color: Colors.blueAccent,
                                            fontWeight: FontWeight.w500,
                                            fontSize: policeSize),
                                      ),
                                      const SizedBox(width: 5),
                                      Wrap(
                                        children: [
                                          Text.rich(TextSpan(
                                              style: TextStyle(
                                                  fontSize: policeSize,
                                                  color: bibleTextColor),
                                              children: formatedVerse[index])),
                                        ],
                                      ),
                                      Container(
                                          margin: const EdgeInsets.only(top: 5),
                                          height: 1,
                                          color: bleu)
                                    ],
                                  ),
                                ),
                              );
                            }))),
              ],
            ),
          )),
      floatingActionButton: SizedBox(
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              width: 80,
              child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: active == Filtre.debut
                        ? MaterialStateProperty.all(
                            const Color.fromARGB(255, 0, 0, 250))
                        : MaterialStateProperty.all(
                            const Color.fromARGB(255, 80, 140, 240)),
                  ),
                  child: Text(
                    "Début",
                    style: TextStyle(color: themeTextColor),
                  ),
                  onPressed: () {
                    setState(() {
                      filtrer(Filtre.debut);
                      rechercher();
                    });
                  }),
            ),
            SizedBox(
              width: 90,
              child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: active == Filtre.fin
                        ? MaterialStateProperty.all(
                            const Color.fromARGB(255, 0, 0, 250))
                        : MaterialStateProperty.all(
                            const Color.fromARGB(255, 80, 140, 240)),
                  ),
                  child: Text(
                    "Absolue",
                    style: TextStyle(color: themeTextColor),
                  ),
                  onPressed: () {
                    setState(() {
                      filtrer(Filtre.fin);
                      rechercher();
                    });
                  }),
            ),
            SizedBox(
              width: 90,
              child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: active == Filtre.tout
                        ? MaterialStateProperty.all(
                            const Color.fromARGB(255, 0, 0, 250))
                        : MaterialStateProperty.all(
                            const Color.fromARGB(255, 80, 140, 240)),
                  ),
                  child: Text(
                    "Partielle",
                    style: TextStyle(color: themeTextColor),
                  ),
                  onPressed: () {
                    setState(() {
                      filtrer(Filtre.tout);
                      rechercher();
                    });
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Enum active = Filtre.tout;
  filtrer(Enum button) {
    if (button == Filtre.debut) {
      active = Filtre.debut;
    } else if (button == Filtre.fin) {
      active = Filtre.fin;
    } else if (button == Filtre.tout) {
      active = Filtre.tout;
    }
  }

  search(String text, String toSearch) {
    List<InlineSpan> formatedTest = [];
    if (active == Filtre.tout) {
      formatedTest = [];
      while (text.toLowerCase().contains(toSearch)) {
        String t1 = text.substring(0, text.toLowerCase().indexOf(toSearch));
        String t2 = text.substring(text.toLowerCase().indexOf(toSearch),
            text.toLowerCase().indexOf(toSearch) + toSearch.length);
        String t3 = text
            .substring(text.toLowerCase().indexOf(toSearch) + toSearch.length);
        formatedTest.addAll([
          TextSpan(text: t1),
          TextSpan(
              text: t2,
              style: const TextStyle(
                  color: Colors.red, fontWeight: FontWeight.w500))
        ]);
        text = t3;
      }
      formatedTest.add(TextSpan(text: text));
    } else if (active == Filtre.fin) {
      formatedTest = [];
      while (text.toLowerCase().contains(" $toSearch ")) {
        String toSearch2 = " $toSearch ";
        String t1 =
            text.substring(0, " $text".toLowerCase().indexOf(toSearch2));
        String t2 = text.substring(" $text".toLowerCase().indexOf(toSearch2),
            " $text".toLowerCase().indexOf(toSearch2) + toSearch.length);
        String t3 = text.substring(
            " $text".toLowerCase().indexOf(toSearch2) + toSearch.length);
        formatedTest.addAll([
          TextSpan(text: t1),
          TextSpan(
              text: t2,
              style: const TextStyle(
                  color: Colors.red, fontWeight: FontWeight.w500))
        ]);
        text = t3;
      }
      formatedTest.add(TextSpan(text: text));
    } else if (active == Filtre.debut) {
      if (text.toLowerCase().startsWith(toSearch)) {
        formatedTest = [];
        String t2 = text.substring(0, toSearch.length);
        String t3 = text.substring(toSearch.length);
        formatedTest.addAll([
          TextSpan(
              text: t2,
              style: const TextStyle(
                  color: Colors.red, fontWeight: FontWeight.w500)),
          TextSpan(text: t3),
        ]);
      }
    }
    return formatedTest;
  }

  rechercher() {
    versesList = [];
    chaptersList = [];
    booksList = [];
    formatedVerse = [];
    if (controller.text.isNotEmpty) {
      for (var books in researchList) {
        for (var chapter in books.listChapters!) {
          for (var verse in chapter.listVerses!) {
            if (active == Filtre.tout) {
              if (verse.text!
                  .toLowerCase()
                  .contains(controller.text.toLowerCase())) {
                booksList.add(books);
                chaptersList.add(chapter);
                versesList.add(verse);
                formatedVerse
                    .add(search(verse.text!, controller.text.toLowerCase()));
              }
            } else if (active == Filtre.debut) {
              if (verse.text!
                  .toLowerCase()
                  .startsWith(controller.text.toLowerCase())) {
                booksList.add(books);
                chaptersList.add(chapter);
                versesList.add(verse);
                formatedVerse
                    .add(search(verse.text!, controller.text.toLowerCase()));
              }
            } else if (active == Filtre.fin) {
              if (verse.text!
                  .toLowerCase()
                  .contains(" ${controller.text.toLowerCase()} ")) {
                booksList.add(books);
                chaptersList.add(chapter);
                versesList.add(verse);

                formatedVerse
                    .add(search(verse.text!, controller.text.toLowerCase()));
              }
            }
          }
        }
      }
    }
  }
}
