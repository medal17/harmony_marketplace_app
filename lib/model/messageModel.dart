import 'package:trainapp/model/userModel.dart';
import 'userModel.dart';


class Message{
  final LocalUser sender;
  final String time;
  final String text;
  final bool read;
  final LocalUser reciever;

  Message(this.sender, this.read, this.text, this.time, this.reciever);
}

final LocalUser me = LocalUser();
final LocalUser ade = LocalUser();
final LocalUser olu = LocalUser();
final LocalUser bola = LocalUser();
final LocalUser lilo= LocalUser();
final LocalUser biljo = LocalUser();
//final LocalUser biljo = LocalUser('Biljo Communications', 5, 'shirt.jpg');


List <Message> chatList = [
  Message(ade, false, 'How much are you selling?', '12:00 AM', me),
  Message(bola, false, 'Last Price pls?', '13:00 AM',me),
  Message(olu, false, 'Still Available?', '12:04 AM', me),
  Message(biljo, false, 'What are the defects?', '12:00 AM',me),
  Message(lilo, true, 'What are the defects?', '12:50 AM', me),
  Message(bola, false, 'is it clean?', '12:00 AM', me),

];


List <Message> messages  = [
  Message(biljo, true, 'Just Sell it like that', '12:55 AM', me),
  Message(biljo, true, 'Just Sell it like that', '12:59 AM', me),
  Message(biljo, true, 'Just Sell it like that', '01:35 AM', olu),
  Message(biljo, true, 'Just Sell it like that pls', '01:55 AM', me),
  Message(olu, false, 'What are the defects?', '12:00 AM', me),
  Message(me, true, 'Just Sell it like that', '12:55 AM', olu),
  Message(me, true, 'What are the defects?', '12:00 AM', olu),

];

