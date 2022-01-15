import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:livreurs_app/Controllers/clientController.dart';
import 'package:livreurs_app/views/Accueil/accueilClient.dart';
import 'Modifier/modifierProfileClient.dart';
import 'package:livreurs_app/const.dart' as Const;

/// This Widget is the main application widget.
class ProfileClient extends StatefulWidget {
  @override
  _ProfileClientState createState() => _ProfileClientState();
}

class _ProfileClientState extends State<ProfileClient> {
  @override
  void initState() {
    super.initState();
  }

  ClientController clientController = new ClientController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: clientController.obtenirInformationClient(),
        builder: (context, AsyncSnapshot clientSnapshot) {
          if (clientSnapshot.hasData) {
            Uint8List _bytesImage;

            String _imgProfileString = '${clientSnapshot.data['imageProfile']}';

            _bytesImage = Base64Decoder().convert(_imgProfileString);

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
                          MaterialPageRoute(
                              builder: (context) => AccueilClient()),
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
                              margin: EdgeInsets.all(5.0),
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                ' Profil personnel',
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
                child: SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            ////// Image de Profile //////
                            Container(
                              padding: const EdgeInsets.all(30),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage("assets/back1.jpg"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Center(
                                child: Container(
                                  child: ClipOval(
                                    child: Image.memory(
                                      _bytesImage,
                                      fit: BoxFit.cover,
                                      width: 150,
                                      height: 150,
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            //////// Nom Prenom CIN ////////////
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    padding:
                                        const EdgeInsets.only(top: 3, left: 3),
                                    child: Text(
                                        "${clientSnapshot.data['prenom']} ${clientSnapshot.data['nom']}",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        )),
                                  ),
                                  ////// Note //////
                                  Center(
                                    child: Container(
                                      margin: const EdgeInsets.all(3),
                                      width: 110,
                                      height: 40,
                                      child: Card(
                                        shape: StadiumBorder(
                                          side: BorderSide(
                                            color: Colors.black,
                                            width: 2.0,
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  left: 5, right: 5),
                                              child: RatingBarIndicator(
                                                //rating: 2.25,
                                                rating: clientSnapshot
                                                    .data['noteTotal']
                                                    .toDouble(),
                                                itemBuilder: (context, index) =>
                                                    Icon(
                                                  Icons.star,
                                                  color: Colors.amber,
                                                ),
                                                itemCount: 5,
                                                itemSize: 15.0,
                                                direction: Axis.horizontal,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ]),

                            //////////// Note,Nombre du Laivraison,Nombre du Signale ///////////////
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  ////// photos Nombre laivraison ///////////
                                  Container(
                                    child: Card(
                                      shape: StadiumBorder(
                                        side: BorderSide(
                                          color: Colors.black,
                                          width: 2.0,
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            padding: const EdgeInsets.all(5),
                                            child: ClipOval(
                                              child: Image.asset(
                                                "assets/livraison.png",
                                                height: 30,
                                                width: 30,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.all(5),
                                            child: Text(" : ",
                                                style: TextStyle(
                                                  color: Colors.orange,
                                                  fontWeight: FontWeight.bold,
                                                )),
                                          ),

                                          /////// Nombre du Laivraison ////////////

                                          Container(
                                            padding: const EdgeInsets.all(5),
                                            child: Text(
                                                "${clientSnapshot.data['nombreLivraisons']}",
                                                style: TextStyle(
                                                  color: Colors.orange,
                                                  fontWeight: FontWeight.bold,
                                                )),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: Card(
                                      shape: StadiumBorder(
                                        side: BorderSide(
                                          color: Colors.black,
                                          width: 2.0,
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          /////// photo nombre signal /////////////

                                          Container(
                                            padding: const EdgeInsets.all(5),
                                            child: ClipOval(
                                              child: Image.asset(
                                                "assets/dislike.png",
                                                height: 30,
                                                width: 30,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.all(5),
                                            child: Text(" : ",
                                                style: TextStyle(
                                                  color: Colors.orange,
                                                  fontWeight: FontWeight.bold,
                                                )),
                                          ),
                                          ////////// Nombre du Signal //////////////

                                          Container(
                                            padding: const EdgeInsets.all(5),
                                            child: Text(
                                                "${clientSnapshot.data['nombreSignale']}",
                                                style: TextStyle(
                                                  color: Colors.orange,
                                                  fontWeight: FontWeight.bold,
                                                )),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ]),
                          ],
                        ),

                        //////// Partie de Profile Detail ///////////
                        Container(
                          decoration:
                              new BoxDecoration(color: Colors.orange[200]),
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              //////
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Container(
                                    child: ClipOval(
                                      child: InkWell(
                                        child: Image.asset(
                                          "assets/update.png",
                                          height: 30,
                                          width: 30,
                                          fit: BoxFit.cover,
                                          color: Colors.orange[800],
                                        ),
                                        onTap: modifierProfileClient,
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              ////// Text Profile Details //////
                              Container(
                                margin:
                                    const EdgeInsets.only(left: 10, bottom: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      child: Text(
                                        'Profil Détails',
                                        style: new TextStyle(
                                          fontSize: 20.0,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              /////// CIN ////////
                              Container(
                                padding:
                                    const EdgeInsets.only(left: 5, bottom: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      "assets/CINlogo2.png",
                                      height: 20,
                                      width: 20,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(5),
                                      child: Text(
                                        "${clientSnapshot.data['numeroCIN']}",
                                        style: new TextStyle(
                                          fontSize: 15.0,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              ///// Adresse //////////
                              Container(
                                padding:
                                    const EdgeInsets.only(left: 5, bottom: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      "assets/adresse.png",
                                      height: 25,
                                      width: 25,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(2),
                                      child: Text(
                                        "${clientSnapshot.data['adresse']}",
                                        style: new TextStyle(
                                          fontSize: 15.0,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              ////// Ville /////////
                              Container(
                                padding:
                                    const EdgeInsets.only(left: 5, bottom: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(Icons.location_city),
                                    new Text(
                                      "${clientSnapshot.data['ville']}",
                                      style: new TextStyle(
                                        fontSize: 15.0,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              /////// Email ////////////////
                              Container(
                                padding:
                                    const EdgeInsets.only(left: 5, bottom: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(Icons.email),
                                    Container(
                                      padding: const EdgeInsets.all(5),
                                      child: Text(
                                        "${clientSnapshot.data['email']}",
                                        style: new TextStyle(
                                          fontSize: 15.0,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              ///// Telephone /////
                              Container(
                                padding:
                                    const EdgeInsets.only(left: 5, bottom: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(Icons.phone),
                                    Container(
                                      padding: const EdgeInsets.all(5),
                                      child: Text(
                                        "${Const.telephone}",
                                        style: new TextStyle(
                                          fontSize: 15.0,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else
            return Container(
              width: 0.0,
              height: 0.0,
              color: Colors.white,
            );
        });
  }

  void modifierProfileClient() {
    Navigator.push(context,
        new MaterialPageRoute(builder: (context) => ModifierProfileClient()));
  }
}
