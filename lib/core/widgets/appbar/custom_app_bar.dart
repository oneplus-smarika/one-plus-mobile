import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core.dart';

class CustomAppBar extends ConsumerWidget implements PreferredSizeWidget {
  final String? title;
  final Function()? onLeadingIconClick;
  final Widget? leadingIcon;
  final bool showLeading;
  final Color? appBarColor, titleColor, surfaceColor;
  final List<Widget>? actions;
  final double? leadingWidth;
  final Widget? titleWidget;
  final bool centerTitle;
  final double? appBarElevation;
  final double? custPreferredSize;
  final PreferredSizeWidget? bottom;
  final bool showSearch;
  final bool showProfile;

  const CustomAppBar({
    super.key,
    this.title,
    this.leadingWidth = 64,
    this.onLeadingIconClick,
    this.leadingIcon,
    this.appBarColor,
    this.titleColor = AppColors.white,
    this.actions,
    this.titleWidget,
    this.centerTitle = false,
    this.surfaceColor,
    this.appBarElevation,
    this.showLeading = false,
    this.custPreferredSize,
    this.bottom,
    this.showSearch = true,
    this.showProfile = true,
  });

  @override
  Size get preferredSize => Size.fromHeight(custPreferredSize ?? 52);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      backgroundColor: appBarColor,
      surfaceTintColor: surfaceColor,
      elevation: appBarElevation,
      leadingWidth: leadingWidth,
      leading: showLeading
          ? leadingIcon ??
              IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: AppColors.white,
                ),
                onPressed: onLeadingIconClick,
              )
          : null
          ,
      centerTitle: centerTitle,
      title: titleWidget ??
          Text(
            title ?? '',
            style: TextStyle(color: titleColor),
          ),
      actions: actions,
      bottom: bottom,
      titleSpacing: 0,
      automaticallyImplyLeading: false,
      toolbarHeight: custPreferredSize,
      );
  }
}
