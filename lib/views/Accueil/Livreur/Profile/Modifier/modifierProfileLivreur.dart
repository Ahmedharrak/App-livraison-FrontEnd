import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:geocoder/geocoder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:livreurs_app/const.dart' as Const;
import 'package:dropdown_search/dropdown_search.dart';
import 'package:image_picker/image_picker.dart';
import 'package:livreurs_app/Controllers/livreurController.dart';
import 'package:livreurs_app/Controllers/userController.dart';
import 'package:livreurs_app/views/Accueil/Livreur/Profile/ModifierPass/modifierMotPassLivreur.dart';
import 'package:livreurs_app/views/Accueil/Livreur/Profile/profileLivreur.dart';
import 'package:livreurs_app/views/Accueil/accueilLivreur.dart';
import 'package:flutter/painting.dart';

/// This Widget is the main application widget.
// ignore: must_be_immutable
class ModifierProfileLivreur extends StatefulWidget {
  int i;
  @override
  _ModifierProfileLivreurState createState() =>
      _ModifierProfileLivreurState(this.i);
}

class _ModifierProfileLivreurState extends State<ModifierProfileLivreur> {
  int i;
  _ModifierProfileLivreurState(i);
  UserController userController = new UserController();
  LivreurController livreurController = new LivreurController();
  TextEditingController nomControllerc = new TextEditingController();
  TextEditingController prenomControllerc = new TextEditingController();
  TextEditingController cinControllerc = new TextEditingController();
  TextEditingController adresseControllerc = new TextEditingController();
  TextEditingController immatriculationController = new TextEditingController();
  TextEditingController telephoneControllerc = new TextEditingController();
  File _imageProfile;
  File _imageCIN;
  File _imagePermis;
  File _imageGrise;
  bool valueLundi;
  bool valueMardi;
  bool valueMecredi;
  bool valueJeudi;
  bool valueVendredi;
  bool valueSamedi;
  bool valueDimanche;
  String dropdownVille;
  String dropdownTransport;
  bool _validateNom = false,
      _validatePrenom = false,
      _validateCIN = false,
      _validateTelephone = false;

  //////////// Fonction pour telecharger l' images du Profile soit avec caméra ou calerie  /////////////////
  _imageProfileCamera() async {
    // ignore: deprecated_member_use
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);

