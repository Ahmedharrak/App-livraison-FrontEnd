import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LivraisonController {
  String serverUrl = "http://127.0.0.1:8000/api";
  var status;

  /// Ajouter Livraison(la demande devient livraison)
  ajouterLivraiosn(
      String idLivreur, String idClient, String idDemande, String prix) async {
    String myurl = "$serverUrl/ajouterLivraiosn";
    final response = await http.post(myurl, body: {
      "idLivreur": "$idLivreur",
      "idClient": "$idClient",
      "idDemande": "$idDemande",
      "prix": "$prix",
    });
    status = response.body.contains("error");
    var data = json.decode(response.body);
    if (status) {
      print("Erreur : ${data['error']}");
    } else {
      print("la demande devient livraison!");
      print(data);
    }
  }

  /// Modifier le statut de livraison
  void modifierStatutDemande(idDemande, statut) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;
    String myurl = "$serverUrl/modifierStatutDemande/" + idDemande;
    http.put(myurl, headers: {
      "Accept": "Application/json",
      "Authentification": "barear : $value"
    }, body: {
      "statutDemande": "$statut",
    }).then((response) {
      print('Response statut : ${response.statusCode}');
      print('Responce body : ${response.body}');
    });
  }

  /// Obtenez les livraisons par id client
  Future<List> obtenirLivraisonsParIdClient(
      $idc,
      dateLivraison,
      contenu,
      nature,
      taille,
      poids,
      regionRecuperation,
      regionLivraison,
      villeDeDepart,
      villeDeLivraison,
      triePar) async {
    String myurl = "$serverUrl/livraisonsClient/" + $idc;
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;
    http.Response response = await http.post(myurl, headers: {
      "Accept": "Application/json",
      "Authentification": "barear : $value"
    }, body: {
      "dateLivraison": "$dateLivraison",
      "contenu": "$contenu",
      "nature": "$nature",
      "taille": "$taille",
      "poids": "$poids",
      "regionRecuperation": "$regionRecuperation",
      "regionLivraison": "$regionLivraison",
      "villeDeDepart": "$villeDeDepart",
      "villeDeLivraison": "$villeDeLivraison",
      "triePar": "$triePar"
    });
    return json.decode(response.body);
  }

  /// Obtenez les livraisons par id livreur
  Future<List> obtenirLivraisonsParIdLivreur(
      $idl,
      String dateLivraison,
      String contenu,
      String nature,
      String taille,
      String poids,
      String regionRecuperation,
      String regionLivraison,
      String villeDeDepart,
      String villeDeLivraison,
      String triePar) async {
    String myurl = "$serverUrl/livraisonsLivreur/" + $idl;
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;
    http.Response response = await http.post(myurl, headers: {
      "Accept": "Application/json",
      "Authentification": "barear : $value",
    }, body: {
      "dateLivraison": "$dateLivraison",
      "contenu": "$contenu",
      "nature": "$nature",
      "taille": "$taille",
      "poids": "$poids",
      "regionRecuperation": "$regionRecuperation",
      "regionLivraison": "$regionLivraison",
      "villeDeDepart": "$villeDeDepart",
      "villeDeLivraison": "$villeDeLivraison",
      "triePar": "$triePar",
    });
    print('voil?? la valuer de ville  : $villeDeDepart');
    print('voil?? la valuer de region  : $regionRecuperation');
    print(' voil?? la dateLivraison : $dateLivraison');
    print('voil?? la valuer de contenu  : $contenu');
    print('voil?? la valuer de nature  : $nature');
    print(' voil?? la taille : $taille');
    print('voil?? la valuer de poids  : $poids');
    print('voil?? la valuer de triePar  : $triePar');
    return json.decode(response.body);
  }

  /// Le client re??u la livraison
  livraisonRecu(idLivraison) async {
    String myurl = "$serverUrl/livraisonRe??u/" + idLivraison;
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;
    http.Response response = await http.post(myurl, headers: {
      "Accept": "Application/json",
      "Authentification": "barear : $value"
    });
    print("${json.decode(response.body)}");
  }

  /// Ajouter un client de retour
  ajouterRetroactionClient(
      idLivraison, note, justification, commentaire) async {
    String myurl = "$serverUrl/ajouterRetroactionClient/" + idLivraison;
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;
    http.Response response = await http.post(myurl, headers: {
      "Accept": "Application/json",
      "Authentification": "barear : $value"
    }, body: {
      "note": "$note",
      "justification": "$justification",
      "commentaire": "$commentaire",
    });
    print("${json.decode(response.body)}");
  }

  /// Le livreur livr?? la livraison
  livraisonlivre(idLivraison) async {
    String myurl = "$serverUrl/livraisonLivr??/" + idLivraison;
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;
    http.Response response = await http.post(myurl, headers: {
      "Accept": "Application/json",
      "Authentification": "barear : $value"
    });
    print("${json.decode(response.body)}");
  }

  /// Ajouter un livreur de feed-back
  ajouterRetroactionLivreur(
      idLivraison, note, justification, commentaire) async {
    String myurl = "$serverUrl/ajouterRetroactionLivreur/" + idLivraison;
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;
    http.Response response = await http.post(myurl, headers: {
      "Accept": "Application/json",
      "Authentification": "barear : $value"
    }, body: {
      "note": "$note",
      "justification": "$justification",
      "commentaire": "$commentaire",
    });
    print("${json.decode(response.body)}");
  }

  /// Modifier le statut de livraison
  statutlivraison(idLivraison, statut) async {
    String myurl =
        "$serverUrl/modifierStatutLivraison/" + idLivraison + "/" + statut;
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;
    http.Response response = await http.post(myurl, headers: {
      "Accept": "Application/json",
      "Authentification": "barear : $value"
    }, body: {
      "statutLivraison": "$statut",
    });
    print("${json.decode(response.body)}");
  }

  /// Obtenez les livraisons par id client
  Future<List> obtenirHistoriquesParIdClient(
      $idc,
      String dateLivraison,
      contenu,
      nature,
      taille,
      poids,
      regionRecuperation,
      regionLivraison,
      villeDeDepart,
      villeDeLivraison,
      triePar) async {
    String myurl = "$serverUrl/HistoriquesClient/" + $idc;
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;
    http.Response response = await http.post(myurl, headers: {
      "Accept": "Application/json",
      "Authentification": "barear : $value"
    }, body: {
      "dateLivraison": "$dateLivraison",
      "contenu": "$contenu",
      "nature": "$nature",
      "taille": "$taille",
      "poids": "$poids",
      "regionRecuperation": "$regionRecuperation",
      "regionLivraison": "$regionLivraison",
      "villeDeDepart": "$villeDeDepart",
      "villeDeLivraison": "$villeDeLivraison",
      "triePar": "$triePar"
    });
    return json.decode(response.body);
  }

  /// Obtenez les livraisons par id livreur
  Future<List> obtenirHistoriquesParIdLivreur(
      $idl,
      String regionRecuperation,
      String regionLivraison,
      String villeDeDepart,
      String villeDeLivraison,
      String dateLivraison,
      String contenu,
      String nature,
      String taille,
      String poids,
      String triePar) async {
    String myurl = "$serverUrl/HistoriquesLivreur/" + $idl;
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;
    http.Response response = await http.post(myurl, headers: {
      "Accept": "Application/json",
      "Authentification": "barear : $value",
    }, body: {
      "regionRecuperation": "$regionRecuperation",
      "regionLivraison": "$regionLivraison",
      "villeDeDepart": "$villeDeDepart",
      "villeDeLivraison": "$villeDeLivraison",
      "dateLivraison": "$dateLivraison",
      "contenu": "$contenu",
      "nature": "$nature",
      "taille": "$taille",
      "poids": "$poids",
      "triePar": "$triePar",
    });
    print('voil?? la valuer de ville  : $villeDeDepart $villeDeLivraison');
    print('voil?? la valuer de region  : $regionRecuperation $regionLivraison');
    print(' voil?? la dateLivraison : $dateLivraison');
    print('voil?? la valuer de contenu  : $contenu');
    print('voil?? la valuer de nature  : $nature');
    print(' voil?? la taille : $taille');
    print('voil?? la valuer de poids  : $poids');
    print('voil?? la valuer de triePar  : $triePar');
    return json.decode(response.body);
  }
}
