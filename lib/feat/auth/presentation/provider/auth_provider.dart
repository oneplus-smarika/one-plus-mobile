import 'package:flutter_riverpod/flutter_riverpod.dart';

final phoneProvider = StateProvider<String>((ref) => '');

// State to hold the OTP input
final otpProvider = StateProvider<String>((ref) => '');

// State to hold OTP verification result (null = idle, true = success, false = failure)
final otpVerificationStateProvider = StateProvider<bool?>((ref) => null);

// Providers for managing form register state
final fullNameProvider = StateProvider.autoDispose<String>((ref) => '');
final genderProvider = StateProvider.autoDispose<String>((ref) => 'Female');
final contactNumberProvider = StateProvider.autoDispose<String>((ref) => '');
