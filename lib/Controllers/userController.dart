import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:livreurs_app/const.dart' as Const;

class UserController {
  String serverUrl = "http://127.0.0.1:8000/api";
  var status;
  var token;
  var data;
  String role;
  String element;
  String idClLiv;
  String codeVerifier;
  String idUtilisateur;

  /// Se connecter
  connecter(String login, String password) async {
    String myurl = "$serverUrl/connecter";
    final response = await http
        .post(myurl, body: {"login": "$login", "password": "$password"});
    status = response.body.contains("error");
    var data = json.decode(response.body);
    if (status) {
      print("Erreur : ${data['error']}");
    } else {
      Const.email = login;
      Const.role = data['user']['role'];
      Const.telephone = data['user']['telephone'];
      Const.idUser = data['success']['token']['token']['user_id'];
      Const.idClLiv = data['user']['idUser'];
      print("Token : ${data['success']['token']['accessToken']}");
    }
  }

  /// Se déconnecter
  deconnecter() async {
    String myurl = "$serverUrl/deconnecter";
    final response = await http.post(myurl, body: {});
    status = response.body.contains("error");
    // ignore: unused_local_variable
    var data = json.decode(response.body);
  }

  /// Obtenir le rôle
  obtenirRole($email) async {
    String myurl = "$serverUrl/roleUtilisateur/";
    http.Response response = await http.get(myurl + $email);
    print("role : ${json.decode(response.body)}");
    Const.role = json.decode(response.body);
    role = json.decode(response.body);
  }

  /// S'inscrire Client
  inscrireClient(
      String nom,
      String prenom,
      String telephone,
      String email,
      String cin,
      String ville,
      String adresse,
      String region,
      String password,
      String imageProfile) async {
    String myurl = "$serverUrl/inscrire";
    final response = await http.post(myurl, body: {
      "nom": "$nom",
      "prenom": "$prenom",
      "telephone": "$telephone",
      "email": "$email",
      "role": "client",
      "numeroCIN": "$cin",
      "adresse": "$adresse",
      "ville": "$ville",
      "region": "$region",
      "password": "$password",
      "imageProfile": "$imageProfile",
    });
    status = response.body.contains("error");
    var data = json.decode(response.body);
    if (status) {
      print("Erreur : ${data['error']}");
    } else {
      Const.email = email;
      Const.role = data['user']['role'];
      Const.telephone = data['user']['telephone'];
      Const.idUser = data['success']['token']['token']['user_id'];
      Const.idClLiv = data['user']['idUser'];
      print("Token : ${data['success']['token']['accessToken']}");
    }
  }

  /// S'inscrire livreur
  inscrireLivreur(
    String nom,
    String prenom,
    String telephone,
    String email,
    String cin,
    String ville,
    String adresse,
    String region,
    String password,
    String imageCIN,
    String immatriculation,
    String type,
    String imagePermis,
    String imageCarteGrise,
    String imageProfile,
    bool lundi,
    bool mardi,
    bool mercredi,
    bool jeudi,
    bool vendredi,
    bool samedi,
    bool dimanche,
  ) async {
    String myurl = "$serverUrl/inscrire";
    final response = await http.post(myurl, body: {
      "nom": "$nom",
      "prenom": "$prenom",
      "telephone": "$telephone",
      "email": "$email",
      "numeroCIN": "$cin",
      "role": "livreur",
      "adresse": "$adresse",
      "ville": "$ville",
      "region": "$region",
      "password": "$password",
      "imageCIN": "$imageCIN",
      "immatriculation": "$immatriculation",
      "type": "$type",
      "imagePermis": "$imagePermis",
      "imageProfile": "$imageProfile",
      "imageCarteGrise": "$imageCarteGrise",
      "lundi": "$lundi",
      "mardi": "$mardi",
      "mercredi": "$mercredi",
      "jeudi": "$jeudi",
      "vendredi": "$vendredi",
      "samedi": "$samedi",
      "dimanche": "$dimanche",
    });
    status = response.body.contains("error");
    var data = json.decode(response.body);
    if (status) {
      print("Erreur : ${data['error']}");
    } else {
      Const.email = email;
      Const.role = data['user']['role'];
      Const.telephone = data['user']['telephone'];
      Const.idUser = data['success']['token']['token']['user_id'];
      Const.idClLiv = data['user']['idUser'];
      print("Token : ${data['success']['token']['accessToken']}");
      enregistrer("${data['success']['token']['accessToken']}");
    }
  }

