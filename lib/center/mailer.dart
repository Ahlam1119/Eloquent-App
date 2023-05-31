import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class MailManagement {
  final String email = "eloquent86@gmail.com";
  final String pass = "zpwixjagxjrmnabj";
  late SmtpServer smtpServer = gmail(email, pass);

  static sendEmail(
      {required SmtpServer smtpServer,
      required String senderEmail,
      required String senderName,
      required String recieverEmail,
      required String title,
      required String body}) async {
    final message = Message()
      ..from = Address(senderEmail, senderName)
      ..recipients.add(recieverEmail)
      ..subject = title
      ..text = body;
    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: $sendReport');
    } on MailerException catch (e) {
      print('Message not sent.');
      print(e);
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
  }
}
