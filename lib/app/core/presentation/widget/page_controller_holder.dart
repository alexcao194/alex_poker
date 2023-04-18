import 'package:flutter/material.dart';

class PageControllerHolder extends InheritedWidget {
  const PageControllerHolder({super.key, required super.child, required this.pageController});
  final PageController pageController;

  static PageControllerHolder? _maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<PageControllerHolder>();
  }

  static PageControllerHolder of(BuildContext context) {
    final PageControllerHolder? result = _maybeOf(context);
    assert(result != null, 'No PageControllerHolder found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(covariant PageControllerHolder oldWidget) {
    if(oldWidget.pageController.hasClients) {
      return oldWidget.pageController.page != pageController.page;
    }
    return false;
  }
}
