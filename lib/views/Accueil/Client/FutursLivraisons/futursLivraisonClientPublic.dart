import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:easy_gradient_text/easy_gradient_text.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:intl/intl.dart';
import 'package:livreurs_app/Controllers/demandeController.dart';
import 'package:livreurs_app/Controllers/livraisonController.dart';
import 'package:livreurs_app/Controllers/livreurController.dart';
import 'package:livreurs_app/views/Accueil/Client/FutursLivraisons/detailLivraisonClient.dart';
import 'package:livreurs_app/const.dart' as Const;

class FutursLivraisonClientPublic extends StatefulWidget {
  final String contenu;
  final String nature;
  final String taille;
  final String poids;
  final String regionRecuperation;
  final String regionLivraison;
  final String villeDeDepart;
  final String villeDeLivraison;
  final String triePar;
  final String dateLivraison;
  FutursLivraisonClientPublic(
      {Key key,
      @required this.contenu,
      @required this.nature,
      @required this.taille,
      @required this.poids,
      @required this.regionRecuperation,
      @required this.regionLivraison,
      @required this.villeDeDepart,
      @required this.villeDeLivraison,
      @required this.triePar,
      @required this.dateLivraison})
      : super(key: key);

  @override
  _FutursLivraisonClientPublicState createState() =>
      _FutursLivraisonClientPublicState(
          contenu,
          nature,
          taille,
          poids,
          regionRecuperation,
          regionLivraison,
          villeDeDepart,
          villeDeLivraison,
          triePar,
          dateLivraison);
}

