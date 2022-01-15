import 'package:flutter/cupertino.dart';
////////// filtresListeLivreurs
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:livreurs_app/Controllers/userController.dart';
import 'package:livreurs_app/views/Accueil/Client/ListeLivreurs/listeLivreurs.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:livreurs_app/const.dart' as Const;

import '../../accueilClient.dart';

/// This Widget is the main application widget.
class FiltresListeLivreurs extends StatefulWidget {
  @override
  _FiltresListeLivreursState createState() => _FiltresListeLivreursState();
}

class _FiltresListeLivreursState extends State<FiltresListeLivreurs> {
  String dropdownVille = "Tout";
  String dropdownRegion = "Tout";
  String nbEtoiles = "Tout";
  String transport = "Tout";
  UserController userController = new UserController();

  Color getColorNbEtoiles(String index) {
    if (nbEtoiles == index) {
      return Colors.black;
    } else {
      return Colors.white;
    }
  }

  Color getColorTransport(String moyen) {
    if (moyen == transport) {
      return Colors.black;
    } else {
      return Colors.white;
    }
  }

  bool _isVisibleRegion = false;

  void voirPlus() {
    setState(() {
      _isVisibleRegion = true;
    });
  }

  void voirMoins() {
    setState(() {
      _isVisibleRegion = !_isVisibleRegion;
    });
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_element

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
                    // Resetting the values to initial ones which were passed
                    nbEtoiles = "Tout";
                    dropdownVille = "Tout";
                    dropdownRegion = "Tout";
                    transport = "Tout";
                  });
                },
                child: Text(
                  "REINITIALISER",
                  style: TextStyle(
                    fontSize: 15,
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
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      ////////////// titre de bare de page /////////
                      child: Text(
                        'Cherche livreur',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
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
          /// Filtres  Ville ////
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
                          "Ville",
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
                            items: Const.villes,
                            onChanged: (value) {
                              setState(() {
                                dropdownVille = value;
                              });
                            },
                            selectedItem: dropdownVille,
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

          /// Filtres Region ////
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
                          "Région",
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
                                dropdownRegion = value;
                              });
                            },
                            selectedItem: dropdownRegion,
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

          /// Filtres Nombre d'etoiles /////
          Container(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        child: Text(
                          "Nombre d'étoiles",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Column(children: [
                    /////// Tout + 1 + 2 //////
                    Container(
                      child: Row(children: [
                        ////// Tout ///////
                        Container(
                          padding: const EdgeInsets.all(10),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: Colors.blueGrey,
                                width: 1.0,
                              ),
                            ),
                            child: InkWell(
                              onTap: voirMoins,
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    nbEtoiles = "Tout";
                                  });
                                },
                                child: Row(
                                  children: [
                                    Container(
                                      color: getColorNbEtoiles("Tout"),
                                      padding: const EdgeInsets.all(5),
                                      child: Text(
                                        "Tout ",
                                        style: TextStyle(
                                            color: Colors.orange,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      color: getColorNbEtoiles("Tout"),
                                      padding: const EdgeInsets.all(5),
                                      child: new FutureBuilder<List>(
                                        future:
                                            userController.obtenirTousLivreurs(
                                                dropdownVille,
                                                dropdownRegion,
                                                nbEtoiles,
                                                transport,
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
                        ),
                        ////// 1 //////
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
                                  nbEtoiles = "1";
                                });
                              },
                              child: Row(
                                children: [
                                  Container(
                                    color: getColorNbEtoiles("1"),
                                    padding: const EdgeInsets.all(5),
                                    child: Text(
                                      "1 ",
                                      style: TextStyle(
                                          color: Colors.orange,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Container(
                                    color: getColorNbEtoiles("1"),
                                    padding: const EdgeInsets.all(5),
                                    child: new FutureBuilder<List>(
                                      future:
                                          userController.obtenirTousLivreurs(
                                              dropdownVille,
                                              dropdownRegion,
                                              "1",
                                              transport,
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
                        //////// 2 /////////
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
                                  nbEtoiles = "2";
                                });
                              },
                              child: Row(
                                children: [
                                  Container(
                                    color: getColorNbEtoiles("2"),
                                    padding: const EdgeInsets.all(5),
                                    child: Text(
                                      "2",
                                      style: TextStyle(
                                          color: Colors.orange,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Container(
                                    color: getColorNbEtoiles("2"),
                                    padding: const EdgeInsets.all(5),
                                    child: new FutureBuilder<List>(
                                      future:
                                          userController.obtenirTousLivreurs(
                                              dropdownVille,
                                              dropdownRegion,
                                              "2",
                                              transport,
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
                    /////// 3 + 4 + 5 ///////
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: Row(children: [
                        /////// 3 ////////
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
                                  nbEtoiles = "3";
                                });
                              },
                              child: Row(
                                children: [
                                  Container(
                                    color: getColorNbEtoiles("3"),
                                    padding: const EdgeInsets.all(5),
                                    child: Text(
                                      "3",
                                      style: TextStyle(
                                          color: Colors.orange,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Container(
                                    color: getColorNbEtoiles("3"),
                                    padding: const EdgeInsets.all(5),
                                    child: new FutureBuilder<List>(
                                      future:
                                          userController.obtenirTousLivreurs(
                                              dropdownVille,
                                              dropdownRegion,
                                              "3",
                                              transport,
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
                        ////////// 4 //////////
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
                                  nbEtoiles = "4";
                                });
                              },
                              child: Row(
                                children: [
                                  Container(
                                    color: getColorNbEtoiles("4"),
                                    padding: const EdgeInsets.all(5),
                                    child: Text(
                                      "4",
                                      style: TextStyle(
                                          color: Colors.orange,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Container(
                                    color: getColorNbEtoiles("4"),
                                    padding: const EdgeInsets.all(5),
                                    child: new FutureBuilder<List>(
                                      future:
                                          userController.obtenirTousLivreurs(
                                              dropdownVille,
                                              dropdownRegion,
                                              "4",
                                              transport,
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
                        ////////// 5 ////////////
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
                                  nbEtoiles = "5";
                                });
                              },
                              child: Row(
                                children: [
                                  Container(
                                    color: getColorNbEtoiles("5"),
                                    padding: const EdgeInsets.all(5),
                                    child: Text(
                                      "5 ",
                                      style: TextStyle(
                                          color: Colors.orange,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Container(
                                    color: getColorNbEtoiles("5"),
                                    padding: const EdgeInsets.all(5),
                                    child: new FutureBuilder<List>(
                                      future:
                                          userController.obtenirTousLivreurs(
                                              dropdownVille,
                                              dropdownRegion,
                                              "5",
                                              transport,
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

          /// Filtres Moyen transport /////
          Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        child: Text(
                          "Moyen transport",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Column(children: [
                    /////// Tout + Voiture + Camion //////
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
                              onTap: voirMoins,
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    transport = "Tout";
                                  });
                                },
                                child: Row(
                                  children: [
                                    Container(
                                      color: getColorTransport("Tout"),
                                      padding: const EdgeInsets.all(5),
                                      child: Text(
                                        "Tout ",
                                        style: TextStyle(
                                            color: Colors.orange,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      color: getColorTransport("Tout"),
                                      padding: const EdgeInsets.all(5),
                                      child: new FutureBuilder<List>(
                                        future:
                                            userController.obtenirTousLivreurs(
                                                dropdownVille,
                                                dropdownRegion,
                                                nbEtoiles,
                                                transport,
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
                        ),
                        ////// Voiture //////
                        Container(
                          child: Card(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: Colors.blueGrey,
                                width: 1.0,
                              ),
                            ),
                            child: InkWell(
                              onTap: voirMoins,
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    transport = "Voiture";
                                  });
                                },
                                child: Row(
                                  children: [
                                    Container(
                                      color: getColorTransport("Voiture"),
                                      padding: const EdgeInsets.all(5),
                                      child: Text(
                                        "Voiture ",
                                        style: TextStyle(
                                            color: Colors.orange,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      color: getColorTransport("Voiture"),
                                      padding: const EdgeInsets.all(5),
                                      child: new FutureBuilder<List>(
                                        future:
                                            userController.obtenirTousLivreurs(
                                                dropdownVille,
                                                dropdownRegion,
                                                nbEtoiles,
                                                "Voiture",
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
                        ),
                        //////// Camion /////////
                        Container(
                          child: Card(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: Colors.blueGrey,
                                width: 1.0,
                              ),
                            ),
                            child: InkWell(
                              onTap: voirMoins,
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    transport = "Camion";
                                  });
                                },
                                child: Row(
                                  children: [
                                    Container(
                                      color: getColorTransport("Camion"),
                                      padding: const EdgeInsets.all(5),
                                      child: Text(
                                        "Camion ",
                                        style: TextStyle(
                                            color: Colors.orange,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      color: getColorTransport("Camion"),
                                      padding: const EdgeInsets.all(5),
                                      child: new FutureBuilder<List>(
                                        future:
                                            userController.obtenirTousLivreurs(
                                                dropdownVille,
                                                dropdownRegion,
                                                nbEtoiles,
                                                "Camion",
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
                        ),
                      ]),
                    ),
                    /////// Moto + Autre ///////
                    Container(
                      child: Row(children: [
                        Container(
                          child: Card(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: Colors.blueGrey,
                                width: 1.0,
                              ),
                            ),
                            child: InkWell(
                              onTap: voirMoins,
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    transport = "Moto";
                                  });
                                },
                                child: Row(
                                  children: [
                                    Container(
                                      color: getColorTransport("Moto"),
                                      padding: const EdgeInsets.all(5),
                                      child: Text(
                                        "Moto ",
                                        style: TextStyle(
                                            color: Colors.orange,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      color: getColorTransport("Moto"),
                                      padding: const EdgeInsets.all(5),
                                      child: new FutureBuilder<List>(
                                        future:
                                            userController.obtenirTousLivreurs(
                                                dropdownVille,
                                                dropdownRegion,
                                                nbEtoiles,
                                                "Moto",
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
                        ),
                        ////////// Pickup //////////
                        Container(
                          child: Card(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: Colors.blueGrey,
                                width: 1.0,
                              ),
                            ),
                            child: InkWell(
                              onTap: voirMoins,
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    transport = "Pickup";
                                  });
                                },
                                child: Row(
                                  children: [
                                    Container(
                                      color: getColorTransport("Pickup"),
                                      padding: const EdgeInsets.all(5),
                                      child: Text(
                                        "Pickup ",
                                        style: TextStyle(
                                            color: Colors.orange,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      color: getColorTransport("Pickup"),
                                      padding: const EdgeInsets.all(5),
                                      child: new FutureBuilder<List>(
                                        future:
                                            userController.obtenirTousLivreurs(
                                                dropdownVille,
                                                dropdownRegion,
                                                nbEtoiles,
                                                "Pickup",
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
                        ),
                        ////////// taxi //////////
                        Container(
                          child: Card(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: Colors.blueGrey,
                                width: 1.0,
                              ),
                            ),
                            child: InkWell(
                              onTap: voirMoins,
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    transport = "Taxi";
                                  });
                                },
                                child: Row(
                                  children: [
                                    Container(
                                      color: getColorTransport("Taxi"),
                                      padding: const EdgeInsets.all(5),
                                      child: Text(
                                        "Taxi ",
                                        style: TextStyle(
                                            color: Colors.orange,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      color: getColorTransport("Taxi"),
                                      padding: const EdgeInsets.all(5),
                                      child: new FutureBuilder<List>(
                                        future:
                                            userController.obtenirTousLivreurs(
                                                dropdownVille,
                                                dropdownRegion,
                                                nbEtoiles,
                                                "Taxi",
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
                        ),
                      ]),
                    ),
                    ///////// Vélo /////////////
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
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
                                onTap: voirMoins,
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      transport = "Vélo";
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      Container(
                                        color: getColorTransport("Vélo"),
                                        padding: const EdgeInsets.all(5),
                                        child: Text(
                                          "Vélo ",
                                          style: TextStyle(
                                              color: Colors.orange,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Container(
                                        color: getColorTransport("Vélo"),
                                        padding: const EdgeInsets.all(5),
                                        child: new FutureBuilder<List>(
                                          future: userController
                                              .obtenirTousLivreurs(
                                                  dropdownVille,
                                                  dropdownRegion,
                                                  nbEtoiles,
                                                  "Vélo",
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  // ignore: deprecated_member_use
                  child: FlatButton(
                    onPressed: () => {
                      Navigator.pop(context),
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => listeLivreurs(
                                  ville: dropdownVille,
                                  region: dropdownRegion,
                                  note: nbEtoiles,
                                  transport: transport))),
                    },
                    child: Text(
                      "Filtrer",
                      textDirection: TextDirection.ltr,
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
