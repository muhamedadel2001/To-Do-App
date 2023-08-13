import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/presentation/screens/done/done_screen.dart';
import 'package:todo_app/presentation/screens/tasks/tasks_screen.dart';
part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());
  static AppCubit get(context) => BlocProvider.of<AppCubit>(context);
  int currIndex = 0;
  late Database database;
  String initialType = 'Personal';
  List<Widget> screens = [
    const TasksScreen(),
    const DoneScreen(),
  ];
  List<String> appBar = ['Tasks', 'Done'];
  void changeBottomAppBar(int index) {
    currIndex = index;
    emit(AppChangeBottomAppState());
  }

  void changeDropDown(String? text) {
    initialType = text!;
    emit(ChangeDropDownAppState());
  }

  List<Map> tasks = [];
  List<Map> done = [];

  void createDatabase() {
    openDatabase(
      'tasks.db',
      version: 1,
      onCreate: (db, version) {
        if (kDebugMode) {
          print('Database created!');
        }
        db
            .execute(
                'CREATE TABLE tasks(id INTEGER PRIMARY KEY,works TEXT,checked BOOLEAN ,type TEXT)')
            .then((value) {
          if (kDebugMode) {
            print('table created!');
          }
        }).catchError((error) {
          if (kDebugMode) {
            print('error happened while create table$error');
          }
        });
      },
      onOpen: (db) {
        getTasks(db);
        if (kDebugMode) {
          print('Database opened');
        }
      }).then((value) {
        print(value);
      database = value;

      print(database);
      emit(OpenDatabaseAppState());

    });
  }
  void getTasks(Database database) async {
    emit(LoadingDatatAppState());
    tasks.clear();
    done.clear();
    await database.rawQuery('SELECT *FROM tasks').then((value) {
      for (Map<String, Object?> element in value) {
        tasks.add(element);
        if (element['checked'] == 1) {
          tasks.remove(element);
          done.add(element);
        }
      }
    });
    emit(GetDataAppState());
  }

  insertToAccount({
    required String text,
    required String type,
  }) async {
    await database.transaction((txn) {
      return txn.rawInsert(
          'INSERT INTO tasks(works,type,checked)VALUES("$text","$type",false)');
    }).then((value) {
      if (kDebugMode) {
        print('contact$value success inserted');
      }
      emit(InsertedDataToDatabaseAppState());
      getTasks(database);
    }).catchError((error) {
      if (kDebugMode) {
        print('error while insert $error');
      }
    });
  }



  void addCheckedOrRemove({required int checked, required int id}) async {
    await database.rawUpdate(
        'UPDATE tasks SET checked=?WHERE id=?', [checked, id]).then((value) {

      getTasks(database);
      emit(AddOrRemoveCheckedAppState());
    });
  }

  Future<void> update(
      {required int id, required String task, required String type}) async {
    await database.rawUpdate('UPDATE tasks SET works=?,type=?WHERE id=?',
        [task, type, id]).then((value) {
      getTasks(database);
      emit(UpdateDataAppState());
    });
  }

  Future<void> delete({required int id}) async {
    await database
        .rawUpdate('DELETE FROM tasks WHERE id=?', [id]).then((value) {
      getTasks(database);
      emit(DeleteDataAppState());
    });
  }
}
