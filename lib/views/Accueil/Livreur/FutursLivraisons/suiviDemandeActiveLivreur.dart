import 'dart:collection';
import 'dart:convert';
import 'dart:typed_data';

import 'package:easy_gradient_text/easy_gradient_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:livreurs_app/Controllers/livraisonController.dart';
import 'package:livreurs_app/Controllers/notificationController.dart';
import 'package:livreurs_app/views/Accueil/Livreur/FutursLivraisons/noterLivreur.dart';
import 'package:livreurs_app/views/Accueil/Livreur/FutursLivraisons/signalerLivreur.dart';
import 'package:livreurs_app/views/Accueil/accueilLivreur.dart';

import 'package:livreurs_app/const.dart' as Const;

// ignore: must_be_immutable
class SuiviDemandeActiveLivreur extends StatefulWidget {
  String idLivraison;
  String idClient;
  LinkedHashMap<String, dynamic> demande;
  LinkedHashMap<String, dynamic> client;
  String prix;

  SuiviDemandeActiveLivreur({
    Key key,
    @required this.demande,
    @required this.idLivraison,
    @required this.idClient,
    @required this.client,
    @required this.prix,
  }) : super(key: key);
  @override
  _SuiviDemandeActiveLivreurState createState() =>
      _SuiviDemandeActiveLivreurState(
          demande, idLivraison, idClient, client, prix);
}

class _SuiviDemandeActiveLivreurState extends State<SuiviDemandeActiveLivreur> {
  String idLivraison;
  String idClient;
  LinkedHashMap<String, dynamic> demande;
  LinkedHashMap<String, dynamic> client;
  String prix;
  _SuiviDemandeActiveLivreurState(
      this.demande, this.idLivraison, this.idClient, this.client, this.prix);
  LivraisonController livraisonController = new LivraisonController();
  NotificationController notificationController = new NotificationController();
  @override
  Widget build(BuildContext context) {
    String todayNotification =
        DateFormat("yyyy-MM-dd HH:mm").format(DateTime.now());
    print(
        "Today :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: $todayNotification");

    _onPressedlivre() {
      notificationController.ajouterNotification(
          idClient,
          Const.idClLiv,
          demande['_id'],
          idLivraison,
          "A",
          " a confirmé qu'il a livré votre commande avec succés.",
          todayNotification);
      livraisonController.statutlivraison(idLivraison, "Livré");
      livraisonController.livraisonlivre(idLivraison);
      Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (context) =>
                  NoterLivreur(idLivraison: idLivraison, idClient: idClient)));
    }

