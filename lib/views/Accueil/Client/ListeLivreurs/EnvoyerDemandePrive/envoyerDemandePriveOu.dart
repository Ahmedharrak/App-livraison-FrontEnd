import 'package:easy_gradient_text/easy_gradient_text.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:livreurs_app/views/Accueil/Client/ListeLivreurs/EnvoyerDemandePrive/envoyerDemandePriveComment.dart';

import 'package:livreurs_app/Controllers/demandeController.dart';

import 'package:dropdown_search/dropdown_search.dart';

import '../../../accueilClient.dart';
import 'package:livreurs_app/const.dart' as Const;

/// This Widget is the main application widget.
class EnvoyerDemandePriveOu extends StatefulWidget {
  final String idLivreur;
  EnvoyerDemandePriveOu({Key key, this.idLivreur}) : super(key: key);
  @override
  EnvoyerDemandePriveOuState createState() =>
      EnvoyerDemandePriveOuState(idLivreur);
}

class EnvoyerDemandePriveOuState extends State<EnvoyerDemandePriveOu> {
  String idLivreur;
  EnvoyerDemandePriveOuState(this.idLivreur);
  DemandeController demandeController = new DemandeController();

  String dropdownDepart = 'à choisir';
  String dropdownLivraison = 'à choisir';
  TextEditingController adresseRecuperation = new TextEditingController();
  TextEditingController adresseLivraison = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //////// AppBar du Page ///////
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        iconTheme: IconThemeData(color: Colors.black),
        actions: <Widget>[
          ////////////// icone home //////////////
          IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AccueilClient()),
                );
              })
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
                        'Envoyer une demande',
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              child: new Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Column(children: <Widget>[
                      Image(
                        image: new AssetImage("assets/oneActive.png"),
                        width: 40,
                        height: 40,
                        color: null,
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.center,
                      ),
                      // Text(
                      //   'Où?',
                      //   style: TextStyle(fontWeight: FontWeight.bold),
                      // ),
                    ]),
                  ),
                  Expanded(
                      flex: 1,
                      child: Container(
                        width: 20,
                        height: 5, // Thickness
                        color: Colors.grey,
                      )),
                  Expanded(
                    flex: 1,
                    child: Column(children: <Widget>[
                      Image(
                        image: new AssetImage("assets/twoD.png"),
                        width: 40,
                        height: 40,
                        color: null,
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.center,
                      ),
                      // Text(
                      //   'Comment?',
                      //   style: TextStyle(fontWeight: FontWeight.bold),
                      // ),
                    ]),
                  ),
                  Expanded(
                      flex: 1,
                      child: Container(
                        width: 20,
                        height: 5, // Thickness
                        color: Colors.grey,
                      )),
                  Expanded(
                    flex: 1,
                    child: Column(children: <Widget>[
                      Image(
                        image: new AssetImage("assets/treeD.png"),
                        width: 40,
                        height: 40,
                        color: null,
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.center,
                      ),
                      // Text(
                      //   'Quand?',
                      //   style: TextStyle(fontWeight: FontWeight.bold),
                      // ),
                    ]),
                  ),
                  Expanded(
                      flex: 1,
                      child: Container(
                        width: 20,
                        height: 5, // Thickness
                        color: Colors.grey,
                      )),
                  Expanded(
                      flex: 1,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image(
                              image: new AssetImage("assets/fourD.png"),
                              width: 40,
                              height: 40,
                              color: null,
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.center,
                            ),

                            // Text(
                            //   'Quoi récupérer?',
                            //   style: TextStyle(fontWeight: FontWeight.bold),
                            // ),
                          ])),
                ],
              ),
            ),

            Container(
              margin: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ////////////////////// Adresse de récupération ////
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                            top: 10,
                            left: 5,
                            bottom: 10,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "* ",
                                style: TextStyle(
                                    color: Colors.orange,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "oubligatoire",
                                style: TextStyle(
                                    color: Colors.orange,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                            top: 30,
                            left: 5,
                            bottom: 10,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Adresse de récupération ",
                              ),
                              Text(
                                "*",
                                style: TextStyle(color: Colors.orange),
                              ),
                            ],
                          ),
                        ),
                        TextField(
                          controller: adresseRecuperation,
                          style: TextStyle(color: Color(0xFF000000)),
                          cursorColor: Color(0xFF9b9b9b),
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: "Avenue.... ",
                            hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 15,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                      ],
                    ),
                  ),
                  //////////////////////////// Ville de récupération
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                            top: 30,
                            left: 5,
                            bottom: 10,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Ville de récupération ",
                              ),
                              Text(
                                "*",
                                style: TextStyle(color: Colors.orange),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              width: 250,
                              child: DropdownSearch<String>(
                                mode: Mode.BOTTOM_SHEET,
                                items: Const.villes,
                                onChanged: (value) {
                                  setState(() {
                                    dropdownDepart = value;
                                  });
                                },
                                selectedItem: dropdownDepart,
                                showSearchBox: true,
                                searchBoxDecoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  contentPadding:
                                      EdgeInsets.fromLTRB(12, 12, 8, 0),
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
                      ],
                    ),
                  ),

                  //////////////////////////// Adresse de livraison //////////////////////
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                            top: 30,
                            left: 5,
                            bottom: 10,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Adresse de livraison ",
                              ),
                              Text(
                                "*",
                                style: TextStyle(color: Colors.orange),
                              ),
                            ],
                          ),
                        ),
                        TextField(
                          controller: adresseLivraison,
                          style: TextStyle(color: Color(0xFF000000)),
                          cursorColor: Color(0xFF9b9b9b),
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: "Avenue...",
                            hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 15,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ///////////////////////////////// ville de livraison ////
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                            top: 30,
                            left: 5,
                            bottom: 10,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Ville de livraison ",
                              ),
                              Text(
                                "*",
                                style: TextStyle(color: Colors.orange),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              width: 250,
                              child: DropdownSearch<String>(
                                mode: Mode.BOTTOM_SHEET,
                                items: Const.villes,
                                onChanged: (value) {
                                  setState(() {
                                    dropdownLivraison = value;
                                  });
                                },
                                selectedItem: dropdownLivraison,
                                showSearchBox: true,
                                searchBoxDecoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  contentPadding:
                                      EdgeInsets.fromLTRB(12, 12, 8, 0),
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
                      ],
                    ),
                  ),
                ],
              ),
            ),

            /////////////////////////// Button Suivant ////////////////////////
            Container(
              margin: const EdgeInsets.all(10),
              // ignore: deprecated_member_use
              child: FlatButton(
                onPressed: () async {
                  if (dropdownDepart == "à choisir")
                    _showDialog("Veuillez remplir Ville de récupération!");
                  if (dropdownLivraison == "à choisir")
                    _showDialog("Veuillez remplir Ville de livraison!");

                  ////////// region de ville depart ////////
                  final queryRecuperation = dropdownDepart;
                  var addressesRecuperation = await Geocoder.local
                      .findAddressesFromQuery(queryRecuperation);
                  var firstRecuperation = addressesRecuperation.first.adminArea;
                  ////////// region de ville livraison ////////
                  final queryLivraison = dropdownLivraison;
                  var addressesLivraison = await Geocoder.local
                      .findAddressesFromQuery(queryLivraison);
                  var firstLivraison = addressesLivraison.first.adminArea;
                  print(firstRecuperation);
                  print(firstLivraison);
                  if (adresseRecuperation.text == "" ||
                      dropdownDepart == "à choisir" ||
                      adresseLivraison.text == "" ||
                      dropdownLivraison == "à choisir") {
                    _showDialog("Veuillez remplir tous les champs!");
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EnvoyerDemandePriveComment(
                                idLivreur: "$idLivreur",
                                adresseRecuperation:
                                    "${adresseRecuperation.text.trim()}",
                                villeRecuperation: "$dropdownDepart",
                                adresseLivraison:
                                    "${adresseLivraison.text.trim()}",
                                villeLivraison: "$dropdownLivraison",
                              )),
                    );
                  }
                },
                child: Text(
                  "Suivant",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                color: Colors.orange,
                disabledColor: Colors.grey,
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(20.0)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDialog(String error) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Theme(
            data:
                Theme.of(context).copyWith(dialogBackgroundColor: Colors.white),
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              contentPadding: EdgeInsets.all(10.0),
              title: new GradientText(
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  text: "Erreur",
                  colors: <Color>[
                    Colors.orange.shade400,
                    Colors.orange.shade900,
                  ]),
              content: new Text(
                error,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              actions: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width,
                        // ignore: deprecated_member_use
                        child: RaisedButton(
                          color: Colors.orange,
                          disabledColor: Colors.orange,
                          child: new Text(
                            'Fermer',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }
}
