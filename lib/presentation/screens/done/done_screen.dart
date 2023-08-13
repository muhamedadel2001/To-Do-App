import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bussines_logic/app_cubit.dart';
import '../../views/list_builder.dart';

class DoneScreen extends StatefulWidget {
  const DoneScreen({Key? key}) : super(key: key);

  @override
  State<DoneScreen> createState() => _DoneScreenState();
}

class _DoneScreenState extends State<DoneScreen> {

  late List<Map> tasksList;
  @override
  void didChangeDependencies() {
    tasksList = AppCubit.get(context)
        .done;
    super.didChangeDependencies();
  }


    @override
    Widget build(BuildContext context) {
      return BlocBuilder<AppCubit, AppState>(
        builder: (context, state) {
          return ListBuilder(
            checked: 1,
            noTasks: 'No Tasks Done',
            tasks: tasksList,
          );
        },
      );
    }


}
