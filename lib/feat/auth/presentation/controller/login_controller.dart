import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../provider/auth_provider.dart';

/// Controller provider for TextEditingController
final phoneControllerProvider = Provider.autoDispose<TextEditingController>((ref) {
  final controller = TextEditingController();

  // Sync controller text with phoneProvider value
  ref.listen<String>(phoneProvider, (previous, next) {
    if (controller.text != next) {
      controller.text = next;
      controller.selection = TextSelection.fromPosition(
        TextPosition(offset: controller.text.length),
      );
    }
  });

  return controller;
});
