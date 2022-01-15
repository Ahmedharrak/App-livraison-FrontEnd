import 'dart:convert';
import 'dart:typed_data';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:easy_gradient_text/easy_gradient_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:livreurs_app/views/Accueil/Client/ListeLivreurs/detailProfileLivreur.dart';
import 'package:livreurs_app/views/Accueil/accueilClient.dart';
import 'package:livreurs_app/Controllers/userController.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:livreurs_app/const.dart' as Const;

// ignore: camel_case_types
class listeLivreurs extends StatefulWidget {
  final String ville;
  final String region;
  final String note;
  final String transport;
  listeLivreurs(
      {Key key,
      @required this.ville,
      @required this.region,
      @required this.note,
      @required this.transport})
      : super(key: key);
  @override
  listeLivreursState createState() =>
      listeLivreursState(ville, region, note, transport);
}

// ignore: camel_case_types
class listeLivreursState extends State<listeLivreurs> {
  String triePar;
  String ville = 'Tout';
  String region = 'Tout';
  String note = 'Tout';
  String transport = 'Tout';
  listeLivreursState(this.ville, this.region, this.note, this.transport);
  UserController userController = new UserController();
  Future<List> aaa;
  @override
  Widget build(BuildContext context) {
    print("--------> $ville");
    print("--------> $note");
    print("--------> $region");
    print("--------> $transport");
    aaa = userController.obtenirTousLivreurs(
        ville, region, note, transport, triePar);
    if (triePar != null) {
      userController.obtenirTousLivreurs(
          ville, region, note, transport, triePar);
      Navigator.pop(context);
    }

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
                        ' Liste des livreurs',
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
        child: Card(
          elevation: 4.0,
          color: Colors.white,
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
              ///////////////////////  Listtes des livreurs ////////////////////////////////
              Container(
                margin: EdgeInsets.only(top: 45),
                color: Colors.grey[50],
                child: new FutureBuilder<List>(
                  future: aaa,
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
                                  textDirection: TextDirection.ltr,
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
                                        onSelected: (String label2) => {
                                              setState(() => triePar = label2),
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
                        onPressed: () => {filtrerListeLivreurs(context)},
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
                                  color: Colors.orange,
                                  height: 30,
                                  width: 30,
                                  fit: BoxFit.cover,
                                ),
                                Text(
                                  'Filtrer',
                                  textDirection: TextDirection.ltr,
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
      ),
    );
  }

  void filtrerListeLivreurs(BuildContext context) async {
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
                            filtrerListeLivreurs(context);
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
                            filtrerListeLivreurs(context);
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
  UserController userController = new UserController();

  List list;
  ItemList({this.list});
  // ignore: avoid_return_types_on_setters
  void set listdata(List list) {
    this.list = list;
  }

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
        itemCount: list == null ? 0 : list.length,
        itemBuilder: (context, i) {
          Uint8List _bytesImage;
          String _imgLivreurString = '${list[i]['imageProfile']}';
          _bytesImage = Base64Decoder().convert(_imgLivreurString);
          Color getColorCIN() {
            if (list[i]['imageCIN'] == null)
              return Colors.grey[300];
            else
              return Colors.green;
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
            } else if (type == "Vélo") {
              return "assets/bicycle.png";
            } else
              return "assets/NoMoyenDeTransport.jpg";
          }

          void afficherPhotoProfile(BuildContext context) async {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    titlePadding: EdgeInsets.all(10.0),
                    contentPadding: EdgeInsets.all(10.0),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GradientText(text: "Image Profile", colors: <Color>[
                          Colors.orangeAccent.shade400,
                          Colors.orangeAccent.shade700,
                        ]),
                        Container(
                          margin: const EdgeInsets.all(5),
                          child: Divider(
                            height: 2.0,
                            color: Colors.blue.shade900,
                          ),
                        ),
                      ],
                    ),
                    content: ClipOval(
                      child: Image.memory(
                        _bytesImage,
                        width: 300,
                        height: 300,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                });
          }

          void afficherPhotoCIN(BuildContext context) async {
            Uint8List _bytesImageCIN;
            String _imageCINString = '${list[i]['imageCIN']}';
            _bytesImageCIN = Base64Decoder().convert(_imageCINString);
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    titlePadding: EdgeInsets.all(10.0),
                    contentPadding: EdgeInsets.all(10.0),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GradientText(text: "Image CIN", colors: <Color>[
                          Colors.orangeAccent.shade400,
                          Colors.orangeAccent.shade700,
                        ]),
                        Container(
                          margin: const EdgeInsets.all(5),
                          child: Divider(
                            height: 2.0,
                            color: Colors.blue.shade900,
                          ),
                        ),
                      ],
                    ),
                    content: ClipOval(
                      child: Image.memory(
                        _bytesImageCIN,
                        width: 300,
                        height: 300,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                });
          }

          return new Container(
            child: Stack(
              children: <Widget>[
                Positioned(
                  child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        ////////////////////// element de chaque livreur ////////////////////
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) => DetailProfileLivreur(
                                        id: "${list[i]['_id']}")));
                          },
                          child: Card(
                            elevation: 4.0,
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            child: Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  /////// image de livreur /////////
                                  Flexible(
                                    flex: 3,
                                    child: Container(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          if (list[i]['imageProfile'] != null)
                                            InkWell(
                                              onTap: () => {
                                                afficherPhotoProfile(context)
                                              },
                                              child: ClipOval(
                                                child: Image.memory(
                                                  _bytesImage,
                                                  height: 50,
                                                  width: 50,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          if (list[i]['imageProfile'] == null)
                                            ClipOval(
                                              child: Image.asset(
                                                "assets/iconeLivreur.png",
                                                height: 50,
                                                width: 50,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          Container(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  width: 70,
                                                  height: 30,
                                                  child: Card(
                                                    shape: StadiumBorder(
                                                      side: BorderSide(
                                                        color: Colors.grey,
                                                        width: 1.0,
                                                      ),
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                          child:
                                                              RatingBarIndicator(
                                                            //rating: 2.25,
                                                            rating: list[i][
                                                                    'noteTotal']
                                                                .toDouble(),
                                                            itemBuilder:
                                                                (context,
                                                                        index) =>
                                                                    Icon(
                                                              Icons.star,
                                                              color:
                                                                  Colors.amber,
                                                            ),
                                                            itemCount: 5,
                                                            itemSize: 9.0,
                                                            direction:
                                                                Axis.horizontal,
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
                                    flex: 7,
                                    child: Container(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                ////// Nom de livreur //////
                                                Flexible(
                                                  flex: 2,
                                                  child: Text(
                                                      "${list[i]['prenom']} ${list[i]['nom']}"),
                                                ),
                                                //////// logi CIN + image ///////////
                                                Flexible(
                                                  flex: 1,
                                                  child: InkWell(
                                                    onTap: () => {
                                                      afficherPhotoCIN(context)
                                                    },
                                                    child: Card(
                                                      color: getColorCIN(),
                                                      shape: StadiumBorder(
                                                        side: BorderSide(
                                                          color: Colors.black,
                                                          width: 2.0,
                                                        ),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                right: 0.0,
                                                                left: 5),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                            Text('CIN',
                                                                style:
                                                                    TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                )),
                                                            ClipOval(
                                                              child:
                                                                  Image.asset(
                                                                "assets/CINlogo.png",
                                                                height: 20,
                                                                width: 20,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),

                                          //////////// Text "Ville " //////////////

                                          Container(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  '${list[i]['ville']}',
                                                  style: TextStyle(
                                                    color: Colors.grey,
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
                                      margin: EdgeInsets.only(left: 0),
                                      child: Padding(
                                        padding: const EdgeInsets.all(1.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: <Widget>[
                                            Text(
                                              "       ${list[i]['nombreLivraisons']} Livraisons",
                                              style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            for (var item in list[i]
                                                ['moyenTransport'])
                                              Image.asset(
                                                getLogoMoyenTransport(
                                                    item['type']),
                                                height: 30,
                                                width: 30,
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
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
