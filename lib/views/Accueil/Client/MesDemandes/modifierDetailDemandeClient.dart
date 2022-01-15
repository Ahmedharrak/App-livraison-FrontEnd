import 'dart:collection';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:intl/intl.dart';
import 'package:livreurs_app/Controllers/demandeController.dart';
import 'package:livreurs_app/views/Accueil/Client/MesDemandes/detailDemandesClient.dart';
import 'package:livreurs_app/const.dart' as Const;
import '../../accueilClient.dart';

/// This Widget is the main application widget.
// ignore: must_be_immutable
class ModifierDetailDemandeClient extends StatefulWidget {
  LinkedHashMap<String, dynamic> demande;
  ModifierDetailDemandeClient({
    Key key,
    @required this.demande,
  }) : super(key: key);

  @override
  _ModifierDetailDemandeClientState createState() =>
      _ModifierDetailDemandeClientState(
        demande,
      );
}

class _ModifierDetailDemandeClientState
    extends State<ModifierDetailDemandeClient> {
  _ModifierDetailDemandeClientState(
    this.demande,
  );
  DemandeController demandeController = new DemandeController();
  String dropdownContenu;
  LinkedHashMap<String, dynamic> demande;
  String dropdownNature;
  String dropdownTaille;
  String dropdownPoids;
  String dropdownDepart;
  String dropdownLivraison;
  TextEditingController dateLivraisonController = new TextEditingController();

  TextEditingController adresseRecuperation = new TextEditingController();
  TextEditingController adresseLivraison = new TextEditingController();
  TextEditingController prixController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();

  final format = DateFormat("yyyy-MM-dd");
  final formatH = DateFormat("HH:mm");

  @override
  Widget build(BuildContext context) {
    print("priiiiiiiiiiiix :!!!! =>>>>>>> ${demande['prix']}");
    dropdownContenu = demande['contenu'];
    dropdownNature = demande['nature'];
    dropdownTaille = demande['taille'];
    dropdownPoids = demande['poids'];
    dropdownDepart = demande['villeDeDepart'];
    dropdownLivraison = demande['villeDeLivraison'];
    //dateLivraisonController.text = demande['dateLivraison'];
    adresseRecuperation.text = demande['adresseRecuperationLivraison'];
    adresseLivraison.text = demande['adresseDestinationLivraison'];
    prixController.text = demande['prix'];
    descriptionController.text = demande['description'];
    // ignore: unused_local_variable
    String dateLivraison;

    String description;
    if (demande['description'] != null) {
      description = demande['description'];
    } else {
      description = "Sans déscription";
    }
    Color getColor(text) {
      if (text == "Sans déscription")
        return Colors.grey;
      else
        return Colors.black;
    }

    //// Fonction pour modifier detail du demande /////
    _onPressedModifierDemande() async {
      if (dropdownDepart == "Tout") {
        _showDialog("Saisir votre ville du départ!");
      }
      if (dropdownLivraison == "Tout") {
        _showDialog("Saisir votre ville du livraison!");
      }
      ////////// region de ville depart ////////
      final queryRecuperation = dropdownDepart;
      var addressesregionRecuperation =
          await Geocoder.local.findAddressesFromQuery(queryRecuperation);
      var regionRecuperation = addressesregionRecuperation.first.adminArea;
      ////////// region de ville livraison ////////
      final queryLivraison = dropdownLivraison;
      var addressesregionLivraison =
          await Geocoder.local.findAddressesFromQuery(queryLivraison);
      var regionLivraison = addressesregionLivraison.first.adminArea;
      demandeController
          .modifierDemande(
        demande["_id"],
        dateLivraisonController.text.trim(),
        dropdownDepart,
        dropdownLivraison,
        adresseRecuperation.text.trim(),
        adresseLivraison.text.trim(),
        regionRecuperation,
        regionLivraison,
        dropdownContenu,
        dropdownNature,
        dropdownTaille,
        dropdownPoids,
        prixController.text.trim(),
        descriptionController.text.trim(),
      )
          .whenComplete(() {
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) => DetailDemandesClient(demande: demande)));
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
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      ////////////// titre de bare de page /////////
                      child: Text(
                        'Modifier Demande',
                        style: TextStyle(color: Colors.black, fontSize: 16),
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 20.0, left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '* : obligatoire',
                    style: TextStyle(
                        color: Colors.orange, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            ///// Date de livraison* /////
            Container(
              margin: const EdgeInsets.only(top: 40, left: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  //////////// Date de livraison
                  Container(
                    child: Column(
                      children: [
                        //////// Titre Date de livraison
                        Container(
                          child: Row(
                            children: [
                              /////// Icone Date de livraison
                              Container(
                                margin:
                                    const EdgeInsets.only(left: 10, right: 5),
                                child: ImageIcon(
                                    AssetImage("assets/calendar.png"),
                                    color: Colors.orange,
                                    size: 25),
                              ),
                              /////// Text
                              Container(
                                child: Text(
                                  "Date de livraison ",
                                ),
                              ),
                              Container(
                                child: Text(
                                  "*",
                                  style: TextStyle(color: Colors.orange),
                                ),
                              ),
                            ],
                          ),
                        ),

                        ///////// Text Field Date de livraison
                        Container(
                          width: 300,
                          margin: const EdgeInsets.all(10),
                          child: DateTimeField(
                            controller: dateLivraisonController,
                            format: format,
                            onShowPicker: (context, currentValue) {
                              setState(() {
                                dateLivraison = dateLivraisonController.text;
                              });

                              return showDatePicker(
                                  builder:
                                      (BuildContext context, Widget child) {
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
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ///////// Adresse de récupération ////
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.all(10),
                                child: Image.asset(
                                  "assets/logoMap.png",
                                  width: 25,
                                  height: 25,
                                  color: Colors.orange,
                                ),
                              ),
                              Text(
                                "Adresse de récupération ",
                              ),
                              Text(
                                "*",
                                style: TextStyle(color: Colors.orange),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 300,
                          child: TextField(
                            controller: adresseRecuperation,
                            style: TextStyle(color: Color(0xFF000000)),
                            cursorColor: Color(0xFF9b9b9b),
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              hintText: "$adresseRecuperation",
                              hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  /////////////////// Ville de récupération /////////////////////
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.all(10),
                                child: Image.asset(
                                  "assets/logoMap.png",
                                  width: 25,
                                  height: 25,
                                  color: Colors.orange,
                                ),
                              ),
                              Text(
                                "Ville de récupération ",
                              ),
                              Text(
                                "*",
                                style: TextStyle(color: Colors.orange),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 300,
                          child: DropdownSearch<String>(
                            mode: Mode.BOTTOM_SHEET,
                            items: Const.villes,
                            onChanged: (value) {
                              dropdownDepart = value;
                            },
                            selectedItem: "$dropdownDepart",
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
                      ],
                    ),
                  ),

                  //////////////////////////// Adresse de livraison /////////////////////
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.all(10),
                                child: Image.asset(
                                  "assets/logoMap.png",
                                  width: 25,
                                  height: 25,
                                  color: Colors.orange,
                                ),
                              ),
                              Text(
                                "Adresse de livraison ",
                              ),
                              Text(
                                "*",
                                style: TextStyle(color: Colors.orange),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 300,
                          child: TextField(
                            controller: adresseLivraison,
                            style: TextStyle(color: Color(0xFF000000)),
                            cursorColor: Color(0xFF9b9b9b),
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              hintText: "$adresseLivraison",
                              hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  /////////////////////// Ville de livraison /////////////////////
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.all(10),
                                child: Image.asset(
                                  "assets/logoMap.png",
                                  width: 25,
                                  height: 25,
                                  color: Colors.orange,
                                ),
                              ),
                              Text(
                                "Ville de livraison ",
                              ),
                              Text(
                                "*",
                                style: TextStyle(color: Colors.orange),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 300,
                          child: DropdownSearch<String>(
                            mode: Mode.BOTTOM_SHEET,
                            items: Const.villes,
                            onChanged: (value) {
                              dropdownLivraison = value;
                            },
                            selectedItem: "$dropdownLivraison",
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
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ///// Column du Select ///////
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              ///////// Contenu //////////
                              Container(
                                child: Row(
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
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 200,
                                margin: const EdgeInsets.only(
                                    top: 10, left: 10, right: 10, bottom: 10),
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    border: Border.all()),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    isExpanded: true,
                                    value: "$dropdownContenu",
                                    style: const TextStyle(color: Colors.black),
                                    underline: Container(
                                      height: 2,
                                      color: Colors.black,
                                    ),
                                    onChanged: (String newValue) {
                                      dropdownContenu = newValue;
                                    },
                                    items: Const.contenus
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              ///////// Nature //////////
                              Container(
                                child: Row(
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
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 200,
                                margin: const EdgeInsets.only(
                                    top: 10, left: 10, right: 10, bottom: 10),
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    border: Border.all()),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    isExpanded: true,
                                    value: "$dropdownNature",
                                    elevation: 16,
                                    style: const TextStyle(color: Colors.black),
                                    underline: Container(
                                      height: 2,
                                      color: Colors.black,
                                    ),
                                    onChanged: (String newValue) {
                                      dropdownNature = newValue;
                                    },
                                    items: Const.natures
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              ///////// Taille //////////
                              Container(
                                child: Row(
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
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 200,
                                margin: const EdgeInsets.only(
                                    top: 10, left: 10, right: 10, bottom: 10),
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    border: Border.all()),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    isExpanded: true,
                                    value: "$dropdownTaille",
                                    style: const TextStyle(color: Colors.black),
                                    underline: Container(
                                      height: 2,
                                      color: Colors.black,
                                    ),
                                    onChanged: (String newValue) {
                                      dropdownTaille = newValue;
                                    },
                                    items: Const.tailles
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              ///////// Poids //////////
                              Container(
                                child: Row(
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
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 200,
                                margin: const EdgeInsets.only(
                                    top: 10, left: 10, right: 10, bottom: 10),
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    border: Border.all()),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    isExpanded: true,
                                    value: "$dropdownPoids",
                                    style: const TextStyle(color: Colors.black),
                                    underline: Container(
                                      height: 2,
                                      color: Colors.black,
                                    ),
                                    onChanged: (String newValue) {
                                      dropdownPoids = newValue;
                                    },
                                    items: Const.poids
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  ///// Prix* ////
                  if (demande['type'] == 'Privé')
                    Container(
                      margin: const EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(
                              top: 30,
                              left: 5,
                              bottom: 10,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                /////// logo de prix /////
                                Container(
                                  child: Image.asset(
                                    "assets/argentIcone.png",
                                    width: 25,
                                    height: 25,
                                    color: Colors.orange,
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 5),
                                  child: Text("Prix(en DH) "),
                                ),
                                Text(
                                  "*",
                                  style: TextStyle(color: Colors.orange),
                                ),
                              ],
                            ),
                          ),
                          TextField(
                            controller: prixController,
                            style: TextStyle(color: Color(0xFF000000)),
                            cursorColor: Color(0xFF9b9b9b),
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: "${demande['prix']}",
                              hintStyle: TextStyle(
                                  color: Color(0xFF000000),
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                        ],
                      ),
                    ),
                  //// Description ////
                  Container(
                    margin: const EdgeInsets.all(
                      10,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.all(
                                5,
                              ),
                              child: Image.asset(
                                "assets/hastag.png",
                                height: 25,
                                width: 25,
                                color: Colors.orange,
                              ),
                            ),
                            Text(
                              "Description",
                            ),
                          ],
                        ),
                        TextField(
                          controller: descriptionController,
                          style: TextStyle(color: Color(0xFF000000)),
                          cursorColor: Color(0xFF9b9b9b),
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: "$description",
                            hintStyle: TextStyle(
                                color: getColor(description),
                                fontSize: 15,
                                fontWeight: FontWeight.normal),
                          ),
                          maxLines: 6,
                        ),
                      ],
                    ),
                  ),
                  ///// Button Publier ////
                  Container(
                    margin: const EdgeInsets.all(10),
                    // ignore: deprecated_member_use
                    child: FlatButton(
                      onPressed: () => _onPressedModifierDemande(),
                      child: Text(
                        "Modifier",
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  //// Fonction afficher message erreur //////
  void _showDialog(String error) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Theme(
            data:
                Theme.of(context).copyWith(dialogBackgroundColor: Colors.white),
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              contentPadding: EdgeInsets.all(10.0),
              title: new Text(
                'Erreur',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              content: new Text(
                error,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              actions: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width,
                        // ignore: deprecated_member_use
                        child: RaisedButton(
                          color: Colors.orange,
                          disabledColor: Colors.orange,
                          child: new Text(
                            'Fermer',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }
}
