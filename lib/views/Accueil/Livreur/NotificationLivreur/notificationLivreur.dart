import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:livreurs_app/Controllers/clientController.dart';
import 'package:livreurs_app/Controllers/demandeController.dart';
import 'package:livreurs_app/Controllers/userController.dart';
import 'package:livreurs_app/Controllers/notificationController.dart';
import 'package:livreurs_app/views/Accueil/Livreur/DemandesPubliques/detailDemandeLivreur.dart';
import 'package:livreurs_app/views/Accueil/Livreur/DemandesRecus/demandesRecues.dart';
import 'package:livreurs_app/views/Accueil/Livreur/FutursLivraisons/futurLivraisonLivreur.dart';
import 'package:livreurs_app/views/Accueil/Livreur/Historiques/histouriquesLivreur.dart';
import 'package:livreurs_app/views/Accueil/Livreur/Profile/profileLivreur.dart';
import 'package:livreurs_app/views/Accueil/accueilLivreur.dart';
import 'package:livreurs_app/const.dart' as Const;

/// This Widget is the main application widget.
class NotificationLivreur extends StatefulWidget {
  @override
  _NotificationLivreurState createState() => _NotificationLivreurState();
}

class _NotificationLivreurState extends State<NotificationLivreur> {
  NotificationController notificationController = new NotificationController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      //////////////////////////////////////////////////// AppBar Livraison GV ///////////////////////////////////////////
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        iconTheme: IconThemeData(color: Colors.black),
        title: Center(
          child: Container(
            padding: EdgeInsets.all(1),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Flexible(
                      flex: 3,
                      child: Container(
                        margin: EdgeInsets.all(1.0),
                        child: Text(
                          ' Livraison GV',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Container(
                        margin: EdgeInsets.all(5.0),
                        child: Image.asset(
                          "assets/logo.png",
                          height: 50,
                          width: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        ///////////////////////////// Icone Home et Notifications /////////////////////
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.notifications,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => AccueilLivreur()));
              }),
          IconButton(
              icon: Icon(
                Icons.home,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => AccueilLivreur()));
              })
        ],
      ),

      /////// Body de Page ///////////

      body: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              ////// Titre du Page  //////

              Container(
                margin: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Notifications",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ],
                ),
              ),
              ///////////////////////  Listtes des notifications ////////////////////////////////
              Container(
                color: Colors.grey[50],
                child: SizedBox(
                  height: 670,
                  child: new FutureBuilder<List>(
                    future: notificationController
                        .obtenirNotificationsParId(Const.idClLiv),
                    builder: (context, snapchot) {
                      if (snapchot.hasError) print(snapchot.error);
                      return snapchot.hasData
                          ? new ItemList(list: snapchot.data)
                          : Center(
                              child: CircularProgressIndicator(),
                            );
                    },
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}

// ignore: must_be_immutable
class ItemList extends StatelessWidget {
  UserController userController = new UserController();
  DemandeController demandeController = new DemandeController();
  ClientController clientController = new ClientController();
  List list;
  ItemList({this.list});
  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
        itemCount: list == null ? 0 : list.length,
        itemBuilder: (context, i) {
          String idClient = list[i]['idExpediteur'];
          String idDemande = list[i]['idDemande'];
          String message = list[i]['message'];
          String dateNotifications = list[i]['dateNotifications'];

          routeController() {
            if (message == "a annulé votre livraison.") {
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => HistouriquesLivreur(
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
            }
            if (message == "a noté votre livraison.") {
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => ProfileLivreur()));
            }
            if (message == "a confirmé qu'il a reçu sa commande avec succès.") {
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => HistouriquesLivreur(
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
            }
            if (message == "vous à envoyé une demande de livraison privée.") {
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => DemandesRecues(
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
            }
            if (message == "a accépté votre demande de livraison.") {
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => FutursLivraisonLivreur(
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
            }
            if (message == "a refusé votre demande de livraison.") {
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => DetailDemandeLivreur(
                          idDemande: idDemande, idClient: idClient)));
            }
          }

          return FutureBuilder(
              future: clientController.obtenirClient(idClient),
              builder: (context, AsyncSnapshot clientSnapshot) {
                if (clientSnapshot.hasData) {
                  Uint8List _bytesImage;
                  String _imgProfileString =
                      '${clientSnapshot.data['imageProfile']}';
                  _bytesImage = Base64Decoder().convert(_imgProfileString);

                  return new Container(
                    margin: const EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Flexible(
                          flex: 2,
                          child: Container(
                            margin: const EdgeInsets.all(2),
                            child: ClipOval(
                                child: Image.memory(
                              _bytesImage,
                              fit: BoxFit.cover,
                              width: 50,
                              height: 50,
                            )),
                          ),
                        ),
                        Flexible(
                          flex: 8,
                          child: Container(
                            margin: const EdgeInsets.all(3),
                            child: Column(
                              children: [
                                Container(
                                  child: Row(
                                    children: [
                                      Text(
                                        "$dateNotifications",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                                Text.rich(
                                  TextSpan(
                                      text:
                                          "${clientSnapshot.data['prenom']} ${clientSnapshot.data['nom']} ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: ' ${list[i]['message']}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal),
                                        )
                                      ]),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: Container(
                            child: IconButton(
                              icon: Icon(Icons.chevron_right),
                              iconSize: 30,
                              color: Colors.black,
                              onPressed: () => routeController(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return Container(
                    width: 0.0,
                    height: 0.0,
                    color: Colors.white,
                  );
                }
              });
        });
  }
}
