import 'package:flutter/material.dart';

/// Provides whether the current widget subtree belongs to the visible page.
/// Used by animation widgets to avoid firing on off-screen pages when
/// using IndexedStack.
class ActivePage extends InheritedWidget {
  final bool isActive;

  const ActivePage({
    super.key,
    required this.isActive,
    required super.child,
  });

  static bool isActiveOf(BuildContext context) {
    return context
            .dependOnInheritedWidgetOfExactType<ActivePage>()
            ?.isActive ??
        true;
  }

  @override
  bool updateShouldNotify(ActivePage oldWidget) =>
      oldWidget.isActive != isActive;
}