  /// Enregistrer le token
  enregistrer(String token) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = token;
    prefs.setString(key, value);
  }

  /// Lire token
  lire() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;
    print('read : $value');
  }

  /// Aficher les information de livreurs
  Future<List> obtenirTousLivreurs(String ville, String region,
      String noteTotal, String transport, String triePar) async {
    String myurl = "$serverUrl/livreurs";
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;
    http.Response response = await http.post(myurl, headers: {
      "Accept": "Application/json",
      "Authentification": "barear : $value"
    }, body: {
      "ville": "$ville",
      "region": "$region",
      "noteTotal": "$noteTotal",
      "transport": "$transport",
      "triePar": "$triePar"
    });
    print(json.decode(response.body));
    print('Voilà la valeur de ville du livreur : $ville');
    print('Voilà la valeur de région du livreur : $region');
    print('Voilà la valuer de note du livreur : $noteTotal');
    print('Voilà la valeur de moyen du transport du livreur : $transport');
    print('Voilà la valeur de triePar du livreur : $triePar');
    return json.decode(response.body);
  }

  /// Supprimer livreur
  void supprimerUtilisateur(int id) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;
    String myurl = "$serverUrl/user/";
    http.delete(myurl + '$id', headers: {
      "Accept": "Application/json",
      "Authentification": "barear : $value"
    }).then((response) {
      print('Response statut : ${response.statusCode}');
      print('Responce body : ${response.body}');
    });
  }

  /// Mettre à jour les données du client par son identifiant
  modifierClient(
    String id,
    String nom,
    String prenom,
    String cin,
    String ville,
    String adresse,
    String region,
    String telephone,
    String imageProfile,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;
    String myurl = "$serverUrl/modifierClient/";
    http.put(myurl + '$id', headers: {
      "Accept": "Application/json",
      "Authentification": "barear : $value"
    }, body: {
      "nom": "$nom",
      "prenom": "$prenom",
      "role": "client",
      "numeroCIN": "$cin",
      "ville": "$ville",
      "adresse": "$adresse",
      "region": "$region",
      "telephone": "$telephone",
      "imageProfile": "$imageProfile"
    }).then((response) {
      status = response.body.contains("error");
      var data = json.decode(response.body);
      if (status) {
        print("Erreur : ${data['error']}");
      } else {
        print('Client est bien modifié');
      }
    });
  }

  /// Mettre à jour les données du livreur par son identifiant
  modifierLivreur(
    String id,
    String nom,
    String prenom,
    String cin,
    String ville,
    String adresse,
    String region,
    String telephone,
    String lundi,
    String mardi,
    String mercredi,
    String jeudi,
    String vendredi,
    String samedi,
    String dimanche,
    String imageProfile,
    String imageCIN,
    String type,
    String immatriculation,
    String imagePermis,
    String carteGrise,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;
    String myurl = "$serverUrl/modifierLivreur/";
    http.put(myurl + '$id', headers: {
      "Accept": "Application/json",
      "Authentification": "barear : $value"
    }, body: {
      "nom": "$nom",
      "prenom": "$prenom",
      "numeroCIN": "$cin",
      "ville": "$ville",
      "adresse": "$adresse",
      "region": "$region",
      "telephone": "$telephone",
      "lundi": "$lundi",
      "mardi": "$mardi",
      "mercredi": "$mercredi",
      "jeudi": "$jeudi",
      "vendredi": "$vendredi",
      "samedi": "$samedi",
      "dimanche": "$dimanche",
      "imageProfile": "$imageProfile",
      "imageCIN": "$imageCIN",
      "type": "$type",
      "immatriculation": "$immatriculation",
      "imagePermis": "$imagePermis",
      "ImageCarteGrise": "$carteGrise",
    }).then((response) {
      status = response.body.contains("error");
      var data = json.decode(response.body);
      if (status) {
        print("Erreur : ${data['error']}");
      } else {
        print('Livreur est bien modifié');
      }
    });
  }

  /// Mettre à jour le mot de passe
  modifierMotDePasse(
    String oldPassword,
    String newPassword,
    String confirmPassword,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;
    String myurl = "$serverUrl/modifierMotDePasse/";
    http.post(myurl + Const.idUser, headers: {
      "Accept": "Application/json",
      "Authentification": "barear : $value"
    }, body: {
      "old_password": "$oldPassword",
      "new_password": "$newPassword",
      "confirm_password": "$confirmPassword",
    }).then((response) {
      status = response.body.contains("error");
      var data = json.decode(response.body);
      if (status) {
        print("Erreur : ${data['error']}");
      } else {
        print('Mot de passe est bien modifié');
      }
    });
  }

  /// Envoyer le mot de passe par e-mail
  envoyerCodeParEmail(email, subject) async {
    String myurl = "$serverUrl/sendmail/" + email + "/" + subject;
    http.Response response = await http.get(myurl);
    print("code Verifier : ${json.decode(response.body)}");
    Const.codeVerifier = json.decode(response.body);
    codeVerifier = json.decode(response.body);
  }

  /// Obtenir le rôle
  obtenirId($email) async {
    String myurl = "$serverUrl/idUtilisateur/";
    http.Response response = await http.get(myurl + $email);
    print("id : ${json.decode(response.body)}");
    Const.idUtilisateur = json.decode(response.body);
    idUtilisateur = json.decode(response.body);
  }

  /// Mettre à jour le mot de passe
  reinitialiseMotDePasse(String newPassword, String confirmPassword, id) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;
    String myurl = "$serverUrl/reinitialiseMotDePasse/";
    http.post(myurl + id, headers: {
      "Accept": "Application/json",
      "Authentification": "barear : $value"
    }, body: {
      "new_password": "$newPassword",
      "confirm_password": "$confirmPassword",
    }).then((response) {
      status = response.body.contains("error");
      var data = json.decode(response.body);
      if (status) {
        print("Erreur : ${data['error']}");
      } else {
        print('Mot de passe est bien reinitialisé !');
      }
    });
  }
}
