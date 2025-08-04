//
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// Future<void> openEmailApps() async {
//   try {
//     if (Platform.isAndroid) {
//       // Open Gmail on Android
//       final gmailUri = Uri.parse("market://launch?id=com.google.android.gm");
//       if (await canLaunchUrl(gmailUri)) {
//         await launchUrl(gmailUri);
//       } else {
//         await launchUrl(Uri.parse("https://play.google.com/store/apps/details?id=com.google.android.gm"));
//       }
//     }
//     else if (Platform.isIOS) {
//       // Try opening Apple Mail app
//       final mailtoUri = Uri.parse('mailto:');
//       if (await canLaunchUrl(mailtoUri)) {
//         await launchUrl(mailtoUri);
//       }
//       // Try opening Gmail if installed
//       else {
//         final gmailUri = Uri.parse("googlegmail://");
//         if (await canLaunchUrl(gmailUri)) {
//           await launchUrl(gmailUri);
//         }
//         // Redirect to App Store if Gmail is not installed
//         else {
//           await launchUrl(Uri.parse("https://apps.apple.com/app/gmail-email-by-google/id422689480"));
//         }
//       }
//     }
//   } catch (e) {
//     debugPrint('Error launching email app: $e');
//   }
// }
