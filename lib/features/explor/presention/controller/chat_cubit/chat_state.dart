import 'package:shop_sphere/features/explor/data/model/massage_model.dart';

class ChatState {}
class ChatInitial extends ChatState {}
class ChatLoading extends ChatState {}
class ChatSuccess extends ChatState {

} 
class ChatError extends ChatState {
  final String error;
  ChatError({required this.error});
}