import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:livreurs_app/const.dart' as Const;

class NotificationController {
  String serverUrl = "http://127.0.0.1:8000/api";
  var status;

  /// Recevoir des notifications par identifiant d'utilisateur
  Future<List> obtenirNotificationsParId(idUser) async {
    String myurl = "$serverUrl/notifications/" + idUser;
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;
    http.Response response = await http.get(myurl, headers: {
      "Accept": "Application/json",
      "Authentification": "barear : $value"
    });
    print("${json.decode(response.body)}");
    print("id---------------------------> ${Const.idUser}");
    return json.decode(response.body);
  }

  ///Ajouter une notification
  ajouterNotification(
      String idDestinataire,
      String idExpediteur,
      String idDemande,
      String idLivraison,
      String type,
      String message,
      String dateNotifications) async {
    String myurl = "$serverUrl/ajouterNotification";
    final response = await http.post(myurl, body: {
      "idDestinataire": "$idDestinataire",
      "idExpediteur": "$idExpediteur",
      "idDemande": "$idDemande",
      "idLivraison": "$idLivraison",
      "type": "$type",
      "message": "$message",
      "dateNotifications": "$dateNotifications"
    });
    status = response.body.contains("error");
    var data = json.decode(response.body);
    if (status) {
      print("Erreur : ${data['error']}");
    } else {
      print(data);
    }
  }

  /// Recevoir des notifications par identifiant d'utilisateur
  Future<List> obtenirNotificationsPasVu(idUser) async {
    String myurl = "$serverUrl/notificationsPasVu/" + idUser;
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;
    http.Response response = await http.get(myurl, headers: {
      "Accept": "Application/json",
      "Authentification": "barear : $value"
    });
    print("${json.decode(response.body)}");
    print("id---de user----------> ${Const.idUser}");
    return json.decode(response.body);
  }

  /// Modifier le statut de notifications
  void modifierVuNotifications(idDestinataire) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;
    String myurl = "$serverUrl/modifierVuNotificatios/" + idDestinataire;
    http.put(myurl, headers: {
      "Accept": "Application/json",
      "Authentification": "barear : $value"
    }).then((response) {
      print('Voilà la valeur de idDestinataire : $idDestinataire');
      print('Response statut : ${response.statusCode}');
      print('Responce body : ${response.body}');
    });
  }
}
