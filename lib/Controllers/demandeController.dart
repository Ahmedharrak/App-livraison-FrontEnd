import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:livreurs_app/const.dart' as Const;

class DemandeController {
  String serverUrl = "http://127.0.0.1:8000/api";
  var status;

  /// Publier une demande publique
  publierDemande(
      String adresseRecuperationLivraison,
      String villeDeDepart,
      String regionRecuperation,
      String adresseDestinationLivraison,
      String villeDeLivraison,
      String regionLivraison,
      String valueVoiture,
      String valueMoto,
      String valueCamion,
      String valuePickup,
      String valueTaxi,
      String valueVelo,
      String dateLivraison,
      String heureLivraison,
      String contenu,
      String nature,
      String taille,
      String poids,
      String description) async {
    String myurl = "$serverUrl/publierDemande";
    final response = await http.post(myurl, body: {
      "idClient": "${Const.idClLiv}",
      "adresseRecuperationLivraison": "$adresseRecuperationLivraison",
      "villeDeDepart": "$villeDeDepart",
      "regionRecuperation": "$regionRecuperation",
      "adresseDestinationLivraison": "$adresseDestinationLivraison",
      "villeDeLivraison": "$villeDeLivraison",
      "regionLivraison": "$regionLivraison",
      "Voiture": "$valueVoiture",
      "Moto": "$valueMoto",
      "Camion": "$valueCamion",
      "Pickup": "$valuePickup",
      "Taxi": "$valueTaxi",
      "Velo": "$valueVelo",
      "dateLivraison": "$dateLivraison",
      "heureLivraison": "$heureLivraison",
      "contenu": "$contenu",
      "nature": "$nature",
      "taille": "$taille",
      "poids": "$poids",
      "description": "$description",
    });
    status = response.body.contains("error");
    var data = json.decode(response.body);
    if (status) {
      print("Erreur : ${data['error']}");
    } else {
      print("La demande publique a été créée avec succès");
      print(data);
    }
  }

  /// Envoyer une demande privée
  envoyerDemandePrive(
      String adresseRecuperationLivraison,
      String villeDeDepart,
      String regionRecuperation,
      String adresseDestinationLivraison,
      String villeDeLivraison,
      String regionLivraison,
      String valueVoiture,
      String valueMoto,
      String valueCamion,
      String valuePickup,
      String valueTaxi,
      String valueVelo,
      String dateLivraison,
      String heureLivraison,
      String contenu,
      String nature,
      String taille,
      String poids,
      String description,
      String prix,
      String idLivreur) async {
    String myurl = "$serverUrl/envoyerDemandePrive";
    final response = await http.post(myurl, body: {
      "adresseRecuperationLivraison": "$adresseRecuperationLivraison",
      "villeDeDepart": "$villeDeDepart",
      "regionRecuperation": "$regionRecuperation",
      "adresseDestinationLivraison": "$adresseDestinationLivraison",
      "villeDeLivraison": "$villeDeLivraison",
      "regionLivraison": "$regionLivraison",
      "Voiture": "$valueVoiture",
      "Moto": "$valueMoto",
      "Camion": "$valueCamion",
      "Pickup": "$valuePickup",
      "Taxi": "$valueTaxi",
      "Velo": "$valueVelo",
      "dateLivraison": "$dateLivraison",
      "heureLivraison": "$heureLivraison",
      "contenu": "$contenu",
      "nature": "$nature",
      "taille": "$taille",
      "poids": "$poids",
      "description": "$description",
      "idClient": "${Const.idClLiv}",
      "idLivreur": "$idLivreur",
      "prix": "$prix",
    });
    status = response.body.contains("error");
    var data = json.decode(response.body);
    if (status) {
      print("Erreur : ${data['error']}");
    } else {
      print("La demande privée a été créée avec succès");
      print(data);
    }
  }

