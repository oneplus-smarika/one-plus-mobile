import 'dart:core';
import 'package:flutter/material.dart';
import '../core.dart';

class AppMethods {
  static showFlexibleSizeBottomSheet({
    required Widget widget,
    required BuildContext context,
    bool isScrollable = true,
    bool showConstraints = true,
  }) {
    return showModalBottomSheet(
      backgroundColor: AppColors.gray500,
      isScrollControlled: isScrollable,
      // constraints: BoxConstraints(maxHeight: 0.70.sh),
      constraints:
          showConstraints ? const BoxConstraints(maxHeight: 0.70) : null,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.0),
          topRight: Radius.circular(25.0),
        ),
      ),
      builder: (context) => Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: widget,
      ),
    );
  }

  static void showLoaderDialog(BuildContext context,
      {String? txt, bool dismissible = true}) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(
              margin: const EdgeInsets.only(left: 8),
              child: CText(txt ?? "Loading...")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: dismissible,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static void dismissLoaderDialog(BuildContext context) {
    // Navigator.pop(context);
    Navigator.of(context, rootNavigator: true).pop();  }

  static Future<bool?> showConfirmDialog(
    BuildContext context,
    String title,
    String message,
    String? id,
  ) async {
    return await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        surfaceTintColor: AppColors.white,
        title: CText(
          title,
          type: TextType.titleLarge,
        ),
        content: SingleChildScrollView(
          child: CText(message),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: CText('Cancel'),
          ),
          TextButton(
            onPressed: () {
              print("Property Deleted");
              // context.pop();
              // Navigator.pop(context,true);
            },
            child: const CText('Confirm'),
          ),
        ],
      ),
    );
  }


  static showCustomSnackBar({
    required BuildContext context,
    required String message,
    Color textColor = Colors.white,
    Color backgroundColor = AppColors.mainColor,
    bool isError = false,
    Duration duration = const Duration(milliseconds: 1500),
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(color: textColor),
        ),
        backgroundColor: isError ? Colors.redAccent : backgroundColor,
        duration: duration,
      ),
    );
  }







}
