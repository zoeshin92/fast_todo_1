import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:fast_app_base/common/common.dart';
import 'package:fast_app_base/common/dart/extension/datetime_extension.dart';
import 'package:fast_app_base/common/widget/rounded_container.dart';
import 'package:fast_app_base/data/memory/vo/vo_todo.dart';
import 'package:fast_app_base/screen/main/tab/todo/%08w_todo_status.dart';
import 'package:flutter/material.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;

  const TodoItem(this.todo, {super.key});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(todo.id),
      onDismissed: (direction) {
        context.todoHolder.removeTodo(todo);
      },
      child: RoundedContainer(
        margin: const EdgeInsets.only(bottom: 6),
        color: context.appColors.removeTodoBg,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            todo.dueDate.formattedDate.text.make(),
            Row(
              children: [
                TodoStatusWidget(todo),
                Expanded(child: todo.title.text.size(20).medium.make()),
                IconButton(
                  onPressed: () async {
                    context.todoHolder.editTodo(todo);
                  },
                  icon: const Icon(EvaIcons.editOutline),
                )
              ],
            ),
          ],
        ).pOnly(top: 15, right: 15, left: 5, bottom: 10),
      ),
    );
  }
}