// ignore: todo
    // TODO: implement build
    print("demande --------> $demande");
    print("client --------> $client");
    String description;
    String dateLivraison = demande['dateLivraison'];
    String today = DateFormat("dd/MM/yyyy").format(DateTime.now());

    print(
        "today :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: $today");
    print(
        "date LIVRAISON :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: $dateLivraison");

    if (demande['description'] != null) {
      description = demande['description'];
    } else {
      description = "Sans déscription";
    }
    Color getColor(text) {
      if (text == "Sans déscription")
        return Colors.grey;
      else
        return Colors.black;
    }

    Uint8List _bytesImage;

    String _imgProfileString = '${client['imageProfile']}';

    _bytesImage = Base64Decoder().convert(_imgProfileString);
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
                  MaterialPageRoute(builder: (context) => AccueilLivreur()),
                );
              })
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
                        'Suiver la livraison',
                        style: TextStyle(
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
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            ////// logo livreur   //////
            Container(
              margin: const EdgeInsets.all(10),
              child: Card(
                shape: StadiumBorder(
                  side: BorderSide(
                    color: Colors.black,
                    width: 2.0,
                  ),
                ),
                child: Container(
                  decoration: new BoxDecoration(
                    borderRadius: new BorderRadius.circular(16.0),
                    color: Colors.orangeAccent,
                  ),
                  padding: const EdgeInsets.only(
                      left: 30, right: 30, bottom: 10, top: 10),
                  child: Text(
                    "Client",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ),
            ),
            ////// donnees du livreurs ///////
            Container(
              child: Column(
                children: <Widget>[
                  Container(
                    child: ClipOval(
                      child: Image.memory(
                        _bytesImage,
                        fit: BoxFit.cover,
                        width: 120,
                        height: 120,
                      ),
                    ),
                  ),
                  Container(
                    child: InkWell(
                      onTap: () {},
                      child: Text(
                        "${client['prenom']} ${client['nom']}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.all(5),
                          child: Icon(
                            Icons.email,
                            color: Colors.orange,
                            size: 25,
                          ),
                        ),
                        Text("${client['email']}"),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.all(5),
                          child: Icon(
                            Icons.phone,
                            color: Colors.orange,
                            size: 25,
                          ),
                        ),
                        Text("${client['telephone']}"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            ////// logo demande   //////
            Container(
              margin: const EdgeInsets.all(10),
              child: Card(
                shape: StadiumBorder(
                  side: BorderSide(
                    color: Colors.black,
                    width: 2.0,
                  ),
                ),
                child: Container(
                  decoration: new BoxDecoration(
                    borderRadius: new BorderRadius.circular(16.0),
                    color: Colors.orangeAccent,
                  ),
                  padding: const EdgeInsets.only(
                      left: 30, right: 30, bottom: 10, top: 10),
                  child: Text(
                    "Demande",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ),
            ),
            ///////////// Date
            Container(
              margin: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GradientText(
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      text: "Date",
                      colors: <Color>[
                        Colors.orange.shade400,
                        Colors.orange.shade900,
                      ]),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(5),
              child: Divider(
                height: 2.0,
                color: Colors.orange.shade900,
              ),
            ),
            ///// Date du Demande ////
            Container(
              margin: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ///// logo de Date /////
                  Container(
                    margin: const EdgeInsets.all(5),
                    child: Image.asset(
                      "assets/calendar.png",
                      width: 25,
                      height: 25,
                      color: Colors.orange,
                    ),
                  ),
                  ////// la date du ivraison //////
                  Container(
                    child: Text(
                      "${demande['dateLivraison']}  ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(5),
                    child: Image.asset(
                      "assets/clock.png",
                      width: 25,
                      height: 25,
                      color: Colors.orange,
                    ),
                  ),
                  Container(
                    child: Text(
                      " ${demande['heureLivraison']} ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),

            ///////////// Localisation
            Container(
              margin: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GradientText(
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      text: "Localisation",
                      colors: <Color>[
                        Colors.orange.shade400,
                        Colors.orange.shade900,
                      ]),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(5),
              child: Divider(
                height: 2.0,
                color: Colors.orange.shade900,
              ),
            ),
            ///// Row de Adresse Depart + Adresse Arrive //////
            Container(
              margin: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.all(5),
                    child: Image.asset(
                      "assets/logoMap.png",
                      width: 25,
                      height: 25,
                      color: Colors.orange,
                    ),
                  ),
                  Container(
                    child: Text(
                      "${demande['adresseRecuperationLivraison']}, ${demande['villeDeDepart']}",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),

            /////// Adresse Arrive ///////
            Container(
              margin: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.all(5),
                    child: Image.asset(
                      "assets/logoMap.png",
                      width: 25,
                      height: 25,
                      color: Colors.orange,
                    ),
                  ),
                  Container(
                    child: Text(
                      "${demande['adresseDestinationLivraison']}, ${demande['villeDeLivraison']}",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
////////////////////// Demande //////////////
            Container(
              margin: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GradientText(
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      text: "Demande",
                      colors: <Color>[
                        Colors.orange.shade400,
                        Colors.orange.shade900,
                      ]),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(5),
              child: Divider(
                height: 2.0,
                color: Colors.orange.shade900,
              ),
            ),

            ////////////////////////////// Row (Contenu + Nature + Taille + Poids) /////
            /////////// Contenu ///////
            Container(
              margin: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ///// logo de Contenu /////
                  Container(
                    margin: const EdgeInsets.all(5),
                    child: Image.asset(
                      "assets/content-marketing.png",
                      width: 25,
                      height: 25,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(5),
                    child: Text(
                      "Contenu :",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Container(
                      margin: const EdgeInsets.all(5),
                      child: Text(
                        "${demande['contenu']}",
                      ),
                    ),
                  ),
                ],
              ),
            ),
            /////////// Taille ///////
            Container(
              margin: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ///// logo de taille /////
                  Container(
                    margin: const EdgeInsets.all(5),
                    child: Image.asset(
                      "assets/size.png",
                      width: 25,
                      height: 25,
                      color: Colors.orange,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(5),
                    child: Text(
                      "Taille :",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Container(
                      margin: const EdgeInsets.all(5),
                      child: Text(
                        "${demande['taille']}",
                      ),
                    ),
                  ),
                ],
              ),
            ),

            /////// Column de Taille et Poids //////////////

            ///////////// Nature //////////
            Container(
              margin: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ///// logo de nature /////
                  Container(
                    margin: const EdgeInsets.all(5),
                    child: Image.asset(
                      "assets/text.png",
                      width: 25,
                      height: 25,
                      color: Colors.orange,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(5),
                    child: Text(
                      "Nature :",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Container(
                      margin: const EdgeInsets.all(5),
                      child: Text(
                        "${demande['nature']}",
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ///////////// Poids //////////
            Container(
              margin: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ///// logo de poids /////
                  Container(
                    margin: const EdgeInsets.all(5),
                    child: Image.asset(
                      "assets/weight.png",
                      width: 25,
                      height: 25,
                      color: Colors.orange,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(5),
                    child: Text(
                      "Poids : ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Container(
                      margin: const EdgeInsets.all(5),
                      child: Text("${demande['poids']}"),
                    ),
                  ),
                ],
              ),
            ),

            ////////////////////////////////////// description ////////////////////////////////////
            Container(
              margin: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ///// titre /////
                  Container(
                    margin: const EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ///// logo d'argent /////
                        Container(
                          margin: const EdgeInsets.only(right: 6),
                          child: Image.asset(
                            "assets/hastag.png",
                            width: 25,
                            height: 25,
                            color: Colors.orange,
                          ),
                        ),
                        Text(
                          "Description : ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ////// Text de description /////
                  Container(
                    child: Row(
                      children: [
                        Flexible(
                          flex: 1,
                          child: Container(
                            margin: const EdgeInsets.all(20),
                            child: Text(
                              "$description",
                              style: TextStyle(
                                color: getColor("$description"),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            ///////// Prix ////////////
            Container(
              margin: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GradientText(
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      text: "Prix",
                      colors: <Color>[
                        Colors.orange.shade400,
                        Colors.orange.shade900,
                      ]),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(5),
              child: Divider(
                height: 2.0,
                color: Colors.orange.shade900,
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: Row(
                children: [
                  /////// logo de prix /////
                  Container(
                    margin: const EdgeInsets.all(5),
                    child: Image.asset(
                      "assets/argentIcone.png",
                      width: 25,
                      height: 25,
                      color: Colors.orange,
                    ),
                  ),
                  //////  Text "Entrer votre prix : (en DH)" //////
                  Container(
                    child: Text(
                      "Prix : $prix dh ",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),

            //////// Button Livré et Signaler /////
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.all(20),
                    // ignore: deprecated_member_use
                    child: FlatButton(
                      onPressed: () => _onPressedlivre(),
                      child: Text(
                        "Livré",
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
                  Container(
                    margin: const EdgeInsets.all(20),
                    // ignore: deprecated_member_use
                    child: FlatButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) =>
                                    SignalerLivreur(idClient: idClient)));
                      },
                      child: Text(
                        "Signaler",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      color: Colors.deepOrange,
                      disabledColor: Colors.grey,
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(20.0)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
