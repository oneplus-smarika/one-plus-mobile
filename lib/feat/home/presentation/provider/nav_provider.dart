import 'package:flutter_riverpod/flutter_riverpod.dart';

class NavigationState {
  final int selectedIndex;

  NavigationState({
    required this.selectedIndex,
  });
}

final navigationProvider =
StateNotifierProvider<NavigationNotifier, NavigationState>(
      (ref) => NavigationNotifier(),
);

class NavigationNotifier extends StateNotifier<NavigationState> {
  NavigationNotifier() : super(NavigationState(selectedIndex: 0));

  void navigate(int index) {
    state = NavigationState(selectedIndex: index);
  }

  void reset() {
    state = NavigationState(selectedIndex: 0); // Reset to index 0
  }
}