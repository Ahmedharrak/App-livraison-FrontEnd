import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:flutter/scheduler.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:livreurs_app/Controllers/livraisonController.dart';
import 'package:livreurs_app/Controllers/livreurController.dart';
import 'package:livreurs_app/Controllers/notificationController.dart';
import 'package:livreurs_app/Controllers/userController.dart';
import 'package:livreurs_app/views/Accueil/accueilClient.dart';
import 'package:livreurs_app/const.dart' as Const;

/// This Widget is the main application widget.
// ignore: must_be_immutable
class NoterClient extends StatefulWidget {
  String idLivraison;
  String idLivreur;
  NoterClient({Key key, @required this.idLivraison, @required this.idLivreur})
      : super(key: key);
  @override
  _NoterClientState createState() => _NoterClientState(idLivraison, idLivreur);
}

class _NoterClientState extends State<NoterClient> {
  String idLivraison;
  String idLivreur;
  _NoterClientState(this.idLivraison, this.idLivreur);
  double note = 3.0;
  LivraisonController livraisonController = new LivraisonController();
  TextEditingController commentaire = new TextEditingController();
  TextEditingController justification = new TextEditingController();
  NotificationController notificationController = new NotificationController();
  UserController userController = new UserController();
  LivreurController livreurController = new LivreurController();
  @override
  Widget build(BuildContext context) {
    void _showDialog(String error) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return Theme(
              data: Theme.of(context)
                  .copyWith(dialogBackgroundColor: Colors.white),
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

    String todayNotification =
        DateFormat("yyyy-MM-dd HH:mm").format(DateTime.now());
    print(
        "Today :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: $todayNotification");
    _onPressedNoter() {
      if (commentaire.text.trim() != "" && note != 0) {
        livraisonController
            .ajouterRetroactionClient(idLivraison, note,
                justification.text.trim(), commentaire.text.trim())
            .whenComplete(() {
          livreurController.ajouterCommentaireLivreur(
              idLivreur, note, commentaire.text.trim());
          notificationController.ajouterNotification(
              idLivreur.trim(),
              Const.idClLiv,
              null,
              idLivraison,
              "A",
              "a noté votre livraison.",
              todayNotification);
          Navigator.push(context,
              new MaterialPageRoute(builder: (context) => AccueilClient()));
        });
      } else {
        _showDialog("remplir tous les champs!");
      }
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
            padding: EdgeInsets.all(5),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      ////////////// titre de bare de page /////////

                      child: Text(
                        'Noter livreur',
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

      /////// Body de Page ///////////

      body: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                  margin: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Text(
                        "* : obligatoire",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.orange),
                      ),
                    ],
                  )),
              ////// Titre du Page  //////
              Container(
                margin: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Note ",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                    ),
                    Text(
                      "*",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          color: Colors.orange),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  left: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    RatingBar.builder(
                      initialRating: 0,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        setState(() {
                          this.note = rating;
                        });
                        print(rating);
                      },
                    ),
                  ],
                ),
              ),
              new Center(
                  child: note <= 2
                      ? new Container(
                          margin: const EdgeInsets.all(20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "justification ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 22),
                              ),
                              Text(
                                "*",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22,
                                    color: Colors.orange),
                              ),
                            ],
                          ),
                        )
                      : new Container()),
              new Center(
                  child: (note <= 2)
                      ? new Container(
                          margin: const EdgeInsets.all(20),
                          child: TextField(
                            controller: justification,
                            style: TextStyle(color: Color(0xFF000000)),
                            cursorColor: Color(0xFF9b9b9b),
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              hintText:
                                  "justifier ici pourquoi vous avez note ce livreur une movaise note ?",
                              hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal),
                            ),
                            maxLines: 6,
                          ),
                        )
                      : new Container()),
              Container(
                margin: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Commentaire ",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                    ),
                    Text(
                      "*",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          color: Colors.orange),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.all(20),
                child: TextField(
                  controller: commentaire,
                  style: TextStyle(color: Color(0xFF000000)),
                  cursorColor: Color(0xFF9b9b9b),
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: "exemple : Bon livreur je le recommande.",
                    hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                        fontWeight: FontWeight.normal),
                  ),
                  maxLines: 6,
                ),
              ),

              /////// Button //////
              Container(
                // ignore: deprecated_member_use
                child: FlatButton(
                  onPressed: () => _onPressedNoter(),
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
            ]),
      ),
    );
  }
}
