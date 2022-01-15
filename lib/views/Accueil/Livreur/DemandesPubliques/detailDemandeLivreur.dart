// ignore: unused_import
import 'dart:collection';

import 'package:easy_gradient_text/easy_gradient_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:intl/intl.dart';
import 'package:livreurs_app/Controllers/notificationController.dart';
import 'package:livreurs_app/views/Accueil/Livreur/DemandesPubliques/demandesPubliques.dart';
import 'package:livreurs_app/views/Accueil/accueilLivreur.dart';
import 'package:livreurs_app/Controllers/demandeController.dart';
import 'package:livreurs_app/const.dart' as Const;

/// This Widget is the main application widget.

// ignore: must_be_immutable
class DetailDemandeLivreur extends StatelessWidget {
  final String idDemande;
  final String idClient;
  DetailDemandeLivreur({Key key, this.idDemande, this.idClient})
      : super(key: key);
  DemandeController demandeController = new DemandeController();
  NotificationController notificationController = new NotificationController();
  TextEditingController prixLivreur = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    String todayNotification =
        DateFormat("yyyy-MM-dd HH:mm").format(DateTime.now());
    print(
        "Today :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: $todayNotification");
    void _showDialog() {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: new Text('Erreur'),
              content: new Text("entrer votre prix d'abord!"),
              actions: <Widget>[
                // ignore: deprecated_member_use
                new RaisedButton(
                  child: new Text('Fermer'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          });
    }

    _onPressedEnvoyer() {
      if (prixLivreur.text.trim() == "") {
        _showDialog();
      } else {
        demandeController
            .ajouterLivreurInteresse(
          idDemande,
          prixLivreur.text.trim(),
        )
            .whenComplete(() {
          notificationController.ajouterNotification(
              idClient,
              Const.idClLiv,
              idDemande,
              null,
              "A",
              "est intéréssé par votre demande de livraison.",
              todayNotification);
          Navigator.of(context).pop();
          Navigator.of(context).pop();

          Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) => DemandesPubliques(
                        dateLivraison: '',
                        contenu: "Tout",
                        nature: "Tout",
                        taille: 'Tout',
                        poids: "Tout",
                        regionRecuperation: "Tout",
                        regionLivraison: "Tout",
                        villeDeDepart: "Tout",
                        villeDeLivraison: "Tout",
                      )));
        });
      }
    }

    print("************------>>>> $idDemande");

    return FutureBuilder(
        future: demandeController.obtenirDemande(idDemande),
        builder: (context, AsyncSnapshot demandeSnapshot) {
          String description;
          if (demandeSnapshot.hasData) {
            if (demandeSnapshot.data['description'] != null) {
              description = demandeSnapshot.data['description'];
            } else {
              description = "Sans déscription";
            }
            Color getColor(text) {
              if (text == "Sans déscription")
                return Colors.grey;
              else
                return Colors.black;
            }

            bool dejaEnvoye() {
              bool deja = false;
              if (demandeSnapshot.data['livreurs_interesses'] != null) {
                for (var item in demandeSnapshot.data['livreurs_interesses']) {
                  if (item['idLivreur'] == Const.idClLiv) {
                    deja = true;
                  }
                }
              }
              return deja;
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

                              child: Text(
                                'Détail',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 18),
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
                    ///////////// Date et heure
                    Container(
                      margin: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GradientText(
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
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
                              "${demandeSnapshot.data['dateLivraison']}  ",
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
                              " ${demandeSnapshot.data['heureLivraison']} ",
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
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                              text: "Localisation",
                              colors: <Color>[
                                Colors.orange.shade300,
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //////// Adresse depart ////////
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
                                            "${demandeSnapshot.data['adresseRecuperationLivraison']}, ${demandeSnapshot.data['villeDeDepart']}",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
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
                                            "${demandeSnapshot.data['adresseDestinationLivraison']}, ${demandeSnapshot.data['villeDeLivraison']}",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
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
                    ////////////////////// Demande //////////////
                    Container(
                      margin: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GradientText(
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
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
                                "${demandeSnapshot.data['contenu']}",
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
                                "${demandeSnapshot.data['taille']}",
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
                                "${demandeSnapshot.data['nature']}",
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
                              child: Text("${demandeSnapshot.data['poids']}"),
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

                    ///////////////////////////////////  Prix //////////////////////////////
                    Container(
                      margin: const EdgeInsets.all(20),
                      child: Card(
                        elevation: 4.0,
                        color: Colors.grey[200],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        child: Column(
                          children: [
                            Container(
                              child: Row(
                                children: [
                                  /////// logo de prix /////
                                  Container(
                                    margin: const EdgeInsets.all(5),
                                    child: Image.asset(
                                      "assets/argentIcone.png",
                                      width: 30,
                                      height: 30,
                                    ),
                                  ),
                                  //////  Text "Entrer votre prix : (en DH)" //////
                                  Container(
                                    child: Text(
                                      "Entrer votre prix : (en DH)",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            //////// TextField "prix" //////
                            Container(
                              margin: const EdgeInsets.all(20),
                              child: TextField(
                                controller: prixLivreur,
                                style: TextStyle(color: Color(0xFF000000)),
                                cursorColor: Color(0xFF000000),
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  hintText: "0",
                                  hintStyle: TextStyle(
                                      color: Color(0xFF000000),
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    ///// Bottom "Envoyer" /////
                    if (dejaEnvoye() == false)
                      Container(
                        // ignore: deprecated_member_use
                        child: FlatButton(
                          onPressed: () => _onPressedEnvoyer(),
                          child: Text(
                            "Envoyer",
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
                    if (dejaEnvoye() == true)
                      Container(
                        // ignore: deprecated_member_use
                        child: FlatButton(
                          onPressed: () => null,
                          child: Text(
                            "déja envoyé",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          color: Colors.grey,
                          disabledColor: Colors.grey,
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(20.0)),
                        ),
                      ),
                  ],
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
