// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:shop_sphere/core/service/notification_service.dart';

class AddNotificationScreen extends StatefulWidget {
  const AddNotificationScreen({
    super.key,
    required this.fCM,
  });
  final String fCM;

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<AddNotificationScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Notification'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _bodyController,
              decoration: const InputDecoration(
                labelText: 'Body',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () async {
                if (_titleController.text.isNotEmpty &&
                    _bodyController.text.isNotEmpty) {
                  String token=await NotificationService.getToken() ?? '';
                  print('$token');
                  await NotificationService.sendNotification(
                    title: _titleController.text,
                    body: _bodyController.text,
                    token: token,
                  );
                  Navigator.pop(context);
                }
              },
              icon: const Icon(Icons.send),
              label: const Text('Send Notification'),
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
