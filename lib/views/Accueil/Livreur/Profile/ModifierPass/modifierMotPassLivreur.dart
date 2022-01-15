import 'package:flutter/material.dart';
import 'package:livreurs_app/Controllers/userController.dart';
import 'package:livreurs_app/views/Accueil/accueilLivreur.dart';

/// This Widget is the main application widget.
class ModifierMotPassLivreur extends StatefulWidget {
  @override
  _ModifierMotPassLivreurState createState() => _ModifierMotPassLivreurState();
}

class _ModifierMotPassLivreurState extends State<ModifierMotPassLivreur> {
  UserController userController = new UserController();
  TextEditingController oldPassword = new TextEditingController();
  TextEditingController newPassword = new TextEditingController();
  TextEditingController confirmPassword = new TextEditingController();
  bool _validateOldPassword = false,
      _validateNewPassword = false,
      _validateConfirmPassword = false;

  @override
  Widget build(BuildContext context) {
    // ignore: todo
    // TODO: implement build
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
                        'Changer le mot de passe',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
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
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: <
            Widget>[
          ////// Row de Text et TextField "Ancien mot de passe " //////

          Container(
            margin: const EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Ancien mot de passe",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                TextField(
                  controller: oldPassword,
                  autofocus: false,
                  style: TextStyle(fontSize: 22.0, color: Color(0xFFbdc6cf)),
                  decoration: InputDecoration(
                    hintText: "saisir mot de pass ancien",
                    errorText: _validateOldPassword
                        ? 'La valeur de nom ne peut pas être vide'
                        : null,
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
              ],
            ),
          ),

          ////// Row de Text et TextField "Neveau mot de passe" //////

          Container(
            margin: const EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Neveau mot de passe",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                TextField(
                  controller: newPassword,
                  autofocus: false,
                  style: TextStyle(fontSize: 22.0, color: Color(0xFFbdc6cf)),
                  decoration: InputDecoration(
                    hintText: "saisir mot de pass neveau",
                    errorText: _validateNewPassword
                        ? 'La valeur de nom ne peut pas être vide'
                        : null,
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
              ],
            ),
          ),

          ////// Row de Text et TextField "Confirmer le neveau mot de passe" //////

          Container(
            margin: const EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Confirmer le neveau mot de passe",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                TextField(
                  controller: confirmPassword,
                  autofocus: false,
                  style: TextStyle(fontSize: 22.0, color: Color(0xFFbdc6cf)),
                  decoration: InputDecoration(
                    hintText: "saisir mot de pass confirmé",
                    errorText: _validateConfirmPassword
                        ? 'La valeur de nom ne peut pas être vide'
                        : null,
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
              ],
            ),
          ),

          /// Row de Button "Changer"

          Container(
            // ignore: deprecated_member_use
            child: FlatButton(
              onPressed: () => _onPressedUpdatePassword(),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
              child: Text(
                'Changer',
                style: TextStyle(fontSize: 20.0),
              ),
              color: Colors.orange,
              textColor: Colors.white,
            ),
          )
        ]),
      ),
    );
  }

  _onPressedUpdatePassword() {
    setState(() {
      oldPassword.text.isEmpty
          ? _validateOldPassword = true
          : _validateOldPassword = false;
      newPassword.text.isEmpty
          ? _validateNewPassword = true
          : _validateNewPassword = false;
      confirmPassword.text.isEmpty
          ? _validateConfirmPassword = true
          : _validateConfirmPassword = false;
    });
    if (oldPassword.text.trim() != newPassword.text.trim()) {
      _showDialog(
          "Le mot de passe doit être égale le mot de passe de confirmation!");
    }
    userController
        .modifierMotDePasse(
      oldPassword.text.trim(),
      newPassword.text.trim(),
      confirmPassword.text.trim(),
    )
        .whenComplete(() {
      if (userController.status) {
        _showDialog("Entrer les informations corrects!");
        print("erreur...");
      } else {
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      }
    });
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
