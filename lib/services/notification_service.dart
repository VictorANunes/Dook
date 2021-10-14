import 'package:dook/services/firestore_service.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class NotificationService {
  void teste() async {
    var status = await OneSignal.shared.getDeviceState();

    var playerId = status.userId;

    await OneSignal.shared.postNotification(
      OSCreateNotification(
        playerIds: [playerId],
        content: "Testando123",
        heading: "Teste",
        /*buttons: [
          OSActionButton(text: "Cancelar", id: "id1"),
          OSActionButton(text: "Responder", id: "id2"),
        ],*/
      ),
    );

    OneSignal.shared.setNotificationWillShowInForegroundHandler(
        (OSNotificationReceivedEvent event) {
      //Acionado sempre que uma notificacao for recebida para salvar no banco
      /*Pretendo Salvar:
        id_aleatorio{
          destinatario: id,
          mensagem: mensagem,
          tipo: tipo,
          DataHora: DataHora,
          acao: acao
        }
        se o tipo for mensagem salvar o email de quem mandou na acao...
      */
      print("Notificação Recebida");
    });
  }

/*await OneSignal.shared.postNotification(
                                  OSCreateNotification(
                                    playerIds: [_replyTo['playerId']],
                                    content: _newMsg.text,
                                    heading: "Nova mensagem de ${userController.user.displayName}",
                                    buttons: [
                                      OSActionButton(text: "Cancelar", id: "id1"),
                                      OSActionButton(text: "Responder", id: "id2"),
                                    ],
                                  ),
                                ); */
//Enviar Notificações pelo app
}
