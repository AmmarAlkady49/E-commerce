import 'package:e_commerce_graduation/core/utils/helper_functions.dart';
import 'package:e_commerce_graduation/core/utils/themes/app_bar_default_theme.dart';
import 'package:e_commerce_graduation/core/utils/themes/font_helper.dart';
import 'package:e_commerce_graduation/core/utils/themes/my_color.dart';
import 'package:e_commerce_graduation/core/utils/themes/notification_storage.dart';
import 'package:e_commerce_graduation/features/notification/models/notification_message_model.dart';
import 'package:e_commerce_graduation/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationPage extends StatefulWidget {
  final List<NotificationMessageModel> notifications;
  const NotificationPage({super.key, required this.notifications});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  late List<NotificationMessageModel> _notifications;

  @override
  void initState() {
    super.initState();
    _notifications = widget.notifications;
  }

  void _clearNotifications() async {
    await NotificationStorage.clearNotifications();
    setState(() {
      _notifications = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.seasalt,
      appBar: AppBarDefaultTheme(
        title: S.of(context).notification,
        actions: [
          SizedBox(width: 10.w),
          Builder(builder: (context) {
            return InkWell(
              borderRadius: BorderRadius.circular(10),
              onTapUp: (TapUpDetails details) {
                final RenderBox renderBox =
                    context.findRenderObject() as RenderBox;
                final Offset offset =
                    renderBox.localToGlobal(details.globalPosition);

                showMenu(
                  context: context,
                  position: RelativeRect.fromLTRB(offset.dx + -100,
                      offset.dy + -20.h, offset.dx + 40, offset.dy + 10),
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  elevation: 5,
                  items: [
                    PopupMenuItem(
                      onTap: _clearNotifications,
                      child: Text(S.of(context).delete_all,
                          style: FontHelper.fontText(
                              context: context,
                              size: 14.sp,
                              weight: FontWeight.w600,
                              color: MyColor.poppy)),
                    ),
                  ],
                );
              },
              child:
                  Icon(CupertinoIcons.ellipsis_vertical, color: Colors.white),
            );
          }),
          SizedBox(width: 10.w),
        ],
      ),
      body: _notifications.isEmpty
          ? _buildEmptyState(context)
          : _buildNotificationList(_notifications),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Notification Bell Icon with modern styling
          Container(
            width: 120.w,
            height: 120.h,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  MyColor.kellyGreen3.withAlpha(90),
                  MyColor.kellyGreen3.withAlpha(40),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              shape: BoxShape.circle,
              border: Border.all(
                color: MyColor.kellyGreen3.withAlpha(40),
                width: 2,
              ),
            ),
            child: Icon(
              Icons.notifications_none_outlined,
              size: 60.sp,
              color: MyColor.kellyGreen3,
            ),
          ),

          SizedBox(height: 16.h),

          // Main title
          Text(
            S.of(context).no_notifications_yet,
            style: FontHelper.fontText(
              size: 20.sp,
              weight: FontWeight.w700,
              color: MyColor.jet,
              context: context,
            ),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 12.h),

          // Subtitle
          Text(
            S.of(context).notification_empty_message,
            style: FontHelper.fontText(
              size: 16.sp,
              weight: FontWeight.w400,
              color: MyColor.gray,
              context: context,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationList(List<NotificationMessageModel> notifications) {
    return ListView.builder(
      padding: EdgeInsets.all(16.w),
      itemCount: _notifications.length,
      itemBuilder: (context, index) {
        final notification = _notifications[index];
        return Container(
          margin: EdgeInsets.only(bottom: 12.h),
          decoration: BoxDecoration(
            color: MyColor.white,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: MyColor.kellyGreen3.withAlpha(40),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: ListTile(
            contentPadding:
                EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
            leading: Container(
              width: 48.w,
              height: 48.h,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    MyColor.kellyGreen3,
                    MyColor.kellyGreen3.withAlpha(190),
                  ],
                ),
                shape: BoxShape.circle,
              ),
              child: Icon(
                notification.icon,
                color: MyColor.white,
                size: 24.sp,
              ),
            ),
            title: Text(
              notification.title,
              style: FontHelper.fontText(
                size: 16.sp,
                weight: FontWeight.w700,
                color: MyColor.jet,
                context: context,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 4.h),
                Text(
                  notification.message,
                  style: FontHelper.fontText(
                    size: 14.sp,
                    weight: FontWeight.w600,
                    color: MyColor.gray,
                    context: context,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  HelperFunctions.formatNotificationTime(
                      notification.time, context),
                  style: FontHelper.fontText(
                    size: 12.sp,
                    weight: FontWeight.w700,
                    color: MyColor.kellyGreen3,
                    context: context,
                  ),
                ),
              ],
            ),
            // trailing: !notification.isRead
            //     ? Container(
            //         width: 8.w,
            //         height: 8.h,
            //         decoration: BoxDecoration(
            //           color: MyColor.poppy,
            //           shape: BoxShape.circle,
            //         ),
            //       )
            //     : null,
          ),
        );
      },
    );
  }
}
