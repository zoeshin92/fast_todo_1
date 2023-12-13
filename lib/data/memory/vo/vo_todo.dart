import 'package:fast_app_base/data/memory/todo_status.dart';

class Todo {
  int id;
  String title;
  DateTime dueDate;
  final DateTime createdTime;
  TodoStatus status;
  DateTime? modifyTime;

  Todo({
    required this.id,
    required this.title,
    required this.dueDate,
    this.status = TodoStatus.incomplete,
    this.modifyTime,
  }) : createdTime = DateTime.now();
}
