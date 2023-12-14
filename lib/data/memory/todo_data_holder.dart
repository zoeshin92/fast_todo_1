import 'package:fast_app_base/common/common.dart';
import 'package:fast_app_base/data/memory/todo_data_notifier.dart';
import 'package:fast_app_base/data/memory/todo_status.dart';
import 'package:fast_app_base/data/memory/vo/vo_todo.dart';
import 'package:fast_app_base/screen/dialog/d_confirm.dart';
import 'package:fast_app_base/screen/main/write/d_write_todo.dart';
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

  static TodoDataHolder _of(BuildContext context) {
    TodoDataHolder inherited =
        context.dependOnInheritedWidgetOfExactType<TodoDataHolder>()!;
    return inherited;
  }

  void changeTodoStatus(Todo todo) async {
    TodoStatus nextStatus = todo.status;
    switch (todo.status) {
      case TodoStatus.complete:
        final result = await ConfirmDialog('다시 처음 상태로 변경하시겠어요?').show();
        if (result?.isFailure == true) {
          return;
        }
        result?.runIfSuccess((data) {
          nextStatus = TodoStatus.incomplete;
        });
      case TodoStatus.incomplete:
        nextStatus = TodoStatus.ongoing;
      case TodoStatus.ongoing:
        nextStatus = TodoStatus.complete;
      // case TodoStatus.unknown:
      //   return;
    }
    // final Todo todoForSave = todo.copyWith(status: nextStatus);
    // final responseResult = await todoRepository.updateTodo(todoForSave); //객체 안의 status 바꿔서 update요청
    // processResponseResult(responseResult, todoForSave);
  }

  void addTodo(BuildContext context) async {
    final result = await WriteTodoDialog().show();
    if (result != null) {
      notifier.addTodo(
        Todo(
            id: DateTime.now().microsecondsSinceEpoch,
            title: result.text,
            dueDate: result.dateTime),
      );
    }
  }

  void editTodo(Todo todo) async {
    final result = await WriteTodoDialog(todoForEdit: todo).show();
    if (result != null) {
      todo.title = result.text;
      todo.dueDate = result.dateTime;
      notifier.notify();
    }
  }

  void removeTodo(Todo todo) {
    notifier.value.remove(todo);
    notifier.notify();
  }
}

extension TodoDataHolderContextExtension on BuildContext {
  TodoDataHolder get todoHolder => TodoDataHolder._of(this);
}
