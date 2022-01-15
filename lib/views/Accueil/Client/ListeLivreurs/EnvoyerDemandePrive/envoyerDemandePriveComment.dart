import 'package:easy_gradient_text/easy_gradient_text.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';

import 'package:livreurs_app/Controllers/demandeController.dart';

import '../../../accueilClient.dart';
import 'envoyerDemandePriveQuand.dart';

/// This Widget is the main application widget.
// ignore: must_be_immutable
class EnvoyerDemandePriveComment extends StatefulWidget {
  String adresseRecuperation;
  String villeRecuperation;
  String adresseLivraison;
  String villeLivraison;
  String idLivreur;

  EnvoyerDemandePriveComment({
    Key key,
    this.adresseRecuperation,
    this.villeRecuperation,
    this.adresseLivraison,
    this.villeLivraison,
    this.idLivreur,
  }) : super(key: key);
  @override
  EnvoyerDemandePriveCommentState createState() =>
      EnvoyerDemandePriveCommentState(adresseRecuperation, villeRecuperation,
          adresseLivraison, villeLivraison, idLivreur);
}

class EnvoyerDemandePriveCommentState
    extends State<EnvoyerDemandePriveComment> {
  String adresseRecuperation;
  String villeRecuperation;
  String adresseLivraison;
  String villeLivraison;
  String idLivreur;
  EnvoyerDemandePriveCommentState(
    this.adresseRecuperation,
    this.villeRecuperation,
    this.adresseLivraison,
    this.villeLivraison,
    this.idLivreur,
  );

  DemandeController demandeController = new DemandeController();
  bool valueVoiture = false;
  bool valueMoto = false;
  bool valueCamion = false;
  bool valuePickup = false;
  bool valueTaxi = false;
  bool valueVelo = false;
  String dure, distance;

  @override
  Widget build(BuildContext context) {
    calculerDistance() async {
      final query = adresseRecuperation + "," + villeRecuperation;
      var addresses = await Geocoder.local.findAddressesFromQuery(query);
      var first = addresses.first;
      // From a query
      final queryA = adresseLivraison + "," + villeLivraison;
      var addressesA = await Geocoder.local.findAddressesFromQuery(queryA);
      var firstA = addressesA.first;

      print(
          "${(Geolocator.distanceBetween(first.coordinates.latitude, first.coordinates.longitude, firstA.coordinates.latitude, firstA.coordinates.longitude) / 1000)}" +
              " Km");
      distance =
          "${(Geolocator.distanceBetween(first.coordinates.latitude, first.coordinates.longitude, firstA.coordinates.latitude, firstA.coordinates.longitude) / 1000)}";
    }

    calculerDure(vitesse) async {
      final query = adresseRecuperation + "," + villeRecuperation;
      var addresses = await Geocoder.local.findAddressesFromQuery(query);
      var first = addresses.first;
      // From a query
      final queryA = adresseLivraison + "," + villeLivraison;
      var addressesA = await Geocoder.local.findAddressesFromQuery(queryA);
      var firstA = addressesA.first;

      if (valueVoiture != false ||
          valueMoto != false ||
          valueCamion != false ||
          valuePickup != false ||
          valueTaxi != false ||
          valueVelo != false)
        print(
            "${(Geolocator.distanceBetween(first.coordinates.latitude, first.coordinates.longitude, firstA.coordinates.latitude, firstA.coordinates.longitude) / 1000) * vitesse}" +
                " s");
      dure =
          "${(Geolocator.distanceBetween(first.coordinates.latitude, first.coordinates.longitude, firstA.coordinates.latitude, firstA.coordinates.longitude) / 1000) * vitesse}";
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
                        image: new AssetImage("assets/oneD.png"),
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
                        image: new AssetImage("assets/twoActive.png"),
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
            ///// Moyens de transport ////

            Container(
              margin: const EdgeInsets.only(top: 25, left: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  /////////// Titre Moyens de transport  ////////
                  Container(
                    // ignore: deprecated_member_use
                    child: Row(
                      children: [
                        Container(
                          child: ImageIcon(AssetImage("assets/trans.png"),
                              size: 40),
                        ),
                        Container(
                          child: Text(
                            " Moyens de transport : ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Column(
                children: [
                  //////// Checkbox Voiture =======> Velo
                  CheckboxListTile(
                    secondary: Image(
                      image: new AssetImage("assets/car.png"),
                      width: 30,
                      height: 30,
                      color: null,
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.center,
                    ),
                    title: const Text('Voiture'),
                    value: this.valueVoiture,
                    onChanged: (bool value) {
                      setState(() {
                        calculerDistance();
                        calculerDure(60);
                        this.valueVoiture = value;
                      });
                    },
                  ),
                  CheckboxListTile(
                    secondary: Image(
                      image: new AssetImage("assets/motorcycle.png"),
                      width: 30,
                      height: 30,
                      color: null,
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.center,
                    ),
                    title: const Text('Moto / Scooter'),
                    value: this.valueMoto,
                    onChanged: (bool value) {
                      setState(() {
                        calculerDistance();
                        calculerDure(40);
                        this.valueMoto = value;
                      });
                    },
                  ),
                  CheckboxListTile(
                    secondary: Image(
                      image: new AssetImage("assets/truck.png"),
                      width: 30,
                      height: 30,
                      color: null,
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.center,
                    ),
                    title: const Text('Camion'),
                    value: this.valueCamion,
                    onChanged: (bool value) {
                      setState(() {
                        calculerDistance();
                        calculerDure(50);
                        this.valueCamion = value;
                      });
                    },
                  ),
                  CheckboxListTile(
                    secondary: Image(
                      image: new AssetImage("assets/pickup.png"),
                      width: 30,
                      height: 30,
                      color: null,
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.center,
                    ),
                    title: const Text('Pickup'),
                    value: this.valuePickup,
                    onChanged: (bool value) {
                      setState(() {
                        calculerDistance();
                        calculerDure(45);
                        this.valuePickup = value;
                      });
                    },
                  ),
                  CheckboxListTile(
                    secondary: Image(
                      image: new AssetImage("assets/taxi.png"),
                      width: 30,
                      height: 30,
                      color: null,
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.center,
                    ),
                    title: const Text('Taxi'),
                    value: this.valueTaxi,
                    onChanged: (bool value) {
                      setState(() {
                        calculerDistance();
                        calculerDure(60);
                        this.valueTaxi = value;
                      });
                    },
                  ),
                  CheckboxListTile(
                    secondary: Image(
                      image: new AssetImage("assets/bicycle.png"),
                      width: 30,
                      height: 30,
                      color: null,
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.center,
                    ),
                    title: const Text('Vélo'),
                    value: this.valueVelo,
                    onChanged: (bool value) {
                      setState(() {
                        calculerDistance();
                        calculerDure(10);
                        this.valueVelo = value;
                      });
                    },
                  ),
                ],
              ),
            ),
            /////////// Distance approximative ////////
            if (distance != null)
              Container(
                margin: const EdgeInsets.all(10),
                // ignore: deprecated_member_use
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          child: Image(
                            image: new AssetImage("assets/distance.png"),
                            width: 40,
                            height: 40,
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.center,
                          ),
                        ),
                        Container(
                          child: Text(
                            "Distance approximative : ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      child: Text(
                        "$distance Km",
                        style:
                            TextStyle(fontSize: 12, color: Colors.orange[700]),
                      ),
                    ),
                  ],
                ),
              ),

            /////////// Durée approximative ////////
            if (dure != null)
              Container(
                margin: const EdgeInsets.all(10),
                // ignore: deprecated_member_use
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          child: Image(
                            image: new AssetImage("assets/stopwatch.png"),
                            width: 40,
                            height: 40,
                            color: null,
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.center,
                          ),
                        ),
                        Container(
                          child: Text(
                            "Durée approximative : ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      child: Text(
                        "$dure s",
                        style:
                            TextStyle(fontSize: 12, color: Colors.orange[700]),
                      ),
                    ),
                  ],
                ),
              ),

            ///// Button Suivant ////
            Container(
              margin: const EdgeInsets.all(10),
              // ignore: deprecated_member_use
              child: FlatButton(
                onPressed: () {
                  if (valueVoiture == false &&
                      valueMoto == false &&
                      valueCamion == false &&
                      valuePickup == false &&
                      valueTaxi == false &&
                      valueVelo == false) {
                    _showDialog(
                        "Vous devez choisir au moins un moyen de transport!");
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EnvoyerDemandePriveQuand(
                                idLivreur: "$idLivreur",
                                adresseRecuperation: "$adresseRecuperation",
                                villeRecuperation: "$villeRecuperation",
                                adresseLivraison: "$adresseLivraison",
                                villeLivraison: "$villeLivraison",
                                valueVoiture: "$valueVoiture",
                                valueMoto: "$valueMoto",
                                valueCamion: "$valueCamion",
                                valuePickup: "$valuePickup",
                                valueTaxi: "$valueTaxi",
                                valueVelo: "$valueVelo",
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
