import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:livreurs_app/Controllers/livreurController.dart';
import 'package:flutter/painting.dart';
import 'package:livreurs_app/views/Accueil/Livreur/Profile/Modifier/modifierProfileLivreur.dart';
import 'package:livreurs_app/views/Accueil/accueilLivreur.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:livreurs_app/const.dart' as Const;
import 'package:flutter_advanced_avatar/flutter_advanced_avatar.dart';

/// This Widget is the main application widget.
class ProfileLivreur extends StatefulWidget {
  @override
  _ProfileLivreurState createState() => _ProfileLivreurState();
}

class _ProfileLivreurState extends State<ProfileLivreur> {
  LivreurController livreurController = new LivreurController();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: livreurController.obtenirInformationLivreur(),
        builder: (context, AsyncSnapshot livreurSnapshot) {
          if (livreurSnapshot.hasData) {
            Color getColorAvatar() {
              if (livreurSnapshot.data['enService'] == true) {
                return Colors.green;
              } else {
                return Colors.grey;
              }
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

            /////// afficher type de moyen du transport ///////
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

            //////// Calculer puissance de compléter profile
            double getpuissanceprofile() {
              double p = 100.0;
              if (livreurSnapshot.data['imageCIN'] == null) p = p - 10;
              if (livreurSnapshot.data['imageProfile'] ==
                  Const.imageProfileLivreur) p = p - 15;
              if (livreurSnapshot.data['moyenTransport'][0]['imagePermis'] ==
                  null) p = p - 10;
              if (livreurSnapshot.data['moyenTransport'][0]
                      ['imageCarteGrise'] ==
                  null) p = p - 10;
              return p;
            }

            /////// afficher image du profile livreur à partir base de donnée
            Uint8List _bytesImage;
            String _imgProfileString =
                '${livreurSnapshot.data['imageProfile']}';
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
                          MaterialPageRoute(
                              builder: (context) => AccueilLivreur()),
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
                                ' Profil personnel',
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
                  child: Column(
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
                            child: Container(
                              margin: const EdgeInsets.all(10),
                              child: AdvancedAvatar(
                                size: 150,
                                statusColor: getColorAvatar(),
                                child: ClipOval(
                                  child: Image.memory(
                                    _bytesImage,
                                    height: 150,
                                    width: 150,
                                    fit: BoxFit.cover,
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
                                  padding: const EdgeInsets.all(5),
                                  child: Text(
                                      "${livreurSnapshot.data['prenom']} ${livreurSnapshot.data['nom']}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      )),
                                ),
                                ////// Note //////
                                Center(
                                  child: Container(
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
                                              rating: livreurSnapshot
                                                  .data['noteTotal']
                                                  .toDouble(),
                                              itemBuilder: (context, index) =>
                                                  Icon(
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

                          //////////// Note,Nombre du Laivraison,Nombre du Signale ///////////////
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                ////// photos Nombre laivraison ///////////
                                Container(
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
                                          padding: const EdgeInsets.all(5),
                                          child: ClipOval(
                                            child: Image.asset(
                                              "assets/livraison.png",
                                              height: 25,
                                              width: 25,
                                            ),
                                          ),
                                        ),

                                        Container(
                                          padding: const EdgeInsets.all(5),
                                          child: Text(" : ",
                                              style: TextStyle(
                                                color: Colors.orange,
                                                fontWeight: FontWeight.bold,
                                              )),
                                        ),

                                        /////// Nombre du Laivraison ////////////

                                        Container(
                                          padding: const EdgeInsets.all(5),
                                          child: Text(
                                              "${livreurSnapshot.data['nombreLivraisons']}",
                                              style: TextStyle(
                                                color: Colors.red,
                                                fontWeight: FontWeight.bold,
                                              )),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                /////// photo nombre signal /////////////

                                Container(
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
                                          padding: const EdgeInsets.all(5),
                                          child: ClipOval(
                                            child: Image.asset(
                                              "assets/dislike.png",
                                              height: 25,
                                              width: 25,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(5),
                                          child: Text(" : ",
                                              style: TextStyle(
                                                color: Colors.orange,
                                                fontWeight: FontWeight.bold,
                                              )),
                                        ),

                                        ////////// Nombre du Signal //////////////

                                        Container(
                                          padding: const EdgeInsets.all(5),
                                          child: Text(
                                              "${livreurSnapshot.data['nombreSignale']}",
                                              style: TextStyle(
                                                color: Colors.red,
                                                fontWeight: FontWeight.bold,
                                              )),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ]),

                          //////// Complétez votre profil ///////////
                          if (getpuissanceprofile() != 100.0)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(5.0),
                                      child: new LinearPercentIndicator(
                                        width: 140.0,
                                        lineHeight: 14.0,
                                        percent: getpuissanceprofile() / 100,
                                        center: Text(
                                          "${getpuissanceprofile()}%",
                                          style: new TextStyle(fontSize: 12.0),
                                        ),
                                        trailing: Icon(Icons.mood),
                                        linearStrokeCap:
                                            LinearStrokeCap.roundAll,
                                        backgroundColor: Colors.grey,
                                        progressColor: Colors.orangeAccent,
                                      ),
                                    ),
                                    // ignore: deprecated_member_use
                                    FlatButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            new MaterialPageRoute(
                                                builder: (context) =>
                                                    ModifierProfileLivreur()));
                                      },
                                      child: Text(
                                        "Complétez votre profil",
                                        style: TextStyle(
                                            color: Colors.orange,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                        ],
                      ),

                      //////// Partie de Profile Detail ///////////
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration:
                            new BoxDecoration(color: Colors.orange[200]),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            //////
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Container(
                                  child: ClipOval(
                                    child: InkWell(
                                        child: Image.asset(
                                          "assets/update.png",
                                          height: 30,
                                          width: 30,
                                          fit: BoxFit.cover,
                                          color: Colors.orange[800],
                                        ),
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              new MaterialPageRoute(
                                                  builder: (context) =>
                                                      ModifierProfileLivreur()));
                                        }),
                                  ),
                                ),
                              ],
                            ),

                            ////// Text Profile Details //////
                            Container(
                              margin:
                                  const EdgeInsets.only(left: 10, bottom: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  new Text(
                                    'Profile Details',
                                    style: new TextStyle(
                                      fontSize: 20.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
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
                                  Image.asset(
                                    "assets/CINlogo2.png",
                                    height: 25,
                                    width: 25,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(5),
                                    child: Text(
                                      "${livreurSnapshot.data['numeroCIN']}",
                                      style: new TextStyle(
                                        fontSize: 15.0,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            ///// Adresse //////////
                            Container(
                              padding: const EdgeInsets.all(5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    "assets/adresse.png",
                                    height: 25,
                                    width: 25,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(5),
                                    child: Text(
                                      "${livreurSnapshot.data['adresse']}",
                                      style: new TextStyle(
                                        fontSize: 15.0,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            ////// Ville /////////
                            Container(
                              padding: const EdgeInsets.all(5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(Icons.location_city),
                                  Container(
                                    padding: const EdgeInsets.all(5),
                                    child: Text(
                                      "${livreurSnapshot.data['ville']}",
                                      style: new TextStyle(
                                        fontSize: 15.0,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            /////// Moyen transport ////////
                            if (livreurSnapshot.data['moyenTransport'] != null)
                              /////// Moyen transport ////////
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.all(5),
                                    child: Image.asset(
                                      "assets/trans.png",
                                      height: 25,
                                      width: 25,
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
                                            margin:
                                                const EdgeInsets.only(left: 30),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      left: 5),
                                                  child: Image.asset(
                                                    "${getLogoMoyenTransport(item['type'])}",
                                                    height: 25,
                                                    width: 25,
                                                    color: Colors.orange[800],
                                                  ),
                                                ),
                                                Container(
                                                  margin: const EdgeInsets.only(
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
                                      margin: const EdgeInsets.only(left: 60),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin:
                                                const EdgeInsets.only(left: 5),
                                            child: Image.asset(
                                              "${getIconePiece(item['imagePermis'])}",
                                              height: 20,
                                              width: 20,
                                              color: Colors.orange[800],
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
                                      margin: const EdgeInsets.only(left: 60),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin:
                                                const EdgeInsets.only(left: 5),
                                            child: Image.asset(
                                              "${getIconePiece(item['imageCarteGrise'])}",
                                              color: Colors.orange[800],
                                              height: 20,
                                              width: 20,
                                            ),
                                          ),
                                          Container(
                                            margin:
                                                const EdgeInsets.only(left: 5),
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
                            /////// Email ////////////////
                            Container(
                              padding: const EdgeInsets.all(5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(Icons.email),
                                  Container(
                                    padding: const EdgeInsets.all(5),
                                    child: Text(
                                      "${livreurSnapshot.data['email']}",
                                      style: new TextStyle(
                                        fontSize: 15.0,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            Container(
                              padding: const EdgeInsets.all(5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.phone,
                                    size: 25,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(5),
                                    child: Text(
                                      "${livreurSnapshot.data['telephone']}",
                                      style: new TextStyle(
                                        fontSize: 15.0,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            ////// Jours de Travail  /////////
                            Container(
                              padding: const EdgeInsets.all(5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(Icons.work),
                                  Container(
                                    padding: const EdgeInsets.all(5),
                                    child: Text(
                                      'Jours de Travail  ',
                                      style: new TextStyle(
                                        fontSize: 15.0,
                                        color: Colors.black,
                                      ),
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
                          ],
                        ),
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
