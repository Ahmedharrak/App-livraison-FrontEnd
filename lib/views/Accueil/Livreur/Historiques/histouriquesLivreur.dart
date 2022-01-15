import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import 'package:livreurs_app/views/Accueil/accueilLivreur.dart';
import 'package:easy_gradient_text/easy_gradient_text.dart';

import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:intl/intl.dart';
import 'package:livreurs_app/Controllers/clientController.dart';
import 'package:livreurs_app/Controllers/demandeController.dart';
import 'package:livreurs_app/Controllers/livraisonController.dart';
import 'package:livreurs_app/const.dart' as Const;
import 'package:livreurs_app/views/Accueil/Livreur/Historiques/filtresHistouriquesLivreur.dart';

import 'detailHistoriqueLivreur.dart';

class HistouriquesLivreur extends StatefulWidget {
  final String dateLivraison;
  final String contenu;
  final String nature;
  final String taille;
  final String poids;
  final String villeDeDepart;
  final String villeDeLivraison;
  final String regionRecuperation;
  final String regionLivraison;
  const HistouriquesLivreur(
      {Key key,
      this.regionRecuperation,
      this.regionLivraison,
      this.villeDeDepart,
      this.villeDeLivraison,
      this.dateLivraison,
      this.contenu,
      this.nature,
      this.taille,
      this.poids})
      : super(key: key);

  @override
  _HistouriquesLivreurState createState() => _HistouriquesLivreurState(
      regionRecuperation,
      regionLivraison,
      villeDeDepart,
      villeDeLivraison,
      dateLivraison,
      contenu,
      nature,
      taille,
      poids);
}

class _HistouriquesLivreurState extends State<HistouriquesLivreur> {
  String villeDeDepart;
  String villeDeLivraison;
  String regionRecuperation;
  String regionLivraison;
  String dateLivraison;
  String contenu;
  String nature;
  String taille;
  String poids;
  _HistouriquesLivreurState(
      this.regionRecuperation,
      this.regionLivraison,
      this.villeDeDepart,
      this.villeDeLivraison,
      this.dateLivraison,
      this.contenu,
      this.nature,
      this.taille,
      this.poids);
  LivraisonController livraiosonController = new LivraisonController();
  String idLivreur = Const.idClLiv;
  Future<List> historiques;
  String triePar;

  // TextEditingController dateLivraison = new TextEditingController();

