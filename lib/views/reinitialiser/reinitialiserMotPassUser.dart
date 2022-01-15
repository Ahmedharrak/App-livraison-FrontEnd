import 'package:flutter/material.dart';
import 'package:livreurs_app/Controllers/userController.dart';
import 'package:livreurs_app/views/Accueil/accueilLivreur.dart';
import 'package:livreurs_app/const.dart' as Const;

import '../../main.dart';
import 'emailEnvoyer.dart';

/// This Widget is the main application widget.
class ModifierMotPassUser extends StatefulWidget {
  final String email;
  ModifierMotPassUser({
    Key key,
    this.email,
  }) : super(key: key);
  @override
  _ModifierMotPassUserState createState() =>
      _ModifierMotPassUserState(this.email);
}

class _ModifierMotPassUserState extends State<ModifierMotPassUser> {
  String email;
  String idUtilisateur;
  UserController userController = new UserController();
  TextEditingController newPassword = new TextEditingController();
  TextEditingController confirmPassword = new TextEditingController();
  TextEditingController code = new TextEditingController();
  bool visibleMotDePass = false;
  _ModifierMotPassUserState(this.email);
  @override
  Widget build(BuildContext context) {
    String codeVerifier = Const.codeVerifier;
    print("code verifier ---------> $codeVerifier");

    void valideCode() {
      // ignore: unrelated_type_equality_checks
      if (code.text == codeVerifier) {
        setState(() {
          visibleMotDePass = true;
        });
      } else if (code.text != codeVerifier)
        setState(() {
          visibleMotDePass = false;
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
                  MaterialPageRoute(builder: (context) => AccueilLivreur()),
                );
              })
        ],

        ////// Center de Page ////////
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

                      child: Text(
                        'Réinitialiser le mot de passe',
                        style: TextStyle(color: Colors.black, fontSize: 14),
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
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              ////// Row de Text et TextField "Code Vérification" //////

              Container(
                margin: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Code Vérification ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "*",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.orange),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(5),
                      child: TextField(
                        controller: code,
                        autofocus: false,
                        style: TextStyle(fontSize: 22.0, color: Colors.black),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.only(
                              left: 14.0, bottom: 8.0, top: 8.0),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(25.7),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(25.7),
                          ),
                        ),
                      ),
                    ),

                    /// Row de Button "Valider"

                    Container(
                      // ignore: deprecated_member_use
                      child: FlatButton(
                        onPressed: () => valideCode(),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        child: Text(
                          'Valider',
                          style: TextStyle(fontSize: 20.0),
                        ),
                        color: Colors.orange,
                        textColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),

              ////// Row de Text et TextField "Neveau mot de passe" //////
              // ignore: unrelated_type_equality_checks
              Visibility(
                visible: visibleMotDePass,
                child: Container(
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.all(5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Neveau mot de passe ",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "*",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.orange),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.all(5),
                              child: TextField(
                                controller: newPassword,
                                autofocus: false,
                                style: TextStyle(
                                    fontSize: 22.0, color: Color(0xFFbdc6cf)),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  contentPadding: const EdgeInsets.only(
                                      left: 14.0, bottom: 8.0, top: 8.0),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                    borderRadius: BorderRadius.circular(25.7),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(25.7),
                                  ),
                                ),
                                obscureText: true,
                              ),
                            ),
                          ],
                        ),
                      ),

                      ////// Row de Text et TextField "Confirmer le neveau mot de passe" //////

                      Container(
                        margin: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.all(5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Confirmer le neveau mot de passe ",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "*",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.orange),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.all(5),
                              child: TextField(
                                controller: confirmPassword,
                                autofocus: false,
                                style: TextStyle(
                                    fontSize: 22.0, color: Color(0xFFbdc6cf)),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  contentPadding: const EdgeInsets.only(
                                      left: 14.0, bottom: 8.0, top: 8.0),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                    borderRadius: BorderRadius.circular(25.7),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(25.7),
                                  ),
                                ),
                                obscureText: true,
                              ),
                            ),
                          ],
                        ),
                      ),

                      /// Row de Button "Changer"

                      Container(
                        // ignore: deprecated_member_use
                        child: FlatButton(
                          onPressed: () => _reinitialiserMotdePasseUser(),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          child: Text(
                            'Réinitialiser',
                            style: TextStyle(fontSize: 20.0),
                          ),
                          color: Colors.orange,
                          textColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ]),
      ),
    );
  }

  _reinitialiserMotdePasseUser() {
    userController.obtenirId(email);
    idUtilisateur = Const.idUtilisateur;
    print(idUtilisateur);
    userController
        .reinitialiseMotDePasse(
            newPassword.text.trim(), confirmPassword.text.trim(), idUtilisateur)
        .whenComplete(() {
      if (newPassword.text.trim() != confirmPassword.text.trim()) {
        _showDialog(
            "Le mot de passe doit être égale le mot de passe de confirmation!");
      } else {
        Navigator.push(
            context, new MaterialPageRoute(builder: (context) => MyApp()));
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
