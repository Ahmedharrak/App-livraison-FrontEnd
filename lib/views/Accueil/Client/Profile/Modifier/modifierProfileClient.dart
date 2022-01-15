import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:livreurs_app/Controllers/clientController.dart';
import 'package:livreurs_app/Controllers/userController.dart';
import 'package:livreurs_app/views/Accueil/Client/Profile/ModifierPass/modifierMotPassClient.dart';
import 'package:livreurs_app/views/Accueil/Client/Profile/profileClient.dart';
import 'package:livreurs_app/views/Accueil/accueilClient.dart';
import 'package:flutter/painting.dart';
import 'dart:convert';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:livreurs_app/const.dart' as Const;

/// This Widget is the main application widget.
class ModifierProfileClient extends StatefulWidget {
  int i;
  @override
  _ModifierProfileClientState createState() =>
      _ModifierProfileClientState(this.i);
}

class _ModifierProfileClientState extends State<ModifierProfileClient> {
  int i;
  _ModifierProfileClientState(this.i);

  File _imageProfile;
  UserController userController = new UserController();
  ClientController clientController = new ClientController();
  TextEditingController nomControllerc = new TextEditingController();
  TextEditingController prenomControllerc = new TextEditingController();
  TextEditingController cinControllerc = new TextEditingController();
  TextEditingController adresseControllerc = new TextEditingController();
  TextEditingController villeControllerc = new TextEditingController();
  TextEditingController telephoneControllerc = new TextEditingController();
  String dropdownVille;
  bool _validateNom = false,
      _validatePrenom = false,
      _validateCIN = false,
      _validateTelephone = false;

  //////////// Fonction pour telecharger l' images du Profile soit avec camera ou calery  /////////////////
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

  @override
  void initState() {
    super.initState();
  }

  // void _showNotifications() async {
  //   await notification();
  // }

  // we can set navigator to navigate another screen

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: clientController.obtenirInformationClient(),
        builder: (context, AsyncSnapshot clientSnapshot) {
          if (clientSnapshot.hasData) {
            if (i != 1) {
              this.nomControllerc.text = clientSnapshot.data['nom'];
              this.prenomControllerc.text = clientSnapshot.data['prenom'];
              this.cinControllerc.text = clientSnapshot.data['numeroCIN'];
              this.adresseControllerc.text = clientSnapshot.data['adresse'];
              this.telephoneControllerc.text = clientSnapshot.data['telephone'];
              this.dropdownVille = clientSnapshot.data['ville'];
            }

            /////// Afficher Image Profile a partir base donnees ///////
            Uint8List _bytesImage;
            String _imgProfileString = '${clientSnapshot.data['imageProfile']}';
            _bytesImage = Base64Decoder().convert(_imgProfileString);
            /////// valeur de Nom,Prenom,CIN,adresse,telephone //////

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

                              child: Text(
                                'Modifier le profil',
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
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        new MaterialPageRoute(
                                            builder: (context) =>
                                                ProfileClient()));
                                  },
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
                                  //////// Fonction pour modifier les données du client /////////
                                  onTap: () async {
                                    /////// si la valeur du nom/prenom/telephone/cin est vide //////
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
                                    /////// pour ajouter l'image du profile en forme String 64 dans base de données ///////
                                    if (_imageProfile != null)
                                      _bytesImage =
                                          _imageProfile.readAsBytesSync();
                                    String _imgProfile64 =
                                        base64Encode(_bytesImage);
                                    /////// si la valeur du ville a égale a tout /////////
                                    if (dropdownVille == "Tout")
                                      _showDialog("Veuillez remplir Ville !");
                                    //////// region du livreur //////
                                    final queryA = dropdownVille;
                                    var addressesA = await Geocoder.local
                                        .findAddressesFromQuery(queryA);
                                    var region = addressesA.first.adminArea;
                                    print(Const.idUser);
                                    userController
                                        .modifierClient(
                                            Const.idUser,
                                            nomControllerc.text.trim(),
                                            prenomControllerc.text.trim(),
                                            cinControllerc.text.trim(),
                                            dropdownVille,
                                            adresseControllerc.text.trim(),
                                            region,
                                            telephoneControllerc.text.trim(),
                                            _imgProfile64)
                                        .whenComplete(() {
                                      if (userController.status) {
                                        _showDialog(
                                            "Entrer les informations corrects!");
                                      } else {
                                        //Navigator.pop(context);
                                        // Navigator.pop(context);
                                        Navigator.push(
                                            context,
                                            new MaterialPageRoute(
                                                builder: (context) =>
                                                    ProfileClient()));
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
                                          child: clientSnapshot
                                                      .data['imageProfile'] !=
                                                  null
                                              ? ClipOval(
                                                  child: Image.memory(
                                                    _bytesImage,
                                                    fit: BoxFit.cover,
                                                    width: 150,
                                                    height: 150,
                                                  ),
                                                )
                                              : ClipOval(
                                                  child: Image.asset(
                                                    "assets/NoMoyenDeTransport.jpg",
                                                    fit: BoxFit.cover,
                                                    width: 150,
                                                    height: 150,
                                                  ),
                                                )),
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
                                "Modifier la photo de profil",
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
                                  controller: nomControllerc,
                                  onChanged: (value) {
                                    setState(() {
                                      nomControllerc.text = value;
                                      this.i = 1;
                                    });
                                  },
                                  style: TextStyle(color: Color(0xFF000000)),
                                  decoration: InputDecoration(
                                    hintText: "${clientSnapshot.data['nom']}",
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
                                        "${clientSnapshot.data['prenom']}",
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
                                  style: TextStyle(color: Color(0xFF000000)),
                                  decoration: InputDecoration(
                                    hintText:
                                        "${clientSnapshot.data['adresse']}",
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
                                    hintText:
                                        "${clientSnapshot.data['telephone']}",
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

                          ////// Row CIN + Ville //////

                          ///// CIN ////////////

                          Container(
                            padding: const EdgeInsets.all(5),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      'CIN',
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
                                  style: TextStyle(color: Color(0xFF000000)),
                                  decoration: InputDecoration(
                                    hintText:
                                        "${clientSnapshot.data['numeroCIN']}",
                                    errorText: _validateCIN
                                        ? 'La valeur de CIN ne peut pas être vide'
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
                          ////// Ville ///////

                          Container(
                            padding: const EdgeInsets.all(5),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Ville',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),

                                ///BottomSheet Mode with no searchBox
                                Container(
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
                                    selectedItem: clientSnapshot.data['ville'],
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

                    ////// Horizontal divider ///////

                    Container(
                      padding: const EdgeInsets.all(10),
                      child: Divider(
                        color: Colors.orange,
                      ),
                    ),

                    ////// Form du Modifier mot de passe //////
                    Container(
                      margin: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.lock,
                            color: Colors.orangeAccent,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (context) =>
                                          ModifierMotPassClient()));
                            },
                            child: Text(
                              'Changer votre mot de passe',
                              textDirection: TextDirection.ltr,
                              style: TextStyle(
                                color: Colors.orangeAccent,
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
