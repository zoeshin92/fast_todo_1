import 'package:fast_app_base/common/common.dart';
import 'package:fast_app_base/data/memory/todo_status.dart';
import 'package:fast_app_base/data/memory/vo/vo_todo.dart';
import 'package:fast_app_base/screen/main/tab/todo/w_fire.dart';
import 'package:flutter/material.dart';

class TodoStatusWidget extends StatelessWidget {
  final Todo todo;
  const TodoStatusWidget(this.todo, {super.key});

  @override
  Widget build(BuildContext context) {
    return Tap(
      onTap: () {
        context.todoHolder.changeTodoStatus(todo);
      },
      child: SizedBox(
        height: 50,
        width: 50,
        child: switch (todo.status) {
          TodoStatus.complete => Checkbox(
              value: true,
              onChanged: null,
              fillColor:
                  MaterialStateProperty.all(context.appColors.checkBoxColor),
            ),
          TodoStatus.incomplete => const Checkbox(
              value: false,
              onChanged: null,
            ),
          TodoStatus.ongoing => const Fire(),
          // TodoStatus.unknown => const Icon(
          //     Icons.question_mark,
          //     size: 25,
          //   ).centered(),
        },
      ),
    );
  }
}
