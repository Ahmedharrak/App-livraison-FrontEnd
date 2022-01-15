import 'dart:convert';
import 'dart:typed_data';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:livreurs_app/Controllers/userController.dart';
import 'dart:io';
import 'package:livreurs_app/views/Accueil/accueilLivreur.dart';
import 'package:livreurs_app/views/Login/loginScreen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/painting.dart';
import 'package:livreurs_app/const.dart' as Const;

class InscrireLivreur extends StatefulWidget {
  @override
  inscrireLivreurState createState() => inscrireLivreurState();
}

// ignore: camel_case_types
class inscrireLivreurState extends State<InscrireLivreur> {
  UserController userController = new UserController();
  TextEditingController _nomControllerl = new TextEditingController();
  TextEditingController _prenomControllerl = new TextEditingController();
  TextEditingController _cinControllerl = new TextEditingController();

  TextEditingController _adresseControllerl = new TextEditingController();
  TextEditingController _telephoneControllerl = new TextEditingController();
  TextEditingController _emailControllerl = new TextEditingController();
  TextEditingController _passwordControllerl = new TextEditingController();
  TextEditingController _immatriculationControllerl =
      new TextEditingController();
  TextEditingController _confirmerPasswordControllerl =
      new TextEditingController();
  bool valueLundi = false;
  bool valueMardi = false;
  bool valueMecredi = false;
  bool valueJeudi = false;
  bool valueVendredi = false;
  bool valueSamedi = false;
  bool valueDimanche = false;
  String dropdownTransport = "Tout";
  String dropdownVille = "Tout";
  File _imageCIN;
  File _imagePermis;
  File _imageGrise;
  bool _validateNom = false,
      _validatePrenom = false,
      _validateCIN = false,
      _validateTelephone = false,
      _validateEmail = false,
      _validatePassword = false;

////////////  pour Ajouter image du CIN soit avec caméra ou galerie  /////////////////
  _imageCINCamera() async {
    // ignore: deprecated_member_use
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);

