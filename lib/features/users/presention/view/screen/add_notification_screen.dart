// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shop_sphere/core/service/setup_locator.dart';
import 'package:shop_sphere/core/widget/custom_button.dart';
import 'package:shop_sphere/core/widget/custom_text_form.dart';
import 'package:shop_sphere/core/widget/warning.dart';
import 'package:shop_sphere/features/users/data/repo_impl/notification_repo_impl.dart';
import 'package:shop_sphere/features/users/presention/controller/add_notification_cubit/add_notification_cubit.dart';

class AddNotificationScreen extends StatefulWidget {
  const AddNotificationScreen({
    super.key,
    required this.fCM,
    required this.userName,
  });
  final String fCM;
  final String userName;

  @override
  State<AddNotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<AddNotificationScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AddNotificationCubit(notificationRepo: getIt<NotificationRepoImpl>()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add Notification'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 50),
              CustomTextForm(
                text: "Title",
                textController: _titleController,
                kType: TextInputType.text,
              ),
              const SizedBox(height: 16),
              CustomTextForm(
                lines: 4,
                text: "Body",
                textController: _bodyController,
                kType: TextInputType.text,
              ),
              const SizedBox(height: 30),
              BlocConsumer<AddNotificationCubit, AddNotificationState>(
                listener: (context, state) {
                  if (state is AddNotificationSuccess) {
                    Navigator.pop(context);
                  } else if (state is AddNotificationFailure) {
                    Warning.showWarning(context,
                        message: state.errMessage, isError: true);
                  }
                },
                builder: (context, state) {
                  return state is AddNotificationLoading
                      ? const Center(child: CircularProgressIndicator())
                      : CustomButton(
                          text: 'Send To ${widget.userName}',
                          onPressed: () async {
                            if (_titleController.text.isNotEmpty &&
                                _bodyController.text.isNotEmpty) {
                              await context
                                  .read<AddNotificationCubit>()
                                  .addNotification(
                                    token: widget.fCM.toString().trim(),
                                    title: _titleController.text.trim(),
                                    body: _bodyController.text.trim(),
                                  );
                            } else {
                              Warning.showWarning(context,
                                  message: 'Please fill all fields');
                            }
                          },
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
