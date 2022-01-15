import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:geocoder/geocoder.dart';
import 'package:livreurs_app/Controllers/userController.dart';
import 'package:livreurs_app/views/Accueil/accueilClient.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:livreurs_app/const.dart' as Const;

class InscrireClient extends StatefulWidget {
  @override
  inscrireClientState createState() => inscrireClientState();
}

// ignore: camel_case_types
class inscrireClientState extends State<InscrireClient> {
  UserController userController = new UserController();
  String dropdownVille = "Tout";
  TextEditingController _nomControllerc = new TextEditingController();
  TextEditingController _prenomControllerc = new TextEditingController();
  TextEditingController _cinControllerc = new TextEditingController();
  TextEditingController _adresseControllerc = new TextEditingController();
  TextEditingController _telephoneControllerc = new TextEditingController();
  TextEditingController _emailControllerc = new TextEditingController();
  TextEditingController _passwordControllerc = new TextEditingController();
  TextEditingController _confirmerPasswordControllerc =
      new TextEditingController();
  bool _validateNom = false,
      _validatePrenom = false,
      _validateCIN = false,
      _validateTelephone = false,
      _validateEmail = false,
      _validatePassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //////////////////////////////////////////////// Center de page ///////////////////////////////
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.topRight,
              colors: [Color(0xffffff), Color(0xffffff), Color(0xffffff)]),
        ),
        child: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              /////////////  background Page /////////////
              new Container(
                decoration: new BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      stops: [
                        0.0,
                        0.4,
                        0.9
                      ],
                      colors: [
                        Color(0xFFFFFF),
                        Color(0xFFFFFF),
                        Color(0xFFFFFF)
                      ]),
                ),
              ),

              ////////////////////////////// Form d'inscrire client //////////////////////////

              Positioned(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    '* : obligatoire',
                                    style: TextStyle(
                                      color: Colors.orange,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  ///////////////////// Nom //////////////////////////////
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Icon(
                                          Icons.account_circle,
                                        ),
                                        Text(
                                          '   Nom  ',
                                          style: TextStyle(),
                                        ),
                                        Text(
                                          '*',
                                          style: TextStyle(
                                            color: Colors.orange,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  TextField(
                                    controller: _nomControllerc,
                                    style: TextStyle(color: Color(0xFF000000)),
                                    cursorColor: Color(0xFF9b9b9b),
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      hintText: "Saisir votre nom ",
                                      errorText: _validateNom
                                          ? 'La valeur de nom ne peut pas être vide'
                                          : null,
                                      hintStyle: TextStyle(
                                          color: Color(0xFF9b9b9b),
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            /////////////////////////////////// Prenom //////////////////////
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Icon(
                                          Icons.account_circle,
                                        ),
                                        Text(
                                          '   Prénom  ',
                                          style: TextStyle(),
                                        ),
                                        Text(
                                          '*',
                                          style: TextStyle(
                                            color: Colors.orange,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  TextField(
                                    controller: _prenomControllerc,
                                    style: TextStyle(color: Color(0xFF000000)),
                                    cursorColor: Color(0xFF9b9b9b),
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      hintText: "Saisir votre prénom ",
                                      errorText: _validatePrenom
                                          ? 'La valeur de prénom ne peut pas être vide'
                                          : null,
                                      hintStyle: TextStyle(
                                          color: Color(0xFF9b9b9b),
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            ////////////////////////// CIN //////////////////////////
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Icon(
                                          Icons.portrait,
                                        ),
                                        Text(
                                          '   Numéro du CIN  ',
                                          style: TextStyle(),
                                        ),
                                        Text(
                                          '*                      ',
                                          style: TextStyle(
                                            color: Colors.orange,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  TextField(
                                    controller: _cinControllerc,
                                    style: TextStyle(color: Color(0xFF000000)),
                                    cursorColor: Color(0xFF9b9b9b),
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      hintText: "Saisir votre numéro du CIN ",
                                      errorText: _validateCIN
                                          ? 'La valeur de CIN ne peut pas être vide'
                                          : null,
                                      hintStyle: TextStyle(
                                          color: Color(0xFF9b9b9b),
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            ////////////////////////// Ville //////////////////////////

                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Icon(
                                          Icons.add_location,
                                        ),
                                        Text(
                                          '   Ville  ',
                                          style: TextStyle(),
                                        ),
                                        Text(
                                          '*',
                                          style: TextStyle(
                                            color: Colors.orange,
                                          ),
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
                                        setState(() {
                                          dropdownVille = value;
                                        });
                                      },
                                      selectedItem: dropdownVille,
                                      showSearchBox: true,
                                      searchBoxDecoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        contentPadding:
                                            EdgeInsets.fromLTRB(12, 12, 8, 0),
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

                            ////////////////////////// Adresse //////////////////////////

                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Icon(
                                          Icons.add_location_alt,
                                        ),
                                        Text(
                                          '   Adresse  ',
                                          style: TextStyle(),
                                        ),
                                      ],
                                    ),
                                  ),
                                  TextField(
                                    controller: _adresseControllerc,
                                    style: TextStyle(color: Color(0xFF000000)),
                                    cursorColor: Color(0xFF9b9b9b),
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      hintText: "Saisir votre adresse ",
                                      hintStyle: TextStyle(
                                          color: Color(0xFF9b9b9b),
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            ////////////////////////// Numero du telephone //////////////////////////

                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Icon(
                                          Icons.mobile_friendly,
                                        ),
                                        Text(
                                          '   Numéro du téléphone  ',
                                          style: TextStyle(),
                                        ),
                                        Text(
                                          '*',
                                          style: TextStyle(
                                            color: Colors.orange,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  TextField(
                                    controller: _telephoneControllerc,
                                    style: TextStyle(color: Color(0xFF000000)),
                                    cursorColor: Color(0xFF9b9b9b),
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      hintText:
                                          "Saisir votre numéro du téléphone ",
                                      errorText: _validateTelephone
                                          ? 'La valeur de numéro du téléphone ne peut pas être vide'
                                          : null,
                                      hintStyle: TextStyle(
                                          color: Color(0xFF9b9b9b),
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            ////////////////////////// Email //////////////////////////

                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Icon(
                                          Icons.mail,
                                        ),
                                        Text(
                                          '   Email  ',
                                          style: TextStyle(),
                                        ),
                                        Text(
                                          '*',
                                          style: TextStyle(
                                            color: Colors.orange,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  TextField(
                                    controller: _emailControllerc,
                                    style: TextStyle(color: Color(0xFF000000)),
                                    cursorColor: Color(0xFF9b9b9b),
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                      hintText: "Saisir votre email ",
                                      errorText: _validateEmail
                                          ? 'La valeur d\'email ne peut pas être vide'
                                          : null,
                                      hintStyle: TextStyle(
                                          color: Color(0xFF9b9b9b),
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            ////////////////////////// Mot de passe //////////////////////////

                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Icon(
                                          Icons.vpn_key,
                                        ),
                                        Text(
                                          '   Mot de passe  ',
                                          style: TextStyle(),
                                        ),
                                        Text(
                                          '*',
                                          style: TextStyle(
                                            color: Colors.orange,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  TextField(
                                    obscureText: true,
                                    controller: _passwordControllerc,
                                    style: TextStyle(color: Color(0xFF000000)),
                                    cursorColor: Color(0xFF9b9b9b),
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      hintText: "Saisir votre mot de passe ",
                                      errorText: _validatePassword
                                          ? 'La valeur de mot de passe ne peut pas être vide'
                                          : null,
                                      hintStyle: TextStyle(
                                          color: Color(0xFF9b9b9b),
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            ////////////////////////// Confirmation mot de passe  //////////////////////////

                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Icon(
                                          Icons.vpn_key,
                                        ),
                                        Text(
                                          '   Confirmation du mot de passe  ',
                                          style: TextStyle(),
                                        ),
                                        Text(
                                          '*',
                                          style: TextStyle(
                                            color: Colors.orange,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  TextField(
                                    obscureText: true,
                                    controller: _confirmerPasswordControllerc,
                                    style: TextStyle(color: Color(0xFF000000)),
                                    cursorColor: Color(0xFF9b9b9b),
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      hintText: "Confirmer du mot de passe ",
                                      hintStyle: TextStyle(
                                          color: Color(0xFF9b9b9b),
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            ////////////////////////// Button inscrire //////////////////////////

                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              // ignore: deprecated_member_use
                              child: FlatButton(
                                onPressed: () => _onPressedClient(),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      top: 8, bottom: 8, left: 10, right: 10),
                                  child: Text(
                                    "S'inscrire",
                                    textDirection: TextDirection.ltr,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15.0,
                                      decoration: TextDecoration.none,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                                color: Colors.orange,
                                disabledColor: Colors.grey,
                                shape: new RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(20.0)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  ///// Fonction pour naviguer a page client accueil

  _onPressedClient() async {
    setState(() {
      _emailControllerc.text.isEmpty
          ? _validateEmail = true
          : _validateEmail = false;
      _nomControllerc.text.isEmpty ? _validateNom = true : _validateNom = false;
      _prenomControllerc.text.isEmpty
          ? _validatePrenom = true
          : _validatePrenom = false;
      _telephoneControllerc.text.isEmpty
          ? _validateTelephone = true
          : _validateTelephone = false;
      _cinControllerc.text.isEmpty ? _validateCIN = true : _validateCIN = false;
      _passwordControllerc.text.isEmpty
          ? _validatePassword = true
          : _validatePassword = false;
    });

    if (dropdownVille == "Tout") {
      _showDialog("Saisir votre ville!");
    }

    String _imgProfile64 = Const.imageProfileClient;
    final villeClient = dropdownVille;
    var addressesClient =
        await Geocoder.local.findAddressesFromQuery(villeClient);
    var regionClient = addressesClient.first.adminArea;
    if (_emailControllerc.text.trim().toLowerCase().isNotEmpty &&
        _passwordControllerc.text.trim().isNotEmpty &&
        _nomControllerc.text.trim().toLowerCase().isNotEmpty &&
        _telephoneControllerc.text.trim().toLowerCase().isNotEmpty &&
        _cinControllerc.text.trim().toLowerCase().isNotEmpty) {
      userController
          .inscrireClient(
              _nomControllerc.text.trim(),
              _prenomControllerc.text.trim(),
              _telephoneControllerc.text.trim(),
              _emailControllerc.text.trim(),
              _cinControllerc.text.trim(),
              dropdownVille,
              _adresseControllerc.text.trim(),
              regionClient,
              _passwordControllerc.text.trim(),
              _imgProfile64)
          .whenComplete(() {
        String pass = _passwordControllerc.text.trim();
        String passC = _confirmerPasswordControllerc.text.trim();

        if (pass != passC) {
          _showDialog(
              "Le mot de passe doit être égale le mot de passe de confirmation!");
        } else {
          if (userController.status) {
            print(
                "Il y a un erreur dans votre email/numero du telephone ou mot de passe");
            _showDialog(
                "Vérifier votre email/numero du telephone ou votre mot de passe.");
          } else {
            print("Vous avez créé votre compte avec succès");
            Navigator.push(context,
                new MaterialPageRoute(builder: (context) => AccueilClient()));
          }
        }
      });
    }
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
