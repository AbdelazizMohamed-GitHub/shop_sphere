import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop_sphere/core/utils/app_color.dart';
import 'package:shop_sphere/features/explor/data/model/massage_model.dart';
import 'package:shop_sphere/features/explor/presention/controller/chat_cubit/chat_cubit.dart';
import 'package:shop_sphere/features/explor/presention/controller/chat_cubit/chat_state.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key, required this.userId});

  final TextEditingController _controller = TextEditingController();

  final String userId;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatCubit(userId: userId),
      child: Scaffold(
        appBar: AppBar(title: const Text("ShopSphere Chatbot 🤖")),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
              Expanded(
                child: BlocBuilder<ChatCubit, ChatState>(
                  builder: (context, state) {
                    return Stack(
                      children: [
                        StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('users')
                              .doc(userId) // ✅ لازم نفس path اللي بتحفظ فيه
                              .collection('messages')
                              .orderBy('timestamp', descending: false)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }

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
                                      color: isUser
                                          ? Colors.blue
                                          : Colors.grey[300],
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      message.text,
                                      style: TextStyle(
                                          color: isUser
                                              ? Colors.white
                                              : Colors.black),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),

                        // 👇 اللودينج يظهر فوق الرسائل
                        if (state is ChatLoading)
                          const Align(
                            alignment: Alignment.bottomLeft,
                            child: Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CircularProgressIndicator(strokeWidth: 2),
                                  SizedBox(width: 8),
                                  Text("الرد قيد التحضير ..."),
                                ],
                              ),
                            ),
                          ),
                      ],
                    );
                  },
                ),
              ),
              Builder(
                builder: (context) {
                  return Row(
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
                        icon: const Icon(
                          Icons.send,
                          color: AppColors.primaryColor,
                          size: 25,
                        ),
                        onPressed: () async {
                          if (_controller.text.isNotEmpty) {
                            await context
                                .read<ChatCubit>()
                                .sendMessage(_controller.text);
                            _controller.clear();
                          }
                        },
                      )
                    ],
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
