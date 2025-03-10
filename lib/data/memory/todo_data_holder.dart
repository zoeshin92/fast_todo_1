import 'package:fast_app_base/data/memory/todo_status.dart';
import 'package:fast_app_base/data/memory/vo/vo_todo.dart';
import 'package:fast_app_base/screen/dialog/d_confirm.dart';
import 'package:fast_app_base/screen/main/write/d_write_todo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final todoDataProvider = StateNotifierProvider<TodoDataHolder, List<Todo>>(
  (ref) => TodoDataHolder(),
);

class TodoDataHolder extends StateNotifier<List<Todo>> {
  TodoDataHolder() : super([]);

  void changeTodoStatus(Todo todo) async {
    switch (todo.status) {
      case TodoStatus.complete:
        final result = await ConfirmDialog('다시 처음 상태로 변경하시겠어요?').show();
        result?.runIfSuccess((data) {
          todo.status = TodoStatus.incomplete;
        });
      case TodoStatus.incomplete:
        todo.status = TodoStatus.ongoing;
      case TodoStatus.ongoing:
        todo.status = TodoStatus.complete;
    }
    state = List.of(state);
  }

  void addTodo() async {
    final result = await WriteTodoDialog().show();
    if (result != null) {
      state.add(
        Todo(
            id: DateTime.now().microsecondsSinceEpoch,
            title: result.text,
            dueDate: result.dateTime),
      );
      state = List.of(state);
    }
  }

  void editTodo(Todo todo) async {
    final result = await WriteTodoDialog(todoForEdit: todo).show();
    if (result != null) {
      todo.title = result.text;
      todo.dueDate = result.dateTime;
      state = List.of(state);
    }
  }

  void removeTodo(Todo todo) {
    state.remove(todo);
    state = List.of(state);
  }
}

extension TodoListHolderProvider on WidgetRef {
  TodoDataHolder get readTodoHolder => read(todoDataProvider.notifier);
}
