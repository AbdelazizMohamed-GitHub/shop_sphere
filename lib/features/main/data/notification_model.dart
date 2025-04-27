import 'package:hive/hive.dart';
part 'notification_model.g.dart';

@HiveType(typeId: 0)
class NotificationModel extends HiveObject {
 
  @HiveField(0)

  final String title;
@HiveField(1)
  final String description;
@HiveField(2)
  final DateTime date;

  NotificationModel({required this.title, required this.description, required this.date});
}