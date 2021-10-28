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

    String fcmToken = result.data()['id'];

    print(fcmToken);

    String fcmUrl = 'https://fcm.googleapis.com/fcm/send';
    String fcmKey =
        'AAAAMJBh8d0:APA91bGkIEONQz1smldPGTWCTP6Di9xoxeR84PdbaXFtdnYPvXLMb25SMjdv4DL1owJzyYHo8f9JIEEDadA293WhEW9gyRNnZq1RGUskagBWgBhYiqsINd4A2XK05FfPdUSYlowdPkbz';

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

    not.changeTitulo('oi');
    not.changeMsg('oi');
    not.changeTipoMensagem('Teste');
    not.changeEmail('luis@gmail.com');
    not.changeData(DateTime.now().millisecondsSinceEpoch);
    not.saveNotification();
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
