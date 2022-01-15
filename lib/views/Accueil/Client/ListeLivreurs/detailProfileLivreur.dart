import 'dart:convert';
import 'dart:typed_data';
import 'package:easy_gradient_text/easy_gradient_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:livreurs_app/Controllers/clientController.dart';
import 'package:livreurs_app/Controllers/livraisonController.dart';
import 'package:livreurs_app/Controllers/livreurController.dart';
import 'package:livreurs_app/views/Accueil/accueilClient.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';

import 'EnvoyerDemandePrive/envoyerDemandePriveOu.dart';

// ignore: must_be_immutable
class DetailProfileLivreur extends StatelessWidget {
  File _imageProfile;
  final String id;
  DetailProfileLivreur({Key key, this.id}) : super(key: key);

  LivreurController livreurController = new LivreurController();
  LivraisonController livraisonController = new LivraisonController();
  ClientController clientController = new ClientController();

  @override
  Widget build(BuildContext context) {
    print(id);
    return FutureBuilder(
        future: livreurController.obtenirLivreur(id),
        builder: (context, AsyncSnapshot livreurSnapshot) {
          if (livreurSnapshot.hasData) {
            //List commentaire = livreurSnapshot.data['commentaires'];
            String nb;

            if (livreurSnapshot.data['commentaires'] == null) {
              nb = "0";
            } else {
              nb = "${(livreurSnapshot.data['commentaires']).length}";
            }
            String getColorJourDeTravail(jour) {
              if (livreurSnapshot.data['joursDeService']['$jour'] == true) {
                return "assets/orange.png";
              } else
                return "assets/white.jpg";
            }

            String getIconePiece(piece) {
              if (piece != null) {
                return "assets/yes.png";
              } else
                return "assets/croix.png";
            }

            String getMessagePermis(piece) {
              if (piece != null) {
                return "Permis importé.";
              } else
                return "Permis non importé.";
            }

            String getMessageCarteGrise(piece) {
              if (piece != null) {
                return "Carte Grise importé.";
              } else
                return "Carte Grise non importé.";
            }

            String getLogoMoyenTransport(String type) {
              if (type == "Voiture") {
                return "assets/car.png";
              } else if (type == "Moto") {
                return "assets/motorcycle.png";
              } else if (type == "Camion") {
                return "assets/truck.png";
              } else if (type == "Pickup") {
                return "assets/pickup.png";
              } else if (type == "Taxi") {
                return "assets/taxi.png";
              } else
                return "assets/bicycle.png";
            }

            // Object commentaire;
            // if (livreurSnapshot.data['commentaires'] != null) {
            //   commentaire = commentaire.len;
            // } else {
            //   commentaire = "0";
            // }

            Uint8List _bytesImage;

            String _imgProfileString =
                '${livreurSnapshot.data['imageProfile']}';

            _bytesImage = Base64Decoder().convert(_imgProfileString);

            Image.memory(_bytesImage);
            void afficherCommentaireLivreur(BuildContext context) async {
              if (livreurSnapshot.data['commentaires'] != null) {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        titlePadding: EdgeInsets.all(10.0),
                        contentPadding: EdgeInsets.all(10.0),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GradientText(text: "Commentaire", colors: <Color>[
                              Colors.orangeAccent.shade400,
                              Colors.orangeAccent.shade700,
                            ]),
                            Container(
                              margin: const EdgeInsets.all(5),
                              child: Divider(
                                height: 2.0,
                                color: Colors.blue.shade900,
                              ),
                            ),
                          ],
                        ),
                        content: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              for (var item
                                  in livreurSnapshot.data['commentaires'])
                                Card(
                                  elevation: 4.0,
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(0.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        /////// image de livreur /////////
                                        Flexible(
                                          flex: 3,
                                          child: Container(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                ClipOval(
                                                  child: Image.asset(
                                                    "assets/iconeClient.png",
                                                    height: 50,
                                                    width: 50,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                Container(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Container(
                                                        width: 70,
                                                        height: 30,
                                                        child: Card(
                                                          shape: StadiumBorder(
                                                            side: BorderSide(
                                                              color:
                                                                  Colors.grey,
                                                              width: 1.0,
                                                            ),
                                                          ),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Container(
                                                                child:
                                                                    RatingBarIndicator(
                                                                  //rating: 2.25,
                                                                  rating: item[
                                                                          'note']
                                                                      .toDouble(),
                                                                  itemBuilder:
                                                                      (context,
                                                                              index) =>
                                                                          Icon(
                                                                    Icons.star,
                                                                    color: Colors
                                                                        .amber,
                                                                  ),
                                                                  itemCount: 5,
                                                                  itemSize: 9.0,
                                                                  direction: Axis
                                                                      .horizontal,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),

                                        /////////////////// Partie Center de la liste (Ahmed harrak,CIN,rabat,CG,Permis)
                                        Flexible(
                                          flex: 7,
                                          child: Container(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                      10.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: <Widget>[
                                                      ////// Nom de livreur //////
                                                      Flexible(
                                                        flex: 2,
                                                        child: Text(
                                                            "${item['commentaire']} "),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
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
                      );
                    });
              }
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
                          MaterialPageRoute(
                              builder: (context) => AccueilClient()),
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
                              margin: EdgeInsets.all(5.0),
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                ' Profil Livreur',
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
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Stack(
                    children: <Widget>[
                      ///////////  background///////////
                      new Container(
                        decoration: new BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            stops: [0.0, 0.4, 0.9],
                            colors: [
                              Color(0xFFFFFFFF),
                              Color(0xFFFFFFFF),
                              Color(0xFFFFFFFF),
                            ],
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              ////// Image de Profile //////
                              Container(
                                padding: const EdgeInsets.all(30),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage("assets/back1.jpg"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: Center(
                                  child: GestureDetector(
                                    child: CircleAvatar(
                                      radius: 70,
                                      backgroundColor: Colors.white,
                                      child: _imageProfile != null
                                          ? ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              child: Image.file(
                                                _imageProfile,
                                                width: 200,
                                                height: 200,
                                                fit: BoxFit.cover,
                                              ),
                                            )
                                          : Container(
                                              child: ClipOval(
                                                  child: Image.memory(
                                                _bytesImage,
                                                fit: BoxFit.cover,
                                                width: 150,
                                                height: 150,
                                              )),
                                            ),
                                    ),
                                  ),
                                ),
                              ),
                              //////// Nom Prenom CIN ////////////
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      padding: const EdgeInsets.only(
                                          top: 3, left: 3),
                                      child: Text(
                                          '${livreurSnapshot.data['prenom']} ${livreurSnapshot.data['nom']} ',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          )),
                                    ),
                                    ////// Note //////
                                    Center(
                                      child: Container(
                                        margin: const EdgeInsets.only(top: 3),
                                        width: 110,
                                        height: 40,
                                        child: Card(
                                          shape: StadiumBorder(
                                            side: BorderSide(
                                              color: Colors.black,
                                              width: 2.0,
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    left: 5, right: 5),
                                                child: RatingBarIndicator(
                                                  //rating: 2.25,
                                                  rating: livreurSnapshot
                                                      .data['noteTotal']
                                                      .toDouble(),
                                                  itemBuilder:
                                                      (context, index) => Icon(
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
                                    ),
                                  ]),

                              //////////// Nombre du Laivraison,Nombre du Signale ///////////////
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    ////// photos Nombre laivraison ///////////
                                    Container(
                                        padding: const EdgeInsets.all(5),
                                        child: Card(
                                            shape: StadiumBorder(
                                              side: BorderSide(
                                                color: Colors.black,
                                                width: 2.0,
                                              ),
                                            ),
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: <Widget>[
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.all(5),
                                                    child: ClipOval(
                                                      child: Image.asset(
                                                        "assets/livraison.png",
                                                        height: 30,
                                                        width: 30,
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.all(5),
                                                    child: Text(" : ",
                                                        style: TextStyle(
                                                          color: Colors.orange,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        )),
                                                  ),
                                                  /////// Nombre du Laivraison ////////////

                                                  Container(
                                                    padding:
                                                        const EdgeInsets.all(5),
                                                    child: Text(
                                                        "${livreurSnapshot.data['nombreLivraisons']}",
                                                        style: TextStyle(
                                                          color: Colors.orange,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        )),
                                                  ),
                                                ]))),

                                    /////// photo nombre signal /////////////

                                    Container(
                                        padding: const EdgeInsets.all(5),
                                        child: Card(
                                            shape: StadiumBorder(
                                              side: BorderSide(
                                                color: Colors.black,
                                                width: 2.0,
                                              ),
                                            ),
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: <Widget>[
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.all(5),
                                                    child: ClipOval(
                                                      child: Image.asset(
                                                        "assets/dislike.png",
                                                        height: 30,
                                                        width: 30,
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.all(5),
                                                    child: Text(" : ",
                                                        style: TextStyle(
                                                          color: Colors.orange,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        )),
                                                  ),
                                                  ////////// Nombre du Signal //////////////

                                                  Container(
                                                    padding:
                                                        const EdgeInsets.all(5),
                                                    child: Text(
                                                        "${livreurSnapshot.data['nombreSignale']}",
                                                        style: TextStyle(
                                                          color: Colors.orange,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        )),
                                                  ),
                                                ])))
                                  ]),

                              //////// Button Envoyer demande de livraison ///////////
                              Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    ///////// logo de carton ///////
                                    Container(
                                      child: ClipOval(
                                          child: Icon(Icons.delivery_dining)),
                                      margin: const EdgeInsets.all(10),
                                    ),
                                    ////////// bottom Envoyer demande privee ///////
                                    Container(
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              new MaterialPageRoute(
                                                  builder: (context) =>
                                                      EnvoyerDemandePriveOu(
                                                          idLivreur:
                                                              " ${livreurSnapshot.data['_id']}")));
                                        },
                                        child: Text(
                                          'Envoyer une demande de livraison',
                                          textDirection: TextDirection.ltr,
                                          style: TextStyle(
                                            color: Colors.black,
                                            backgroundColor:
                                                Colors.orangeAccent,
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold,
                                            decoration: TextDecoration.none,
                                          ),
                                        ),
                                      ),
                                      margin: const EdgeInsets.only(
                                        left: 5,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          //////// Partie de Profile Detail ///////////
                          Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ////// Ville /////////
                                Container(
                                  padding: const EdgeInsets.all(5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(5),
                                        child: Icon(Icons.location_city),
                                      ),
                                      Text(
                                        "${livreurSnapshot.data['ville']}",
                                        style: new TextStyle(
                                          fontSize: 15.0,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                /////// CIN ////////
                                Container(
                                  padding: const EdgeInsets.all(5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.all(5),
                                        child: Image.asset(
                                          "assets/CINlogo2.png",
                                          height: 25,
                                          width: 25,
                                        ),
                                      ),
                                      new Text(
                                        "${livreurSnapshot.data['numeroCIN']}",
                                        style: new TextStyle(
                                          fontSize: 15.0,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                /////// Moyen transport ////////
                                Container(
                                  padding: const EdgeInsets.all(5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.all(5),
                                        child: Image.asset(
                                          "assets/trans.png",
                                          height: 30,
                                          width: 30,
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                          'Moyen de transport',
                                          style: new TextStyle(
                                            fontSize: 15.0,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                ////////// photos moyen transport ////
                                for (var item
                                    in livreurSnapshot.data['moyenTransport'])
                                  Container(
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    left: 30),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              left: 5),
                                                      child: Image.asset(
                                                        "${getLogoMoyenTransport(item['type'])}",
                                                        height: 30,
                                                        width: 30,
                                                      ),
                                                    ),
                                                    Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              left: 5),
                                                      child: Text(
                                                        '${item['type']}',
                                                        style: new TextStyle(
                                                          fontSize: 15.0,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        ///////// Permis importé. ///////////
                                        Container(
                                          margin:
                                              const EdgeInsets.only(left: 60),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    left: 5),
                                                child: Image.asset(
                                                  "${getIconePiece(item['imagePermis'])}",
                                                  height: 20,
                                                  width: 20,
                                                ),
                                              ),
                                              Container(
                                                margin: const EdgeInsets.all(5),
                                                child: Text(
                                                  "${getMessagePermis(item['imagePermis'])}",
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        ///////// CG ///////////
                                        Container(
                                          margin:
                                              const EdgeInsets.only(left: 60),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    left: 5),
                                                child: Image.asset(
                                                  "${getIconePiece(item['imageCarteGrise'])}",
                                                  height: 20,
                                                  width: 20,
                                                ),
                                              ),
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    left: 5),
                                                child: Text(
                                                  "${getMessageCarteGrise(item['imageCarteGrise'])}",
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

                          ////// Jours de Travail  /////////
                          Container(
                            margin: const EdgeInsets.all(5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(5),
                                  child: Icon(Icons.work),
                                ),
                                Text(
                                  'Jours de Travail  ',
                                  style: new TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              /////// Lundi ///////
                              Container(
                                child: Column(
                                  children: [
                                    Text(
                                      "L",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Card(
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                          color: Colors.black,
                                          width: 1.0,
                                        ),
                                      ),
                                      child: Image.asset(
                                        "${getColorJourDeTravail('lundi')}",
                                        width: 25,
                                        height: 25,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              //////////////// Mardi /////////////////////
                              Container(
                                child: Column(
                                  children: [
                                    Text(
                                      "M",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Card(
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                          color: Colors.black,
                                          width: 1.0,
                                        ),
                                      ),
                                      child: Image.asset(
                                        "${getColorJourDeTravail('mardi')}",
                                        width: 25,
                                        height: 25,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              ////////// Mecredi ////////////////////////
                              Container(
                                child: Column(
                                  children: [
                                    Text(
                                      "M",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Card(
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                          color: Colors.black,
                                          width: 1.0,
                                        ),
                                      ),
                                      child: Image.asset(
                                        "${getColorJourDeTravail('mercredi')}",
                                        width: 25,
                                        height: 25,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              /////////////////// Jeudi ///////////////////
                              Container(
                                child: Column(
                                  children: [
                                    Text(
                                      "J",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Card(
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                          color: Colors.black,
                                          width: 1.0,
                                        ),
                                      ),
                                      child: Image.asset(
                                        "${getColorJourDeTravail('jeudi')}",
                                        width: 25,
                                        height: 25,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              ////////////////////// Vendredi ////////////////////////////
                              Container(
                                child: Column(
                                  children: [
                                    Text(
                                      "V",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Card(
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                          color: Colors.black,
                                          width: 1.0,
                                        ),
                                      ),
                                      child: Image.asset(
                                        "${getColorJourDeTravail('vendredi')}",
                                        width: 25,
                                        height: 25,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              //////////////////// Samedi //////////////////////////////////
                              Container(
                                child: Column(
                                  children: [
                                    Text(
                                      "S",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Card(
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                          color: Colors.black,
                                          width: 1.0,
                                        ),
                                      ),
                                      child: Image.asset(
                                        "${getColorJourDeTravail('samedi')}",
                                        width: 25,
                                        height: 25,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              ////////////// Dimanche /////////////////
                              Container(
                                child: Column(
                                  children: [
                                    Text(
                                      "D",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Card(
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                          color: Colors.black,
                                          width: 1.0,
                                        ),
                                      ),
                                      child: Image.asset(
                                        "${getColorJourDeTravail('dimanche')}",
                                        width: 25,
                                        height: 25,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          InkWell(
                            onTap: () => afficherCommentaireLivreur(context),
                            child: Container(
                              margin: const EdgeInsets.all(5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.all(5),
                                    child: Image.asset(
                                      "assets/hastag.png",
                                      height: 25,
                                      width: 25,
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      "Commentaires",
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(left: 5),
                                    child: Text(
                                      // "66",
                                      nb,
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else
            return Container(
              width: 0.0,
              height: 0.0,
              color: Colors.white,
            );
        });
  }
}
