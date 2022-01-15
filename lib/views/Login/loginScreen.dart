import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:livreurs_app/Views/Accueil/accueilClient.dart';
import 'package:livreurs_app/views/Accueil/accueilLivreur.dart';
import 'package:livreurs_app/Controllers/userController.dart';
import 'package:livreurs_app/views/reinitialiser/emailEnvoyer.dart';

class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  UserController userController = new UserController();
  TextEditingController _loginController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  bool _validateLogin = false, _validatePassword = false;
  ///////////////// Body  ///////////////////
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Positioned(
              child: Container(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    //////////////////// Email ou Numero du telephone /////////////////////////////////
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Image.asset(
                                  "assets/login222.png",
                                  color: Colors.orange,
                                  height: 35,
                                  width: 35,
                                  fit: BoxFit.cover,
                                ),
                                Text(' Email ou téléphone '),
                              ],
                            ),
                          ),
                          Container(
                            padding:
                                const EdgeInsets.only(left: 28.0, right: 28),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                TextField(
                                  controller:
                                      _loginController, //controller login
                                  style: TextStyle(color: Color(0xFF000000)),
                                  cursorColor: Color(0xFF9b9b9b),
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    hintText:
                                        "Saisir votre email ou numero du téléphone",
                                    // errorText: _validateLogin
                                    //     ? 'La valeur d\'email ne peut pas être vide'
                                    //     : null,
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

                    /////////////// Mot de passe  ////////////////////
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Image.asset(
                                  "assets/password222.png",
                                  height: 35,
                                  width: 35,
                                  color: Colors.orange,
                                  fit: BoxFit.cover,
                                ),
                                Text(' Mot de passe '),
                              ],
                            ),
                          ),
                          Container(
                            padding:
                                const EdgeInsets.only(left: 28.0, right: 28),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                TextField(
                                  controller:
                                      _passwordController, //controller password,
                                  style: TextStyle(color: Color(0xFF000000)),
                                  cursorColor: Color(0xFF9b9b9b),
                                  keyboardType: TextInputType.text,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    hintText: "Saisir votre mot de passe",
                                    // errorText: _validatePassword
                                    //     ? 'La valeur de mot de passe ne peut pas être vide'
                                    //     : null,
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
                    ///////////// Botton Se connecter ///////////////////
                    Container(
                      padding: const EdgeInsets.only(top: 30.0, bottom: 30),
                      // ignore: deprecated_member_use
                      child: FlatButton(
                        onPressed: () => _onPressed(),
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: 12, bottom: 12, left: 45, right: 45),
                          child: Text(
                            'Se connecter',
                            textDirection: TextDirection.ltr,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        color: Colors.orange,
                        disabledColor: Colors.grey,
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(20.0)),
                      ),
                    ),
                    ///////////// Botton mot de passe oublié ///////////////////
                    Container(
                      padding: const EdgeInsets.only(top: 20),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => EmailEnvoyer()));
                        },
                        child: Text(
                          'mot de passe oublié ?',
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                            color: Colors.orange[700],
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
            ),
          ],
        ),
      ),
    );
  }

  ///// Fonction pour naviguer a page  accueil
  _onPressed() {
    setState(() {
      _loginController.text.isEmpty
          ? _validateLogin = true
          : _validateLogin = false;
      _passwordController.text.isEmpty
          ? _validatePassword = true
          : _validatePassword = false;
      String email = _loginController.text.trim().toLowerCase();
      userController.obtenirRole(email);
      if (_loginController.text.trim().toLowerCase().isNotEmpty &&
          _passwordController.text.trim().isNotEmpty) {
        userController
            .connecter(_loginController.text.trim().toLowerCase().toString(),
                _passwordController.text.trim().toString())
            .whenComplete(() {
          if (userController.status) {
            print(
                "Il y a un erreur dans votre email/numero du telephone ou mot de passe");
            _showDialog(
                "Vérifier votre email/numero du telephone ou votre mot de passe.");
          } else {
            if (userController.role == "livreur") {
              print("je suis dans l'espace livreur");
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => AccueilLivreur()));
            }
            if (userController.role == "client") {
              print("je suis dans l'espace client");
              Navigator.push(context,
                  new MaterialPageRoute(builder: (context) => AccueilClient()));
            }
          }
        });
      } else {
        if (_loginController.text.trim().toLowerCase().isEmpty &&
            _passwordController.text.trim().isEmpty) {
          _showDialog("Remplir tous les champs!");
        }
      }
    });
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
