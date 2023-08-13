import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:todo_app/bussines_logic/app_cubit.dart';

import '../../views/insert_task_dialog.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  late AppCubit cubit;

  @override
  void initState() {
    cubit = AppCubit.get(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.teal[300],
          appBar: AppBar(
            title: Text(
              cubit.appBar[cubit.currIndex],
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.sp),
            ),
            backgroundColor: Colors.teal[300],
            centerTitle: true,
            elevation: 0,
          ),
          floatingActionButton: Visibility(
            visible: cubit.currIndex == 0,
            replacement: Container(),
            child: FloatingActionButton(
              onPressed: () => showDialog(
                  context: context,
                  builder: (context) =>  InsertDialog(),
                  barrierDismissible: false),
              backgroundColor: Colors.teal,
              elevation: 15,
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          body: Stack(
            children: [
              Padding(
                padding: EdgeInsetsDirectional.only(
                    start: 15.sp, end: 15.sp, bottom: 25.sp, top: 10.sp),
                child: Container(
                   // width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.sp)),
                    child: cubit.screens[cubit.currIndex]),
              )
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: cubit.currIndex,
            onTap: (index) => cubit.changeBottomAppBar(index),
            backgroundColor: Colors.teal,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.black,
            items: [
              BottomNavigationBarItem(
                  icon: const Icon(Icons.home), label: cubit.appBar[0]),
              BottomNavigationBarItem(
                  icon: const Icon(Icons.done), label: cubit.appBar[1])
            ],
          ),
        );
      },
    );
  }
}
