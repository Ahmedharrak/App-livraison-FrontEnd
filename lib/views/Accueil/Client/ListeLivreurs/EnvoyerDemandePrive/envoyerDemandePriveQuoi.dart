import 'package:easy_gradient_text/easy_gradient_text.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:intl/intl.dart';
import 'package:livreurs_app/Controllers/notificationController.dart';
import 'package:livreurs_app/views/Accueil/Client/MesDemandes/demandesClient.dart';
import '../../../accueilClient.dart';
import 'package:livreurs_app/Controllers/demandeController.dart';
import 'package:livreurs_app/const.dart' as Const;

/// This Widget is the main application widget.
// ignore: must_be_immutable
class EnvoyerDemandePriveQuoi extends StatefulWidget {
  String adresseRecuperation;
  String villeRecuperation;
  String adresseLivraison;
  String villeLivraison;
  String valueVoiture;
  String valueMoto;
  String valueCamion;
  String valuePickup;
  String valueTaxi;
  String valueVelo;
  String dateLivraison;
  String heureLivraison;
  String idLivreur;

  EnvoyerDemandePriveQuoi({
    Key key,
    this.adresseRecuperation,
    this.villeRecuperation,
    this.adresseLivraison,
    this.villeLivraison,
    this.valueVoiture,
    this.valueMoto,
    this.valueCamion,
    this.valuePickup,
    this.valueTaxi,
    this.valueVelo,
    this.dateLivraison,
    this.heureLivraison,
    this.idLivreur,
  }) : super(key: key);
  @override
  EnvoyerDemandePriveQuoiState createState() => EnvoyerDemandePriveQuoiState(
      this.adresseRecuperation,
      this.villeRecuperation,
      this.adresseLivraison,
      this.villeLivraison,
      this.valueVoiture,
      this.valueMoto,
      this.valueCamion,
      this.valuePickup,
      this.valueTaxi,
      this.valueVelo,
      this.dateLivraison,
      this.heureLivraison,
      this.idLivreur);
}

class EnvoyerDemandePriveQuoiState extends State<EnvoyerDemandePriveQuoi> {
  String adresseRecuperation;
  String villeRecuperation;
  String adresseLivraison;
  String villeLivraison;
  String valueVoiture;
  String valueMoto;
  String valueCamion;
  String valuePickup;
  String valueTaxi;
  String valueVelo;
  String dateLivraison;
  String heureLivraison;
  String idLivreur;
  EnvoyerDemandePriveQuoiState(
      this.adresseRecuperation,
      this.villeRecuperation,
      this.adresseLivraison,
      this.villeLivraison,
      this.valueVoiture,
      this.valueMoto,
      this.valueCamion,
      this.valuePickup,
      this.valueTaxi,
      this.valueVelo,
      this.dateLivraison,
      this.heureLivraison,
      this.idLivreur);
  DemandeController demandeController = new DemandeController();
  NotificationController notificationController = new NotificationController();

  String dropdownContenu = 'Tout';
  String dropdownNature = 'Tout';
  String dropdownTaille = 'Tout';
  String dropdownPoids = 'Tout';

