import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:todo_app/presentation/views/task_item.dart';

import '../widgets/default_lists_divider.dart';

class ListBuilder extends StatelessWidget {
  const ListBuilder(
      {Key? key,
      required this.noTasks,
      required this.tasks,
      required this.checked})
      : super(key: key);
  final String noTasks;
  final List<Map> tasks;
  final int checked;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: tasks.isNotEmpty,
      replacement: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.no_accounts,
              size: 50.sp,
            ),
            Text(
              noTasks,
              style: TextStyle(
                  color: Colors.teal,
                  fontSize: 25.sp,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
      child: ListView.separated(
          itemBuilder: (context, index) => TaskItemBuilder(taskModel: tasks[index],),
          separatorBuilder: (context, index) => const DefaultListsDivider(),
          itemCount: tasks.length),
    );
  }
}
