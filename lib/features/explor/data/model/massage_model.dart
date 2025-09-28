import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String text;
  final String sender;
  final DateTime timestamp;

  Message({
    required this.text,
    required this.sender,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'sender': sender,
      'timestamp': timestamp,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      text: map['text'] ?? '',
      sender: map['sender'] ?? 'user',
      timestamp: (map['timestamp'] as Timestamp).toDate(),
    );
  }
}
