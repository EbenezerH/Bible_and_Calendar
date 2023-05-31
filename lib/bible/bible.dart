import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lecteur_bible/bible/recherche.dart';
import 'package:lecteur_bible/models/themes.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import '../calendrier/calendrier.dart';
import '../widgets/my_drawer.dart';
import '../models/lire_bible.dart';
import 'selection_livre.dart';

// ignore: must_be_immutable
class Bible extends StatefulWidget {
  Books book;
  Chapters chapitre;
  Verses versets;
  Bible(
      {Key? key,
      required this.book,
      required this.chapitre,
      required this.versets})
      : super(key: key);

  @override
  State<Bible> createState() => _BibleState();
}

class _BibleState extends State<Bible> {
  @override
  void initState() {
    setTestament(bibleVersion.path);
    Timer(const Duration(milliseconds: 1000), () {
      controlScroll.jumpTo(index: widget.versets.id! - 1);
    });
    widget.chapitre.listVerses![widget.versets.id! - 1].isSelected = true;
    Timer(const Duration(milliseconds: 3000), () {
      setState(() {
        widget.chapitre.listVerses![widget.versets.id! - 1].isSelected = false;
      });
    });
    super.initState();
  }

  BibleClass bibleClass = BibleClass();
  ItemScrollController controlScroll = ItemScrollController();
  bool isSelected = false;
  bool isFirstPrint = false;
  bool continueMarkdownColor = false;

  @override
  Widget build(BuildContext context) {
    double largeur = MediaQuery.of(context).size.width;

    return Scaffold(
        drawerScrimColor: const Color.fromARGB(10, 7, 90, 255),
        drawer: const MyDrawer(),
        appBar: AppBar(
            backgroundColor: themeAppBarColor,
            foregroundColor: appBarTitleColor,
            centerTitle: true,
            title: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateColor.resolveWith(
                        (states) => themeAppBarColor)),
                child: Text(
                  "${widget.book.text} ${widget.chapitre.id}",
                  style: TextStyle(color: appBarTitleColor, fontSize: 16),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              SelectionLivre(bibleClass: bibleClass)));
                }),
            elevation: 0.0,
            actions: [
              IconButton(
                icon: const Icon(Icons.search),
                iconSize: 25.0,
                color: appBarTitleColor,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Recherche(bibleClass)));
                },
              ),
              IconButton(
                icon: const Icon(Icons.bookmark_outline),
                iconSize: 25.0,
                color: appBarTitleColor,
                onPressed: () {},
              )
            ]),
        body: WillPopScope(
          onWillPop: () {
            return _onWillPop();
          },
          child: Column(
            children: [
              Expanded(
                child: Container(
                  width: largeur,
                  decoration: BoxDecoration(
                    color: themeFontColor,
                  ),
                  child: ScrollablePositionedList.builder(
                      padding: const EdgeInsets.only(bottom: 100),
                      itemScrollController: controlScroll,
                      itemCount: widget.chapitre.listVerses!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              widget.chapitre.listVerses![index].isSelected ==
                                      true
                                  ? widget.chapitre.listVerses![index]
                                      .isSelected = false
                                  : widget.chapitre.listVerses![index]
                                      .isSelected = true;
                            });
                          },
                          onHorizontalDragEnd: (details) {
                            setState(() {
                              swipe(!(details.primaryVelocity! > 0));
                            });
                          },
                          child: Container(
                            color:
                                widget.chapitre.listVerses![index].isSelected ==
                                        true
                                    ? selectedColor
                                    : Colors.transparent,
                            margin: const EdgeInsets.only(
                                top: 10, left: 8, right: 8),
                            child: RichText(
                              text: TextSpan(children: [
                                WidgetSpan(
                                    child: Container(
                                  //color: Colors.red,
                                  padding: const EdgeInsets.all(0),
                                  child: Text(
                                    "${widget.chapitre.listVerses![index].id}",
                                    style: TextStyle(
                                        color: const Color.fromARGB(
                                            255, 35, 90, 185),
                                        fontFamily: fontFamily,
                                        fontWeight: FontWeight.w500,
                                        fontSize: policeSize),
                                  ),
                                )),
                                const TextSpan(text: "  "),
                                TextSpan(
                                  children: markdownColor(
                                      widget.chapitre.listVerses![index].text!),
                                  style: TextStyle(
                                      fontFamily: fontFamily,
                                      fontSize: policeSize,
                                      color: bibleTextColor),
                                ),
                              ]),
                            ),
                          ),
                        );
                      }),
                ),
              )
            ],
          ),
        ),
        floatingActionButton: GestureDetector(
          onTap: () {},
          child: const Icon(
            Icons.book_outlined,
            size: 25,
            color: Colors.amber,
          ),
          // ),
        ));
  }

  Future setTestament(String fichierJson) async {
    String jsonPage = await rootBundle.loadString(fichierJson);
    final jsonResponse = json.decode(jsonPage);
    setState(() {
      bibleClass = BibleClass.fromJson(jsonResponse);
    });
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
        formatedTest
            .add(TextSpan(text: t2, style: const TextStyle(color: Colors.red)));

        text2index = -1;
      }
      String t3 = text.substring(text.indexOf(toSearch) + toSearch.length);

      text = t3;
    }
    //formatedTest.add(TextSpan(text: text));
    if (text2index != -1) {
      formatedTest
          .add(TextSpan(text: text, style: const TextStyle(color: Colors.red)));

      //continueMarkdownColor = true;
    } else {
      formatedTest.add(TextSpan(text: text));
      //continueMarkdownColor = false;
    }
    debugPrint(text2index.toString());

    return formatedTest;
  }

  swipe(bool toRight) {
    List<Books> allBooks = [
      ...bibleClass.listTestaments![0].listBooks!,
      ...bibleClass.listTestaments![1].listBooks!
    ];
    int actualChapterIndex = widget.chapitre.id! - 1;
    int actualBookIndex = widget.book.id!;

    if (toRight) {
      if (widget.book.listChapters!.length > actualChapterIndex + 1) {
        //next Chapter
        widget.chapitre = widget.book.listChapters![actualChapterIndex + 1];
      } else {
        //next book
        if (allBooks[allBooks.length - 1].id! > actualBookIndex) {
          widget.book = allBooks[actualBookIndex + 1];
          widget.chapitre = widget.book.listChapters![0];
        } else {
          //restart from a first book
          widget.book = allBooks[0];
          widget.chapitre = widget.book.listChapters![0];
        }
      }
    } else {
      if (actualChapterIndex >= 1) {
        //previous Chapter
        widget.chapitre = widget.book.listChapters![actualChapterIndex - 1];
      } else {
        //previous book
        if (actualBookIndex > 0) {
          widget.book = allBooks[actualBookIndex - 1];
          widget.chapitre =
              widget.book.listChapters![widget.book.listChapters!.length - 1];
        } else {
          //restart from a first book
          widget.book = allBooks[allBooks.length - 1];
          widget.chapitre =
              widget.book.listChapters![widget.book.listChapters!.length - 1];
        }
      }
    }
  }

  Future<bool> _onWillPop() async {
    bool? back;
    if (backToCalendarDay) {
      back = true;
      backToCalendarDay = false;
    } else {
      back = false;
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Calendrier()));
    }
    return back;
  }
}
