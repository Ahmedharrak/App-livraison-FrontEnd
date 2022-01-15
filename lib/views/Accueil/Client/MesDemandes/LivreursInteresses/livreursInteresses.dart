// ignore: unused_import
import 'dart:collection';
import 'dart:convert';
import 'dart:typed_data';
import 'package:easy_gradient_text/easy_gradient_text.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:intl/intl.dart';
import 'package:livreurs_app/Controllers/notificationController.dart';
import 'package:livreurs_app/const.dart' as Const;
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:livreurs_app/Controllers/demandeController.dart';
import 'package:livreurs_app/views/Accueil/Client/ListeLivreurs/detailProfileLivreur.dart';
import 'package:livreurs_app/views/Accueil/Client/MesDemandes/demandesClient.dart';
import 'package:livreurs_app/views/Accueil/accueilClient.dart';
import 'package:livreurs_app/Controllers/livreurController.dart';
import 'package:livreurs_app/Controllers/livraisonController.dart';

// ignore: must_be_immutable
class LivreursInteresses extends StatefulWidget {
  final String idClient;
  final String idDemande;
  List list;
  LivreursInteresses(
      {Key key,
      @required this.list,
      @required this.idClient,
      @required this.idDemande})
      : super(key: key);

  void initState() {}

  @override
  LivreursInteressesState createState() =>
      LivreursInteressesState(this.list, this.idClient, this.idDemande);
}

class LivreursInteressesState extends State<LivreursInteresses> {
  List list;
  String idClient;
  String idDemande;
  String idLivreur;
  LivreursInteressesState(this.list, this.idClient, this.idDemande);
  LivreurController livreurController = new LivreurController();
  LivraisonController livraisonController = new LivraisonController();
  DemandeController demandeController = new DemandeController();
  NotificationController notificationController = new NotificationController();
  Future<List> aaa;
  String triePar;
  String ville = 'Tout';
  String region = 'Tout';
  String note = 'Tout';
  String transport = 'Tout';
  @override
  void initState() {
    super.initState();
    // ignore: unnecessary_statements
    list;
    // ignore: unnecessary_statements
    idLivreur;
    // ignore: unnecessary_statements
    idClient;
    // ignore: unnecessary_statements
    idDemande;
  }

