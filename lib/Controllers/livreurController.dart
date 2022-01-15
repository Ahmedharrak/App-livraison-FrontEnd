import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:livreurs_app/const.dart' as Const;

class LivreurController {
  String serverUrl = "http://127.0.0.1:8000/api";
  List livreur;
  var status;

  /// Obtenir le client par ID utilisateur
  Future obtenirInformationLivreur() async {
    String myurl = "$serverUrl/informationLivreur/";
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;
    print("cons id user ........> ${Const.idUser}");
    http.Response response = await http.get(myurl + Const.idUser, headers: {
      "Accept": "Application/json",
      "Authentification": "barear : $value"
    });
    return json.decode(response.body);
  }

  /// Obtenez livreur sa pièce d'identité
  Future obtenirLivreur(id) async {
    String myurl = "$serverUrl/livreur/";
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;
    http.Response response = await http.get(myurl + id, headers: {
      "Accept": "Application/json",
      "Authentification": "barear : $value"
    });
    return json.decode(response.body);
  }

  /// Obtenir l'élément livreur par identifiant
  obtenirElementLivreur($id, $element) async {
    String myurl = "$serverUrl/elementLivreur/";
    http.Response response = await http.get(myurl + $id + "/" + $element);
    return json.decode(response.body);
  }

  ///// Ajouter photo profil livreur
  ajouterPhotoProfileLivreur(String imageProfile, String id) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;
    String myurl = "$serverUrl/ajouterPhotoProfileLivreur/";
    http.put(myurl + Const.idUser, headers: {
      "Accept": "Application/json",
      "Authentification": "barear : $value"
    }, body: {
      "imageProfile": "$imageProfile",
    }).then((response) {
      print('Response statut : ${response.statusCode}');
      print('Responce body : ${response.body}');
    });
  }

  /// Signaler livreur
  signalerLivreur(idLivreur, causeDeSignale) async {
    String myurl = "$serverUrl/signalerLivreur/" + idLivreur;
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;
    http.Response response = await http.put(myurl, headers: {
      "Accept": "Application/json",
      "Authentification": "barear : $value"
    }, body: {
      "idClient": "${Const.idClLiv}",
      "causeDeSignale": "$causeDeSignale"
    });
    print(json.decode(response.body));
  }

  /// Obtenir tous les livreurs intersses
  Future<List> obtenirLivreursInteresses(String $idDemande, String ville,
      String region, String noteTotal, String transport, String triePar) async {
    String myurl = "$serverUrl/obtenirLivreursInteresses/";
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;
    http.Response response = await http.post(myurl + $idDemande, headers: {
      "Accept": "Application/json",
      "Authentification": "barear : $value",
    }, body: {
      "ville": "$ville",
      "region": "$region",
      "noteTotal": "$noteTotal",
      "transport": "$transport",
      "triePar": "$triePar",
    });

    print(' voilà la ville : $ville');
    print('voilà la valuer de region  : $region');
    print('voilà la valuer de note  : $noteTotal');
    print(' voilà la transport : $transport');
    return json.decode(response.body);
  }

  /// Modifier enService un livreur
  modifierEnServiceLivreur(String enService) async {
    String myurl = "$serverUrl/modifierEnService/" + Const.idClLiv;
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;
    http.Response response = await http.put(myurl, headers: {
      "Accept": "Application/json",
      "Authentification": "barear : $value"
    }, body: {
      "enService": "$enService",
    });
    print(json.decode(response.body));
  }

  ///// Ajouter Commentaire dans livreur
  ajouterCommentaireLivreur(idLivreur, double note, commentaire) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;
    String myurl = "$serverUrl/ajouterCommentaireLivreur/";
    http.put(myurl + idLivreur, headers: {
      "Accept": "Application/json",
      "Authentification": "barear : $value"
    }, body: {
      "id_client": "${Const.idClLiv}",
      "note": "$note",
      "commentaire": "$commentaire",
    }).then((response) {
      print('Response statut : ${response.statusCode}');
      print('Responce body : ${response.body}');
    });
  }
}
