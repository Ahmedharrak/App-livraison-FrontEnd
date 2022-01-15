import 'package:flutter/material.dart';
import 'package:livreurs_app/Controllers/livreurController.dart';
import 'package:livreurs_app/views/Accueil/Client/FutursLivraisons/futursLivraisonsClient.dart';
import 'package:livreurs_app/views/Accueil/accueilClient.dart';

/// This Widget is the main application widget.
// ignore: must_be_immutable
class SignalerClient extends StatefulWidget {
  String idLivreur;
  SignalerClient({Key key, @required this.idLivreur}) : super(key: key);
  @override
  _SignalerClientState createState() => _SignalerClientState(idLivreur);
}

class _SignalerClientState extends State<SignalerClient> {
  String idLivreur;
  _SignalerClientState(this.idLivreur);
  LivreurController livreurController = new LivreurController();
  bool valueCase1 = false;
  bool valueCase2 = false;
  bool valueCase3 = false;
  bool valueCase4 = false;
  bool valueCaseAutre = false;
  bool valueAccepter = false;
  String causeDeSignale;
  // ignore: non_constant_identifier_names
  TextEditingController CommentaireCaseAutre = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    // ignore: todo
    // TODO: implement build
    print("****///////////-----> idClient signaler $idLivreur");
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

    _signalerLivreur() {
      if (this.valueCaseAutre == true) {
        causeDeSignale = CommentaireCaseAutre.text;
      }
      if (valueAccepter == true && causeDeSignale != null) {
        livreurController.signalerLivreur(idLivreur, causeDeSignale);
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) => FutursLivraisonClient(
                      contenu: 'Tout',
                      nature: 'Tout',
                      poids: 'Tout',
                      regionLivraison: 'Tout',
                      regionRecuperation: 'Tout',
                      taille: 'Tout',
                      triePar: 'Tout',
                      villeDeDepart: 'Tout',
                      villeDeLivraison: 'Tout',
                      dateLivraison: '',
                    )));
      } else {
        _showDialog("Remplir les champs correctement!");
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
                        'Signaler',
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
              ////// Titre du Page  //////
              Container(
                margin: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        "Pourquoi voulez-vous le signaler",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 22),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: [
                    //////// Checkbox Cases
                    CheckboxListTile(
                      title: const Text('Case 1'),
                      value: this.valueCase1,
                      onChanged: (bool value) {
                        setState(() {
                          this.valueCase1 = value;
                          causeDeSignale = "cause 1";
                        });
                      },
                    ),
                    CheckboxListTile(
                      title: const Text('Case 2'),
                      value: this.valueCase2,
                      onChanged: (bool value) {
                        setState(() {
                          this.valueCase2 = value;
                          causeDeSignale = "cause 2";
                        });
                      },
                    ),
                    CheckboxListTile(
                      title: const Text('Case 3'),
                      value: this.valueCase3,
                      onChanged: (bool value) {
                        setState(() {
                          this.valueCase3 = value;
                          causeDeSignale = "cause 3";
                        });
                      },
                    ),
                    CheckboxListTile(
                      title: const Text('Case 4'),
                      value: this.valueCase4,
                      onChanged: (bool value) {
                        setState(() {
                          this.valueCase4 = value;
                          causeDeSignale = "cause 4";
                        });
                      },
                    ),
                    CheckboxListTile(
                      title: const Text('Autre'),
                      value: this.valueCaseAutre,
                      onChanged: (bool value) {
                        setState(() {
                          this.valueCaseAutre = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
              if (this.valueCaseAutre == true)
                Container(
                  padding: EdgeInsets.all(20),
                  child: TextField(
                    controller: CommentaireCaseAutre,
                    style: TextStyle(color: Color(0xFF000000)),
                    cursorColor: Color(0xFF9b9b9b),
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: "Entrer le cas",
                      hintStyle: TextStyle(
                          color: Color(0xFF9b9b9b),
                          fontSize: 15,
                          fontWeight: FontWeight.normal),
                    ),
                    maxLines: 6,
                  ),
                ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Flexible(
                      flex: 1,
                      child: Checkbox(
                        checkColor: Colors.greenAccent,
                        activeColor: Colors.red,
                        value: this.valueAccepter,
                        onChanged: (bool value) {
                          setState(() {
                            this.valueAccepter = value;
                          });
                        },
                      ),
                    ),
                    Flexible(
                      flex: 8,
                      child: Text(
                        'Je pense que cela va à l’encontre des Standards de la communauté Livraiosn GV App. ',
                        style: TextStyle(fontSize: 17.0),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                // ignore: deprecated_member_use
                child: FlatButton(
                  onPressed: () => _signalerLivreur(),
                  child: Padding(
                    padding:
                        EdgeInsets.only(top: 8, bottom: 8, left: 10, right: 10),
                    child: Text(
                      "Signaler",
                      textDirection: TextDirection.ltr,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  color: Colors.deepOrange,
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
