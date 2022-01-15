import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:easy_gradient_text/easy_gradient_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:livreurs_app/views/Accueil/Client/PublierDemande/publierDemandeQuoi.dart';

import '../../accueilClient.dart';
import 'package:livreurs_app/Controllers/demandeController.dart';

// ignore: must_be_immutable
class PublierDemandeQuand extends StatefulWidget {
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

  PublierDemandeQuand({
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
  }) : super(key: key);
  @override
  PublierDemandeQuandState createState() => PublierDemandeQuandState(
        adresseRecuperation,
        villeRecuperation,
        adresseLivraison,
        villeLivraison,
        valueVoiture,
        valueMoto,
        valueCamion,
        valuePickup,
        valueTaxi,
        valueVelo,
      );
}

class PublierDemandeQuandState extends State<PublierDemandeQuand> {
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
  PublierDemandeQuandState(
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
  );
  DemandeController demandeController = new DemandeController();
  final format = DateFormat("yyyy-MM-dd");
  final formatH = DateFormat("HH:mm");
  TextEditingController dateLivraison = new TextEditingController();
  TextEditingController heureLivraison = new TextEditingController();

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
                        'Publier une demande',
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
                        image: new AssetImage("assets/treeActive.png"),
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
                              image: new AssetImage("assets/fourD.png"),
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
                                  size: 25,
                                  color: Colors.orange,
                                ),
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
                          margin: const EdgeInsets.all(10),
                          child: DateTimeField(
                            controller: dateLivraison,
                            format: format,
                            onShowPicker: (context, currentValue) {
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
                                  firstDate: DateTime.now(),
                                  initialDate: currentValue ?? DateTime.now(),
                                  lastDate: DateTime(2100));
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  //////////// Heure de livraison
                  Container(
                    child: Column(
                      children: [
                        //////// titre Heure de livraison
                        Container(
                          margin: const EdgeInsets.only(left: 10, right: 5),
                          child: Row(
                            children: [
                              /////// Icone Heure de livraison
                              Container(
                                child: ImageIcon(
                                  AssetImage("assets/clock.png"),
                                  size: 25,
                                  color: Colors.orange,
                                ),
                              ),
                              ////// Text
                              Container(
                                margin: const EdgeInsets.only(left: 5),
                                child: Text(
                                  "Heure de livraison ",
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
                        ///////// Text Field Heure de livraison
                        Container(
                          margin: const EdgeInsets.all(10),
                          child: DateTimeField(
                            controller: heureLivraison,
                            format: formatH,
                            onShowPicker: (context, currentValue) async {
                              final time = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                                builder: (context, child) {
                                  if (MediaQuery.of(context)
                                      .alwaysUse24HourFormat) {
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
                                  } else {
                                    return Localizations.override(
                                      context: context,
                                      locale: const Locale("fr", "FR"),
                                      child: Theme(
                                        data: ThemeData.light().copyWith(
                                          colorScheme: ColorScheme.fromSwatch(
                                            primarySwatch: Colors.orange,
                                            primaryColorDark:
                                                Colors.orangeAccent,
                                            accentColor: Colors.orangeAccent,
                                          ),
                                          dialogBackgroundColor: Colors.white,
                                        ),
                                        child: child,
                                      ),
                                    );
                                  }
                                },
                              );
                              return DateTimeField.convert(time);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            ///// Button Suivant ////
            Container(
              margin: const EdgeInsets.all(20),
              // ignore: deprecated_member_use
              child: FlatButton(
                onPressed: () {
                  if (dateLivraison.text == "" || heureLivraison.text == "") {
                    _showDialog("Veuillez remplir tous les champs!");
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PublierDemandeQuoi(
                                adresseRecuperation: "$adresseRecuperation",
                                villeRecuperation: "$villeRecuperation",
                                adresseLivraison: "$adresseLivraison",
                                villeLivraison: "$villeLivraison",
                                valueVoiture: "$valueVoiture",
                                valueMoto: "$valueMoto",
                                valueCamion: "$valueCamion",
                                valuePickup: "$valuePickup",
                                valueTaxi: "$valueTaxi",
                                valueVelo: "$valueVelo",
                                dateLivraison: "${dateLivraison.text.trim()}",
                                heureLivraison: "${heureLivraison.text.trim()}",
                              )),
                    );
                  }
                },
                child: Text(
                  "Suivant",
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
