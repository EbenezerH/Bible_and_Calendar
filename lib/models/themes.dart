import 'package:flutter/material.dart';

bool darkMode = false;
BibleVersion bibleVersion = versionsList[0];
bool backToCalendarDay = false;
late bool rechargementCompris;
String fontFamily = "Roboto";

const Color appbarcolor = Color(0xFF0075FF);
const Color blanc = Color(0xFFFFFFFF);
const Color blancGris = Color.fromARGB(255, 237, 234, 234);
const Color blanc2 = Color.fromARGB(238, 183, 212, 244);
const Color vert = Color(0xFF00FF00);
const Color jaune = Color(0xFFFFFF00);
const Color rouge = Color(0xFFFF0000);
const Color bleu = Color(0xFF0000FF);
const Color noire = Color(0xFF000000);
const Color transparent = Color(0x00000000);

// ----------------------------- ECRAN ACCUEIL --------------------------------------------
String imfontp = darkMode == false
    ? "assets/images/image3.jpg"
    : "assets/images/image5.jpg"; //Image font accueil
// 1ere partie / AppBar
double appBarTitleSize = 20.0; // Taile de police titre
Color appBarTitleColor = darkMode == false ? blanc : blanc2; // Couleur du titre

//3eme partie / la date du jour
double dateSize = 17; // Taille de police du texte
Color dateColor = noire; // Couleur du text
Color parentBgColor = transparent; // Grand Conteneur Couleur
Color childBgColor = transparent; // Petit Conteneur Couleur (le Card)

//4eme partie / passages bibliques du jour
//               les  titres
double titleSize = 17.0; // Taille des titres
Color titleBgColor = transparent; // Couleur du conteneur  des titres
//               les passages
double opac1 = 0.9;
double textSize = 20.0; // Taille des passages

// 5eme partie / les mois
Color buttonRowBg = transparent; // Conteneur des boutons par Row
Color buttonParentBg = transparent; // Conteneur des Row
Color buttonColor = bleu; // couleur des boutons
double opac = 0.8;
double buttonTextSize =
    17.0; //Taile de police des boutons (janvier, février, mars...)
Color buttonTextColor =
    darkMode == false ? blanc : noire; // Couleur de police des boutons

// ---------------------------- ECRAN D'UN MOIS -------------------------------------------
// 1ere partie / AppBar

//2eme partie / Jésus-Christ est Seigneur
double textRandomSize = 16; // Taille du texte
Color textRandomParentBg = transparent; // Conteneur
String textRandom = "Jésus-Christ est Seigneur";

// 3eme partie / Les Boutons
Color buttonMonthColor = appbarcolor; // couleur des boutons
double buttonMonthTextSize = 17.0; //Taile de police des boutons (01, 02, 03...)
double opc = 0.9; //opacité des boutons
String imfont = "assets/images/image5.jpg"; // Image de font

// ---------------------------- MY DRAWER -------------------------------------------
double drawerTextSize = 17;

Color bibleTextColor =
    darkMode == false ? noire : const Color.fromARGB(150, 150, 150, 150);

double policeSize = 18;
Color themeFontColor = darkMode == false ? blancGris : const Color(0xff181818);
Color themeTextColor = darkMode == false ? noire : blancGris;
Color selectedColor = darkMode == false
    ? const Color.fromARGB(255, 180, 195, 202)
    : const Color.fromARGB(255, 57, 57, 58);
Color themeAppBarColor =
    darkMode == false ? appbarcolor : const Color.fromARGB(255, 0, 95, 203);

void reloadTheme() {
  imfontp = darkMode == false
      ? "assets/images/image3.jpg"
      : "assets/images/image5.jpg";
  //buttonTextColor = darkMode == false ? blanc : noire;
  appBarTitleColor = darkMode == false ? blanc : blanc2; // Couleur du titre
  themeFontColor = darkMode == false ? blancGris : const Color(0xff181818);
  bibleTextColor =
      darkMode == false ? noire : const Color.fromARGB(150, 150, 150, 150);
  themeTextColor = darkMode == false ? noire : blancGris;
  selectedColor = darkMode == false
      ? const Color.fromARGB(255, 180, 195, 202)
      : const Color.fromARGB(255, 57, 57, 58);
  themeAppBarColor =
      darkMode == false ? appbarcolor : const Color.fromARGB(255, 0, 95, 203);
}

void checkSystemTheme(context) {
  Brightness brightness = MediaQuery.of(context).platformBrightness;
  if (brightness == Brightness.dark) {
    darkMode = true;
    reloadTheme();
  } else {
    darkMode = false;
  }
}

List<BibleVersion> versionsList = [
  BibleVersion("Louis Segond",
      available: true,
      path: 'assets/fichiers/bible/French_Louis_Segond_1910.json'), // 0
  BibleVersion("Darby",
      available: true, path: 'assets/fichiers/bible/French_Darby.json'), // 1
  BibleVersion("Segond 21"), // 2
  BibleVersion("Français Courant"), // 3
  BibleVersion("Parole de Vie"), // 4
  BibleVersion("Semeur"), // 5
  BibleVersion("Colombe"), // 6
  BibleVersion("Traduction Œcuménique"), // 7
];

class BibleVersion {
  String name;
  String path;
  bool available;

  BibleVersion(this.name, {this.available = false, this.path = ""});
}