  final format = DateFormat("yyyy-MM-dd");
/////////////////widget///////////////////
  @override
  Widget build(BuildContext context) {
    historiques = livraiosonController.obtenirHistoriquesParIdLivreur(
        idLivreur,
        dateLivraison,
        regionRecuperation,
        regionLivraison,
        villeDeDepart,
        villeDeLivraison,
        contenu,
        nature,
        taille,
        poids,
        triePar);
    if (triePar != null) {
      Navigator.pop(context);
    }
    return
        // child: DefaultTabController(
        //   length: 2,
        //   child: Scaffold(
        //     appBar: AppBar(
        //       backgroundColor: Colors.orangeAccent,
        //       iconTheme: IconThemeData(color: Colors.black),
        //       actions: <Widget>[
        //         ////////////// icone home //////////////
        //         IconButton(
        //             icon: Icon(Icons.home),
        //             onPressed: () {
        //               Navigator.push(
        //                 context,
        //                 MaterialPageRoute(builder: (context) => AccueilLivreur()),
        //               );
        //             })
        //       ],
        //       title: Center(
        //         child: Container(
        //           padding: EdgeInsets.all(5),
        //           child: Column(
        //             children: <Widget>[
        //               Row(
        //                 mainAxisAlignment: MainAxisAlignment.center,
        //                 children: <Widget>[
        //                   Container(
        //                     ////////////// titre de bare de page /////////
        //                     margin: EdgeInsets.all(5.0),
        //                     padding: EdgeInsets.all(8.0),
        //                     child: Text(
        //                       'Historiques',
        //                       style: TextStyle(
        //                         color: Colors.black,
        //                       ),
        //                     ),
        //                   ),
        //                 ],
        //               ),
        //             ],
        //           ),
        //         ),
        //       ),
        //       bottom: PreferredSize(
        //         preferredSize: Size.fromHeight(48),
        //         child: Material(
        //           color: Colors.white,
        //           child: TabBar(
        //             indicatorColor: Colors.deepOrange,
        //             labelColor: Colors.black,
        //             unselectedLabelColor: Colors.black,
        //             tabs: [Tab(text: "Public"), Tab(text: "Privé")],
        //           ),
        //         ),
        //       ),
        //     ),
        //     /////// Body de page ////////////
        //     body: TabBarView(
        //       children: [
        //         HistouriquesLivreurPublic(
        //             regionRecuperation: "$regionRecuperation",
        //             regionLivraison: "$regionLivraison",
        //             villeDeDepart: "$villeDeDepart",
        //             villeDeLivraison: "$villeDeLivraison",
        //             dateLivraiSon: '$dateLivraison',
        //             contenu: "$contenu",
        //             nature: "$nature",
        //             taille: '$taille',
        //             poids: "$poids"),
        //         HistouriquesLivreurPrive(
        //             regionRecuperation: "$regionRecuperation",
        //             regionLivraison: "$regionLivraison",
        //             villeDeDepart: "$villeDeDepart",
        //             villeDeLivraison: "$villeDeLivraison",
        //             dateLivraiSon: '$dateLivraison',
        //             contenu: "$contenu",
        //             nature: "$nature",
        //             taille: '$taille',
        //             poids: "$poids"),
        //       ],
        //     ),
        //   ),
        // ),
        Scaffold(
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
                        'Historiques',
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
      /////// Body de page ////////////
      body: Container(
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

            ///////////////////////  Listtes des Demandes publiques ////////////////////////////////
            Container(
              margin: EdgeInsets.only(top: 45),
              color: Colors.grey[50],
              child: new FutureBuilder<List>(
                future: historiques,
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

            ////////////////////////////////////////// Button Filtrer / trier ////////////////////////////////////////////////////

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Flexible(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.all(0.0),
                    width: 200,
                    // ignore: deprecated_member_use
                    child: FlatButton(
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: 0,
                            bottom: 0,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: 0,
                              bottom: 0,
                              right: 0,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                /////// image de logo trier et text //////

                                Image.asset(
                                  "assets/logoTrier.png",
                                  height: 25,
                                  width: 25,
                                  fit: BoxFit.cover,
                                  color: Colors.orange,
                                ),
                                Text(
                                  'Trier',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15.0,
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        color: Colors.white,
                        disabledColor: Colors.black,
                        onPressed: () {
                          showModalBottomSheet<void>(
                              context: context,
                              builder: (BuildContext context) {
                                return SingleChildScrollView(
                                    child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ////////////// Date de livraison //////////////
                                    Container(
                                      margin: const EdgeInsets.all(10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          GradientText(
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                              text: "Date de livraison",
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
                                    RadioButtonGroup(
                                        activeColor: Colors.orange,
                                        labels: [
                                          "Date de livraison (croissant)",
                                          "Date de livraison (decroissant)",
                                        ],
                                        picked: triePar,
                                        onSelected: (String label) => {
                                              setState(() => triePar = label),
                                            }),
                                    ////////////// Date de livraison //////////////
                                    Container(
                                      margin: const EdgeInsets.all(10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          GradientText(
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                              text: "Prix",
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
                                    RadioButtonGroup(
                                        activeColor: Colors.orange,
                                        labels: [
                                          "Prix (croissant)",
                                          "Prix (decroissant)",
                                        ],
                                        picked: triePar,
                                        onSelected: (String label) => {
                                              setState(() => triePar = label),
                                            }),
                                  ],
                                ));
                              });
                        }),
                  ),
                ),

                //////////////////////// Button Filtre ////////////////////////
                Flexible(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.all(0.0),
                    width: 200,
                    // ignore: deprecated_member_use
                    child: FlatButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  FiltresHistouriquesLivreur()),
                        );
                      },
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: 0,
                          bottom: 0,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 0,
                            bottom: 0,
                            right: 0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.asset(
                                "assets/logoFiltrer.png",
                                height: 30,
                                width: 30,
                                fit: BoxFit.cover,
                                color: Colors.orange,
                              ),
                              Text(
                                'Filtrer',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15.0,
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      color: Colors.white,
                      disabledColor: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class ItemList extends StatelessWidget {
  DemandeController demandeController = new DemandeController();
  ClientController clientController = new ClientController();
  List list;

  ItemList({this.list});
  @override
  Widget build(BuildContext context) {
    // ignore: todo
    // TODO: implement build
    return new ListView.builder(
        itemCount: list == null ? 0 : list.length,
        itemBuilder: (context, i) {
          return FutureBuilder(
              future: demandeController.obtenirDemande(list[i]['idDemande']),
              builder: (context, AsyncSnapshot demandeSnapshot) {
                if (demandeSnapshot.hasData) {
                  return FutureBuilder(
                      future:
                          clientController.obtenirClient(list[i]['idClient']),
                      builder: (context, AsyncSnapshot clientSnapshot) {
                        if (clientSnapshot.hasData) {
                          return new Container(
                            child: Stack(
                              children: <Widget>[
                                Positioned(
                                  child: Padding(
                                    padding: const EdgeInsets.all(1.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        ////////////////////// element de chaque demande ////////////////////
                                        InkWell(
                                          onTap: () => {
                                            Navigator.push(
                                                context,
                                                new MaterialPageRoute(
                                                    builder: (context) =>
                                                        DetailHistoriqueLivreur(
                                                          idLivraison: list[i]
                                                              ['_id'],
                                                          demande:
                                                              demandeSnapshot
                                                                  .data,
                                                          client: clientSnapshot
                                                              .data,
                                                          prix: list[i]['prix'],
                                                        ))),
                                          },
                                          child: Card(
                                            elevation: 4.0,
                                            color: Colors.white,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(0.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Flexible(
                                                    flex: 3,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: <Widget>[
                                                        ////// Partie de Date /////
                                                        Container(
                                                          margin:
                                                              const EdgeInsets
                                                                  .all(10),
                                                          child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: <
                                                                  Widget>[
                                                                ///// logo de Date /////
                                                                Container(
                                                                  child: Image
                                                                      .asset(
                                                                    "assets/calendar.png",
                                                                    width: 30,
                                                                    height: 30,
                                                                    color: Colors
                                                                        .orange,
                                                                  ),
                                                                ),
                                                                ////// la date du ivraison //////
                                                                Container(
                                                                  margin: const EdgeInsets
                                                                          .only(
                                                                      left: 5),
                                                                  child: Text(
                                                                    "${demandeSnapshot.data['dateLivraison']} ",
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  margin: EdgeInsets
                                                                      .only(
                                                                          left:
                                                                              5),
                                                                  child: Image
                                                                      .asset(
                                                                    "assets/clock.png",
                                                                    width: 30,
                                                                    height: 30,
                                                                    color: Colors
                                                                        .orange,
                                                                  ),
                                                                ),
                                                                Container(
                                                                  margin: const EdgeInsets
                                                                          .only(
                                                                      left: 5),
                                                                  child: Text(
                                                                    "${demandeSnapshot.data['heureLivraison']}",
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                ),
                                                              ]),
                                                        ),
                                                        ////// Partie de Client Person /////
                                                        Container(
                                                          margin:
                                                              const EdgeInsets
                                                                  .all(10),
                                                          child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: <
                                                                  Widget>[
                                                                ///// logo de Client /////
                                                                Container(
                                                                  child: Image
                                                                      .asset(
                                                                    "assets/iconeLivreur.png",
                                                                    width: 30,
                                                                    height: 30,
                                                                    color: Colors
                                                                        .orange,
                                                                  ),
                                                                ),
                                                                ////// Nom et Prenom du Client //////
                                                                Container(
                                                                  margin: const EdgeInsets
                                                                          .only(
                                                                      left: 5),
                                                                  child: Text(
                                                                    "${clientSnapshot.data['prenom']} ${clientSnapshot.data['nom']}",
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                ),
                                                              ]),
                                                        ),
                                                        ////// Partie de Ville depart et arrive ///////
                                                        Container(
                                                          margin:
                                                              const EdgeInsets
                                                                  .all(10),
                                                          child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: <
                                                                  Widget>[
                                                                ////// logo et ville de depart /////
                                                                Container(
                                                                  child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    children: <
                                                                        Widget>[
                                                                      Image
                                                                          .asset(
                                                                        "assets/logoMap.png",
                                                                        width:
                                                                            30,
                                                                        height:
                                                                            30,
                                                                        color: Colors
                                                                            .orange,
                                                                      ),
                                                                      Text(
                                                                          "${demandeSnapshot.data['villeDeDepart']}"),
                                                                    ],
                                                                  ),
                                                                ),
                                                                ////// image center ------> /////
                                                                Container(
                                                                  child: Image
                                                                      .asset(
                                                                    "assets/passer.png",
                                                                    width: 80,
                                                                    height: 30,
                                                                    color: Colors
                                                                        .orange,
                                                                  ),
                                                                ),
                                                                /////// logo et ville d'arrive ////////
                                                                Container(
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .end,
                                                                    children: <
                                                                        Widget>[
                                                                      Column(
                                                                        children: <
                                                                            Widget>[
                                                                          Image
                                                                              .asset(
                                                                            "assets/logoMap.png",
                                                                            width:
                                                                                30,
                                                                            height:
                                                                                30,
                                                                            color:
                                                                                Colors.orange,
                                                                          ),
                                                                          Text(
                                                                              "${demandeSnapshot.data['villeDeLivraison']}"),
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ]),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Flexible(
                                                    flex: 1,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        ////// Status de demandes //////
                                                        Container(
                                                          margin:
                                                              const EdgeInsets
                                                                  .all(5),
                                                          child: Text(
                                                            "${list[i]['statutLivraison']}",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .orange),
                                                          ),
                                                        ),
                                                        Container(
                                                          margin:
                                                              const EdgeInsets
                                                                  .all(5),
                                                          child: Text(
                                                              "${demandeSnapshot.data['contenu']}"),
                                                        ),
                                                        /////// Nature de demande ////////////
                                                        Container(
                                                          margin:
                                                              const EdgeInsets
                                                                  .all(5),
                                                          child: Text(
                                                              "${demandeSnapshot.data['nature']}"),
                                                        ),
                                                        ///////// Taille de demande /////////////
                                                        Container(
                                                          margin:
                                                              const EdgeInsets
                                                                  .all(5),
                                                          child: Text(
                                                              "${demandeSnapshot.data['taille']}"),
                                                        ),
                                                        //////// Poids de demande ///////////
                                                        Container(
                                                          margin:
                                                              const EdgeInsets
                                                                  .all(5),
                                                          child: Text(
                                                              "${demandeSnapshot.data['poids']}"),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else
                          return Container(
                            width: 0.0,
                            height: 0.0,
                            color: Colors.white,
                          );
                      });
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
