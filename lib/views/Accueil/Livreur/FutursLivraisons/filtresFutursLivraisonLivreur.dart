import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:livreurs_app/Controllers/livraisonController.dart';
import 'package:livreurs_app/views/Accueil/Livreur/FutursLivraisons/futurLivraisonLivreur.dart';
import 'package:livreurs_app/const.dart' as Const;

/// This Widget is the main application widget.
class FiltresFutursLivraisonLivreur extends StatefulWidget {
  @override
  _FiltresFutursLivraisonLivreurState createState() =>
      _FiltresFutursLivraisonLivreurState();
}

class _FiltresFutursLivraisonLivreurState
    extends State<FiltresFutursLivraisonLivreur> {
  String villeDeDepart = 'Tout';
  String villeDeLivraison = 'Tout';
  String regionRecuperation = "Tout";
  String regionLivraison = "Tout";
  String contenu = 'Tout';
  String nature = 'Tout';
  String taille = 'Tout';
  String poids = 'Tout';
  String dateLivraison;
  TextEditingController date = new TextEditingController();
  String idLivreur = Const.idClLiv;
  LivraisonController livraisonController = new LivraisonController();

  final format = DateFormat("yyyy-MM-dd");
  Color getColorTaille(String moyen) {
    if (moyen == taille) {
      return Colors.black;
    } else {
      return Colors.white;
    }
  }

  Color getColorPoids(String moyen) {
    if (moyen == poids) {
      return Colors.black;
    } else {
      return Colors.white;
    }
  }

  Color getColorNature(String moyen) {
    if (moyen == nature) {
      return Colors.black;
    } else {
      return Colors.white;
    }
  }

  Color getColorContenu(String moyen) {
    if (moyen == contenu) {
      return Colors.black;
    } else {
      return Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    // ignore: todo
    // TODO: implement build
    return Scaffold(
      //////// AppBar du Page ///////
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        iconTheme: IconThemeData(color: Colors.black),
        actions: <Widget>[
          ////////////// Button REINITIALISER //////////////
          Center(
            child: Container(
              margin: const EdgeInsets.only(right: 10),
              child: InkWell(
                onTap: () {
                  setState(() {
                    villeDeDepart = 'Tout';
                    villeDeLivraison = 'Tout';
                    contenu = 'Tout';
                    nature = 'Tout';
                    taille = 'Tout';
                    poids = 'Tout';
                    date.text = '';
                    regionRecuperation = 'Tout';
                    regionLivraison = 'Tout';
                  });
                },
                child: Text(
                  "REINITIALISER",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ],

        ////// Center de Page ////////
        title: Center(
          child: Container(
            padding: EdgeInsets.all(5),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      ////////////// titre de bare de page /////////

                      child: Text(
                        'Filtres ',
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),

      /////// Body de Page ///////////

      body: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: <
            Widget>[
          ////// Body  //////

          ////// Horizontal divider ///////

          Container(
            padding: const EdgeInsets.all(10),
            child: Divider(),
          ),
////// Body  //////
          /// Filtres par Ville DeDepart ////
          Container(
            child: Column(
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.all(10),
                        child: Text(
                          "Ville Recuperation",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: InkWell(
                    onTap: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: 300,
                          child: DropdownSearch<String>(
                            mode: Mode.BOTTOM_SHEET,
                            items: Const.villes,
                            onChanged: (value) {
                              setState(() {
                                villeDeDepart = value;
                              });
                            },
                            selectedItem: villeDeDepart,
                            showSearchBox: true,
                            searchBoxDecoration: InputDecoration(
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.fromLTRB(12, 12, 8, 0),
                              labelText: "Rechercher une ville",
                            ),
                            popupTitle: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'Ville',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            popupShape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(24),
                                topRight: Radius.circular(24),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          /// Filtres par  Ville De Livraison ////
          Container(
            child: Column(
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.all(10),
                        child: Text(
                          "Ville Livraison",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: InkWell(
                    onTap: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: 300,
                          child: DropdownSearch<String>(
                            mode: Mode.BOTTOM_SHEET,
                            items: Const.villes,
                            onChanged: (value) {
                              setState(() {
                                villeDeLivraison = value;
                              });
                            },
                            selectedItem: villeDeLivraison,
                            showSearchBox: true,
                            searchBoxDecoration: InputDecoration(
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.fromLTRB(12, 12, 8, 0),
                              labelText: "Rechercher une ville",
                            ),
                            popupTitle: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'Ville',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            popupShape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(24),
                                topRight: Radius.circular(24),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          ////// Horizontal divider ///////

          Container(
            padding: const EdgeInsets.all(10),
            child: Divider(),
          ),

          /// Filtres Region Recuperation////
          Container(
            child: Column(
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.all(10),
                        child: Text(
                          "Région Recuperation",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: InkWell(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: 300,
                          child: DropdownSearch<String>(
                            mode: Mode.BOTTOM_SHEET,
                            items: Const.regions,
                            onChanged: (value) {
                              setState(() {
                                regionRecuperation = value;
                              });
                            },
                            selectedItem: regionRecuperation,
                            showSearchBox: true,
                            searchBoxDecoration: InputDecoration(
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.fromLTRB(12, 12, 8, 0),
                              labelText: "Rechercher une region",
                            ),
                            popupTitle: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'Region',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            popupShape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(24),
                                topRight: Radius.circular(24),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          /// Filtres Region Livraison////
          Container(
            child: Column(
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.all(10),
                        child: Text(
                          "Région Livraison",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: InkWell(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: 300,
                          child: DropdownSearch<String>(
                            mode: Mode.BOTTOM_SHEET,
                            items: Const.regions,
                            onChanged: (value) {
                              setState(() {
                                regionLivraison = value;
                              });
                            },
                            selectedItem: regionLivraison,
                            showSearchBox: true,
                            searchBoxDecoration: InputDecoration(
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.fromLTRB(12, 12, 8, 0),
                              labelText: "Rechercher une region",
                            ),
                            popupTitle: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'Region',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            popupShape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(24),
                                topRight: Radius.circular(24),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          ////// Horizontal divider ///////

          Container(
            padding: const EdgeInsets.all(10),
            child: Divider(),
          ),

          /// Filtres Date de livrasion /////
          Container(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        child: Text(
                          "Date de livrasion",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: DateTimeField(
                    controller: date,
                    format: format,
                    onShowPicker: (context, currentValue) {
                      setState(() {
                        dateLivraison = date.text.trim();
                      });
                      return showDatePicker(
                          builder: (BuildContext context, Widget child) {
                            return Theme(
                              data: ThemeData.light().copyWith(
                                colorScheme: ColorScheme.fromSwatch(
                                  primarySwatch: Colors.orange,
                                  primaryColorDark: Colors.orangeAccent,
                                  accentColor: Colors.orangeAccent,
                                ),
                                dialogBackgroundColor: Colors.white,
                              ),
                              child: child,
                            );
                          },
                          context: context,
                          locale: const Locale("fr", "FR"),
                          firstDate: DateTime(2020),
                          initialDate: DateTime.now(),
                          lastDate: DateTime(2100));
                    },
                  ),
                ),
              ],
            ),
          ),
          ////// Horizontal divider ///////

          Container(
            padding: const EdgeInsets.all(10),
            child: Divider(),
          ),

          /// Filtres Taille /////
          Container(
            child: Column(
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          "Taille",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Column(children: [
                    /////// Tout + Petite //////
                    Container(
                      child: Row(children: [
                        ////// Tout ///////
                        Container(
                          child: Card(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: Colors.blueGrey,
                                width: 1.0,
                              ),
                            ),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  taille = "Tout";
                                });
                              },
                              child: Row(
                                children: [
                                  Container(
                                    color: getColorTaille("Tout"),
                                    padding: const EdgeInsets.all(5),
                                    child: Text(
                                      "Tout ",
                                      style: TextStyle(
                                          color: Colors.orange,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Container(
                                    color: getColorTaille("Tout"),
                                    padding: const EdgeInsets.all(5),
                                    child: new FutureBuilder<List>(
                                      future: livraisonController
                                          .obtenirLivraisonsParIdLivreur(
                                              idLivreur,
                                              dateLivraison,
                                              contenu,
                                              nature,
                                              taille,
                                              poids,
                                              villeDeDepart,
                                              villeDeLivraison,
                                              regionRecuperation,
                                              regionLivraison,
                                              null),
                                      builder: (context, snapchot) {
                                        if (snapchot.hasError)
                                          print(snapchot.error);
                                        return snapchot.hasData
                                            ? Text(
                                                " (${snapchot.data.length})",
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              )
                                            : Text(
                                                "",
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        ////// Petite //////
                        Container(
                          child: Card(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: Colors.blueGrey,
                                width: 1.0,
                              ),
                            ),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  taille = "Petite";
                                });
                              },
                              child: Row(
                                children: [
                                  Container(
                                    color: getColorTaille("Petite"),
                                    padding: const EdgeInsets.all(5),
                                    child: Text(
                                      "Petite",
                                      style: TextStyle(
                                          color: Colors.orange,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Container(
                                    color: getColorTaille("Petite"),
                                    padding: const EdgeInsets.all(5),
                                    child: new FutureBuilder<List>(
                                      future: livraisonController
                                          .obtenirLivraisonsParIdLivreur(
                                              idLivreur,
                                              dateLivraison,
                                              contenu,
                                              nature,
                                              "Petite",
                                              poids,
                                              villeDeDepart,
                                              villeDeLivraison,
                                              regionRecuperation,
                                              regionLivraison,
                                              null),
                                      builder: (context, snapchot) {
                                        if (snapchot.hasError)
                                          print(snapchot.error);
                                        return snapchot.hasData
                                            ? Text(
                                                " (${snapchot.data.length})",
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              )
                                            : Text(
                                                "",
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ]),
                    ),
                    /////// Moyenne + Grand  ///////
                    Container(
                      child: Row(children: [
                        /////// Moyenne ////////
                        Container(
                          child: Card(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: Colors.blueGrey,
                                width: 1.0,
                              ),
                            ),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  taille = "Moyenne";
                                });
                              },
                              child: Row(
                                children: [
                                  Container(
                                    color: getColorTaille("Moyenne"),
                                    padding: const EdgeInsets.all(5),
                                    child: Text(
                                      "Moyenne ",
                                      style: TextStyle(
                                          color: Colors.orange,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Container(
                                    color: getColorTaille("Moyenne"),
                                    padding: const EdgeInsets.all(5),
                                    child: new FutureBuilder<List>(
                                      future: livraisonController
                                          .obtenirLivraisonsParIdLivreur(
                                              idLivreur,
                                              dateLivraison,
                                              contenu,
                                              nature,
                                              "Moyenne",
                                              poids,
                                              villeDeDepart,
                                              villeDeLivraison,
                                              regionRecuperation,
                                              regionLivraison,
                                              null),
                                      builder: (context, snapchot) {
                                        if (snapchot.hasError)
                                          print(snapchot.error);
                                        return snapchot.hasData
                                            ? Text(
                                                " (${snapchot.data.length})",
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              )
                                            : Text(
                                                "",
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        ////////// Grand //////////
                        Container(
                          child: Card(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: Colors.blueGrey,
                                width: 1.0,
                              ),
                            ),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  taille = "Grande";
                                });
                              },
                              child: Row(
                                children: [
                                  Container(
                                    color: getColorTaille("Grande"),
                                    padding: const EdgeInsets.all(5),
                                    child: Text(
                                      "Grande",
                                      style: TextStyle(
                                          color: Colors.orange,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Container(
                                    color: getColorTaille("Grande"),
                                    padding: const EdgeInsets.all(5),
                                    child: new FutureBuilder<List>(
                                      future: livraisonController
                                          .obtenirLivraisonsParIdLivreur(
                                              idLivreur,
                                              dateLivraison,
                                              contenu,
                                              nature,
                                              "Grande",
                                              poids,
                                              villeDeDepart,
                                              villeDeLivraison,
                                              regionRecuperation,
                                              regionLivraison,
                                              null),
                                      builder: (context, snapchot) {
                                        if (snapchot.hasError)
                                          print(snapchot.error);
                                        return snapchot.hasData
                                            ? Text(
                                                " (${snapchot.data.length})",
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              )
                                            : Text(
                                                "",
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ]),
                    ),
                  ]),
                ),
              ],
            ),
          ),
          ////// Horizontal divider ///////

          Container(
            padding: const EdgeInsets.all(10),
            child: Divider(),
          ),

          /// Filtres Poids /////
          Container(
            child: Column(
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          "Poids",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Column(children: [
                    /////// Tout + 0-5 kg //////
                    Container(
                      child: Row(children: [
                        ////// Tout ///////
                        Container(
                          child: Card(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: Colors.blueGrey,
                                width: 1.0,
                              ),
                            ),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  poids = "Tout";
                                });
                              },
                              child: Row(
                                children: [
                                  Container(
                                    color: getColorPoids("Tout"),
                                    padding: const EdgeInsets.all(5),
                                    child: Text(
                                      "Tout ",
                                      style: TextStyle(
                                          color: Colors.orange,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Container(
                                    color: getColorPoids("Tout"),
                                    padding: const EdgeInsets.all(5),
                                    child: new FutureBuilder<List>(
                                      future: livraisonController
                                          .obtenirLivraisonsParIdLivreur(
                                              idLivreur,
                                              dateLivraison,
                                              contenu,
                                              nature,
                                              taille,
                                              poids,
                                              villeDeDepart,
                                              villeDeLivraison,
                                              regionRecuperation,
                                              regionLivraison,
                                              null),
                                      builder: (context, snapchot) {
                                        if (snapchot.hasError)
                                          print(snapchot.error);
                                        return snapchot.hasData
                                            ? Text(
                                                " (${snapchot.data.length})",
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              )
                                            : Text(
                                                "",
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        ////// 0-10 Kg //////
                        Container(
                          child: Card(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: Colors.blueGrey,
                                width: 1.0,
                              ),
                            ),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  poids = "0 à 10";
                                });
                              },
                              child: Row(
                                children: [
                                  Container(
                                    color: getColorPoids("0 à 10"),
                                    padding: const EdgeInsets.all(5),
                                    child: Text(
                                      "0 à 10",
                                      style: TextStyle(
                                          color: Colors.orange,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Container(
                                    color: getColorPoids("0 à 10"),
                                    padding: const EdgeInsets.all(5),
                                    child: new FutureBuilder<List>(
                                      future: livraisonController
                                          .obtenirLivraisonsParIdLivreur(
                                              idLivreur,
                                              dateLivraison,
                                              contenu,
                                              nature,
                                              taille,
                                              "0 à 10",
                                              villeDeDepart,
                                              villeDeLivraison,
                                              regionRecuperation,
                                              regionLivraison,
                                              null),
                                      builder: (context, snapchot) {
                                        if (snapchot.hasError)
                                          print(snapchot.error);
                                        return snapchot.hasData
                                            ? Text(
                                                " (${snapchot.data.length})",
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              )
                                            : Text(
                                                "",
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ]),
                    ),
                    /////// 5-15Kg + 15Kg-30Kg  ///////
                    Container(
                      child: Row(children: [
                        /////// 5-15Kg ////////
                        Container(
                          child: Card(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: Colors.blueGrey,
                                width: 1.0,
                              ),
                            ),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  poids = "10 à 20";
                                });
                              },
                              child: Row(
                                children: [
                                  Container(
                                    color: getColorPoids("10 à 20"),
                                    padding: const EdgeInsets.all(5),
                                    child: Text(
                                      "10 à 20",
                                      style: TextStyle(
                                          color: Colors.orange,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Container(
                                    color: getColorPoids("10 à 20"),
                                    padding: const EdgeInsets.all(5),
                                    child: new FutureBuilder<List>(
                                      future: livraisonController
                                          .obtenirLivraisonsParIdLivreur(
                                              idLivreur,
                                              dateLivraison,
                                              contenu,
                                              nature,
                                              taille,
                                              "10 à 20",
                                              villeDeDepart,
                                              villeDeLivraison,
                                              regionRecuperation,
                                              regionLivraison,
                                              null),
                                      builder: (context, snapchot) {
                                        if (snapchot.hasError)
                                          print(snapchot.error);
                                        return snapchot.hasData
                                            ? Text(
                                                " (${snapchot.data.length})",
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              )
                                            : Text(
                                                "",
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        ////////// 15Kg-30Kg //////////
                        Container(
                          child: Card(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: Colors.blueGrey,
                                width: 1.0,
                              ),
                            ),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  poids = "20 à 30";
                                });
                              },
                              child: Row(
                                children: [
                                  Container(
                                    color: getColorPoids("20 à 30"),
                                    padding: const EdgeInsets.all(5),
                                    child: Text(
                                      "20 à 30",
                                      style: TextStyle(
                                          color: Colors.orange,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Container(
                                    color: getColorPoids("20 à 30"),
                                    padding: const EdgeInsets.all(5),
                                    child: new FutureBuilder<List>(
                                      future: livraisonController
                                          .obtenirLivraisonsParIdLivreur(
                                              idLivreur,
                                              dateLivraison,
                                              contenu,
                                              nature,
                                              taille,
                                              "20 à 30",
                                              villeDeDepart,
                                              villeDeLivraison,
                                              regionRecuperation,
                                              regionLivraison,
                                              null),
                                      builder: (context, snapchot) {
                                        if (snapchot.hasError)
                                          print(snapchot.error);
                                        return snapchot.hasData
                                            ? Text(
                                                " (${snapchot.data.length})",
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              )
                                            : Text(
                                                "",
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ]),
                    ),
                    /////// 30-50Kg + +50Kg  ///////
                    Container(
                      child: Row(children: [
                        /////// 30-50Kg ////////
                        Container(
                          child: Card(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: Colors.blueGrey,
                                width: 1.0,
                              ),
                            ),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  poids = "30 à 40";
                                });
                              },
                              child: Row(
                                children: [
                                  Container(
                                    color: getColorPoids("30 à 40"),
                                    padding: const EdgeInsets.all(5),
                                    child: Text(
                                      "30 à 40",
                                      style: TextStyle(
                                          color: Colors.orange,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Container(
                                    color: getColorPoids("30 à 40"),
                                    padding: const EdgeInsets.all(5),
                                    child: new FutureBuilder<List>(
                                      future: livraisonController
                                          .obtenirLivraisonsParIdLivreur(
                                              idLivreur,
                                              dateLivraison,
                                              contenu,
                                              nature,
                                              taille,
                                              "30 à 40",
                                              villeDeDepart,
                                              villeDeLivraison,
                                              regionRecuperation,
                                              regionLivraison,
                                              null),
                                      builder: (context, snapchot) {
                                        if (snapchot.hasError)
                                          print(snapchot.error);
                                        return snapchot.hasData
                                            ? Text(
                                                " (${snapchot.data.length})",
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              )
                                            : Text(
                                                "",
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        ////////// +50Kg //////////
                        Container(
                          child: Card(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: Colors.blueGrey,
                                width: 1.0,
                              ),
                            ),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  poids = "40 à 50";
                                });
                              },
                              child: Row(
                                children: [
                                  Container(
                                    color: getColorPoids("40 à 50"),
                                    padding: const EdgeInsets.all(5),
                                    child: Text(
                                      "40 à 50",
                                      style: TextStyle(
                                          color: Colors.orange,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Container(
                                    color: getColorPoids("40 à 50"),
                                    padding: const EdgeInsets.all(5),
                                    child: new FutureBuilder<List>(
                                      future: livraisonController
                                          .obtenirLivraisonsParIdLivreur(
                                              idLivreur,
                                              dateLivraison,
                                              contenu,
                                              nature,
                                              taille,
                                              "40 à 50",
                                              villeDeDepart,
                                              villeDeLivraison,
                                              regionRecuperation,
                                              regionLivraison,
                                              null),
                                      builder: (context, snapchot) {
                                        if (snapchot.hasError)
                                          print(snapchot.error);
                                        return snapchot.hasData
                                            ? Text(
                                                " (${snapchot.data.length})",
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              )
                                            : Text(
                                                "",
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ]),
                    ),
                    //////// +50
                    Container(
                      child: Row(
                        children: [
                          Container(
                            child: Card(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  color: Colors.blueGrey,
                                  width: 1.0,
                                ),
                              ),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    poids = "> 50";
                                  });
                                },
                                child: Row(
                                  children: [
                                    Container(
                                      color: getColorPoids("> 50"),
                                      padding: const EdgeInsets.all(5),
                                      child: Text(
                                        "> 50",
                                        style: TextStyle(
                                            color: Colors.orange,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      color: getColorPoids("> 50"),
                                      padding: const EdgeInsets.all(5),
                                      child: new FutureBuilder<List>(
                                        future: livraisonController
                                            .obtenirLivraisonsParIdLivreur(
                                                idLivreur,
                                                dateLivraison,
                                                contenu,
                                                nature,
                                                taille,
                                                "> 50",
                                                villeDeDepart,
                                                villeDeLivraison,
                                                regionRecuperation,
                                                regionLivraison,
                                                null),
                                        builder: (context, snapchot) {
                                          if (snapchot.hasError)
                                            print(snapchot.error);
                                          return snapchot.hasData
                                              ? Text(
                                                  " (${snapchot.data.length})",
                                                  style: TextStyle(
                                                      color: Colors.grey),
                                                )
                                              : Text(
                                                  "",
                                                  style: TextStyle(
                                                      color: Colors.grey),
                                                );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
                ),
              ],
            ),
          ),
          ////// Horizontal divider ///////

          Container(
            padding: const EdgeInsets.all(10),
            child: Divider(),
          ),

          /// Filtres Nature /////
          Container(
            child: Column(
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          "Nature",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Column(children: [
                    /////// Tout + Sensible //////
                    Container(
                      child: Row(children: [
                        ////// Tout ///////
                        Container(
                          child: Card(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: Colors.blueGrey,
                                width: 1.0,
                              ),
                            ),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  nature = "Tout";
                                });
                              },
                              child: Row(
                                children: [
                                  Container(
                                    color: getColorNature("Tout"),
                                    padding: const EdgeInsets.all(5),
                                    child: Text(
                                      "Tout ",
                                      style: TextStyle(
                                          color: Colors.orange,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Container(
                                    color: getColorNature("Tout"),
                                    padding: const EdgeInsets.all(5),
                                    child: new FutureBuilder<List>(
                                      future: livraisonController
                                          .obtenirLivraisonsParIdLivreur(
                                              idLivreur,
                                              dateLivraison,
                                              contenu,
                                              nature,
                                              taille,
                                              poids,
                                              regionRecuperation,
                                              regionLivraison,
                                              villeDeDepart,
                                              villeDeLivraison,
                                              null),
                                      builder: (context, snapchot) {
                                        if (snapchot.hasError)
                                          print(snapchot.error);
                                        return snapchot.hasData
                                            ? Text(
                                                " (${snapchot.data.length})",
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              )
                                            : Text(
                                                "",
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        ////// Nature1 //////
                        Container(
                          child: Card(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: Colors.blueGrey,
                                width: 1.0,
                              ),
                            ),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  nature = "Lourd";
                                });
                              },
                              child: Row(
                                children: [
                                  Container(
                                    color: getColorNature("Lourd"),
                                    padding: const EdgeInsets.all(5),
                                    child: Text(
                                      "Lourd",
                                      style: TextStyle(
                                          color: Colors.orange,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Container(
                                    color: getColorNature("Lourd"),
                                    padding: const EdgeInsets.all(5),
                                    child: new FutureBuilder<List>(
                                      future: livraisonController
                                          .obtenirLivraisonsParIdLivreur(
                                              idLivreur,
                                              dateLivraison,
                                              contenu,
                                              "Lourd",
                                              taille,
                                              poids,
                                              villeDeDepart,
                                              villeDeLivraison,
                                              regionRecuperation,
                                              regionLivraison,
                                              null),
                                      builder: (context, snapchot) {
                                        if (snapchot.hasError)
                                          print(snapchot.error);
                                        return snapchot.hasData
                                            ? Text(
                                                " (${snapchot.data.length})",
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              )
                                            : Text(
                                                "",
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ]),
                    ),
                    /////// Nature2 + Nature 3   ///////
                    Container(
                      child: Row(children: [
                        /////// Nature2 ////////
                        Container(
                          child: Card(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: Colors.blueGrey,
                                width: 1.0,
                              ),
                            ),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  nature = "Léger";
                                });
                              },
                              child: Row(
                                children: [
                                  Container(
                                    color: getColorNature("Léger"),
                                    padding: const EdgeInsets.all(5),
                                    child: Text(
                                      "Léger",
                                      style: TextStyle(
                                          color: Colors.orange,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Container(
                                    color: getColorNature("Léger"),
                                    padding: const EdgeInsets.all(5),
                                    child: new FutureBuilder<List>(
                                      future: livraisonController
                                          .obtenirLivraisonsParIdLivreur(
                                              idLivreur,
                                              dateLivraison,
                                              contenu,
                                              "Léger",
                                              taille,
                                              poids,
                                              villeDeDepart,
                                              villeDeLivraison,
                                              regionRecuperation,
                                              regionLivraison,
                                              null),
                                      builder: (context, snapchot) {
                                        if (snapchot.hasError)
                                          print(snapchot.error);
                                        return snapchot.hasData
                                            ? Text(
                                                " (${snapchot.data.length})",
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              )
                                            : Text(
                                                "",
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        ////////// Nature 3 //////////
                        Container(
                          child: Card(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: Colors.blueGrey,
                                width: 1.0,
                              ),
                            ),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  nature = "Sensible";
                                });
                              },
                              child: Row(
                                children: [
                                  Container(
                                    color: getColorNature("Sensible"),
                                    padding: const EdgeInsets.all(5),
                                    child: Text(
                                      "Sensible",
                                      style: TextStyle(
                                          color: Colors.orange,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Container(
                                    color: getColorNature("Sensible"),
                                    padding: const EdgeInsets.all(5),
                                    child: new FutureBuilder<List>(
                                      future: livraisonController
                                          .obtenirLivraisonsParIdLivreur(
                                              idLivreur,
                                              dateLivraison,
                                              contenu,
                                              "Sensible",
                                              taille,
                                              poids,
                                              villeDeDepart,
                                              villeDeLivraison,
                                              regionRecuperation,
                                              regionLivraison,
                                              null),
                                      builder: (context, snapchot) {
                                        if (snapchot.hasError)
                                          print(snapchot.error);
                                        return snapchot.hasData
                                            ? Text(
                                                " (${snapchot.data.length})",
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              )
                                            : Text(
                                                "",
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ]),
                    ),
                    /////// Nature 4  + Autres ///////
                    Container(
                      child: Row(children: [
                        /////// Nature 4  ////////
                        Container(
                          child: Card(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: Colors.blueGrey,
                                width: 1.0,
                              ),
                            ),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  nature = "Garder au frais";
                                });
                              },
                              child: Row(
                                children: [
                                  Container(
                                    color: getColorNature("Garder au frais"),
                                    padding: const EdgeInsets.all(5),
                                    child: Text(
                                      "Garder au frais",
                                      style: TextStyle(
                                          color: Colors.orange,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Container(
                                    color: getColorNature("Garder au frais"),
                                    padding: const EdgeInsets.all(5),
                                    child: new FutureBuilder<List>(
                                      future: livraisonController
                                          .obtenirLivraisonsParIdLivreur(
                                              idLivreur,
                                              dateLivraison,
                                              contenu,
                                              "Garder au frais",
                                              taille,
                                              poids,
                                              villeDeDepart,
                                              villeDeLivraison,
                                              regionRecuperation,
                                              regionLivraison,
                                              null),
                                      builder: (context, snapchot) {
                                        if (snapchot.hasError)
                                          print(snapchot.error);
                                        return snapchot.hasData
                                            ? Text(
                                                " (${snapchot.data.length})",
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              )
                                            : Text(
                                                "",
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ]),
                    ),
                  ]),
                ),
              ],
            ),
          ),
          ////// Horizontal divider ///////

          Container(
            padding: const EdgeInsets.all(10),
            child: Divider(),
          ),

          /// Filtres Contenu /////
          Container(
            child: Column(
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          "Contenu",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Column(children: [
                    ////// Tout ///////
                    Container(
                      child: Row(
                        children: [
                          Container(
                            child: Card(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  color: Colors.blueGrey,
                                  width: 1.0,
                                ),
                              ),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    contenu = "Tout";
                                  });
                                },
                                child: Row(
                                  children: [
                                    Container(
                                      color: getColorContenu("Tout"),
                                      padding: const EdgeInsets.all(5),
                                      child: Text(
                                        "Tout",
                                        style: TextStyle(
                                            color: Colors.orange,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      color: getColorContenu("Tout"),
                                      padding: const EdgeInsets.all(5),
                                      child: new FutureBuilder<List>(
                                        future: livraisonController
                                            .obtenirLivraisonsParIdLivreur(
                                                idLivreur,
                                                dateLivraison,
                                                contenu,
                                                nature,
                                                taille,
                                                poids,
                                                villeDeDepart,
                                                villeDeLivraison,
                                                regionRecuperation,
                                                regionLivraison,
                                                null),
                                        builder: (context, snapchot) {
                                          if (snapchot.hasError)
                                            print(snapchot.error);
                                          return snapchot.hasData
                                              ? Text(
                                                  " (${snapchot.data.length})",
                                                  style: TextStyle(
                                                      color: Colors.grey),
                                                )
                                              : Text(
                                                  "",
                                                  style: TextStyle(
                                                      color: Colors.grey),
                                                );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ////// Produits d\'ameublement ///////
                    Container(
                      child: Row(
                        children: [
                          Container(
                            child: Card(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  color: Colors.blueGrey,
                                  width: 1.0,
                                ),
                              ),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    contenu = "Produits d\'ameublement";
                                  });
                                },
                                child: Row(
                                  children: [
                                    Container(
                                      color: getColorContenu(
                                          "Produits d\'ameublement"),
                                      padding: const EdgeInsets.all(5),
                                      child: Text(
                                        "Produits d\'ameublement",
                                        style: TextStyle(
                                            color: Colors.orange,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      color: getColorContenu(
                                          "Produits d\'ameublement"),
                                      padding: const EdgeInsets.all(5),
                                      child: new FutureBuilder<List>(
                                        future: livraisonController
                                            .obtenirLivraisonsParIdLivreur(
                                                idLivreur,
                                                dateLivraison,
                                                "Produits d\'ameublement",
                                                nature,
                                                taille,
                                                poids,
                                                villeDeDepart,
                                                villeDeLivraison,
                                                regionRecuperation,
                                                regionLivraison,
                                                null),
                                        builder: (context, snapchot) {
                                          if (snapchot.hasError)
                                            print(snapchot.error);
                                          return snapchot.hasData
                                              ? Text(
                                                  " (${snapchot.data.length})",
                                                  style: TextStyle(
                                                      color: Colors.grey),
                                                )
                                              : Text(
                                                  "",
                                                  style: TextStyle(
                                                      color: Colors.grey),
                                                );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    /////// Produits outillage ////////
                    Container(
                      child: Row(
                        children: [
                          Container(
                            child: Card(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  color: Colors.blueGrey,
                                  width: 1.0,
                                ),
                              ),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    contenu = "Produits outillage";
                                  });
                                },
                                child: Row(
                                  children: [
                                    Container(
                                      color:
                                          getColorContenu("Produits outillage"),
                                      padding: const EdgeInsets.all(5),
                                      child: Text(
                                        "Produits outillage",
                                        style: TextStyle(
                                            color: Colors.orange,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      color:
                                          getColorContenu("Produits outillage"),
                                      padding: const EdgeInsets.all(5),
                                      child: new FutureBuilder<List>(
                                        future: livraisonController
                                            .obtenirLivraisonsParIdLivreur(
                                                idLivreur,
                                                dateLivraison,
                                                "Produits outillage",
                                                nature,
                                                taille,
                                                poids,
                                                villeDeDepart,
                                                villeDeLivraison,
                                                regionRecuperation,
                                                regionLivraison,
                                                null),
                                        builder: (context, snapchot) {
                                          if (snapchot.hasError)
                                            print(snapchot.error);
                                          return snapchot.hasData
                                              ? Text(
                                                  " (${snapchot.data.length})",
                                                  style: TextStyle(
                                                      color: Colors.grey),
                                                )
                                              : Text(
                                                  "",
                                                  style: TextStyle(
                                                      color: Colors.grey),
                                                );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ////////// Articles ménagers //////////
                    Container(
                      child: Row(
                        children: [
                          Container(
                            child: Card(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  color: Colors.blueGrey,
                                  width: 1.0,
                                ),
                              ),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    contenu = "Articles ménagers";
                                  });
                                },
                                child: Row(
                                  children: [
                                    Container(
                                      color:
                                          getColorContenu("Articles ménagers"),
                                      padding: const EdgeInsets.all(5),
                                      child: Text(
                                        "Articles ménagers",
                                        style: TextStyle(
                                            color: Colors.orange,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      color:
                                          getColorContenu("Articles ménagers"),
                                      padding: const EdgeInsets.all(5),
                                      child: new FutureBuilder<List>(
                                        future: livraisonController
                                            .obtenirLivraisonsParIdLivreur(
                                                idLivreur,
                                                dateLivraison,
                                                "Articles ménagers",
                                                nature,
                                                taille,
                                                poids,
                                                villeDeDepart,
                                                villeDeLivraison,
                                                regionRecuperation,
                                                regionLivraison,
                                                null),
                                        builder: (context, snapchot) {
                                          if (snapchot.hasError)
                                            print(snapchot.error);
                                          return snapchot.hasData
                                              ? Text(
                                                  " (${snapchot.data.length})",
                                                  style: TextStyle(
                                                      color: Colors.grey),
                                                )
                                              : Text(
                                                  "",
                                                  style: TextStyle(
                                                      color: Colors.grey),
                                                );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    /////// Produits alimentaire  ////////
                    Container(
                      child: Row(
                        children: [
                          Container(
                            child: Card(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  color: Colors.blueGrey,
                                  width: 1.0,
                                ),
                              ),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    contenu = "Produits alimentaire";
                                  });
                                },
                                child: Row(
                                  children: [
                                    Container(
                                      color: getColorContenu(
                                          "Produits alimentaire"),
                                      padding: const EdgeInsets.all(5),
                                      child: Text(
                                        "Produits alimentaire",
                                        style: TextStyle(
                                            color: Colors.orange,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      color: getColorContenu(
                                          "Produits alimentaire"),
                                      padding: const EdgeInsets.all(5),
                                      child: new FutureBuilder<List>(
                                        future: livraisonController
                                            .obtenirLivraisonsParIdLivreur(
                                                idLivreur,
                                                dateLivraison,
                                                "Produits alimentaire",
                                                nature,
                                                taille,
                                                poids,
                                                villeDeDepart,
                                                villeDeLivraison,
                                                regionRecuperation,
                                                regionLivraison,
                                                null),
                                        builder: (context, snapchot) {
                                          if (snapchot.hasError)
                                            print(snapchot.error);
                                          return snapchot.hasData
                                              ? Text(
                                                  " (${snapchot.data.length})",
                                                  style: TextStyle(
                                                      color: Colors.grey),
                                                )
                                              : Text(
                                                  "",
                                                  style: TextStyle(
                                                      color: Colors.grey),
                                                );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ////////// Accessoires de voyage //////////
                    Container(
                      child: Row(
                        children: [
                          Container(
                            child: Card(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  color: Colors.blueGrey,
                                  width: 1.0,
                                ),
                              ),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    contenu = "Accessoires de voyage";
                                  });
                                },
                                child: Row(
                                  children: [
                                    Container(
                                      color: getColorContenu(
                                          "Accessoires de voyage"),
                                      padding: const EdgeInsets.all(5),
                                      child: Text(
                                        "Accessoires de voyage",
                                        style: TextStyle(
                                            color: Colors.orange,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      color: getColorContenu(
                                          "Accessoires de voyage"),
                                      padding: const EdgeInsets.all(5),
                                      child: new FutureBuilder<List>(
                                        future: livraisonController
                                            .obtenirLivraisonsParIdLivreur(
                                                idLivreur,
                                                dateLivraison,
                                                "Accessoires de voyage",
                                                nature,
                                                taille,
                                                poids,
                                                villeDeDepart,
                                                villeDeLivraison,
                                                regionRecuperation,
                                                regionLivraison,
                                                null),
                                        builder: (context, snapchot) {
                                          if (snapchot.hasError)
                                            print(snapchot.error);
                                          return snapchot.hasData
                                              ? Text(
                                                  " (${snapchot.data.length})",
                                                  style: TextStyle(
                                                      color: Colors.grey),
                                                )
                                              : Text(
                                                  "",
                                                  style: TextStyle(
                                                      color: Colors.grey),
                                                );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    /////// Animaux domestiques ///////

                    Container(
                      child: Row(
                        children: [
                          Container(
                            child: Card(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  color: Colors.blueGrey,
                                  width: 1.0,
                                ),
                              ),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    contenu = "Animaux domestiques";
                                  });
                                },
                                child: Row(
                                  children: [
                                    Container(
                                      color: getColorContenu(
                                          "Animaux domestiques"),
                                      padding: const EdgeInsets.all(5),
                                      child: Text(
                                        "Animaux domestiques",
                                        style: TextStyle(
                                            color: Colors.orange,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      color: getColorContenu(
                                          "Animaux domestiques"),
                                      padding: const EdgeInsets.all(5),
                                      child: new FutureBuilder<List>(
                                        future: livraisonController
                                            .obtenirLivraisonsParIdLivreur(
                                                idLivreur,
                                                dateLivraison,
                                                "Animaux domestiques",
                                                nature,
                                                taille,
                                                poids,
                                                villeDeDepart,
                                                villeDeLivraison,
                                                regionRecuperation,
                                                regionLivraison,
                                                null),
                                        builder: (context, snapchot) {
                                          if (snapchot.hasError)
                                            print(snapchot.error);
                                          return snapchot.hasData
                                              ? Text(
                                                  " (${snapchot.data.length})",
                                                  style: TextStyle(
                                                      color: Colors.grey),
                                                )
                                              : Text(
                                                  "",
                                                  style: TextStyle(
                                                      color: Colors.grey),
                                                );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ////////// Produits électronique, informatique et divertissement //////////
                    Container(
                      child: Row(
                        children: [
                          Container(
                            child: Card(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  color: Colors.blueGrey,
                                  width: 1.0,
                                ),
                              ),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    contenu =
                                        "Produits électronique, informatique et divertissement";
                                  });
                                },
                                child: Row(
                                  children: [
                                    Container(
                                      color: getColorContenu(
                                          "Produits électronique, informatique et divertissement"),
                                      padding: const EdgeInsets.all(5),
                                      child: Text(
                                        "Produits électronique, \ninformatique et divertissement",
                                        style: TextStyle(
                                            color: Colors.orange,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      color: getColorContenu(
                                          "Produits électronique, informatique et divertissement"),
                                      padding: const EdgeInsets.all(5),
                                      child: new FutureBuilder<List>(
                                        future: livraisonController
                                            .obtenirLivraisonsParIdLivreur(
                                                idLivreur,
                                                dateLivraison,
                                                "Produits électronique, informatique et divertissement",
                                                nature,
                                                taille,
                                                poids,
                                                villeDeDepart,
                                                villeDeLivraison,
                                                regionRecuperation,
                                                regionLivraison,
                                                null),
                                        builder: (context, snapchot) {
                                          if (snapchot.hasError)
                                            print(snapchot.error);
                                          return snapchot.hasData
                                              ? Text(
                                                  " (${snapchot.data.length})",
                                                  style: TextStyle(
                                                      color: Colors.grey),
                                                )
                                              : Text(
                                                  "",
                                                  style: TextStyle(
                                                      color: Colors.grey),
                                                );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    /////// Autres produits  ////////
                    Container(
                      child: Row(
                        children: [
                          Container(
                            child: Card(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  color: Colors.blueGrey,
                                  width: 1.0,
                                ),
                              ),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    contenu = "Autres produits";
                                  });
                                },
                                child: Row(
                                  children: [
                                    Container(
                                      color: getColorContenu("Autres produits"),
                                      padding: const EdgeInsets.all(5),
                                      child: Text(
                                        "Autres produits",
                                        style: TextStyle(
                                            color: Colors.orange,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      color: getColorContenu("Autres produits"),
                                      padding: const EdgeInsets.all(5),
                                      child: new FutureBuilder<List>(
                                        future: livraisonController
                                            .obtenirLivraisonsParIdLivreur(
                                                idLivreur,
                                                dateLivraison,
                                                "Autres produits",
                                                nature,
                                                taille,
                                                poids,
                                                villeDeDepart,
                                                villeDeLivraison,
                                                regionRecuperation,
                                                regionLivraison,
                                                null),
                                        builder: (context, snapchot) {
                                          if (snapchot.hasError)
                                            print(snapchot.error);
                                          return snapchot.hasData
                                              ? Text(
                                                  " (${snapchot.data.length})",
                                                  style: TextStyle(
                                                      color: Colors.grey),
                                                )
                                              : Text(
                                                  "",
                                                  style: TextStyle(
                                                      color: Colors.grey),
                                                );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
                ),
              ],
            ),
          ),

          /// Button Filtrer /////
          Container(
            margin: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  // ignore: deprecated_member_use
                  child: FlatButton(
                    onPressed: () => {
                      dateLivraison = date.text.trim(),
                      print(dateLivraison),
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FutursLivraisonLivreur(
                                    dateLivraison: '$dateLivraison',
                                    contenu: "$contenu",
                                    nature: "$nature",
                                    taille: '$taille',
                                    poids: "$poids",
                                    regionRecuperation: '$regionRecuperation',
                                    regionLivraison: '$regionLivraison',
                                    villeDeDepart: '$villeDeDepart',
                                    villeDeLivraison: '$villeDeLivraison',
                                  ))),
                    },
                    child: Text(
                      "Filtrer",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.0,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    color: Colors.orange,
                    disabledColor: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
