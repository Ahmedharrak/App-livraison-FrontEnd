import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:livreurs_app/Controllers/clientController.dart';
import 'package:livreurs_app/Controllers/notificationController.dart';
import 'package:livreurs_app/views/Accueil/Client/FutursLivraisons/futursLivraisonsClient.dart';
import 'package:livreurs_app/views/Accueil/Client/Historiques/histouriquesClient.dart';
import 'package:livreurs_app/views/Accueil/Client/ListeLivreurs/filtresListeLivreurs.dart';
import 'package:livreurs_app/views/Accueil/Client/ListeLivreurs/listeLivreurs.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:livreurs_app/views/Accueil/Client/NotificationClient/notificationClient.dart';
import 'package:livreurs_app/views/Accueil/Client/Profile/profileClient.dart';
import 'package:livreurs_app/views/Accueil/Client/Propos/aProposClient.dart';
import 'package:livreurs_app/views/Accueil/Client/PublierDemande/publierDemandeOu.dart';
import '../../main.dart';
import 'package:livreurs_app/const.dart' as Const;
import 'client/MesDemandes/demandesClient.dart';
import 'package:icon_badge/icon_badge.dart';

/// This Widget is the main application widget.
// ignore: must_be_immutable
class AccueilClient extends StatefulWidget {
  int i;
  @override
  _AccueilClientState createState() => _AccueilClientState(this.i);
}