    setState(() {
      _imageProfile = image;
    });
  }

  _imageProfileGallery() async {
    // ignore: deprecated_member_use
    File image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _imageProfile = image;
    });
  }

  ////////////  pour Ajouter image du CIN soit avec caméra ou calerie  /////////////////
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

    setState(() {
      _imageCIN = image;
    });
  }

  ////////////  pour Ajouter image du Permis  soit avec caméra ou calerie  /////////////////

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

  ////////////  pour Ajouter image du Grise  soit avec caméra ou calerie /////////////////
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

  /////// Body /////
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: livreurController.obtenirInformationLivreur(),
        builder: (context, AsyncSnapshot livreurSnapshot) {
          if (livreurSnapshot.hasData) {
            if (i != 1) {
              this.valueLundi = livreurSnapshot.data['joursDeService']['lundi'];
              this.valueMardi = livreurSnapshot.data['joursDeService']['mardi'];
              this.valueMecredi =
                  livreurSnapshot.data['joursDeService']['mercredi'];
              this.valueJeudi = livreurSnapshot.data['joursDeService']['jeudi'];
              this.valueVendredi =
                  livreurSnapshot.data['joursDeService']['vendredi'];
              this.valueSamedi =
                  livreurSnapshot.data['joursDeService']['samedi'];
              this.valueDimanche =
                  livreurSnapshot.data['joursDeService']['dimanche'];
              this.dropdownTransport =
                  livreurSnapshot.data['moyenTransport'][0]['type'];
              this.dropdownVille = livreurSnapshot.data['ville'];
              this.nomControllerc.text = livreurSnapshot.data['nom'];
              this.prenomControllerc.text = livreurSnapshot.data['prenom'];
              this.cinControllerc.text = livreurSnapshot.data['numeroCIN'];
              this.adresseControllerc.text = livreurSnapshot.data['adresse'];
              this.telephoneControllerc.text =
                  livreurSnapshot.data['telephone'];
              this.immatriculationController.text =
                  livreurSnapshot.data['moyenTransport'][0]['immatriculation'];
            }

            //////// Afficher Image Profile a partir base donnees ///////
            Uint8List _bytesImage;
            String _imgProfileString =
                '${livreurSnapshot.data['imageProfile']}';
            _bytesImage = Base64Decoder().convert(_imgProfileString);
            //////// Afficher Image CIN a partir base donnees ///////
            Uint8List _bytesImageCIN;
            String _imageCINString = '${livreurSnapshot.data['imageCIN']}';
            _bytesImageCIN = Base64Decoder().convert(_imageCINString);
            //////// Afficher Image Permis a partir base donnees ///////
            Uint8List _bytesImagePermis;
            String _imagePermisString =
                '${livreurSnapshot.data['moyenTransport'][0]['imagePermis']}';
            _bytesImagePermis = Base64Decoder().convert(_imagePermisString);
            //////// Afficher Image Grise a partir base donnees ///////
            Uint8List _bytesImageGrise;
            String _imageGriseString =
                '${livreurSnapshot.data['moyenTransport'][0]['imageCarteGrise']}';
            _bytesImageGrise = Base64Decoder().convert(_imageGriseString);
            /////// valeur de Nom,Prenom,CIN,adresse,telephone,immatriculation //////

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
                              builder: (context) => AccueilLivreur()),
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
                                'Modifier le profile',
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
                    //////// Button Annuler et Terminer //////////

                    Container(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                            ////// Button Annuler /////

                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                InkWell(
                                  onTap: () {},
                                  child: Text(
                                    'Annuler',
                                    textDirection: TextDirection.ltr,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15.0,
                                      decoration: TextDecoration.none,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            ////// Titre du Page "Modifier le compte" ////

                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                InkWell(
                                  onTap: () {},
                                  child: Text(
                                    'Modifier le compte',
                                    textDirection: TextDirection.ltr,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 17.0,
                                      decoration: TextDecoration.none,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          /////// Button Terminer ////////
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                InkWell(
                                  //////// Fonction pour modifier les données du livreur /////////
                                  onTap: () async {
                                    /////// si la valeur du nom/prenom/email/telephone/cin/mot de passe est vide //////
                                    setState(() {
                                      nomControllerc.text.isEmpty
                                          ? _validateNom = true
                                          : _validateNom = false;
                                      prenomControllerc.text.isEmpty
                                          ? _validatePrenom = true
                                          : _validatePrenom = false;
                                      telephoneControllerc.text.isEmpty
                                          ? _validateTelephone = true
                                          : _validateTelephone = false;
                                      cinControllerc.text.isEmpty
                                          ? _validateCIN = true
                                          : _validateCIN = false;
                                    });
                                    /////// pour ajouter les image en forme String 64 dans base de données ///////
                                    if (_imageProfile != null)
                                      _bytesImage =
                                          _imageProfile.readAsBytesSync();
                                    String _imgProfile64 =
                                        base64Encode(_bytesImage);
                                    if (_imageCIN != null)
                                      _bytesImageCIN =
                                          _imageCIN.readAsBytesSync();
                                    String _imgCIN64 =
                                        base64Encode(_bytesImageCIN);
                                    if (_imagePermis != null)
                                      _bytesImagePermis =
                                          _imagePermis.readAsBytesSync();
                                    String _imgPermis64 =
                                        base64Encode(_bytesImagePermis);
                                    if (_imageGrise != null)
                                      _bytesImageGrise =
                                          _imageGrise.readAsBytesSync();
                                    String _imgGrise64 =
                                        base64Encode(_bytesImageGrise);

                                    /////// si la valeur du ville a égale a tout /////////
                                    if (dropdownVille == "Tout") {
                                      _showDialog("Saisir votre ville!");
                                    }
                                    /////// si la valeur du moyen du transport a égale a tout /////////
                                    if (dropdownTransport == "Tout") {
                                      _showDialog(
                                          "Saisir votre moyen du transport!");
                                    }
                                    //////// region du livreur //////
                                    final queryA = dropdownVille;
                                    var addressesA = await Geocoder.local
                                        .findAddressesFromQuery(queryA);
                                    var region = addressesA.first.adminArea;

                                    userController
                                        .modifierLivreur(
                                            Const.idUser,
                                            nomControllerc.text.trim(),
                                            prenomControllerc.text.trim(),
                                            cinControllerc.text.trim(),
                                            dropdownVille,
                                            adresseControllerc.text.trim(),
                                            region,
                                            telephoneControllerc.text.trim(),
                                            valueLundi.toString(),
                                            valueMardi.toString(),
                                            valueMecredi.toString(),
                                            valueJeudi.toString(),
                                            valueVendredi.toString(),
                                            valueSamedi.toString(),
                                            valueDimanche.toString(),
                                            _imgProfile64,
                                            _imgCIN64,
                                            dropdownTransport,
                                            immatriculationController.text
                                                .trim(),
                                            _imgPermis64,
                                            _imgGrise64)
                                        .whenComplete(() {
                                      if (userController.status) {
                                        _showDialog(
                                            "Entrer les informations corrects!");
                                      } else {
                                        // Navigator.pop(context);
                                        // Navigator.pop(context);
                                        Navigator.push(
                                            context,
                                            new MaterialPageRoute(
                                                builder: (context) =>
                                                    ProfileLivreur()));
                                      }
                                    });
                                  },
                                  child: Text(
                                    'Terminer',
                                    textDirection: TextDirection.ltr,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15.0,
                                      decoration: TextDecoration.none,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    ///////// Charger image profile //////////////
                    Container(
                      margin: const EdgeInsets.all(20),
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          ////// Photos Profile ///////

                          Container(
                            child: Center(
                              child: GestureDetector(
                                onTap: () {
                                  _afficherImageProfile(context);
                                },
                                child: CircleAvatar(
                                  radius: 70,
                                  backgroundColor: Colors.white,
                                  child: _imageProfile != null
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          child: Image.file(
                                            _imageProfile,
                                            width: 150,
                                            height: 150,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : Container(
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
                            ),
                          ),

                          ////// Text "Changer la photo profile" ///////

                          Container(
                            margin: const EdgeInsets.all(5),
                            child: InkWell(
                              onTap: () {
                                _afficherImageProfile(context);
                              },
                              child: Text(
                                "Changer la photo profile",
                                textDirection: TextDirection.ltr,
                                style: TextStyle(
                                  color: Colors.orange,
                                  fontSize: 17.0,
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    ////////////// Form du Modification //////////////
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          ////// Nom ///////////

                          Container(
                            padding: const EdgeInsets.all(5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Nom',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(5),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                TextField(
                                  onChanged: (value) {
                                    setState(() {
                                      nomControllerc.text = value;
                                      this.i = 1;
                                    });
                                  },
                                  controller: nomControllerc,
                                  style: TextStyle(color: Color(0xFF000000)),
                                  decoration: InputDecoration(
                                    hintText: "${livreurSnapshot.data['nom']}",
                                    errorText: _validateNom
                                        ? 'La valeur de nom ne peut pas être vide'
                                        : null,
                                    filled: true,
                                    fillColor: Colors.white,
                                    contentPadding: const EdgeInsets.only(
                                        left: 14.0, bottom: 8.0, top: 8.0),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                      borderRadius: BorderRadius.circular(25.7),
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(25.7),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          ////////Prenom ////////////

                          Container(
                            padding: const EdgeInsets.all(5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Prénom',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(5),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                TextField(
                                  controller: prenomControllerc,
                                  onChanged: (value) {
                                    setState(() {
                                      prenomControllerc.text = value;
                                      this.i = 1;
                                    });
                                  },
                                  style: TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
                                    hintText:
                                        "${livreurSnapshot.data['prenom']}",
                                    errorText: _validatePrenom
                                        ? 'La valeur de prénom ne peut pas être vide'
                                        : null,
                                    filled: true,
                                    fillColor: Colors.white,
                                    contentPadding: const EdgeInsets.only(
                                        left: 14.0, bottom: 8.0, top: 8.0),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                      borderRadius: BorderRadius.circular(25.7),
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(25.7),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          ////// Adresse ///////////

                          Container(
                            padding: const EdgeInsets.all(5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Adresse',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(5),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                TextField(
                                  controller: adresseControllerc,
                                  onChanged: (value) {
                                    setState(() {
                                      adresseControllerc.text = value;
                                      this.i = 1;
                                    });
                                  },
                                  style: TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
                                    hintText:
                                        "${livreurSnapshot.data['adresse']}",
                                    filled: true,
                                    fillColor: Colors.white,
                                    contentPadding: const EdgeInsets.only(
                                        left: 14.0, bottom: 8.0, top: 8.0),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                      borderRadius: BorderRadius.circular(25.7),
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(25.7),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          ////// Telephone ///////////
                          Container(
                            padding: const EdgeInsets.all(5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Telephone',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(5),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                TextField(
                                  controller: telephoneControllerc,
                                  onChanged: (value) {
                                    setState(() {
                                      telephoneControllerc.text = value;
                                      this.i = 1;
                                    });
                                  },
                                  style: TextStyle(color: Color(0xFF000000)),
                                  decoration: InputDecoration(
                                    errorText: _validateTelephone
                                        ? 'La valeur de numéro du téléphone ne peut pas être vide'
                                        : null,
                                    filled: true,
                                    fillColor: Colors.white,
                                    contentPadding: const EdgeInsets.only(
                                        left: 14.0, bottom: 8.0, top: 8.0),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                      borderRadius: BorderRadius.circular(25.7),
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(25.7),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ///// CIN + image CIN ////////////

                          //////// Ajouter numero du CIN ///////////
                          Container(
                            padding: const EdgeInsets.all(5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Flexible(
                                  flex: 1,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            '   CIN',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      TextField(
                                        controller: cinControllerc,
                                        onChanged: (value) {
                                          setState(() {
                                            cinControllerc.text = value;
                                            this.i = 1;
                                          });
                                        },
                                        style: TextStyle(color: Colors.black),
                                        decoration: InputDecoration(
                                          hintText:
                                              "${livreurSnapshot.data['numeroCIN']}",
                                          errorText: _validateCIN
                                              ? 'La valeur de CIN ne peut pas être vide'
                                              : null,
                                          filled: true,
                                          fillColor: Colors.white,
                                          contentPadding: const EdgeInsets.only(
                                              left: 14.0,
                                              bottom: 8.0,
                                              top: 8.0),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.black),
                                            borderRadius:
                                                BorderRadius.circular(25.7),
                                          ),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.white),
                                            borderRadius:
                                                BorderRadius.circular(25.7),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                ///////////////// Telecharger image CIN //////////////////
                                Flexible(
                                  flex: 1,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            '',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      Center(
                                        child: GestureDetector(
                                          onTap: () {
                                            _afficherImageCIN(context);
                                          },
                                          child: CircleAvatar(
                                            radius: 25,
                                            backgroundColor: Color(0xffFDCF09),
                                            child: _imageCIN != null
                                                ? ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            40),
                                                    child: Image.file(
                                                      _imageCIN,
                                                      width: 70,
                                                      height: 70,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  )
                                                : Container(
                                                    decoration: BoxDecoration(
                                                        color: Colors.grey[200],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50)),
                                                    width: 70,
                                                    height: 70,
                                                    child: livreurSnapshot.data[
                                                                'imageCIN'] !=
                                                            null
                                                        ? ClipOval(
                                                            child: Image.memory(
                                                              _bytesImageCIN,
                                                              width: 70,
                                                              height: 70,
                                                              fit: BoxFit.cover,
                                                            ),
                                                          )
                                                        : ClipOval(
                                                            child: Image.asset(
                                                              "assets/NoMoyenDeTransport.jpg",
                                                              width: 70,
                                                              height: 70,
                                                              fit: BoxFit.cover,
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

                          ////// Ville ///////
                          Container(
                            padding: const EdgeInsets.all(5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  '   Ville',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  width: 300,
                                  child: DropdownSearch<String>(
                                    mode: Mode.BOTTOM_SHEET,
                                    items: Const.villes,
                                    onChanged: (value) {
                                      setState(() {
                                        dropdownVille = value;
                                        this.i = 1;
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
                        ],
                      ),
                    ),

                    /////// Jour du Travail ///////////////////////

                    Container(
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Text(
                                  "Jours du Travailler : ",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Column(
                              children: [
                                //////// Checkbox Lundi =======> Dimanche
                                CheckboxListTile(
                                  activeColor: Colors.orange,
                                  title: const Text('Lundi'),
                                  value: this.valueLundi,
                                  onChanged: (bool value) {
                                    setState(() {
                                      this.valueLundi = value;
                                      this.i = 1;
                                    });
                                  },
                                ),
                                CheckboxListTile(
                                  activeColor: Colors.orange,
                                  title: const Text('Mardi'),
                                  value: this.valueMardi,
                                  onChanged: (bool value) {
                                    setState(() {
                                      this.valueMardi = value;
                                      this.i = 1;
                                    });
                                  },
                                ),
                                CheckboxListTile(
                                  activeColor: Colors.orange,
                                  title: const Text('Mecredi'),
                                  value: this.valueMecredi,
                                  onChanged: (bool value) {
                                    setState(() {
                                      this.valueMecredi = value;
                                      this.i = 1;
                                    });
                                  },
                                ),
                                CheckboxListTile(
                                  activeColor: Colors.orange,
                                  title: const Text('Jeudi'),
                                  value: this.valueJeudi,
                                  onChanged: (bool value) {
                                    setState(() {
                                      this.valueJeudi = value;
                                      this.i = 1;
                                    });
                                  },
                                ),
                                CheckboxListTile(
                                  activeColor: Colors.orange,
                                  title: const Text('Vendredi'),
                                  value: this.valueVendredi,
                                  onChanged: (bool value) {
                                    setState(() {
                                      this.valueVendredi = value;
                                      this.i = 1;
                                    });
                                  },
                                ),
                                CheckboxListTile(
                                  activeColor: Colors.orange,
                                  title: const Text('Samedi'),
                                  value: this.valueSamedi,
                                  onChanged: (bool value) {
                                    setState(() {
                                      this.valueSamedi = value;
                                      this.i = 1;
                                    });
                                  },
                                ),
                                CheckboxListTile(
                                  activeColor: Colors.orange,
                                  title: const Text('Dimanche'),
                                  value: this.valueDimanche,
                                  onChanged: (bool value) {
                                    setState(() {
                                      this.valueDimanche = value;
                                      this.i = 1;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    ////// Horizontal divider ///////

                    Container(
                      padding: const EdgeInsets.all(10),
                      child: Divider(),
                    ),

                    ///////////////////// Card (moyen transport + carte permis+ grise )////

                    Card(
                      elevation: 4.0,
                      color: Colors.orange[100],
                      margin: EdgeInsets.only(left: 5, right: 1, top: 15),
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
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        ////// Moyen transport
                                        Container(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                'Moyen de transport',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(10),
                                          width: 300,
                                          child: DropdownSearch<String>(
                                            mode: Mode.BOTTOM_SHEET,
                                            items: Const.moyensTransport,
                                            onChanged: (value) {
                                              setState(() {
                                                dropdownTransport = value;
                                                this.i = 1;
                                              });
                                            },
                                            selectedItem: dropdownTransport,
                                            showSearchBox: true,
                                            searchBoxDecoration:
                                                InputDecoration(
                                              border: OutlineInputBorder(),
                                              contentPadding:
                                                  EdgeInsets.fromLTRB(
                                                      12, 12, 8, 0),
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
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        ////// Numero du matriculation
                                        Container(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                'Numéro du matriculation',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                        TextField(
                                          controller: immatriculationController,
                                          onChanged: (value) {
                                            setState(() {
                                              immatriculationController.text =
                                                  value;
                                              this.i = 1;
                                            });
                                          },
                                          style: TextStyle(
                                              color: Color(0xFF000000)),
                                          cursorColor: Color(0xFF9b9b9b),
                                          keyboardType: TextInputType.text,
                                          decoration: InputDecoration(
                                            hintText:
                                                "Saisir votre matriculation ",
                                            hintStyle: TextStyle(
                                                color: Colors.orange[400],
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
                            Container(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    child: Column(
                                      children: [
                                        ///// Permis + image Permis ////////////

                                        Text(
                                          'Permis',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        ///////////////// Telecharger image Permis //////////////////
                                        Text(
                                          '',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),

                                        Center(
                                          child: GestureDetector(
                                            onTap: () {
                                              _afficherImagePermis(context);
                                            },
                                            child: CircleAvatar(
                                              radius: 25,
                                              backgroundColor:
                                                  Color(0xffFDCF09),
                                              child: _imagePermis != null
                                                  ? ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              40),
                                                      child: Image.file(
                                                        _imagePermis,
                                                        width: 70,
                                                        height: 70,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    )
                                                  : Container(
                                                      decoration: BoxDecoration(
                                                          color:
                                                              Colors.grey[200],
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      50)),
                                                      width: 70,
                                                      height: 70,
                                                      child: livreurSnapshot
                                                                          .data[
                                                                      'moyenTransport'][0]
                                                                  [
                                                                  'imagePermis'] !=
                                                              null
                                                          ? ClipOval(
                                                              child:
                                                                  Image.memory(
                                                                _bytesImagePermis,
                                                                width: 70,
                                                                height: 70,
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                            )
                                                          : ClipOval(
                                                              child:
                                                                  Image.asset(
                                                                "assets/NoMoyenDeTransport.jpg",
                                                                width: 70,
                                                                height: 70,
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                            ),
                                                    ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(
                                        left: 100, top: 5),
                                    child: Column(
                                      children: [
                                        ///// carte grise + image carte grise ////////////

                                        Text(
                                          'Carte Grise',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        ///////////////// Telecharger image carte grise //////////////////

                                        Text(
                                          '',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),

                                        Center(
                                          child: GestureDetector(
                                            onTap: () {
                                              _afficherImageGrise(context);
                                            },
                                            child: CircleAvatar(
                                              radius: 25,
                                              backgroundColor:
                                                  Color(0xffFDCF09),
                                              child: _imageGrise != null
                                                  ? ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              40),
                                                      child: Image.file(
                                                        _imageGrise,
                                                        width: 70,
                                                        height: 70,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    )
                                                  : Container(
                                                      decoration: BoxDecoration(
                                                          color:
                                                              Colors.grey[200],
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      50)),
                                                      width: 70,
                                                      height: 70,
                                                      child: livreurSnapshot
                                                                          .data[
                                                                      'moyenTransport'][0]
                                                                  [
                                                                  'imageCarteGrise'] !=
                                                              null
                                                          ? ClipOval(
                                                              child:
                                                                  Image.memory(
                                                                _bytesImageGrise,
                                                                width: 70,
                                                                height: 70,
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                            )
                                                          : ClipOval(
                                                              child:
                                                                  Image.asset(
                                                                "assets/NoMoyenDeTransport.jpg",
                                                                width: 70,
                                                                height: 70,
                                                                fit: BoxFit
                                                                    .cover,
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

                    ////// Horizontal divider ///////

                    Container(
                      padding: const EdgeInsets.all(10),
                      child: Divider(),
                    ),

                    ////// Form du Modifier mot de passe //////
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.lock,
                            color: Colors.orange[700],
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (context) =>
                                          ModifierMotPassLivreur()));
                            },
                            child: Text(
                              'Changer votre mot de passe',
                              textDirection: TextDirection.ltr,
                              style: TextStyle(
                                color: Colors.orange[700],
                                fontSize: 17.0,
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
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

  /////// fonction pour afficher les button galery et camera pour ajouter une image  Profile/////
  void _afficherImageProfile(context) {
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
                        _imageProfileGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Caméra'),
                    onTap: () {
                      _imageProfileCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  /////// fonction pour afficher les button galery et camera pour ajouter une image du CIN /////
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

  /////// fonction pour afficher les button galery et camera pour ajouter une image Permis /////
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

  /////// fonction pour afficher les button galery et camera pour ajouter une image Grise  /////
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
}
