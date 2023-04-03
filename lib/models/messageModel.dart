// Importar as bibliotecas necessárias
// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';

// Criar a coleção de usuários
final CollectionReference usersCollection =
    FirebaseFirestore.instance.collection('users');

// Criar a coleção de mensagens
final CollectionReference messagesCollection =
    FirebaseFirestore.instance.collection('messages');

// Definir a estrutura do documento de mensagem
class Message {
  final String senderUid;
  final String recipientUid;
  final String text;
  final Timestamp timestamp;

  Message(
      {required this.senderUid,
      required this.recipientUid,
      required this.text,
      required this.timestamp});

  Map<String, dynamic> toMap() {
    return {
      'senderUid': senderUid,
      'recipientUid': recipientUid,
      'text': text,
      'timestamp': timestamp,
    };
  }
}

// Salva um inicio de conversa
class Conversation {
  final String senderUid;
  final String recipientUid;
  final String lastMessage;
  final Timestamp timestamp;
  final String id;

  Conversation(
      {required this.senderUid,
      required this.recipientUid,
      required this.lastMessage,
      required this.timestamp,
      required this.id});

  Map<String, dynamic> toMap() {
    return {
      'senderUid': senderUid,
      'recipientUid': recipientUid,
      'lastMessage': lastMessage,
      'timestamp': timestamp,
      'conversationId': id,
    };
  }
}

// Salvar uma nova mensagem no banco de dados
Future<void> saveMessage(Message message) {
  return messagesCollection.add(message.toMap());
}

// Buscar todas as mensagens trocadas entre dois usuários
Stream<QuerySnapshot> getMessagesBetweenUsers(
    String senderUid, String recipientUid) {
  return messagesCollection
      .where('senderUid', isEqualTo: senderUid)
      .where('recipientUid', isEqualTo: recipientUid)
      .snapshots();
}

Future<void> saveTalkUser(Conversation newMessage) {
  return messagesCollection.add(newMessage.toMap());
}
