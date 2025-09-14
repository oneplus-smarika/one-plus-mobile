import 'package:flutter_riverpod/flutter_riverpod.dart';

final phoneProvider = StateProvider<String>((ref) => '');
final otpProvider = StateProvider<String>((ref) => '');
final otpVerificationStateProvider = StateProvider<bool?>((ref) => null);
final fullNameProvider = StateProvider<String>((ref) => '');
final genderProvider = StateProvider<String?>((ref) => null);
final contactNumberProvider = StateProvider<String>((ref) => '');