  TextEditingController description = new TextEditingController();
  TextEditingController prix = new TextEditingController();
  @override
  Widget build(BuildContext context) {
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
                        'Envoyer une demande',
                        style: TextStyle(
                          fontSize: 18,
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              child: new Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Column(children: <Widget>[
                      Image(
                        image: new AssetImage("assets/oneD.png"),
                        width: 40,
                        height: 40,
                        color: null,
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.center,
                      ),
                      // Text(
                      //   'Où?',
                      //   style: TextStyle(fontWeight: FontWeight.bold),
                      // ),
                    ]),
                  ),
                  Expanded(
                      flex: 1,
                      child: Container(
                        width: 20,
                        height: 5, // Thickness
                        color: Colors.grey,
                      )),
                  Expanded(
                    flex: 1,
                    child: Column(children: <Widget>[
                      Image(
                        image: new AssetImage("assets/twoD.png"),
                        width: 40,
                        height: 40,
                        color: null,
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.center,
                      ),
                      // Text(
                      //   'Comment?',
                      //   style: TextStyle(fontWeight: FontWeight.bold),
                      // ),
                    ]),
                  ),
                  Expanded(
                      flex: 1,
                      child: Container(
                        width: 20,
                        height: 5, // Thickness
                        color: Colors.grey,
                      )),
                  Expanded(
                    flex: 1,
                    child: Column(children: <Widget>[
                      Image(
                        image: new AssetImage("assets/treeD.png"),
                        width: 40,
                        height: 40,
                        color: null,
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.center,
                      ),
                      // Text(
                      //   'Quand?',
                      //   style: TextStyle(fontWeight: FontWeight.bold),
                      // ),
                    ]),
                  ),
                  Expanded(
                      flex: 1,
                      child: Container(
                        width: 20,
                        height: 5, // Thickness
                        color: Colors.grey,
                      )),
                  Expanded(
                      flex: 1,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image(
                              image: new AssetImage("assets/fourActive.png"),
                              width: 40,
                              height: 40,
                              color: null,
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.center,
                            ),

                            // Text(
                            //   'Quoi récupérer?',
                            //   style: TextStyle(fontWeight: FontWeight.bold),
                            // ),
                          ])),
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
                              ///// logo de Contenu /////
                              Container(
                                margin: const EdgeInsets.all(10),
                                child: Row(
                                  children: [
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
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
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
                                    value: dropdownContenu,
                                    style: const TextStyle(color: Colors.black),
                                    underline: Container(
                                      height: 2,
                                      color: Colors.black,
                                    ),
                                    onChanged: (String newValue) {
                                      setState(() {
                                        dropdownContenu = newValue;
                                      });
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
                              ///// Nature ////////
                              ///// logo de nature /////
                              Container(
                                margin: const EdgeInsets.all(10),
                                child: Row(
                                  children: [
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
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
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
                                    value: dropdownNature,
                                    elevation: 16,
                                    style: const TextStyle(color: Colors.black),
                                    underline: Container(
                                      height: 2,
                                      color: Colors.black,
                                    ),
                                    onChanged: (String newValue) {
                                      setState(() {
                                        dropdownNature = newValue;
                                      });
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
                              ///////////////// Taille ////////////////
                              ///// logo de taille /////
                              Container(
                                margin: const EdgeInsets.all(10),
                                child: Row(
                                  children: [
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
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
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
                                    value: dropdownTaille,
                                    style: const TextStyle(color: Colors.black),
                                    underline: Container(
                                      height: 2,
                                      color: Colors.black,
                                    ),
                                    onChanged: (String newValue) {
                                      setState(() {
                                        dropdownTaille = newValue;
                                      });
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
                              ///////// Poids ////////////
                              ///// logo de poids /////
                              Container(
                                margin: const EdgeInsets.all(10),
                                child: Row(
                                  children: [
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
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
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
                                    value: dropdownPoids,
                                    style: const TextStyle(color: Colors.black),
                                    underline: Container(
                                      height: 2,
                                      color: Colors.black,
                                    ),
                                    onChanged: (String newValue) {
                                      setState(() {
                                        dropdownPoids = newValue;
                                      });
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
                                margin: const EdgeInsets.all(5),
                                child: Image.asset(
                                  "assets/argentIcone.png",
                                  width: 25,
                                  height: 25,
                                  color: Colors.orange,
                                ),
                              ),
                              Text(
                                "Prix(en DH) ",
                              ),
                              Text(
                                "*",
                                style: TextStyle(color: Colors.red),
                              ),
                            ],
                          ),
                        ),
                        TextField(
                          controller: prix,
                          style: TextStyle(color: Color(0xFF000000)),
                          cursorColor: Color(0xFF9b9b9b),
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: "0 ",
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
                    margin: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.all(5),
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
                          controller: description,
                          style: TextStyle(color: Color(0xFF000000)),
                          cursorColor: Color(0xFF9b9b9b),
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: "entrer votre descreption ici",
                            hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 15,
                                fontWeight: FontWeight.normal),
                          ),
                          maxLines: 6,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            ///// Button Publier ////
            Container(
              margin: const EdgeInsets.all(10),
              // ignore: deprecated_member_use
              child: FlatButton(
                onPressed: () => _onPressedEnvoyerDemande(),
                child: Text(
                  "Publier",
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
    );
  }

  _onPressedEnvoyerDemande() async {
    if (dropdownContenu == "Tout" ||
        dropdownNature == "Tout" ||
        dropdownTaille == "Tout" ||
        dropdownPoids == "Tout") {
      _showDialog(
          "Veuillez choisir la catégorie, la Nature, la taille et le poids!");
    } else {
      ////////// region de ville depart ////////
      final queryRecuperation = villeRecuperation;
      var addressesRecuperation =
          await Geocoder.local.findAddressesFromQuery(queryRecuperation);
      var regionRecuperation = addressesRecuperation.first.adminArea;
      ////////// region de ville livraison ////////
      final queryLivraison = villeLivraison;
      var addressesLivraison =
          await Geocoder.local.findAddressesFromQuery(queryLivraison);
      var regionLivraison = addressesLivraison.first.adminArea;
      demandeController
          .envoyerDemandePrive(
        adresseRecuperation,
        villeRecuperation,
        regionRecuperation,
        adresseLivraison,
        villeLivraison,
        valueVoiture,
        regionLivraison,
        valueMoto,
        valueCamion,
        valuePickup,
        valueTaxi,
        valueVelo,
        dateLivraison,
        heureLivraison,
        dropdownContenu,
        dropdownNature,
        dropdownTaille,
        dropdownPoids,
        description.text.trim(),
        prix.text.trim(),
        idLivreur.trim(),
      )
          .whenComplete(() {
        if (demandeController.status) {
          _showDialog(
              "Veuillez choisir la catégorie, la Nature, la taille et le poids!");
          print("erreur...");
        } else {
          String todayNotification =
              DateFormat("yyyy-MM-dd HH:mm").format(DateTime.now());
          print(
              "Today :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: $todayNotification");
          notificationController.ajouterNotification(
              idLivreur.trim(),
              Const.idClLiv,
              null,
              null,
              "A",
              "vous à envoyé une demande de livraison privée.",
              todayNotification);
          Navigator.of(context).pop();
          Navigator.of(context).pop();
          Navigator.of(context).pop();
          Navigator.of(context).pop();
          Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) => DemandesClient(
                        contenu: "Tout",
                        nature: "Tout",
                        taille: "Tout",
                        poids: "Tout",
                        regionRecuperation: "Tout",
                        regionLivraison: "Tout",
                        villeDeDepart: "Tout",
                        villeDeLivraison: "Tout",
                        triePar: "Tout",
                        dateLivraison: '',
                      )));
        }
      });
    }
  }

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
              title: new GradientText(
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  text: "Erreur",
                  colors: <Color>[
                    Colors.orange.shade400,
                    Colors.orange.shade900,
                  ]),
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