class _AccueilClientState extends State<AccueilClient> {
  ClientController clientController = new ClientController();
  NotificationController notificationController = new NotificationController();
  int nombreNotification;
  int i;
  _AccueilClientState(this.i);
  Widget build(BuildContext context) {
    //////// Body ////////////////
    return new WillPopScope(
        onWillPop: () async => false,
        child: FutureBuilder(
            future: clientController.obtenirInformationClient(),
            builder: (context, AsyncSnapshot clientSnapshot) {
              if (clientSnapshot.hasData) {
                ////////////// Afficher l'image du profile de l'utilisateur /////////////
                Uint8List _bytesImage;
                String _imgProfileString =
                    '${clientSnapshot.data['imageProfile']}';
                _bytesImage = Base64Decoder().convert(_imgProfileString);
                return Scaffold(
                  backgroundColor: Colors.grey[200],
                  //////////////////////////////////////////////////// AppBar Livraison GV ///////////////////////////////////////////
                  appBar: AppBar(
                    backgroundColor: Colors.orangeAccent,
                    iconTheme: IconThemeData(color: Colors.black),
                    title: Center(
                      child: Container(
                        padding: EdgeInsets.all(1),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.all(1.0),
                              child: Text(
                                'LivraisonGV',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 18),
                              ),
                            ),
                            Container(
                              child: Image.asset(
                                "assets/logo.png",
                                height: 35,
                                width: 35,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    ///////////////////////////// Icone Home et Notifications /////////////////////
                    actions: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(5),
                        child: new FutureBuilder<List>(
                          future: notificationController
                              .obtenirNotificationsPasVu(Const.idUser),
                          builder: (context, snapchot) {
                            if (snapchot.hasError) print(snapchot.error);
                            return snapchot.hasData
                                ? IconBadge(
                                    icon: Icon(
                                      Icons.notifications,
                                      color: Colors.black,
                                    ),
                                    itemCount: snapchot.data.length,
                                    badgeColor: Colors.orange[800],
                                    itemColor: Colors.white,
                                    maxCount: 99,
                                    hideZero: true,
                                    onTap: () {
                                      setState(() {
                                        notificationController
                                            .modifierVuNotifications(
                                                '${clientSnapshot.data["_id"]}');
                                      });

                                      nombreNotification = 0;
                                      Navigator.push(
                                          context,
                                          new MaterialPageRoute(
                                              builder: (context) =>
                                                  NotificationClient()));
                                    })
                                : Icon(
                                    Icons.notifications,
                                    color: Colors.black,
                                  );
                          },
                        ),
                      ),
                      IconButton(
                          icon: Icon(
                            Icons.home,
                            color: Colors.black,
                          ),
                          onPressed: () {})
                    ],
                  ),

                  //////////////////////////////////// Center ou Body //////////////////////////
                  body: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        /////////////////////////////////////  slider Image ///////////////////
                        Container(
                          margin: const EdgeInsets.all(10),
                          width: MediaQuery.of(context).size.width,
                          height: 300,
                          child: Carousel(
                            images: [
                              AssetImage('assets/photo3.jpg'),
                              AssetImage('assets/photo2.jpg'),
                              AssetImage('assets/photo4.jpg'),
                            ],
                            dotSize: 8,
                            dotIncreaseSize: 2,
                            dotSpacing: 20,
                            dotColor: Colors.white,
                            dotBgColor: Colors.black.withOpacity(0.5),
                            boxFit: BoxFit.cover,
                            dotIncreasedColor: Colors.orangeAccent,
                          ),
                        ),

                        ////////////////////////////////// Partir les Button /////////////////////////////////////////////

                        //////////  Button chercher un  livreurs   //////
                        Container(
                          margin: const EdgeInsets.all(10),
                          width: MediaQuery.of(context).size.width,
                          // ignore: deprecated_member_use
                          child: FlatButton(
                            child: Padding(
                              padding: const EdgeInsets.all(40),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    margin: const EdgeInsets.all(10),
                                    child: Image.asset(
                                      "assets/listLivreurs.png",
                                      height: 70,
                                      width: 70,
                                      fit: BoxFit.cover,
                                      color: Colors.orange,
                                    ),
                                  ),
                                  Flexible(
                                    child: Container(
                                      margin: const EdgeInsets.all(10),
                                      child: Text(
                                        'Chercher un livreur ',
                                        textDirection: TextDirection.ltr,
                                        style: TextStyle(
                                          color: Colors.black,
                                          decoration: TextDecoration.none,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            color: Colors.white,
                            disabledColor: Colors.white,
                            onPressed: () => _chercherLivreur(),
                          ),
                        ),

                        //////////  Publier une demande   //////
                        Container(
                          margin: const EdgeInsets.all(10),
                          width: MediaQuery.of(context).size.width,
                          // ignore: deprecated_member_use
                          child: FlatButton(
                            onPressed: () => publierDemande(),
                            child: Padding(
                              padding: const EdgeInsets.all(40),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    margin: const EdgeInsets.all(10),
                                    // ignore: deprecated_member_use
                                    child: Image.asset(
                                      "assets/demandepublic1.png",
                                      height: 70,
                                      width: 70,
                                      fit: BoxFit.cover,
                                      color: Colors.orange,
                                    ),
                                  ),
                                  Flexible(
                                    child: Container(
                                      margin: const EdgeInsets.all(10),
                                      // ignore: deprecated_member_use
                                      child: Text(
                                        'Publier une demande',
                                        textDirection: TextDirection.ltr,
                                        style: TextStyle(
                                          color: Colors.black,
                                          decoration: TextDecoration.none,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            color: Colors.white,
                            disabledColor: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),

                  //////////////// Bar Drawer du Page Accueil //////////////////////////////
                  drawer: Drawer(
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.topRight,
                                  colors: [
                                    Color(0xFFFFAB40),
                                    Color(0xFFFFAB40)
                                  ]),
                            ),
                            child: Container(
                              margin:
                                  const EdgeInsets.only(top: 40, bottom: 10),
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Container(
                                        margin: const EdgeInsets.all(10),
                                        child: ClipOval(
                                          child: Image.memory(
                                            _bytesImage,
                                            height: 70,
                                            width: 70,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      /////////// Image du Profile ///////////
                                      Column(
                                        children: <Widget>[
                                          Text(
                                              "${clientSnapshot.data['prenom']} ${clientSnapshot.data['nom']}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                          Text("Espace client",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Container(
                                        margin: const EdgeInsets.only(left: 20),
                                        child: Image.asset(
                                          "assets/enterProfil.png",
                                          height: 30,
                                          width: 30,
                                          fit: BoxFit.cover,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(left: 20),
                                        child: InkWell(
                                          onTap: monProfile,
                                          child: Text(
                                            "Voir le Profile",
                                            style: TextStyle(
                                                decoration:
                                                    TextDecoration.underline,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),

                          ////////////////////// les Button du Bar Drawer /////////////////////////

                          Column(
                            children: <Widget>[
                              ListTile(
                                title: new Text("Mes demandes"),
                                leading: new Image.asset(
                                  "assets/mesdemandes.png",
                                  height: 30,
                                  width: 30,
                                  fit: BoxFit.cover,
                                  color: Colors.orange,
                                ),
                                onTap: mesDemandes,
                              ),
                              ListTile(
                                title: new Text("Liste des livreurs "),
                                leading: new Image.asset(
                                  "assets/delivery-man.png",
                                  height: 30,
                                  width: 30,
                                  fit: BoxFit.cover,
                                  color: Colors.orange,
                                ),
                                onTap: _listeLivreurs,
                              ),
                              ListTile(
                                title: new Text("Futur livraisons"),
                                leading: new Image.asset(
                                  "assets/receive.png",
                                  height: 30,
                                  width: 30,
                                  fit: BoxFit.cover,
                                  color: Colors.orange,
                                ),
                                onTap: voirListeFutursLivraisonsClient,
                              ),
                              ListTile(
                                title: new Text("Publier une demande"),
                                leading: new Image.asset(
                                  "assets/request.png",
                                  height: 30,
                                  width: 30,
                                  fit: BoxFit.cover,
                                  color: Colors.orange,
                                ),
                                onTap: publierDemande,
                              ),
                              ListTile(
                                title: new Text("Historiques"),
                                leading: new Image.asset(
                                  "assets/history.png",
                                  height: 30,
                                  width: 30,
                                  fit: BoxFit.cover,
                                  color: Colors.orange,
                                ),
                                onTap: voirHistoriquesClient,
                              ),
                              ListTile(
                                title: new Text("A propos"),
                                leading: new Image.asset(
                                  "assets/about.png",
                                  height: 30,
                                  width: 30,
                                  fit: BoxFit.cover,
                                  color: Colors.orange,
                                ),
                                onTap: aProposClient,
                              ),
                              ListTile(
                                title: new Text("Déconnecter"),
                                leading: new Image.asset(
                                  "assets/log-out.png",
                                  height: 30,
                                  width: 30,
                                  fit: BoxFit.cover,
                                  color: Colors.orange,
                                ),
                                onTap: _logoutClient,
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
            }));
  }

  /////// fonction pour naviguer a page chercher une livreur //////////////
  void _chercherLivreur() {
    Navigator.push(context,
        new MaterialPageRoute(builder: (context) => FiltresListeLivreurs()));
  }

  /////// fonction pour naviguer a page liste des livreurs //////////////
  void _listeLivreurs() {
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => listeLivreurs(
                ville: "Tout",
                region: "Tout",
                note: "Tout",
                transport: "Tout")));
  }

  /////// fonction pour naviguer a page Login //////////////
  void _logoutClient() {
    Const.email = "";
    Const.idUser = "";
    Const.role = "";
    Const.token = "";
    Const.idClLiv = "";
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => MyApp()));
  }

  /////// fonction pour naviguer a page profile du client //////////////
  void monProfile() {
    setState(() {
      Navigator.push(context,
          new MaterialPageRoute(builder: (context) => ProfileClient()));
    });
  }

  /////// fonction pour naviguer a page publier une demande  //////////////
  void publierDemande() {
    Navigator.push(context,
        new MaterialPageRoute(builder: (context) => PublierDemandeOu()));
  }

  /////// fonction pour naviguer a page les demandes du l'utilisateur //////////////
  void mesDemandes() {
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => DemandesClient(
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

  /////// fonction pour naviguer a page l'historiques des demandes du l'utilisateur //////////////
  void voirHistoriquesClient() {
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

  /////// fonction pour naviguer a page a propos //////////////
  void aProposClient() {
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => AProposClient()));
  }

  /////// fonction pour naviguer a page les demandes livraisons //////////////
  void voirListeFutursLivraisonsClient() {
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
}