    setState(() {
      _imageCIN = image;
    });
  }

  _imageCINGallery() async {
    // ignore: deprecated_member_use
    File image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);
    final bytes = image.readAsBytesSync();
    // ignore: unused_local_variable
    String _img64 = base64Encode(bytes);

    setState(() {
      _imageCIN = image;
    });
  }

  ////////////  pour Ajouter image du Permis soit avec caméra ou galerie  /////////////////
  _imagePermisCamera() async {
    // ignore: deprecated_member_use
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);

    setState(() {
      _imagePermis = image;
    });
  }

  _imagePermisGallery() async {
    // ignore: deprecated_member_use
    File image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _imagePermis = image;
    });
  }

  ////////////  pour Ajouter image du Grise soit avec caméra ou galerie  /////////////////
  _imageGriseCamera() async {
    // ignore: deprecated_member_use
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);

    setState(() {
      _imageGrise = image;
    });
  }

  _imageGriseGallery() async {
    // ignore: deprecated_member_use
    File image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _imageGrise = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.topRight,
                colors: [
                  Color(0xFFFFFFFF),
                  Color(0xFFFFFFFF),
                  Color(0xFFFFFFFF)
                ]),
          ),
          child: SingleChildScrollView(
            child: Stack(
              children: <Widget>[
                /////////////  background /////////////
                new Container(
                  decoration: new BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      stops: [0.0, 0.4, 0.9],
                      colors: [
                        Color(0xFFFFFFFF),
                        Color(0xFFFFFFFF),
                        Color(0xFFFFFFFF),
                      ],
                    ),
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

                              //////////////////// "Nom " /////////////
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
                                      controller: _nomControllerl,
                                      style:
                                          TextStyle(color: Color(0xFF000000)),
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

                              ///////////////////////// "Prenom" /////////////////
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
                                      controller: _prenomControllerl,
                                      style:
                                          TextStyle(color: Color(0xFF000000)),
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

                              /////////////////////////// "CIN" //////////////////
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

                                          //////Telecharger image CIN ////////
                                          Center(
                                            child: GestureDetector(
                                              onTap: () {
                                                _afficherImageCIN(context);
                                              },
                                              child: CircleAvatar(
                                                radius: 25,
                                                backgroundColor:
                                                    Color(0xffFDCF09),
                                                child: _imageCIN != null
                                                    ? ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(40),
                                                        child: Image.file(
                                                          _imageCIN,
                                                          width: 70,
                                                          height: 70,
                                                          fit: BoxFit.fitHeight,
                                                        ),
                                                      )
                                                    : Container(
                                                        decoration: BoxDecoration(
                                                            color: Colors
                                                                .grey[200],
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50)),
                                                        width: 70,
                                                        height: 70,
                                                        child: Icon(
                                                          Icons.image,
                                                          color:
                                                              Colors.grey[800],
                                                        ),
                                                      ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    TextField(
                                      controller: _cinControllerl,
                                      style:
                                          TextStyle(color: Color(0xFF000000)),
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

                              ///////////////////////// "Email" //////////////
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
                                      controller: _emailControllerl,
                                      style:
                                          TextStyle(color: Color(0xFF000000)),
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

                              /////////////////////// "Telephone" ///////////////
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
                                      controller: _telephoneControllerl,
                                      style:
                                          TextStyle(color: Color(0xFF000000)),
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

                              ////////////////////////// "Ville" ///////////////
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
                                      width: 200,
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
                                            color: Theme.of(context)
                                                .primaryColorDark,
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

                              ////////////////////// "Adresse" ///////////////
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
                                      controller: _adresseControllerl,
                                      style:
                                          TextStyle(color: Color(0xFF000000)),
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

                              ///////////////////// "mot de passe " //////////////
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
                                      controller: _passwordControllerl,
                                      style:
                                          TextStyle(color: Color(0xFF000000)),
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

                              ///////////// "Configuration de mot de passe " ////////
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
                                      controller: _confirmerPasswordControllerl,
                                      style:
                                          TextStyle(color: Color(0xFF000000)),
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

                              ///////// Column de Les jours des Services (L===> D)

                              Column(
                                children: <Widget>[
                                  ////// Text /////
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            'Sélectionnez les jours de la journée ',
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.orangeAccent,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 1,
                                  ),

                                  //////// Checkbox Lundi =======> Dimanche
                                  CheckboxListTile(
                                    title: const Text('Lundi'),
                                    value: this.valueLundi,
                                    onChanged: (bool value) {
                                      setState(() {
                                        this.valueLundi = value;
                                      });
                                    },
                                  ),
                                  CheckboxListTile(
                                    title: const Text('Mardi'),
                                    value: this.valueMardi,
                                    onChanged: (bool value) {
                                      setState(() {
                                        this.valueMardi = value;
                                      });
                                    },
                                  ),
                                  CheckboxListTile(
                                    title: const Text('Mecredi'),
                                    value: this.valueMecredi,
                                    onChanged: (bool value) {
                                      setState(() {
                                        this.valueMecredi = value;
                                      });
                                    },
                                  ),
                                  CheckboxListTile(
                                    title: const Text('Jeudi'),
                                    value: this.valueJeudi,
                                    onChanged: (bool value) {
                                      setState(() {
                                        this.valueJeudi = value;
                                      });
                                    },
                                  ),
                                  CheckboxListTile(
                                    title: const Text('Vendredi'),
                                    value: this.valueVendredi,
                                    onChanged: (bool value) {
                                      setState(() {
                                        this.valueVendredi = value;
                                      });
                                    },
                                  ),
                                  CheckboxListTile(
                                    title: const Text('Samedi'),
                                    value: this.valueSamedi,
                                    onChanged: (bool value) {
                                      setState(() {
                                        this.valueSamedi = value;
                                      });
                                    },
                                  ),
                                  CheckboxListTile(
                                    title: const Text('Dimanche'),
                                    value: this.valueDimanche,
                                    onChanged: (bool value) {
                                      setState(() {
                                        this.valueDimanche = value;
                                      });
                                    },
                                  ),
                                ],
                              ),

                              ///////////////////// Card (moyen transport + carte permis+ grise )////

                              Card(
                                elevation: 4.0,
                                color: Colors.orange[100],
                                margin:
                                    EdgeInsets.only(left: 5, right: 1, top: 15),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: <Widget>[
                                                  ////// Moyen transport
                                                  Container(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Text(
                                                          'Moyen de transport',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 200,
                                                    margin:
                                                        const EdgeInsets.only(
                                                            top: 10,
                                                            left: 10,
                                                            right: 10,
                                                            bottom: 10),
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10,
                                                            right: 10),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                        border: Border.all()),
                                                    child:
                                                        DropdownButtonHideUnderline(
                                                      child: DropdownButton<
                                                          String>(
                                                        value:
                                                            dropdownTransport,
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.black),
                                                        underline: Container(
                                                          height: 2,
                                                          color: Colors.black,
                                                        ),
                                                        onChanged:
                                                            (String newValue) {
                                                          setState(() {
                                                            dropdownTransport =
                                                                newValue;
                                                          });
                                                        },
                                                        items: Const
                                                            .moyensTransport
                                                            .map<
                                                                DropdownMenuItem<
                                                                    String>>((String
                                                                value) {
                                                          return DropdownMenuItem<
                                                              String>(
                                                            value: value,
                                                            child: Text(value),
                                                          );
                                                        }).toList(),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: <Widget>[
                                                  ////// Numero du matriculation
                                                  Container(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Text(
                                                          'Numéro du matriculation',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  TextField(
                                                    controller:
                                                        _immatriculationControllerl,
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xFF000000)),
                                                    cursorColor:
                                                        Color(0xFF9b9b9b),
                                                    keyboardType:
                                                        TextInputType.text,
                                                    decoration: InputDecoration(
                                                      hintText:
                                                          "Saisir votre matriculation ",
                                                      hintStyle: TextStyle(
                                                          color: Colors
                                                              .orange[400],
                                                          fontSize: 15,
                                                          fontWeight: FontWeight
                                                              .normal),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      /////////////////// Carte Permis ////////////
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: <Widget>[
                                                  /////// Text de carte Permis
                                                  Container(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Text(
                                                          'L\'image du Carte Permis    ',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10.0),
                                                    child: Center(
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          _afficherImagePermis(
                                                              context);
                                                        },
                                                        child: CircleAvatar(
                                                          radius: 25,
                                                          backgroundColor:
                                                              Color(0xffFDCF09),
                                                          child:
                                                              _imagePermis !=
                                                                      null
                                                                  ? ClipRRect(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              40),
                                                                      child: Image
                                                                          .file(
                                                                        _imagePermis,
                                                                        width:
                                                                            70,
                                                                        height:
                                                                            70,
                                                                        fit: BoxFit
                                                                            .fitHeight,
                                                                      ),
                                                                    )
                                                                  : Container(
                                                                      decoration: BoxDecoration(
                                                                          color: Colors.orange[
                                                                              200],
                                                                          borderRadius:
                                                                              BorderRadius.circular(50)),
                                                                      width: 70,
                                                                      height:
                                                                          70,
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .image,
                                                                        color: Colors
                                                                            .grey[800],
                                                                      ),
                                                                    ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      ////////////// Carte grise /////////////////
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: <Widget>[
                                                  Container(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Text(
                                                          'L\'image du Carte Grise        ',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  //// Telecharger image de grise //////
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.all(5),
                                                    child: Center(
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          _afficherImageGrise(
                                                              context);
                                                        },
                                                        child: CircleAvatar(
                                                          radius: 25,
                                                          backgroundColor:
                                                              Color(0xffFDCF09),
                                                          child:
                                                              _imageGrise !=
                                                                      null
                                                                  ? ClipRRect(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              40),
                                                                      child: Image
                                                                          .file(
                                                                        _imageGrise,
                                                                        width:
                                                                            70,
                                                                        height:
                                                                            70,
                                                                        fit: BoxFit
                                                                            .fitHeight,
                                                                      ),
                                                                    )
                                                                  : Container(
                                                                      decoration: BoxDecoration(
                                                                          color: Colors.orange[
                                                                              200],
                                                                          borderRadius:
                                                                              BorderRadius.circular(50)),
                                                                      width: 70,
                                                                      height:
                                                                          70,
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .image,
                                                                        color: Colors
                                                                            .grey[800],
                                                                      ),
                                                                    ),
                                                        ),
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

                              //////////// Button "Inscrire" //////////
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                // ignore: deprecated_member_use
                                child: FlatButton(
                                  onPressed: () => _onPressedLivreur(),
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

                        /////////////// Botton "se connecter" ////////////
                        Padding(
                          padding: const EdgeInsets.only(top: 20, bottom: 40),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (context) => LogIn()));
                            },
                            child: Text(
                              'Vous avez déjà un compte',
                              textDirection: TextDirection.ltr,
                              style: TextStyle(
                                color: Colors.white,
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
      ),
    );
  }

///// Fonction pour naviguer a page livreur accueil
  _onPressedLivreur() async {
    /////// si la valeur du nom/prenom/email/telephone/cin/mot de passe est vide //////
    setState(() {
      _emailControllerl.text.isEmpty
          ? _validateEmail = true
          : _validateEmail = false;
      _nomControllerl.text.isEmpty ? _validateNom = true : _validateNom = false;
      _prenomControllerl.text.isEmpty
          ? _validatePrenom = true
          : _validatePrenom = false;
      _telephoneControllerl.text.isEmpty
          ? _validateTelephone = true
          : _validateTelephone = false;
      _cinControllerl.text.isEmpty ? _validateCIN = true : _validateCIN = false;
      _passwordControllerl.text.isEmpty
          ? _validatePassword = true
          : _validatePassword = false;
    });
    /////// si la valeur du ville a égale a tout /////////
    if (dropdownVille == "Tout") {
      _showDialog("Saisir votre ville!");
    }
    /////// si la valeur du moyen du transport a égale a tout /////////
    if (dropdownTransport == "Tout") {
      _showDialog("Saisir votre transport!");
    }
    /////// region du ville ///////
    final queryA = dropdownVille;
    var addressesA = await Geocoder.local.findAddressesFromQuery(queryA);
    var region = addressesA.first.adminArea;
    /////// la valeur du image profile en form string 64 par défault //////////////
    String _imgProfile64 = Const.imageProfileLivreur;
    /////// pour ajouter les image en forme String 64 dans base de données ///////
    Uint8List _bytesImageCIN;
    Uint8List _bytesImagePermis;
    Uint8List _bytesImageGrise;
    String _imgCIN64, _imgPermis64, _imgGrise64;
    if (_imageCIN != null) {
      _bytesImageCIN = _imageCIN.readAsBytesSync();
      _imgCIN64 = base64Encode(_bytesImageCIN);
    }
    if (_imagePermis != null) {
      _bytesImagePermis = _imagePermis.readAsBytesSync();
      _imgPermis64 = base64Encode(_bytesImagePermis);
    }
    if (_imageGrise != null) {
      _bytesImageGrise = _imageGrise.readAsBytesSync();
      _imgGrise64 = base64Encode(_bytesImageGrise);
    }
    //////// si mot de passe n'est pas égale du confirmation du mot de passe //////
    if (_passwordControllerl.text.trim() !=
        _confirmerPasswordControllerl.text.trim()) {
      _showDialog(
          "Le mot de passe doit etre egale le mot de passe de confirmation!");
    } else {
      userController
          .inscrireLivreur(
        _nomControllerl.text.trim(),
        _prenomControllerl.text.trim(),
        _telephoneControllerl.text.trim(),
        _emailControllerl.text.trim(),
        _cinControllerl.text.trim(),
        dropdownVille,
        _adresseControllerl.text.trim(),
        region,
        _passwordControllerl.text.trim(),
        _imgCIN64,
        _immatriculationControllerl.text.trim(),
        dropdownTransport,
        _imgPermis64,
        _imgGrise64,
        _imgProfile64,
        valueLundi,
        valueMardi,
        valueMecredi,
        valueJeudi,
        valueVendredi,
        valueSamedi,
        valueDimanche,
      )
          .whenComplete(() {
        /////// si une erreur d'inscrire livreur (par exemple email déja exist ou numéro du telephone n'est pas validé)
        if (userController.status) {
          _showDialog("Entrer les informations corrects!");
        } else {
          print("Vous avez créé votre compte avec succès");
          Navigator.push(context,
              new MaterialPageRoute(builder: (context) => AccueilLivreur()));
        }
      });
    }
  }

  //// Fonction qui afficher le message d'erreur //////
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

  /////// fonction pour afficher les button galerie et caméra pour ajouter une image du CIN /////
  void _afficherImageCIN(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Galerie de photos'),
                      onTap: () {
                        _imageCINGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Caméra'),
                    onTap: () {
                      _imageCINCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  /////// fonction pour afficher les button galerie et caméra pour ajouter une image Permis/////
  void _afficherImagePermis(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Galerie de photos'),
                      onTap: () {
                        _imagePermisGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Caméra'),
                    onTap: () {
                      _imagePermisCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  /////// fonction pour afficher les button galerie et caméra pour ajouter une image Grise/////
  void _afficherImageGrise(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Galerie de photos'),
                      onTap: () {
                        _imageGriseGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Caméra'),
                    onTap: () {
                      _imageGriseCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
}
