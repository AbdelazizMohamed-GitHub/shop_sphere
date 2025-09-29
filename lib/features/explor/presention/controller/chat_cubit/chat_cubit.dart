import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_sphere/features/explor/data/model/massage_model.dart';
import 'package:shop_sphere/features/explor/presention/controller/chat_cubit/chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit({required this.userId}) : super(ChatInitial());

  final String userId;
  final _firestore = FirebaseFirestore.instance;

  Future<void> sendMessage(String text) async {
    emit(ChatLoading());
  try {
      final ref = _firestore
        .collection('users')
        .doc(userId)
        .collection('messages');

    // 1. Save user message
    final userMessage = Message(
      text: text,
      sender: 'user',
      timestamp: DateTime.now(),
    );
    await ref.add(userMessage.toMap());

    // 2. Fake Bot Logic
    final botReply = _getBotReply(text);

    // 3. Save bot reply
    final botMessage = Message(
      text: botReply,
      sender: 'bot',
      timestamp: DateTime.now(),
    );
    await ref.add(botMessage.toMap());

    emit(ChatSuccess());
  } catch (e) {
      emit(ChatError(error: e.toString()));
    
  }
  }

  String _getBotReply(String userInput) {
    if (userInput.contains('مرحبا')) {
      return ' مرحبا بك في قسم العروض 🌹';
    } else if (userInput.contains('منتج')) {
      return 'ممكن تلاقي المنتج في قسم العروض 🛒';
    } else if (userInput.contains('سعر')) {
      return 'الأسعار بتبدأ من 100 جنيه 💰';
    } else {
      return 'ممكن توضح أكتر؟ 🤔';
    }
  }
}
