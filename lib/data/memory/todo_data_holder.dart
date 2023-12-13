import 'package:fast_app_base/data/memory/todo_data_notifier.dart';
import 'package:flutter/material.dart';

class TodoDataHolder extends InheritedWidget {
  final TodoDataNotifier notifier;

  const TodoDataHolder(
      {super.key, required super.child, required this.notifier});

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
  // -> app.dart의 MaterialApp을 TodoDataHolder로 감싼다.

  static TodoDataHolder of(BuildContext context) {
    TodoDataHolder inherited =
        context.dependOnInheritedWidgetOfExactType<TodoDataHolder>()!;
    return inherited;
  }
}