class _FutursLivraisonClientPublicState
    extends State<FutursLivraisonClientPublic> {
  final format = DateFormat("yyyy-MM-dd");
  Future<List> aaa;
  TextEditingController date = new TextEditingController();

  String contenu = "Tout";
  String nature = "Tout";
  String taille = "Tout";
  String poids = "Tout";
  String regionRecuperation = "Tout";
  String regionLivraison = "Tout";
  String villeDeDepart = "Tout";
  String villeDeLivraison = "Tout";
  String triePar = "Tout";
  String type = 'Public';
  String dateLivraison;
  _FutursLivraisonClientPublicState(
      this.contenu,
      this.nature,
      this.taille,
      this.poids,
      this.regionRecuperation,
      this.regionLivraison,
      this.villeDeDepart,
      this.villeDeLivraison,
      this.triePar,
      this.dateLivraison);

  LivraisonController livraiosonController = new LivraisonController();
  String idClient = Const.idClLiv;

  @override
  Widget build(BuildContext context) {
    print("contenu--------> $contenu");
    print("nature--------> $nature");
    print("taille--------> $taille");
    print("poids--------> $poids");
    print("regionRec--------> $regionRecuperation");
    print("regionliv--------> $regionLivraison");
    print("villedepart--------> $villeDeDepart");
    print("villeLivraiosn--------> $villeDeLivraison");
    print("triePar--------> $triePar");
    print("dateLivraison--------> $dateLivraison");
    aaa = livraiosonController.obtenirLivraisonsParIdClient(
        idClient,
        dateLivraison,
        contenu,
        nature,
        taille,
        poids,
        regionRecuperation,
        regionLivraison,
        villeDeDepart,
        villeDeLivraison,
        triePar);

    return Scaffold(
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
                    Colors.white70,
                    Colors.white70,
                    Colors.white70,
                  ],
                ),
              ),
            ),

            ///////////////////////  Listtes des Futurs Livraison ////////////////////////////////
            Container(
              margin: EdgeInsets.only(top: 45),
              color: Colors.grey[50],
              child: new FutureBuilder<List>(
                future: aaa,
                builder: (context, snapchot) {
                  if (snapchot.hasError) print(snapchot.error);
                  return snapchot.hasData
                      ? new ItemList(list: snapchot.data, type: type)
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
                                  ////////////// Prix //////////////
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
                      onPressed: () => {filtrerFutursLivraisonClient(context)},
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

  void filtrerFutursLivraisonClient(BuildContext context) async {
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
                  Colors.orange.shade400,
                  Colors.orange.shade900,
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
                      color: Colors.orange.shade900,
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
                          date = null;
                          regionRecuperation = 'Tout';
                          regionLivraison = 'Tout';
                          villeDeDepart = 'Tout';
                          villeDeLivraison = 'Tout';
                          contenu = 'Tout';
                          nature = 'Tout';
                          taille = 'Tout';
                          poids = 'Tout';
                        });
                      },
                      child: Text(
                        "REINITIALISER",
                        style: TextStyle(color: Colors.white),
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
                            text: "Date",
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
                  Container(
                    width: 200,
                    margin: const EdgeInsets.all(10),
                    child: DateTimeField(
                      controller: date,
                      format: format,
                      onShowPicker: (context, currentValue) {
                        setState(() {
                          dateLivraison = date.text;
                        });

                        return showDatePicker(
                            builder: (BuildContext context, Widget child) {
                              return Theme(
                                data: ThemeData.light().copyWith(
                                  colorScheme: ColorScheme.fromSwatch(
                                    primarySwatch: Colors.orange,
                                    primaryColorDark: Colors.orangeAccent,
                                    accentColor: Colors.orangeAccent,
                                  ),
                                  dialogBackgroundColor: Colors.white,
                                ),
                                child: child,
                              );
                            },
                            context: context,
                            locale: const Locale("fr", "FR"),
                            firstDate: DateTime(2020),
                            initialDate: DateTime.now(),
                            lastDate: DateTime(2100));
                      },
                    ),
                  ),
                  ////////////// Produit
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GradientText(
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                            text: "Produit",
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
                  //////////// Contenu
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.all(5),
                        child: Image.asset(
                          "assets/content-marketing.png",
                          height: 30,
                          width: 30,
                        ),
                      ),
                      Text(
                        "Contenu",
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                  Container(
                    width: 200,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all()),
                    margin: const EdgeInsets.only(
                        top: 10, left: 10, right: 10, bottom: 10),
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: contenu,
                        style: const TextStyle(color: Colors.black),
                        underline: Container(
                          height: 2,
                          color: Colors.black,
                        ),
                        onChanged: (String newValue) {
                          setState(() {
                            contenu = newValue;
                            Navigator.pop(context);
                            filtrerFutursLivraisonClient(context);
                          });
                        },
                        items: Const.contenus
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  //////////// Nature
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.all(5),
                        child: Image.asset(
                          "assets/text.png",
                          height: 30,
                          width: 30,
                          color: Colors.orange,
                        ),
                      ),
                      Text(
                        "Nature",
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                  Container(
                    width: 200,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all()),
                    margin: const EdgeInsets.only(
                        top: 10, left: 10, right: 10, bottom: 10),
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: nature,
                        style: const TextStyle(color: Colors.black),
                        underline: Container(
                          height: 2,
                          color: Colors.black,
                        ),
                        onChanged: (String newValue) {
                          setState(() {
                            nature = newValue;
                            Navigator.pop(context);
                            filtrerFutursLivraisonClient(context);
                          });
                        },
                        items: Const.natures
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  ///////////// Taille
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.all(5),
                        child: Image.asset(
                          "assets/size.png",
                          height: 30,
                          width: 30,
                          color: Colors.orange,
                        ),
                      ),
                      Text(
                        "Taille",
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
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
                        isExpanded: true,
                        value: taille,
                        style: const TextStyle(color: Colors.black),
                        underline: Container(
                          height: 2,
                          color: Colors.black,
                        ),
                        onChanged: (String newValue) {
                          setState(() {
                            taille = newValue;
                            Navigator.pop(context);
                            filtrerFutursLivraisonClient(context);
                          });
                        },
                        items: Const.tailles
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  ///////// Poids
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.all(5),
                        child: Image.asset(
                          "assets/weight.png",
                          height: 30,
                          width: 30,
                          color: Colors.orange,
                        ),
                      ),
                      Text(
                        "Poids",
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                  ///////// Poids ////////////
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
                        isExpanded: true,
                        value: poids,
                        style: const TextStyle(color: Colors.black),
                        underline: Container(
                          height: 2,
                          color: Colors.black,
                        ),
                        onChanged: (String newValue) {
                          setState(() {
                            poids = newValue;
                            Navigator.pop(context);
                            filtrerFutursLivraisonClient(context);
                          });
                        },
                        items: Const.poids
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
                  /////////////////// Region A
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
                        "Region Recuperation",
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                        top: 10, left: 10, right: 10, bottom: 10),
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    width: 200,
                    child: DropdownSearch<String>(
                      mode: Mode.BOTTOM_SHEET,
                      items: Const.regions,
                      onChanged: (value) {
                        setState(() {
                          regionRecuperation = value;
                        });
                      },
                      selectedItem: regionRecuperation,
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
                  /////////////////// Region B
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
                        "Region Livraison",
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                        top: 10, left: 10, right: 10, bottom: 10),
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    width: 200,
                    child: DropdownSearch<String>(
                      mode: Mode.BOTTOM_SHEET,
                      items: Const.regions,
                      onChanged: (value) {
                        setState(() {
                          regionLivraison = value;
                        });
                      },
                      selectedItem: regionLivraison,
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
                  /////////////////// Ville A
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
                        "Ville Recuperation",
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                  Container(
                    width: 200,
                    margin: const EdgeInsets.only(
                        top: 10, left: 10, right: 10, bottom: 10),
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: DropdownSearch<String>(
                      mode: Mode.BOTTOM_SHEET,
                      items: Const.villes,
                      onChanged: (value) {
                        setState(() {
                          villeDeDepart = value;
                        });
                      },
                      selectedItem: villeDeDepart,
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

                  /////////////////// Ville B
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
                        "Ville Livraison",
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                  Container(
                    width: 200,
                    margin: const EdgeInsets.only(
                        top: 10, left: 10, right: 10, bottom: 10),
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: DropdownSearch<String>(
                      //mode: Mode.BOTTOM_SHEET,
                      items: Const.villes,
                      onChanged: (value) {
                        setState(() {
                          villeDeLivraison = value;
                        });
                      },
                      selectedItem: villeDeLivraison,
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
                        setState(() {
                          dateLivraison = date.text;
                        }),
                        print(dateLivraison +
                            contenu +
                            nature +
                            taille +
                            poids +
                            regionRecuperation +
                            regionRecuperation +
                            villeDeDepart +
                            villeDeLivraison),
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
  DemandeController demandeController = new DemandeController();
  LivreurController livreurController = new LivreurController();
  List list;
  String type = 'Public';

  ItemList({this.list, this.type});
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
                if (demandeSnapshot.hasData &&
                    demandeSnapshot.data['type'] == 'Public') {
                  return FutureBuilder(
                      future: livreurController
                          .obtenirLivreur(list[i]['idLivreur']),
                      builder: (context, AsyncSnapshot livreurSnapshot) {
                        if (livreurSnapshot.hasData) {
                          void detailLivraisonsClient() {
                            Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) => DetailLivraisonClient(
                                          livraison: list[i],
                                          idLivraison: list[i]['_id'],
                                          demande: demandeSnapshot.data,
                                          livreur: livreurSnapshot.data,
                                          prix: list[i]['prix'],
                                        )));
                          }

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
                                        ////////////////////// element de chaque demande du Futur Livraison ////////////////////

                                        Card(
                                          elevation: 4.0,
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          child: Column(
                                            children: [
                                              Padding(
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
                                                                    .all(5),
                                                            child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: <
                                                                    Widget>[
                                                                  ///// logo de Date /////
                                                                  Container(
                                                                    margin: const EdgeInsets
                                                                            .only(
                                                                        right:
                                                                            5),
                                                                    child: Image
                                                                        .asset(
                                                                      "assets/calendar.png",
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      color: Colors
                                                                          .orange,
                                                                    ),
                                                                  ),

                                                                  ////// la date du ivraison //////
                                                                  Container(
                                                                    child: Text(
                                                                      "${demandeSnapshot.data['dateLivraison']}",
                                                                      style: TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    margin: EdgeInsets.only(
                                                                        left: 5,
                                                                        right:
                                                                            5),
                                                                    child: Image
                                                                        .asset(
                                                                      "assets/clock.png",
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      color: Colors
                                                                          .orange,
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    margin: const EdgeInsets
                                                                        .all(3),
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
                                                                    .all(5),
                                                            child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: <
                                                                    Widget>[
                                                                  ///// logo de Client /////
                                                                  Container(
                                                                    margin: const EdgeInsets
                                                                            .only(
                                                                        right:
                                                                            5),
                                                                    child: Image
                                                                        .asset(
                                                                      "assets/iconeClient.png",
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      color: Colors
                                                                          .orange,
                                                                    ),
                                                                  ),
                                                                  ////// Nom et Prenom du Client //////
                                                                  Container(
                                                                    child: Text(
                                                                      "${livreurSnapshot.data['prenom']} ${livreurSnapshot.data['nom']}",
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
                                                                    .all(5),
                                                            child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: <
                                                                    Widget>[
                                                                  ////// logo et ville de depart /////
                                                                  Container(
                                                                    child:
                                                                        Column(
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
                                                                          color:
                                                                              Colors.orange,
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
                                                                      height:
                                                                          30,
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
                                                                            Image.asset(
                                                                              "assets/logoMap.png",
                                                                              width: 30,
                                                                              height: 30,
                                                                              color: Colors.orange,
                                                                            ),
                                                                            Text("${demandeSnapshot.data['villeDeLivraison']}"),
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ]),
                                                          ),
                                                          ////// Partie de Prix /////
                                                          Container(
                                                            margin:
                                                                const EdgeInsets
                                                                    .all(5),
                                                            child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: <
                                                                    Widget>[
                                                                  ///// logo de Prix /////
                                                                  Container(
                                                                    margin: const EdgeInsets
                                                                            .only(
                                                                        right:
                                                                            5),
                                                                    child: Image
                                                                        .asset(
                                                                      "assets/argentIcone.png",
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      color: Colors
                                                                          .orange,
                                                                    ),
                                                                  ),
                                                                  ////// la date du ivraison //////
                                                                  Container(
                                                                    child: Text(
                                                                      "Prix : ",
                                                                      style: TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    child: Text(
                                                                      "${list[i]['prix']}",
                                                                      style: TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    child: Text(
                                                                      " dh",
                                                                      style: TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.bold),
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
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          ///// Contenu de damande ////////
                                                          Container(
                                                            margin:
                                                                const EdgeInsets
                                                                    .all(5),
                                                            child: Text(
                                                                "${demandeSnapshot.data['contenu']}"),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              /////// Partie buttom "plus" /////
                                              Container(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: <Widget>[
                                                    Container(
                                                      child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: <Widget>[
                                                            Text("plus "),
                                                            Container(
                                                              child: IconButton(
                                                                icon: Icon(Icons
                                                                    .chevron_right),
                                                                iconSize: 30,
                                                                color: Colors
                                                                    .black,
                                                                onPressed: () =>
                                                                    detailLivraisonsClient(),
                                                              ),
                                                            ),
                                                          ]),
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
