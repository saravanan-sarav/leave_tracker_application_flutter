import 'package:flutter_riverpod/flutter_riverpod.dart';

class PageNavigation extends StateNotifier {
  PageNavigation(super.state);

  int getState(){
    return state;
  }
  void changeNavigationPage(int index) {
    state = index;
  }
}

final pageNavigatorProvider = StateNotifierProvider((ref) => PageNavigation(0));
