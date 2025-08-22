import 'package:flutter/material.dart';
import 'package:oneplus_app/core/core.dart';
import '../../data/model/notification_data.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  void markAllAsRead() {
    setState(() {
      for (var notification in notifications) {
        notification['isRead'] = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        iconTheme: const IconThemeData(color: AppColors.white),
        title: const CText(
          'Notifications',
          color: AppColors.white,
          type: TextType.headlineSmall,
        ),
        actions: [
          TextButton(
            onPressed: markAllAsRead,
            child: const Text(
              'Read All',
              style: TextStyle(
                color: AppColors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16.0),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          final colors = AppColors.getColors(!notification['isRead']);

          return Container(
            margin: const EdgeInsets.only(bottom: 12.0),
            decoration: BoxDecoration(
              color: colors.containerColor,
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: colors.borderColor),
            ),
            child: ListTile(
              leading: Icon(
                Icons.notifications,
                color: colors.iconColor,
                size: 30,
              ),
              title: CText(
                notification['title'],
                color: colors.textColor,
                type: TextType.titleMedium,
                fontWeight: FontWeight.w600,
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CText(
                    notification['description'],
                    color: colors.textColor,
                    type: TextType.bodyMedium,
                  ),
                  AppSpacing.verticalSpaceTiny,
                  CText(
                    notification['time'],
                    color: AppColors.mainColor,
                    type: TextType.bodySmall,
                  ),
                ],
              ),
              onTap: () {
                setState(() {
                  notification['isRead'] = true;
                });
              },
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider();
        },
      ),
    );
  }
}
