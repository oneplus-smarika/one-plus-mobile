// import 'package:flutter/material.dart';
// import 'package:notice_park/core/core.dart';
//
// class InitialsWidget extends StatelessWidget {
//   final String? name;
//   final double size; // Optional: to control the size of the circle
//   final TextType textType; // Optional: to customize text style
//   final Color backgroundColor; // Optional: to customize background color
//   final Color textColor; // Optional: to customize text color
//
//   const InitialsWidget({
//     Key? key,
//     this.name,
//     this.size = 50.0,
//     this.textType = TextType.titleMedium,
//     this.backgroundColor = AppColors.mainColor,
//     this.textColor = AppColors.white,
//   }) : super(key: key);
//
//   String _getInitials(String? name) {
//     if (name == null || name.trim().isEmpty) {
//       return 'N/A';
//     }
//     final nameParts = name.trim().split(' ');
//     String initials = '';
//     if (nameParts.isNotEmpty) {
//       initials = nameParts[0][0].toUpperCase();
//       if (nameParts.length > 1) {
//         initials += nameParts.last[0].toUpperCase();
//       }
//     }
//     return initials.isNotEmpty ? initials : 'N/A';
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final initials = _getInitials(name);
//
//     return ClipOval(
//       child: Container(
//         width: size,
//         height: size,
//         color: backgroundColor,
//         alignment: Alignment.center,
//         child: CText(
//           initials,
//           type: textType,
//           color: textColor,
//           fontWeight: FontWeight.w600,
//         ),
//       ),
//     );
//   }
// }