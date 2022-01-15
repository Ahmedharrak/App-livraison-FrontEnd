import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:livreurs_app/const.dart' as Const;

class ClientController {
  String serverUrl = "http://127.0.0.1:8000/api";
  String element;

  /// Afficher les information d'un client
  obtenirInformationClient() async {
    String myurl = "$serverUrl/informationClient/";
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;
    http.Response response = await http.get(myurl + Const.idUser, headers: {
      "Accept": "Application/json",
      "Authentification": "barear : $value"
    });
    return json.decode(response.body);
  }

  /// Afficher les information d'un seule client avec son id
  Future obtenirClient(id) async {
    String myurl = "$serverUrl/client/";
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;
    http.Response response = await http.get(myurl + id, headers: {
      "Accept": "Application/json",
      "Authentification": "barear : $value"
    });
    return json.decode(response.body);
  }

  /// Obtenir l'élément client par identifiant
  obtenirElementClient(id, elm) async {
    String myurl = "$serverUrl/elementClient/" + id + "/" + elm;
    http.Response response = await http.get(myurl);
    element = json.decode(response.body);
  }

  /// Ajouter image profile
  ajouterPhotoProfile(String imageProfile, String id) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;
    String myurl = "$serverUrl/ajouterPhotoProfile/";
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

  /// Signaler client
  signalerClient(idClient, causeDeSignale) async {
    String myurl = "$serverUrl/signalerClient/" + idClient;
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;
    http.Response response = await http.put(myurl, headers: {
      "Accept": "Application/json",
      "Authentification": "barear : $value"
    }, body: {
      "idLivreur": "${Const.idClLiv}",
      "causeDeSignale": "$causeDeSignale"
    });
    print(json.decode(response.body));
  }

  /// Ajouter Commentaire dans client
  ajouterCommentaireClient(idClient, double note, commentaire) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;
    String myurl = "$serverUrl/ajouterCommentaireClient/";
    http.put(myurl + idClient, headers: {
      "Accept": "Application/json",
      "Authentification": "barear : $value"
    }, body: {
      "id_livreur": "${Const.idClLiv}",
      "note": "$note",
      "commentaire": "$commentaire",
    }).then((response) {
      print('Response statut : ${response.statusCode}');
      print('Responce body : ${response.body}');
    });
  }
}
