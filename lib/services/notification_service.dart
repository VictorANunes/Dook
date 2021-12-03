import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dook/provider/notification_provider.dart';
import 'package:dook/services/firestore_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;

class NotificationService {
  FirestoreService firestore = FirestoreService();
  final FirebaseMessaging _fcm = FirebaseMessaging();
  FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<String> getDeviceToken() async {
    String fcmToken = await _fcm.getToken(); //Pega o token

    if (fcmToken != null) {
      return fcmToken;
    }
  }

  void sendNotification(
      String titulo, String msg, String email, String tipoMensagem) async {
    var result = await _db.collection('Usuario').doc(email).get();
    if (result.data()['notificacao']) {
      String fcmToken = result.data()['id'];

      print(fcmToken);

      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'key=$fcmKey',
      };

      var request = http.Request('POST', Uri.parse(fcmUrl));

      request.body =
          '''{"to":"$fcmToken","priority":"high","notification":{"title":"$titulo","body":"$msg","sound": "default","click_action": "FLUTTER_NOTIFICATION_CLICK",},}''';
      request.headers.addAll(headers);

      await request.send();

      NotificationProvider not = new NotificationProvider();

      not.changeTitulo(titulo);
      not.changeMsg(msg);
      not.changeTipoMensagem(tipoMensagem);
      not.changeEmail(email);
      not.changeData(DateTime.now().millisecondsSinceEpoch);
      not.saveNotification();
    } else {
      print('notify off');
    }
  }

  void verifyToken() async {
    String token = await _fcm.getToken();
    String email = firestore.getEmail();

    var result = await _db.collection('Usuario').doc(email).get();
    String token2 = result.data()['id'];

    if (token != token2) {
      _db.collection('Usuario').doc(email).update({'id': token});
    }
  }
}
