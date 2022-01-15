import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:livreurs_app/Controllers/livraisonController.dart';
import 'package:livreurs_app/Controllers/notificationController.dart';
import 'package:livreurs_app/views/Accueil/Client/FutursLivraisons/SignalerClient.dart';
import 'package:livreurs_app/views/Accueil/Client/FutursLivraisons/noterClient.dart';
import 'package:livreurs_app/views/Accueil/accueilClient.dart';
import 'package:livreurs_app/const.dart' as Const;
import 'package:timeline_tile/timeline_tile.dart';

// ignore: must_be_immutable
class SuiviDemandeActive extends StatefulWidget {
  String idLivraison;
  String idLivreur;
  LinkedHashMap<String, dynamic> demande;
  LinkedHashMap<String, dynamic> livraison;
  LinkedHashMap<String, dynamic> livreur;
  SuiviDemandeActive(
      {Key key,
      @required this.demande,
      @required this.idLivraison,
      @required this.idLivreur,
      @required this.livraison,
      @required this.livreur})
      : super(key: key);

  @override
  _SuiviDemandeActiveState createState() => _SuiviDemandeActiveState(
      demande, idLivraison, idLivreur, livraison, livreur);
}

class _SuiviDemandeActiveState extends State<SuiviDemandeActive> {
  String idLivraison;
  String idLivreur;
  String status;
  LinkedHashMap<String, dynamic> demande;
  LinkedHashMap<String, dynamic> livraison;
  LinkedHashMap<String, dynamic> livreur;
  _SuiviDemandeActiveState(this.demande, this.idLivraison, this.idLivreur,
      this.livraison, this.livreur);
  LivraisonController livraisonController = new LivraisonController();
  NotificationController notificationController = new NotificationController();

  @override
  Widget build(BuildContext context) {
    print("********************* $idLivraison *******************");
    print("********************* $demande *******************");
    print('********************* $livraison *******************');
    print('********************* $livreur *******************');
    String todayNotification =
        DateFormat("yyyy-MM-dd HH:mm").format(DateTime.now());
    String today = DateFormat("MM/dd/yyyy hh:mm a").format(DateTime.now());
    print(
        "Today :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: $todayNotification");

    _onPressedRecu() {
      livraisonController.livraisonRecu(idLivraison);
      notificationController.ajouterNotification(
          idLivreur.trim(),
          Const.idClLiv,
          demande['_id'],
          idLivraison,
          "A",
          "a confirmé qu'il a reçu sa commande avec succès.",
          todayNotification);
      setState(() {
        Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) => NoterClient(
                    idLivraison: idLivraison, idLivreur: idLivreur)));
      });
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
            Container(
              margin: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    child: Text(
                      "$today",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    child: Icon(Icons.person),
                  ),
                  Container(
                    child: Text(
                      "${livreur['prenom']} ${livreur['nom']}",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),

            Container(
              margin: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  livraison['statutLivraison'] == "en attente "
                      ? TimelineTile(
                          alignment: TimelineAlign.center,
                          isFirst: true,
                          indicatorStyle: const IndicatorStyle(
                            width: 20,
                            color: Colors.green,
                            padding: EdgeInsets.all(8),
                            indicatorXY: 0.3,
                          ),
                          endChild: Container(
                            child: Column(
                              children: [
                                Image.asset(
                                  "assets/order_processed.PNG",
                                  height: 50,
                                  width: 50,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "En attente",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: Colors.black),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "En attente de la livreur qui livre votre commande",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.black),
                                )
                              ],
                            ),
                          ),
                        )
                      : TimelineTile(
                          alignment: TimelineAlign.center,
                          isFirst: true,
                          indicatorStyle: const IndicatorStyle(
                            width: 20,
                            color: Colors.orange,
                            padding: EdgeInsets.all(8),
                            indicatorXY: 0.3,
                          ),
                          endChild: Container(
                            child: Column(
                              children: [
                                Image.asset(
                                  "assets/order_processed.PNG",
                                  height: 50,
                                  width: 50,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "En attente",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: Colors.black),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "En attente de la livreur qui livre votre commande",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.black),
                                )
                              ],
                            ),
                          ),
                        ),
                  livraison['statutLivraison'] == "En cours"
                      ? TimelineTile(
                          alignment: TimelineAlign.center,
                          indicatorStyle: const IndicatorStyle(
                            width: 20,
                            color: Colors.green,
                            padding: EdgeInsets.all(8),
                            indicatorXY: 0.3,
                          ),
                          startChild: Container(
                            child: Column(
                              children: [
                                Image.asset(
                                  "assets/on_the_way.PNG",
                                  height: 50,
                                  width: 50,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "En cours",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: Colors.black),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Cette livreur est en route",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.black),
                                )
                              ],
                            ),
                          ),
                        )
                      : TimelineTile(
                          alignment: TimelineAlign.center,
                          indicatorStyle: const IndicatorStyle(
                            width: 20,
                            color: Colors.orange,
                            padding: EdgeInsets.all(8),
                            indicatorXY: 0.3,
                          ),
                          startChild: Container(
                            child: Column(
                              children: [
                                Image.asset(
                                  "assets/on_the_way.PNG",
                                  height: 50,
                                  width: 50,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "En cours",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: Colors.black),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Cette livreur est en route",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.black),
                                )
                              ],
                            ),
                          ),
                        ),
                  livraison['statutLivraison'] == "Livré"
                      ? TimelineTile(
                          alignment: TimelineAlign.center,
                          isLast: true,
                          indicatorStyle: const IndicatorStyle(
                            width: 20,
                            color: Colors.green,
                            padding: EdgeInsets.all(8),
                            indicatorXY: 0.3,
                          ),
                          endChild: Container(
                            child: Column(
                              children: [
                                Image.asset(
                                  "assets/order_confirmed.PNG",
                                  height: 50,
                                  width: 50,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Livré",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: Colors.black),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "La demande a été livrée avec succès !",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.black),
                                )
                              ],
                            ),
                          ),
                        )
                      : TimelineTile(
                          alignment: TimelineAlign.center,
                          isLast: true,
                          indicatorStyle: const IndicatorStyle(
                            width: 20,
                            color: Colors.orange,
                            padding: EdgeInsets.all(8),
                            indicatorXY: 0.3,
                          ),
                          endChild: Container(
                            child: Column(
                              children: [
                                Image.asset(
                                  "assets/order_confirmed.PNG",
                                  height: 50,
                                  width: 50,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Livré",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: Colors.black),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "La demande a été livrée avec succès !",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.black),
                                )
                              ],
                            ),
                          ),
                        ),
                ],
              ),
            ),

            //////// Button Recus et Signaler /////
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.all(20),
                    // ignore: deprecated_member_use
                    child: FlatButton(
                      onPressed: () => _onPressedRecu(),
                      child: Text(
                        "Reçu",
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
                        setState(() {
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) =>
                                      SignalerClient(idLivreur: idLivreur)));
                        });
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
