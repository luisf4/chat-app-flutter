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
  final String text;
  final Timestamp timestamp;

  Message(
      {required this.senderUid, required this.text, required this.timestamp});

  Map<String, dynamic> toMap() {
    return {
      'senderUid': senderUid,
      'text': text,
      'timestamp': timestamp,
    };
  }
}

// Salva um inicio de conversa
class Conversation {
  final String contactName;
  final String lastMessage;
  final Timestamp timestamp;
  final String conversationId;

  Conversation(
      {required this.contactName,
      required this.lastMessage,
      required this.timestamp,
      required this.conversationId});

  Map<String, dynamic> toMap() {
    return {
      'contactName': contactName,
      'lastMessage': lastMessage,
      'timestamp': timestamp,
      'conversationId': conversationId,
    };
  }
}

// Cria uma nova conversa
Future<void> saveNewConversation(Conversation newMessage, uid) {
  return usersCollection
      .doc(uid)
      .collection('conversation')
      .add(newMessage.toMap());
}

// busca todoas as menssagens
Stream<QuerySnapshot> getMessages(id) {
  return messagesCollection
      .doc(id)
      .collection('chat')
      .orderBy('timestamp', descending: false)
      .snapshots();
}
