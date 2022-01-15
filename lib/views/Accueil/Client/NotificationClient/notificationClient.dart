import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:livreurs_app/Controllers/demandeController.dart';
import 'package:livreurs_app/Controllers/livreurController.dart';
import 'package:livreurs_app/Controllers/userController.dart';
import 'package:livreurs_app/Controllers/notificationController.dart';
import 'package:livreurs_app/views/Accueil/Client/FutursLivraisons/futursLivraisonsClient.dart';
import 'package:livreurs_app/views/Accueil/Client/Historiques/histouriquesClient.dart';
import 'package:livreurs_app/views/Accueil/Client/ListeLivreurs/detailProfileLivreur.dart';

import 'package:livreurs_app/views/Accueil/accueilClient.dart';
import 'package:livreurs_app/const.dart' as Const;

/// This Widget is the main application widget.
class NotificationClient extends StatefulWidget {
  @override
  _NotificationClientState createState() => _NotificationClientState();
}

class _NotificationClientState extends State<NotificationClient> {
  NotificationController notificationController = new NotificationController();
  @override
  Widget build(BuildContext context) {
    // ignore: todo
    // TODO: implement build
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
                        builder: (context) => AccueilClient()));
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
                        builder: (context) => AccueilClient()));
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
  LivreurController livreurController = new LivreurController();
  List list;
  ItemList({this.list});
  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
        itemCount: list == null ? 0 : list.length,
        itemBuilder: (context, i) {
          String idLivreur = list[i]['idExpediteur'];
          // ignore: unused_local_variable
          String idDemande = list[i]['idDemande'];
          // ignore: unused_local_variable
          String idLivraison = list[i]['idLivraison'];
          String message = list[i]['message'];
          // ignore: unused_local_variable
          bool dejaVu = list[i]['dejaVu'];
          String dateNotifications = list[i]['dateNotifications'];

          routeController() {
            if (message == "est intéréssé par votre demande de livraison.") {
              Navigator.push(
                  context, new MaterialPageRoute(builder: (context) => null));
            }
            if (message == "a accepté votre demande de livraison privée.") {
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

            if (message == "a refusé votre demande de livraison privée.") {
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) =>
                          DetailProfileLivreur(id: idLivreur)));
            }
            if (message == "a annulé votre livraison.") {
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => HistouriquesClient(
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
            if (message == "est en route de récupération de votre livraison.") {
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
            if (message ==
                "a confirmé qu'il a livré votre commande avec succés.") {
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => HistouriquesClient(
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
          }

          return FutureBuilder(
              future: livreurController.obtenirLivreur(idLivreur),
              builder: (context, AsyncSnapshot livreurSnapshot) {
                if (livreurSnapshot.hasData) {
                  Uint8List _bytesImage;
                  String _imgProfileString =
                      '${livreurSnapshot.data['imageProfile']}';
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
                                          "${livreurSnapshot.data['prenom']} ${livreurSnapshot.data['nom']} ",
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
