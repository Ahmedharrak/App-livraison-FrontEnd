import 'dart:collection';
import 'dart:convert';
import 'dart:typed_data';
import 'package:easy_gradient_text/easy_gradient_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:livreurs_app/Controllers/livraisonController.dart';
import 'package:livreurs_app/Controllers/notificationController.dart';
import 'package:livreurs_app/views/Accueil/Livreur/DemandesRecus/demandesRecues.dart';
import 'package:livreurs_app/views/Accueil/Livreur/FutursLivraisons/futurLivraisonLivreur.dart';
import 'package:livreurs_app/views/Accueil/accueilLivreur.dart';
import 'package:livreurs_app/const.dart' as Const;

// ignore: must_be_immutable
class LivreurAccepterDemandePrive extends StatefulWidget {
  LinkedHashMap<String, dynamic> demande;
  LinkedHashMap<String, dynamic> client;
  void initState() {}
  LivreurAccepterDemandePrive({
    Key key,
    @required this.demande,
    @required this.client,
  }) : super(key: key);
  @override
  LivreurAccepterDemandePriveState createState() =>
      LivreurAccepterDemandePriveState(this.demande, this.client);
}

// ignore: must_be_immutable
class LivreurAccepterDemandePriveState
    extends State<LivreurAccepterDemandePrive> {
  LinkedHashMap<String, dynamic> demande;
  LinkedHashMap<String, dynamic> client;
  LivraisonController livraisonController = new LivraisonController();
  NotificationController notificationController = new NotificationController();
  LivreurAccepterDemandePriveState(this.demande, this.client);
  @override
  Widget build(BuildContext context) {
    String todayNotification =
        DateFormat("yyyy-MM-dd HH:mm").format(DateTime.now());
    print(
        "Today :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: $todayNotification");
    String idLivreur = demande['livreur_choisi']['idLivreur'];
    String idClient = demande['idClient'];
    String idDemande = demande['_id'];
    String prix = demande['prix'];
    _onPressedAccepter() {
      livraisonController
          .ajouterLivraiosn(idLivreur, idClient, idDemande, prix)
          .whenComplete(() {
        notificationController.ajouterNotification(
            idClient,
            Const.idClLiv,
            idDemande,
            null,
            "A",
            "a accepté votre demande de livraison privée.",
            todayNotification);
        livraisonController.modifierStatutDemande(idDemande, "fermé");

        setState(() => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return DemandesRecues(
                  dateLivraison: '',
                  contenu: "Tout",
                  nature: "Tout",
                  taille: 'Tout',
                  poids: "Tout",
                  regionRecuperation: "Tout",
                  regionLivraison: "Tout",
                  villeDeDepart: "Tout",
                  villeDeLivraison: "Tout",
                );
              }))
            });
      });
    }

    _onPressedRefuser() {
      livraisonController.modifierStatutDemande(idDemande, "fermé");
      notificationController.ajouterNotification(
          idClient,
          Const.idClLiv,
          idDemande,
          null,
          "A",
          "a refusé votre demande de livraison privée.",
          todayNotification);
      setState(() => {
            Navigator.push(context,
                MaterialPageRoute(builder: (BuildContext context) {
              return DemandesRecues(
                dateLivraison: '',
                contenu: "Tout",
                nature: "Tout",
                taille: 'Tout',
                poids: "Tout",
                regionRecuperation: "Tout",
                regionLivraison: "Tout",
                villeDeDepart: "Tout",
                villeDeLivraison: "Tout",
              );
            }))
          });
    }

    Uint8List _bytesImage;

    String _imgProfileString = '${client['imageProfile']}';

    _bytesImage = Base64Decoder().convert(_imgProfileString);

    String description;
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
                        'Details de demande',
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
          ////// Titre du Page  //////
          ////// logo Client   //////
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

          ////// donnees du Clients ///////
          Container(
            child: Row(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.all(10),
                  child: ClipOval(
                    child: Image.memory(
                      _bytesImage,
                      width: 70,
                      height: 70,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Text(
                          "${client['prenom']} ${client['nom']}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(10),
                        child: Text(
                          "${client['ville']}",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        margin: const EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ////// Note //////
                            Container(
                              margin: const EdgeInsets.all(5),
                              width: 100,
                              height: 30,
                              child: Card(
                                shape: StadiumBorder(
                                  side: BorderSide(
                                    color: Colors.black,
                                    width: 2.0,
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(
                                          left: 5, right: 5),
                                      child: RatingBarIndicator(
                                        rating: client['noteTotal'].toDouble(),
                                        itemBuilder: (context, index) => Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        itemCount: 5,
                                        itemSize: 15.0,
                                        direction: Axis.horizontal,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            //// Nombre des livraisons ////
                            Container(
                              child: Text(
                                "${client['nombreLivraisons']} livraisons",
                                style: TextStyle(
                                  color: Colors.orange,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          ////// Horizontal divider ///////

          Container(
            margin: const EdgeInsets.all(5),
            child: Divider(
              height: 2.0,
              color: Colors.orange.shade900,
            ),
          ),
          ////// logo Client   //////
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

          ///////////// Date et heure
          Container(
            margin: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GradientText(
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    text: "Date et heure de livraison",
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
          ///// Row de Adresse Depart + Adresse Arrive //////
          //////////////// Localisation
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
          ///// Row de Adresse Depart + Adresse Arrive //////
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //////// Adresse depart ////////
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

          ///////// Description ///////////
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
                          margin: const EdgeInsets.all(10),
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

          //////////// Prix ///////////////
          Container(
            margin: const EdgeInsets.all(10),
            child: Row(
              children: [
                ///// logo d'argent /////
                Container(
                  margin: const EdgeInsets.all(5),
                  child: Image.asset(
                    "assets/argentIcone.png",
                    width: 25,
                    height: 25,
                    color: Colors.orange,
                  ),
                ),
                ////// Prix //////
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
                        "${demande['prix']} DH",
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          ///////////// Button Accepter / Refuser ///////////
          Container(
            padding: const EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  // ignore: deprecated_member_use
                  child: FlatButton(
                    onPressed: () => _onPressedRefuser(),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(5),
                          child: Image.asset(
                            "assets/croix.png",
                            width: 15,
                            color: Colors.white,
                            height: 15,
                          ),
                        ),
                        Text(
                          "Refuser",
                          style: TextStyle(
                            color: Colors.white,
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                    color: Colors.deepOrange,
                    disabledColor: Colors.grey,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  // ignore: deprecated_member_use
                  child: FlatButton(
                    onPressed: () => _onPressedAccepter(),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(5),
                          child: Image.asset(
                            "assets/yes.png",
                            width: 15,
                            color: Colors.white,
                            height: 15,
                          ),
                        ),
                        Text(
                          "Accepter",
                          style: TextStyle(
                            color: Colors.white,
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                    color: Colors.orange,
                    disabledColor: Colors.grey,
                  ),
                )
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