  @override
  Widget build(BuildContext context) {
    Future<List> aaa = livreurController.obtenirLivreursInteresses(
        idDemande, ville, region, note, transport, triePar);

    if (triePar != null) {
      Navigator.pop(context);
    }
    print("vloilá ville la liste  $ville");
    print("vloilá region la liste  $region");
    print("vloilá etoile la liste  $note");
    print("vloilá traspont la liste  $transport");
    print("vloilá trier la liste  $triePar");
    return Scaffold(
      ///////// AppBar de page ////////////
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
                        ' Livreurs intéréssés',
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
            Container(
              margin: EdgeInsets.only(top: 45),
              color: Colors.grey[50],
              child: new FutureBuilder<List>(
                future: aaa,
                builder: (context, snapchot) {
                  if (snapchot.hasError) print(snapchot.error);
                  return snapchot.hasData
                      ? new ItemList(
                          list: snapchot.data,
                          idDemande: idDemande,
                          idClient: idClient)
                      : Center(
                          child: CircularProgressIndicator(),
                        );
                },
              ),
            ),
            ///////////////////////  Listtes des livreurs interesses  ////////////////////////////////

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
                                  ////////////// Nombre d’étoiles //////////////
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
                                            text: "Nombre d’étoiles",
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
                                        "Nombre d’étoiles (croissant)",
                                        "Nombre d’étoiles (decroissant)",
                                      ],
                                      picked: triePar,
                                      onSelected: (String label) => {
                                            setState(() => triePar = label),
                                          }),
                                  ////////////// "Nombre du livraison //////////////
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
                                            text: "Nombre du livraison",
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
                                        "Nombre du livraison (croissant)",
                                        "Nombre du livraison (decroissant)",
                                      ],
                                      picked: triePar,
                                      onSelected: (String label) => {
                                            setState(() => triePar = label),
                                          }),
                                  ////////////// "Nombre du livraison //////////////
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
                      },
                    ),
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
                      onPressed: () => {filtrerLivreursinteresses(context)},
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

  void filtrerLivreursinteresses(BuildContext context) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            titlePadding: EdgeInsets.all(10.0),
            contentPadding: EdgeInsets.all(10.0),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.all(5),
                  child: Image.asset(
                    "assets/filter.png",
                    height: 40,
                    width: 40,
                  ),
                ),
                GradientText(text: "Filtrer", colors: <Color>[
                  Colors.orangeAccent.shade400,
                  Colors.orangeAccent.shade700,
                ]),
              ],
            ),
            content: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.all(5),
                    child: Divider(
                      height: 2.0,
                      color: Colors.blue.shade900,
                    ),
                  ),
                  Container(
                    width: 200,
                    child:
                        // ignore: deprecated_member_use
                        RaisedButton(
                      color: Colors.orange.shade400,
                      disabledColor: Colors.orange.shade400,
                      onPressed: () {
                        setState(() {
                          note = 'Tout';
                          transport = 'Tout';
                          ville = 'Tout';
                          region = 'Tout';
                        });
                      },
                      child: Text(
                        "REINITIALISER",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),

                  ////////////// Moyen de transport
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GradientText(
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                            text: "Moyen de transport",
                            colors: <Color>[
                              Colors.orangeAccent.shade400,
                              Colors.orangeAccent.shade700,
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
                  Container(
                    width: 200,
                    margin: const EdgeInsets.only(
                        top: 10, left: 10, right: 10, bottom: 10),
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all()),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: transport,
                        style: const TextStyle(color: Colors.black),
                        underline: Container(
                          height: 2,
                          color: Colors.black,
                        ),
                        onChanged: (String newValue) {
                          setState(() {
                            transport = newValue;
                            Navigator.pop(context);
                            filtrerLivreursinteresses(context);
                          });
                        },
                        items: Const.moyensTransport
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),

                  Container(
                    margin: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GradientText(
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                            text: "Nombre d’etoile",
                            colors: <Color>[
                              Colors.orangeAccent.shade400,
                              Colors.orangeAccent.shade700,
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
                  Container(
                    width: 200,
                    margin: const EdgeInsets.only(
                        top: 10, left: 10, right: 10, bottom: 10),
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all()),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: note,
                        style: const TextStyle(color: Colors.black),
                        underline: Container(
                          height: 2,
                          color: Colors.black,
                        ),
                        onChanged: (String newValue) {
                          setState(() {
                            note = newValue;
                            Navigator.pop(context);
                            filtrerLivreursinteresses(context);
                          });
                        },
                        items: Const.nombreEtoiles
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
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
                              Colors.orangeAccent.shade400,
                              Colors.orangeAccent.shade700,
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
                  /////////////////// Region
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.all(5),
                        child: Image.asset(
                          "assets/region.png",
                          height: 30,
                          width: 30,
                          color: Colors.orange,
                        ),
                      ),
                      Text(
                        "Region",
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                  Container(
                    width: 200,
                    child: DropdownSearch<String>(
                      mode: Mode.BOTTOM_SHEET,
                      items: Const.regions,
                      onChanged: (value) {
                        setState(() {
                          region = value;
                        });
                      },
                      selectedItem: region,
                      showSearchBox: true,
                      searchBoxDecoration: InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.fromLTRB(12, 12, 8, 0),
                        labelText: "Rechercher une region",
                      ),
                      popupTitle: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Region',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      popupShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24),
                        ),
                      ),
                    ),
                  ),
                  /////////////////// Ville
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.all(5),
                        child: Image.asset(
                          "assets/home.png",
                          height: 30,
                          width: 30,
                          color: Colors.orange,
                        ),
                      ),
                      Text(
                        "Ville",
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                  Container(
                    width: 200,
                    child: DropdownSearch<String>(
                      mode: Mode.BOTTOM_SHEET,
                      items: Const.villes,
                      onChanged: (value) {
                        setState(() {
                          ville = value;
                        });
                      },
                      selectedItem: ville,
                      showSearchBox: true,
                      searchBoxDecoration: InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.fromLTRB(12, 12, 8, 0),
                        labelText: "Rechercher une ville",
                      ),
                      popupTitle: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Ville',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      popupShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24),
                        ),
                      ),
                    ),
                  ),
                  ////////////////// Button Filtrer
                  Container(
                    width: 200,
                    child:
                        // ignore: deprecated_member_use
                        RaisedButton(
                      color: Colors.deepOrange,
                      disabledColor: Colors.deepOrange,
                      onPressed: () => {
                        print(transport + note + ville + region),
                        Navigator.pop(context)
                      },
                      child: Text(
                        "Filtrer",
                        style: TextStyle(color: Colors.white, fontSize: 18),
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

// ignore: must_be_immutable
class ItemList extends StatelessWidget {
  LivraisonController livraisonController = new LivraisonController();
  LivreurController livreurController = new LivreurController();
  DemandeController demandeController = new DemandeController();
  NotificationController notificationController = new NotificationController();

  final String idDemande;
  final String idClient;
  List list;
  ItemList({this.list, this.idDemande, this.idClient});
  @override
  Widget build(BuildContext context) {
    String todayNotification =
        DateFormat("yyyy-MM-dd HH:mm").format(DateTime.now());
    print(
        "Today :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: $todayNotification");
    return new ListView.builder(
        itemCount: list
            .length, // Nombre d'élément dans votre liste de données (ici data)
        itemBuilder: (context, i) {
          String prix = list[i]['prix'];
          String idLivreur = list[i]['idLivreur'];
          _onPressedAccepter() {
            String idLivreur = list[i]['idLivreur'];
            livraisonController
                .ajouterLivraiosn(idLivreur, idClient, idDemande, prix)
                .whenComplete(() {
              livraisonController.modifierStatutDemande(idDemande, "fermé");
              notificationController.ajouterNotification(
                  idLivreur.trim(),
                  Const.idClLiv,
                  idDemande,
                  null,
                  "A",
                  "a accepté votre demande de livraison.",
                  todayNotification);
              Navigator.of(context).pop();
              Navigator.of(context).pop();
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => DemandesClient(
                            contenu: 'Tout',
                            nature: 'Tout',
                            taille: 'Tout',
                            poids: 'Tout',
                            villeDeLivraison: 'Tout',
                            villeDeDepart: 'Tout',
                            regionRecuperation: 'Tout',
                            regionLivraison: 'Tout',
                            triePar: 'Tout',
                            dateLivraison: '',
                          )));
            });
          }

          _onPressedRefuser() {
            String idLivreur = list[i]['idLivreur'];
            demandeController.refuserLivreurInteresse(idDemande, idLivreur);
            print('id demande ->>>>>>>>> $idDemande');
            print('id Livreur ->>>>>>>>> $idLivreur');
            notificationController.ajouterNotification(
                idLivreur.trim(),
                Const.idClLiv,
                idDemande,
                null,
                "A",
                "a refusé votre demande de livraison.",
                todayNotification);
            Navigator.of(context).pop();

            Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) => LivreursInteresses(
                        list: list, idClient: idClient, idDemande: idDemande)));
          }

          return Container(
              color: Colors.grey[50],
              child: FutureBuilder(
                  //future: aaa,
                  future: livreurController.obtenirLivreur(idLivreur),
                  builder: (context, AsyncSnapshot livreurSnapshot) {
                    if (livreurSnapshot.hasData) {
                      Color getColorCIN() {
                        if (livreurSnapshot.data['imageCIN'] == null)
                          return Colors.grey[300];
                        else
                          return Colors.orange;
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

                      Uint8List _bytesImage;

                      String _imgProfileString =
                          '${livreurSnapshot.data['imageProfile']}';

                      _bytesImage = Base64Decoder().convert(_imgProfileString);

                      Image.memory(_bytesImage);
                      return Container(
                        child: Stack(
                          children: <Widget>[
                            Positioned(
                              child: Padding(
                                padding: const EdgeInsets.all(1.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    ////////////////////// element de chaque livreur interesse ////////////////////
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            new MaterialPageRoute(
                                                builder: (context) =>
                                                    DetailProfileLivreur(
                                                        id: "${livreurSnapshot.data['_id']}")));
                                      },
                                      child: Card(
                                        elevation: 4.0,
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: Container(
                                          padding: const EdgeInsets.all(0.0),
                                          child: Column(
                                            children: <Widget>[
                                              Container(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: <Widget>[
                                                    /////// image de livreur /////////
                                                    Flexible(
                                                      flex: 3,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10.0),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                            ClipOval(
                                                              child:
                                                                  Image.memory(
                                                                _bytesImage,
                                                                height: 50,
                                                                width: 50,
                                                                fit: BoxFit
                                                                    .cover,
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
                                                                      shape:
                                                                          StadiumBorder(
                                                                        side:
                                                                            BorderSide(
                                                                          color:
                                                                              Colors.grey,
                                                                          width:
                                                                              1.0,
                                                                        ),
                                                                      ),
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          Container(
                                                                            child:
                                                                                RatingBarIndicator(
                                                                              //rating: 2.25,
                                                                              rating: livreurSnapshot.data['noteTotal'].toDouble(),
                                                                              itemBuilder: (context, index) => Icon(
                                                                                Icons.star,
                                                                                color: Colors.amber,
                                                                              ),
                                                                              itemCount: 5,
                                                                              itemSize: 9.0,
                                                                              direction: Axis.horizontal,
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
                                                      flex: 6,
                                                      child: Container(
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .all(
                                                                      10.0),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: <
                                                                    Widget>[
                                                                  ////// Nom de livreur //////
                                                                  Flexible(
                                                                    flex: 1,
                                                                    child: Text(
                                                                        "${livreurSnapshot.data['prenom']}  ${livreurSnapshot.data['nom']}"),
                                                                  ),
                                                                  //////// logi CIN + image ///////////
                                                                  Flexible(
                                                                    flex: 1,
                                                                    child: Card(
                                                                      color:
                                                                          getColorCIN(),
                                                                      shape:
                                                                          StadiumBorder(
                                                                        side:
                                                                            BorderSide(
                                                                          color:
                                                                              Colors.black,
                                                                          width:
                                                                              2.0,
                                                                        ),
                                                                      ),
                                                                      child:
                                                                          Padding(
                                                                        padding: const EdgeInsets.only(
                                                                            right:
                                                                                0.0,
                                                                            left:
                                                                                5),
                                                                        child:
                                                                            Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          children: <
                                                                              Widget>[
                                                                            Text('CIN',
                                                                                style: TextStyle(
                                                                                  fontWeight: FontWeight.bold,
                                                                                )),
                                                                            ClipOval(
                                                                              child: Image.asset(
                                                                                "assets/CINlogo.png",
                                                                                height: 20,
                                                                                width: 20,
                                                                                fit: BoxFit.cover,
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

                                                            //////////// Text "Ville " //////////////

                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .all(
                                                                      10.0),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: <
                                                                    Widget>[
                                                                  Text(
                                                                    "${livreurSnapshot.data['ville']}",
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .grey,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),

                                                    ///////////////////// Partie end de liste (note ,nombre livarison,moyen transport)

                                                    Flexible(
                                                      flex: 2,
                                                      child: Container(
                                                        margin: EdgeInsets.only(
                                                            left: 0),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(1.0),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .end,
                                                            children: <Widget>[
                                                              Text(
                                                                "${livreurSnapshot.data['nombreLivraisons']} Livraisons",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 10,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                              if (livreurSnapshot
                                                                          .data[
                                                                      'moyenTransport'] ==
                                                                  null)
                                                                ClipOval(
                                                                  child: Image
                                                                      .asset(
                                                                    "assets/NoMoyenDeTransport.jpg",
                                                                    height: 25,
                                                                    width: 25,
                                                                  ),
                                                                ),
                                                              if (livreurSnapshot
                                                                          .data[
                                                                      'moyenTransport'] !=
                                                                  null)
                                                                ClipOval(
                                                                  child: Image
                                                                      .asset(
                                                                    getLogoMoyenTransport(
                                                                        livreurSnapshot.data['moyenTransport'][0]
                                                                            [
                                                                            'type']),
                                                                    height: 25,
                                                                    width: 25,
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
                                              Container(
                                                margin: const EdgeInsets.all(5),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      margin:
                                                          const EdgeInsets.all(
                                                              5),
                                                      child: Image.asset(
                                                        "assets/argentIcone.png",
                                                        width: 25,
                                                        height: 25,
                                                      ),
                                                    ),
                                                    Text(
                                                      "Prix proposé : ${list[i]['prix']} dh ",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              if (list[i]['statut'] ==
                                                  "en attente")
                                                Container(
                                                  margin:
                                                      const EdgeInsets.all(10),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      // ignore: deprecated_member_use
                                                      FlatButton(
                                                        onPressed: () =>
                                                            _onPressedAccepter(),
                                                        child: Row(
                                                          children: [
                                                            Image.asset(
                                                                "assets/yes.png",
                                                                height: 20,
                                                                width: 20,
                                                                fit: BoxFit
                                                                    .cover,
                                                                color: Colors
                                                                    .white),
                                                            Text(
                                                              "Accepter",
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 12.0,
                                                                decoration:
                                                                    TextDecoration
                                                                        .none,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        color: Colors.orange,
                                                        disabledColor:
                                                            Colors.grey,
                                                        shape: new RoundedRectangleBorder(
                                                            borderRadius:
                                                                new BorderRadius
                                                                        .circular(
                                                                    20.0)),
                                                      ),
                                                      Container(
                                                        margin: const EdgeInsets
                                                            .all(5),
                                                        // ignore: deprecated_member_use
                                                        child: FlatButton(
                                                          onPressed: () =>
                                                              _onPressedRefuser(),
                                                          child: Row(
                                                            children: [
                                                              Image.asset(
                                                                  "assets/croix.png",
                                                                  height: 20,
                                                                  width: 20,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  color: Colors
                                                                      .white),
                                                              Text(
                                                                "Refuser",
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      12.0,
                                                                  decoration:
                                                                      TextDecoration
                                                                          .none,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          color:
                                                              Colors.deepOrange,
                                                          disabledColor:
                                                              Colors.grey,
                                                          shape: new RoundedRectangleBorder(
                                                              borderRadius:
                                                                  new BorderRadius
                                                                          .circular(
                                                                      20.0)),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              if (list[i]['statut'] == "refusé")
                                                Container(
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      // ignore: deprecated_member_use
                                                      Container(
                                                        margin: const EdgeInsets
                                                            .all(5),
                                                        // ignore: deprecated_member_use
                                                        child: FlatButton(
                                                          onPressed: () => null,
                                                          child: Row(
                                                            children: [
                                                              Icon(
                                                                  Icons.delete),
                                                              Text(
                                                                "Refusé",
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      12.0,
                                                                  decoration:
                                                                      TextDecoration
                                                                          .none,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          color: Colors.grey,
                                                          disabledColor:
                                                              Colors.grey,
                                                          shape: new RoundedRectangleBorder(
                                                              borderRadius:
                                                                  new BorderRadius
                                                                          .circular(
                                                                      20.0)),
                                                        ),
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
                      );
                  }));
        });
  }
}
