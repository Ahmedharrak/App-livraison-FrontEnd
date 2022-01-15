import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';
import 'package:custom_switch/custom_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_avatar/flutter_advanced_avatar.dart';
import 'package:icon_badge/icon_badge.dart';
import 'package:livreurs_app/Controllers/livreurController.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:livreurs_app/Controllers/notificationController.dart';
import 'package:livreurs_app/Controllers/userController.dart';
import 'package:livreurs_app/views/Accueil/Livreur/DemandesRecus/demandesRecues.dart';
import 'package:livreurs_app/views/Accueil/Livreur/FutursLivraisons/futurLivraisonLivreur.dart';
import 'package:livreurs_app/views/Accueil/Livreur/Historiques/histouriquesLivreur.dart';
import 'package:livreurs_app/views/Accueil/Livreur/NotificationLivreur/notificationLivreur.dart';
import 'package:livreurs_app/views/Accueil/Livreur/Profile/profileLivreur.dart';
import 'package:livreurs_app/views/Accueil/Livreur/Propos/aProposLivreur.dart';
import '../../main.dart';
import 'Livreur/DemandesPubliques/demandesPubliques.dart';
import 'package:livreurs_app/const.dart' as Const;

/// This Widget is the main application widget.
// ignore: must_be_immutable
class AccueilLivreur extends StatefulWidget {
  int i;
  @override
  _AccueilLivreurState createState() => _AccueilLivreurState(this.i);
}

class _AccueilLivreurState extends State<AccueilLivreur> {
  int nombreNotification;
  int i;
  NotificationController notificationController = new NotificationController();

  _AccueilLivreurState(this.i);
  LivreurController livreurController = new LivreurController();
  bool enService;

  Widget build(BuildContext context) {
    return new WillPopScope(
        onWillPop: () async => false,
        child: FutureBuilder(
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

                if (i != 1) {
                  enService = livreurSnapshot.data['enService'];
                }

                Uint8List _bytesImage;

                String _imgProfileString =
                    '${livreurSnapshot.data['imageProfile']}';

                _bytesImage = Base64Decoder().convert(_imgProfileString);

                return Scaffold(
                  backgroundColor: Colors.grey[200],

                  /////////////////  Bar de page Livraison GV ////////////////////////
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

                    /////// icone home et notifications /////
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
                                                '${livreurSnapshot.data["_id"]}');
                                      });

                                      nombreNotification = 0;
                                      Navigator.push(
                                          context,
                                          new MaterialPageRoute(
                                              builder: (context) =>
                                                  NotificationLivreur()));
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
                  //////////// Body de page ///////////////////////////////////////////////////////////////////

                  body: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        /////////// Slide image de page //////
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
                            dotIncreasedColor: Colors.orange,
                          ),
                        ),
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
                                    // ignore: deprecated_member_use
                                    child: Image.asset(
                                      "assets/list.png",
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
                                        'Demandes publiques',
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
                            onPressed: () => voirListeDemandePublique(),
                          ),
                        ),

                        Container(
                          margin: const EdgeInsets.all(10),
                          width: MediaQuery.of(context).size.width,
                          // ignore: deprecated_member_use
                          child: FlatButton(
                            onPressed: () => voirListeDemandeRecus(),
                            child: Padding(
                              padding: const EdgeInsets.all(40),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    margin: const EdgeInsets.all(10),
                                    // ignore: deprecated_member_use
                                    child: Image.asset(
                                      "assets/demandepublic.png",
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
                                        'Demandes reçues',
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
                            disabledColor: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),

//////////////////////////////////// Bar Drawer du Page Accueil //////////////////////////////

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
                                        child: AdvancedAvatar(
                                          statusColor: getColorAvatar(),
                                          child: ClipOval(
                                            child: Image.memory(
                                              _bytesImage,
                                              height: 80,
                                              width: 80,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Column(
                                        children: <Widget>[
                                          Text(
                                              "${livreurSnapshot.data['prenom']} ${livreurSnapshot.data['nom']}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                          Text("Espace livreur",
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
                                          onTap: monProfileLivreur,
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

                          ListTile(
                            title: Container(
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(right: 10),
                                    child: Text("Disponibilité"),
                                  ),
                                  SizedBox(
                                    height: 35,
                                    width: 75,
                                    child: CustomSwitch(
                                      activeColor: Colors.orange,
                                      value: enService,
                                      onChanged: (value) {
                                        print("VALUE : $value");
                                        setState(() {
                                          this.i = 1;
                                          enService = value;
                                          livreurController
                                              .modifierEnServiceLivreur(
                                                  enService.toString());
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            leading: new Image.asset(
                              "assets/disponible.png",
                              height: 30,
                              width: 30,
                              fit: BoxFit.cover,
                              color: Colors.orange,
                            ),
                          ),
                          ListTile(
                            title: new Text("Demandes publiques "),
                            leading: new Image.asset(
                              "assets/list.png",
                              height: 30,
                              width: 30,
                              fit: BoxFit.cover,
                              color: Colors.orange,
                            ),
                            onTap: voirListeDemandePublique,
                          ),
                          ListTile(
                            title: new Text("Demandes reçues"),
                            leading: new Image.asset(
                              "assets/demandepublic.png",
                              height: 30,
                              width: 30,
                              fit: BoxFit.cover,
                              color: Colors.orange,
                            ),
                            onTap: voirListeDemandeRecus,
                          ),

                          ListTile(
                            title: new Text("Futur livraison"),
                            leading: new Image.asset(
                              "assets/receive.png",
                              height: 30,
                              width: 30,
                              fit: BoxFit.cover,
                              color: Colors.orange,
                            ),
                            onTap: voirListeFutursLivraisonsLivreurs,
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
                            onTap: voirHistoriquesLivreurs,
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
                            onTap: aProposLivreur,
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
                            onTap: _logoutLivreur,
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

  void _logoutLivreur() {
    // ignore: unused_local_variable
    UserController user = new UserController();
    Const.email = '';
    Const.idUser = '';
    Const.role = '';
    Const.token = '';
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => MyApp()));
  }

  void monProfileLivreur() {
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => ProfileLivreur()));
  }

  void voirListeDemandePublique() {
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
  }

  void voirListeDemandeRecus() {
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

  void voirHistoriquesLivreurs() {
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

  void voirListeFutursLivraisonsLivreurs() {
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

  void aProposLivreur() {
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => AProposLivreur()));
  }
}
