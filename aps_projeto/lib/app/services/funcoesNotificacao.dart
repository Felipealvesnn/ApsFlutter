import 'dart:math';

import 'package:aps_projeto/app/services/notificacaoawasome.dart';

class NotificacoesGerais {
  static Future<void> notificarEstacionar() async {
    
    int _generateRandomId() {
      // Use a combinação de DateTime e Random para gerar um ID único e aleatório
      final random = Random();
      final currentTimeMillis = DateTime.now().millisecondsSinceEpoch;
      final randomId = random.nextInt(999999) + currentTimeMillis;
      return randomId;
    }

    CustomNotification notification = CustomNotification(
      id: _generateRandomId(),
      title: "App emprestado",
      body: "Data de devolver o produto ta chegando.",
      payload: "emprestado",
    );
    try {
      await NotificationAwesomeNotification.showNotification(
        title: notification.title,
        body: notification.body,
        // summary: "Sumario",
        interval: 2, //para gerar a notificaoao
        scheduled: true, // parar gerar notifiação precisa ser tru
      );
    } catch (e) {
      print(e);
    }
  }
}

class CustomNotification {
  final int id;
  final String title;
  final String body;
  final String payload;

  CustomNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
  });
}
