import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:livreurs_app/Controllers/userController.dart';
import 'package:livreurs_app/main.dart';
import 'package:livreurs_app/views/Login/mainLogin.dart';

import 'reinitialiserMotPassUser.dart';

// ignore: camel_case_types
class EmailEnvoyer extends StatefulWidget {
  @override
  EmailEnvoyerState createState() => EmailEnvoyerState();
}

// ignore: camel_case_types
class EmailEnvoyerState extends State<EmailEnvoyer> {
  UserController userController = new UserController();
  TextEditingController _loginController = new TextEditingController();
  bool _validateLogin = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ///////////////// Bar Livraison GV   /////////////////
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        iconTheme: IconThemeData(color: Colors.black),
        title: Center(
          child: Container(
            padding: EdgeInsets.all(5),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      child: Container(
                        margin: EdgeInsets.all(5.0),
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          ' Livraison GV',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Container(
                        margin: EdgeInsets.all(5.0),
                        padding: EdgeInsets.all(8.0),
                        child: Image.asset(
                          "assets/logo.png",
                          height: 50,
                          width: 50,
                          fit: BoxFit.cover,
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
      /////////////////// Body de page ///////////////////
      body: SingleChildScrollView(
        child: Center(
          child: Stack(
            children: <Widget>[
              Positioned(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: Image.asset(
                          "assets/reset.png",
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            ///////////////// text "mot de passe oublie" /////////////////////
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Mot de passe oublié ?',
                                    style: TextStyle(
                                      fontSize: 24.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            ////////////////////// text "Entrez votre compte pour récupérer votre mot de passe" /////////////
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Flexible(
                                      child: Container(
                                    child: Text(
                                      'Entrez votre compte pour récupérer votre mot de passe',
                                      style: TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ))
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      /////////////// TextField Adresse email ////////////////////
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text(' Adresse e-mail '),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 28.0, right: 28),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  TextField(
                                    controller: _loginController,
                                    style: TextStyle(color: Color(0xFF000000)),
                                    cursorColor: Color(0xFF9b9b9b),
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      hintText: "Saisir votre email",
                                      errorText: _validateLogin
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
                          ],
                        ),
                      ),

                      /////////////   Botton  demande mot de passe ///////////////////
                      Padding(
                        padding: const EdgeInsets.only(top: 50.0, bottom: 30),
                        // ignore: deprecated_member_use
                        child: FlatButton(
                          ///// Fonction pour envoyer mot de passe par email
                          onPressed: () => setState(() {
                            _loginController.text.isEmpty
                                ? _validateLogin = true
                                : _validateLogin = false;
                            if (_loginController.text
                                .trim()
                                .toLowerCase()
                                .isNotEmpty) {
                              userController
                                  .envoyerCodeParEmail(
                                      _loginController.text
                                          .trim()
                                          .toLowerCase()
                                          .toString(),
                                      "Vérification de votre compte Livraison GV")
                                  .whenComplete(() {
                                print(
                                    "Le mot de passe a été envoyé à votre gmail, Vérifiez votre e-mail maintenant Livraison GV Ok");
                                Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                        builder: (context) =>
                                            ModifierMotPassUser(
                                                email: _loginController.text)));
                              });
                            }
                          }),
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: 12, bottom: 12, left: 35, right: 35),
                            child: Text(
                              'Demander un mot de passe',
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
                          disabledColor: Color(0xFFFF5722),
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(20.0)),
                        ),
                      ),

                      /////////////////// botton se connecter //////////////////
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) => MainI()));
                          },
                          child: Text(
                            'Se connecter',
                            textDirection: TextDirection.ltr,
                            style: TextStyle(
                              color: Colors.orange,
                              fontSize: 15.0,
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
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

  //// Fonction afficher message erreur //////
  void _showDialog(String error, String titre, String type) {
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
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  new Text(
                    '$titre',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
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
                            '$type',
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
