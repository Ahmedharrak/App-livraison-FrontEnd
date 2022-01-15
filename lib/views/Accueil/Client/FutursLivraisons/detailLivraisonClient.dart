import 'dart:collection';
import 'dart:convert';
import 'dart:typed_data';

import 'package:easy_gradient_text/easy_gradient_text.dart';
import 'package:flutter/material.dart';
import 'package:livreurs_app/Controllers/livraisonController.dart';
import 'package:livreurs_app/Controllers/notificationController.dart';
import 'package:livreurs_app/views/Accueil/Client/FutursLivraisons/futursLivraisonsClient.dart';
import 'package:livreurs_app/views/Accueil/Client/FutursLivraisons/suiviDemandeActive.dart';
import 'package:livreurs_app/views/Accueil/accueilClient.dart';
import 'package:intl/intl.dart';
import 'package:livreurs_app/const.dart' as Const;

/// This Widget is the main application widget.

// ignore: must_be_immutable
class DetailLivraisonClient extends StatelessWidget {
  String idLivraison;
  LinkedHashMap<String, dynamic> demande;
  LinkedHashMap<String, dynamic> livreur;
  LinkedHashMap<String, dynamic> livraison;

  LivraisonController livraisonController = new LivraisonController();
  NotificationController notificationController = new NotificationController();
  String prix;
  DetailLivraisonClient({
    Key key,
    @required this.idLivraison,
    @required this.livraison,
    @required this.demande,
    @required this.livreur,
    @required this.prix,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    print("demande --------> $demande");
    print("livreur --------> $livreur");
    String description;
    String dateLivraison = demande['dateLivraison'];
    String today = DateFormat("yyyy-MM-dd").format(DateTime.now());
    String todayNotification =
        DateFormat("yyyy-MM-dd HH:mm").format(DateTime.now());
    print(
        "Today :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: $todayNotification");
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

    _onPressedAnnuler() {
      livraisonController.statutlivraison(idLivraison, "Annulé par client");
      notificationController.ajouterNotification(
          livreur['_id'],
          Const.idClLiv,
          demande['_id'],
          idLivraison,
          "A",
          "a annulé votre livraison.",
          todayNotification);
      Navigator.of(context).pop();
      Navigator.of(context).pop();

      Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (context) => FutursLivraisonClient(
                    contenu: 'Tout',
                    nature: 'Tout',
                    poids: 'Tout',
                    regionLivraison: 'Tout',
                    regionRecuperation: 'Tout',
                    taille: 'Tout',
                    triePar: 'Tout',
                    villeDeDepart: 'Tout',
                    villeDeLivraison: 'Tout',
                    dateLivraison: '',
                  )));
    }

    Uint8List _bytesImage;

    String _imgProfileString = '${livreur['imageProfile']}';

    _bytesImage = Base64Decoder().convert(_imgProfileString);

    // ignore: todo
    // TODO: implement build
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
            padding: EdgeInsets.all(5),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      ////////////// titre de bare de page /////////

                      child: Text(
                        'Détail',
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
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: <
            Widget>[
          ////// logo livreur   //////
          Container(
            margin: const EdgeInsets.all(10),
            child: Card(
              child: Container(
                decoration: new BoxDecoration(
                  borderRadius: new BorderRadius.circular(16.0),
                  color: Colors.orangeAccent,
                ),
                padding: const EdgeInsets.only(
                    left: 30, right: 30, bottom: 10, top: 10),
                child: Text(
                  "Livreur",
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
                Center(
                  child: Container(
                    child: ClipOval(
                      child: Image.memory(
                        _bytesImage,
                        fit: BoxFit.cover,
                        width: 100,
                        height: 100,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(5),
                  child: Text(
                    "${livreur['prenom']} ${livreur['nom']}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.email,
                        color: Colors.orange,
                        size: 25,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 5),
                        child: Text("${livreur['email']}"),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.phone,
                        color: Colors.orange,
                        size: 25,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 5),
                        child: Text("${livreur['telephone']}"),
                      ),
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
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                Flexible(
                  flex: 1,
                  child: Container(
                    child: Text(
                      "${demande['adresseRecuperationLivraison']}, ${demande['villeDeDepart']}",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
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
                Flexible(
                  flex: 1,
                  child: Container(
                    child: Text(
                      "${demande['adresseDestinationLivraison']}, ${demande['villeDeLivraison']}",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
          ///////////// Demande
          Container(
            margin: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GradientText(
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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

          /////// Column de Contenu et Nature //////////////

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

          ///////// Prix ////////////
          Container(
            margin: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GradientText(
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                //////  Text   prix : (en DH) //////
                Container(
                  margin: const EdgeInsets.only(left: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Prix : ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "$prix DH",
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          ////////////////////////////////////// description ////////////////////////////////////
          Container(
            margin: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GradientText(
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    text: "Description",
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
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
                              color: getColor(description),
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
          ///// Bottom "Envoyer" /////
          if (dateLivraison == today)
            Container(
              // ignore: deprecated_member_use
              child: FlatButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => SuiviDemandeActive(
                                demande: demande,
                                idLivraison: idLivraison,
                                idLivreur: livreur['_id'],
                                livraison: livraison,
                                livreur: livreur,
                              )));
                },
                child: Text(
                  "Suivre la livraison",
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

          if (dateLivraison != today)
            Container(
              // ignore: deprecated_member_use
              child: FlatButton(
                onPressed: () => _onPressedAnnuler(),
                child: Text(
                  "Annuler la livraison",
                  style: TextStyle(
                    color: Colors.deepOrange,
                    fontSize: 20.0,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                color: Colors.brown,
                disabledColor: Colors.grey,
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(20.0)),
              ),
            ),
        ]),
      ),
    );
  }
}
