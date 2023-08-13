import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:todo_app/bussines_logic/app_cubit.dart';
import 'package:todo_app/presentation/views/update_dialog.dart';

class TaskItemBuilder extends StatelessWidget {
  const TaskItemBuilder({Key? key, required this.taskModel}) : super(key: key);
  final Map taskModel;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 3.h),
          child: Checkbox(
              value: taskModel['checked'] == 0 ? false : true,
              activeColor: Colors.teal,
              onChanged: (value) {
                AppCubit.get(context).addCheckedOrRemove(
                    checked: value == false ? 0 : 1, id: taskModel['id']);
              }),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(top: 6.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: Text(
                    taskModel['works'],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        taskModel['type'],
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 9.sp,
                        ),
                      ),
                    ),
                    BlocBuilder<AppCubit, AppState>(
                      builder: (context, state) {
                        return Padding(
                          padding: EdgeInsetsDirectional.only(start: 1.w),
                          child: Visibility(
                              visible: taskModel['type'] == 'Personal',
                              replacement: Icon(Icons.person,
                                  color: Colors.deepPurple, size: 13.sp),
                              child: Icon(
                                Icons.circle,
                                color: Colors.blue,
                                size: 7.sp,
                              )),
                        );
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        Padding(
            padding: EdgeInsets.only(top: 2.h, left: 3.w),
            child: IconButton(
              onPressed: () => showDialog(
                  context: context,
                  builder: (context) => UpdateTask(
                        taskModel: taskModel,
                      ),
                  barrierDismissible: false),
              icon: Icon(
                Icons.edit,
                color: Colors.grey,
                size: 15.sp,
              ),
            )),
        Padding(
          padding: EdgeInsets.only(top: 2.h),
          child: IconButton(
              onPressed: () {
                AppCubit.get(context).delete(id: taskModel['id']);
              },
              icon: Icon(
                Icons.delete,
                color: Colors.grey,
                size: 15.sp,
              )),
        ),
      ],
    );
  }
}
