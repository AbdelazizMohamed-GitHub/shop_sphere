import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop_sphere/features/explor/data/model/massage_model.dart';
import 'package:shop_sphere/features/explor/presention/controller/chat_cubit/chat_cubit.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key, required this.userId});

  final TextEditingController _controller = TextEditingController();

  final String userId;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ChatCubit(userId: userId),
      child: Scaffold(
        appBar: AppBar(title: const Text("ShopSphere Chatbot 🤖")),
        body: Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('messages')
                    .orderBy('timestamp', descending: false)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData)
                    return const CircularProgressIndicator();

                  final docs = snapshot.data!.docs;
                  return ListView.builder(
                    itemCount: docs.length,
                    itemBuilder: (context, index) {
                      final message = Message.fromMap(
                          docs[index].data() as Map<String, dynamic>);
                      final isUser = message.sender == 'user';
                      return Align(
                        alignment: isUser
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 8),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: isUser ? Colors.blue : Colors.grey[300],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            message.text,
                            style: TextStyle(
                                color: isUser ? Colors.white : Colors.black),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: "اكتب رسالتك...",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    if (_controller.text.isNotEmpty) {
                      context.read<ChatCubit>().sendMessage(_controller.text);
                      _controller.clear();
                    }
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
