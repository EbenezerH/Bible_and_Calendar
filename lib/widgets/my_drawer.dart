// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lecteur_bible/models/themes.dart';
import 'package:lecteur_bible/calendrier/calendrier.dart';

import '../bible/bible.dart';
import '../models/lire_bible.dart';
import '../pages/parametre.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: themeFontColor,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              curve: Curves.fastOutSlowIn,
              decoration: BoxDecoration(
                gradient: darkMode == false
                    ? const LinearGradient(
                        begin: Alignment.topLeft,
                        colors: <Color>[
                            Color.fromARGB(255, 25, 51, 201),
                            Color.fromARGB(255, 59, 113, 206),
                            Color.fromARGB(255, 83, 103, 213),
                            Color.fromARGB(255, 158, 212, 253),
                          ])
                    : const LinearGradient(
                        begin: Alignment.topLeft,
                        colors: <Color>[
                            Color.fromARGB(255, 1, 6, 36),
                            Color.fromARGB(255, 10, 42, 97),
                            Color.fromARGB(255, 40, 63, 191),
                            Color.fromARGB(255, 21, 124, 203),
                          ]),
                //color: Colors.blue,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 200,
                        height: 100,
                        child: Stack(
                          children: [
                            Positioned(
                                left: 25,
                                child: Container(
                                    decoration: const BoxDecoration(
                                      gradient: LinearGradient(
                                          begin: Alignment.topLeft,
                                          colors: <Color>[
                                            Color.fromARGB(255, 236, 8, 8),
                                            Color.fromARGB(255, 207, 106, 39),
                                            Color.fromARGB(255, 231, 188, 60),
                                            Color.fromARGB(255, 241, 223, 172),
                                          ]),
                                    ),
                                    width: 12,
                                    height: 100)),
                            Positioned(
                                top: 25,
                                child: Container(
                                    decoration: const BoxDecoration(
                                      gradient: LinearGradient(
                                          begin: Alignment.topLeft,
                                          colors: <Color>[
                                            Color.fromARGB(255, 236, 8, 8),
                                            Color.fromARGB(255, 207, 106, 39),
                                            Color.fromARGB(255, 231, 188, 60),
                                            Color.fromARGB(255, 241, 223, 172),
                                            Color.fromARGB(255, 207, 106, 39),
                                            Color.fromARGB(255, 236, 8, 8),
                                          ]),
                                    ),
                                    width: 62,
                                    height: 12))
                          ],
                        ),
                      ),
                      const Text(
                        'Bible & Lecteur',
                        style: TextStyle(
                          color: blanc2,
                          fontSize: 22,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            ListTile(
                leading: const Icon(
                  Icons.book,
                  color: appbarcolor,
                ),
                title: Text('Bible',
                    style: TextStyle(
                        fontSize: drawerTextSize, color: themeTextColor)),
                //subtitle: const Text("Votre Bible d'étude"),
                onTap: () async {
                  String jsonPage =
                      await rootBundle.loadString(bibleVersion.path);
                  final jsonResponse = json.decode(jsonPage);
                  BibleClass bibleClass = BibleClass.fromJson(jsonResponse);

                  Navigator.of(context).pop();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => Bible(
                              book: bibleClass.listTestaments![0].listBooks![0],
                              chapitre: bibleClass.listTestaments![0]
                                  .listBooks![0].listChapters![0],
                              versets: bibleClass
                                  .listTestaments![0]
                                  .listBooks![0]
                                  .listChapters![0]
                                  .listVerses![0])));
                }),
            ListTile(
              leading: const Icon(
                Icons.calendar_today,
                color: appbarcolor,
              ),
              title: Text('Calendrier',
                  style: TextStyle(
                      fontSize: drawerTextSize, color: themeTextColor)),
              //subtitle: const Text("Le Calendrier Biblique Annuel en Français"),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const Calendrier()));
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.favorite,
                color: appbarcolor,
              ),
              title: Text('Favoris',
                  style: TextStyle(
                      fontSize: drawerTextSize, color: themeTextColor)),
              //subtitle: Text("Modifier le Thème"),
              onTap: null,
            ),
            ListTile(
                leading: const Icon(
                  Icons.settings,
                  color: appbarcolor,
                ),
                title: Text('Paramètre',
                    style: TextStyle(
                        fontSize: drawerTextSize, color: themeTextColor)),
                //subtitle: const Text("Choisir ses préférances"),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const Parametre()));
                }),
            ListTile(
              leading: const Icon(
                Icons.more_horiz,
                color: appbarcolor,
              ),
              title: Text('A propos',
                  style: TextStyle(
                      fontSize: drawerTextSize, color: themeTextColor)),
              //subtitle: Text("En savoir plus . . ."),
              onTap: null,
            ),
            const SizedBox(height: 40)
          ],
        ),
      ),
    );
  }
}
