import 'package:flutter_riverpod/flutter_riverpod.dart';

class PageNavigation extends StateNotifier<int> {
  PageNavigation(super.state);

  int getState() {
    return state;
  }

  void changeNavigationPage(int index) {
    state = index;
  }
}

final pageNavigatorProvider =
    StateNotifierProvider<PageNavigation, int>((ref) => PageNavigation(0));
