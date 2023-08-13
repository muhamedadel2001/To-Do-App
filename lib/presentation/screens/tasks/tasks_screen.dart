import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../bussines_logic/app_cubit.dart';
import '../../views/list_builder.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({Key? key}) : super(key: key);

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  late List<Map> tasksList;

  @override
  void didChangeDependencies() {
    tasksList = AppCubit.get(context)
        .tasks;
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return ListBuilder(
          checked: 0,
          noTasks:'No Tasks Added' ,
          tasks: tasksList,
        );
      },
    );

  }
}