  /// Obtenez toutes les demandes
  Future<List> obtenirTousDemandesPublic(
      String dateLivraison,
      String contenu,
      String nature,
      String taille,
      String poids,
      String villeDeDepart,
      String villeDeLivraison,
      String regionRecuperation,
      String regionLivraison,
      String triePar) async {
    String myurl = "$serverUrl/demandespubliques";
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
      "villeDeDepart": "$villeDeDepart",
      "villeDeLivraison": "$villeDeLivraison",
      "regionRecuperation": "$regionRecuperation",
      "regionLivraison": "$regionLivraison",
      "triePar": "$triePar",
    });
    // ignore: unnecessary_brace_in_string_interps
    print('voilà la dateLivraison : ${dateLivraison}');
    // ignore: unnecessary_brace_in_string_interps
    print('voilà la valuer de contenu  : ${contenu}');
    // ignore: unnecessary_brace_in_string_interps
    print('voilà la valuer de nature  : ${nature}');
    // ignore: unnecessary_brace_in_string_interps
    print(' voilà la taille : ${taille}');
    // ignore: unnecessary_brace_in_string_interps
    print('voilà la valuer de poids  : ${poids}');
    // ignore: unnecessary_brace_in_string_interps
    print('voilà la valuer de regionRecuperation  : ${regionRecuperation}');
    // ignore: unnecessary_brace_in_string_interps
    print('voilà la valuer de regionLivraison  : ${regionLivraison}');
    // ignore: unnecessary_brace_in_string_interps
    print('voilà la valuer de villeDeDepart  : ${villeDeDepart}');
    // ignore: unnecessary_brace_in_string_interps
    print('voilà la valuer de villeDeLivraison  : ${villeDeLivraison}');
    // ignore: unnecessary_brace_in_string_interps
    print('voilà la valuer de triePar  : ${triePar}');

    return json.decode(response.body);
  }

  /// Obtenir des demandes par identifiant client
  Future<List> obtenirDemandesClientParId(
    idc,
    dateLivraison,
    contenu,
    nature,
    taille,
    poids,
    regionRecuperation,
    regionLivraison,
    villeDeDepart,
    villeDeLivraison,
    triePar,
  ) async {
    String myurl = "$serverUrl/demandesClient/" + idc;
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
      "triePar": "$triePar",
    });
    return json.decode(response.body);
  }

  /// Obtenir une demande par sa pièce d'identité
  obtenirDemande($idDemande) async {
    String myurl = "$serverUrl/demande/";
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;
    http.Response response = await http.get(myurl + $idDemande, headers: {
      "Accept": "Application/json",
      "Authentification": "barear : $value"
    });

    return json.decode(response.body);
  }

  /// Ajouter livreur interessee
  ajouterLivreurInteresse(idDemande, prix) async {
    String myurl = "$serverUrl/ajouterLivreurInteresse/" + idDemande;
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;
    http.Response response = await http.put(myurl, headers: {
      "Accept": "Application/json",
      "Authentification": "barear : $value"
    }, body: {
      "idLivreur": "${Const.idClLiv}",
      "prix": "$prix"
    });
    print("${json.decode(response.body)}");
  }

  /// Obtenir une demande de récus par sa pièce d'identité
  Future<List> obtenirDemandesRecusParId(
      $idl,
      String dateLivraison,
      String contenu,
      String nature,
      String taille,
      String poids,
      String villeDeDepart,
      String villeDeLivraison,
      String regionRecuperation,
      String regionLivraison,
      String triePar) async {
    String myurl = "$serverUrl/demandesReçus/" + $idl;
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
      "villeDeDepart": "$villeDeDepart",
      "villeDeLivraison": "$villeDeLivraison",
      "regionRecuperation": "$regionRecuperation",
      "regionLivraison": "$regionLivraison",
      "triePar": "$triePar",
    });
    // ignore: unnecessary_brace_in_string_interps
    print('voilà la valuer de ville  : ${villeDeDepart} ${villeDeLivraison}');
    // ignore: unnecessary_brace_in_string_interps
    print('voilà la valuer de region  : $regionRecuperation  $regionLivraison');
    // ignore: unnecessary_brace_in_string_interps
    print(' voilà la dateLivraison : ${dateLivraison}');
    // ignore: unnecessary_brace_in_string_interps
    print('voilà la valuer de contenu  : ${contenu}');
    // ignore: unnecessary_brace_in_string_interps
    print('voilà la valuer de nature  : ${nature}');
    // ignore: unnecessary_brace_in_string_interps
    print(' voilà la taille : ${taille}');
    // ignore: unnecessary_brace_in_string_interps
    print('voilà la valuer de poids  : ${poids}');
    // ignore: unnecessary_brace_in_string_interps
    print('voilà la valuer de triePar  : ${triePar}');
    return json.decode(response.body);
  }

  /// Refuser un livreur intéréssé
  refuserLivreurInteresse(idDemande, idLivreur) async {
    String myurl =
        "$serverUrl/refuserLivreurInteresse/" + idDemande + "/" + idLivreur;
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;
    http.Response response = await http.put(myurl, headers: {
      "Accept": "Application/json",
      "Authentification": "barear : $value"
    });
    print('Response statut : ${response.statusCode}');
    print('Responce body : ${response.body}');
    print("${json.decode(response.body)}");
  }

  /// Mise à jour demande
  modifierDemande(
      String id,
      String dateLivraison,
      String villeDeDepart,
      String villeDeLivraison,
      String adresseRecuperationLivraison,
      String adresseDestinationLivraison,
      String regionRecuperation,
      String regionLivraison,
      String contenu,
      String nature,
      String taille,
      String poids,
      String prix,
      String description) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;
    String myurl = "$serverUrl/modifierDemande/";
    http.put(myurl + '$id', headers: {
      "Accept": "Application/json",
      "Authentification": "barear : $value"
    }, body: {
      "dateLivraison": "$dateLivraison",
      "villeDeDepart": "$villeDeDepart",
      "villeDeLivraison": "$villeDeLivraison",
      "adresseRecuperationLivraison": "$adresseRecuperationLivraison",
      "adresseDestinationLivraison": "$adresseDestinationLivraison",
      "regionRecuperation": "$regionRecuperation",
      "regionLivraison": "$regionLivraison",
      "contenu": "$contenu",
      "nature": "$nature",
      "taille": "$taille",
      "poids": "$poids",
      "prix": "$prix",
      "description": "$description",
    }).then((response) {
      print('Response statut : ${response.statusCode}');
      print('Responce body : ${response.body}');
    });
  }

  /// Supprimer la demande
  annulerDemande(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;
    String myurl = "$serverUrl/annulerDemande/";
    http.delete(myurl + '$id', headers: {
      "Accept": "Application/json",
      "Authentification": "barear : $value"
    }).then((response) {
      print('Response statut : ${response.statusCode}');
      print('Responce body : ${response.body}');
    });
  }
}
