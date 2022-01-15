import 'package:flutter/material.dart';
import 'package:livreurs_app/views/Accueil/accueilClient.dart';

/// This Widget is the main application widget.
class AProposClient extends StatefulWidget {
  @override
  _AProposClientState createState() => _AProposClientState();
}

class _AProposClientState extends State<AProposClient> {
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
                        'A propos',
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ////// Titre du Page  //////

              Container(
                margin: const EdgeInsets.all(20),
                child: Text(
                  "Qui sommes-nous ?",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),

              Container(
                margin: const EdgeInsets.all(10),
                child: new Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ////// Contenu du Page  //////

                    Expanded(
                      flex: 1,
                      child: Container(
                        child: Text(
                          "Livraison GV – Une marque du groupe Livraison GV MarocGroupe Marocanais spécialisé aujourd'hui dans la livraison de colis. Dans un secteur de la distribution postale quasi monopolisé par les postes nationales historiques, IMX a su s'imposer depuis plus de 20 ans comme un distributeur postal mondial de qualité."
                          "   Le groupe, s'est développé sur 4 segments de marché principaux : la presse, le marketing direct, le courrier de gestion et bien sûr le colis. Doté de l'unique centre de tri international indépendant en Maroc, Livraison GV bénéficie d'un réseau de distribution international et d'une organisation logistique permettant d'offrir des services compétitifs et de qualité.",
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ]),
      ),
    );
  }
}
