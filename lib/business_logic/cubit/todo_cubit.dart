import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:sqflite/sqflite.dart';
import 'package:task_2/presentation/screens/new_tasks.dart';
import 'package:path/path.dart';
import '../../presentation/screens/all_tasks.dart';
import '../../presentation/screens/completed_tasks.dart';
import '../../presentation/screens/favorites_tasks.dart';
import '../../presentation/screens/uncomplete_tasks.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  TodoCubit() : super(TodoInitial());

  static TodoCubit get(context) => BlocProvider.of(context);

  int tabBarIndex = 0;

  List<Map> allTasks = [];
  List<Map> completedTasks = [];
  List<Map> incompleteTasks = [];
  List<Map> favoriteTasks = [];

  String dropdownvalue = '1 day before';

  List<String> reminderItems = [
    '1 day before',
    '1 hour before',
    '30 min before',
    '10 min before'
  ];

  String repeatedItemValue = 'Daily';
  List<String> repeatItems = [
    'Daily',
    'Weekly',
    'Monthly'
  ];

  List<Widget> screens = [
    AllTasksScreen(),
    CompletedScreen(),
    UncompletedScreen(),
    FavoritesScreen(),
    NewTasks()
  ];

  List<String> tabs = ['All', 'Complete', 'Incomplet', 'Favorites'];

  List<String> titles = [
    'All tasks screen',
    'Completed tasks screen',
    'Incomplete tasks screen',
    'Favorities tasks screen'
  ];

   static Database? database;

  void changeIndex(int index) {
    tabBarIndex = index;
    emit(TodoChangeTabBarState());
  }

  void createDatabase()  {
//    var databasesPath = await getDatabasesPath();
// String path = join(databasesPath, 'todo.db');

// // Delete the database
// await deleteDatabase(path);

    openDatabase('todo.db', version: 1, onCreate: (database, version) {
      print('created');
      database
          .execute(
              'create table tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, starttime TEXT, endtime TEXT,reminder TEXT,repeat TEXT, type TEXT)')
          .then((value) => value)
          .catchError((error) {
        print('Error when creating table ${error.toString()}');
      });
    }, onOpen: (database) {
      getDataFromDatabase(database);

      print('opend');
    }).then((value) {
      database = value;
      emit(TodoCreateDatabaseState());
    });
  }

  insertToDatabase(
      {required String title,
      required String date,
      required String starttime,
      required String endtime,
      required String reminder,
      required String repeat}) async {
    //  Database database;

    await database?.transaction((txn) {
      txn
          .rawInsert(
              'INSERT into tasks (title,date,starttime,endtime,reminder,repeat,type) VALUES ("$title","$date","$starttime","$endtime","$reminder","$repeat","new")')
          .then((value) 
          {
            print('$value inserted');
            emit(TodoInsertDatabaseState());

            getDataFromDatabase(database);
      }).catchError((error) {
        print('Error when inserting new record ${error.toString()}');
      });

      return Future<Null>(() {});
    });
  }

  void getDataFromDatabase(database)  {
            allTasks = [];
            completedTasks = [];
            incompleteTasks = [];
            favoriteTasks = [];

     database.rawQuery('SELECT * from tasks').then((value) {
           
            print(value);
            emit(TodoGetDatabaseState());

            value.forEach((element) { 
              if (element['type'] == 'new') {
                allTasks.add(element);
              }
              else if (element['type'] == 'done')
              {
                completedTasks.add(element);
              }
              else if (element['type'] == 'incomplete')
              {
                incompleteTasks.add(element);
              }
              else if (element['type'] == 'favorite')
              {
                favoriteTasks.add(element);
              }
              
            });
      });
  }
  

  void updateData({required String type, required int id}) {
    database!.rawUpdate(
    'UPDATE tasks SET type = ? WHERE id = ?',
    ['$type', id]).then((value) {
      
      getDataFromDatabase(database);
      emit(TodoUpdateDatabaseState());
    });
  }

   void deleteData({required int id}) {
    database!.rawDelete(
    'DELETE FROM tasks WHERE id = ?', [id]).then((value) {
      
      getDataFromDatabase(database);
      emit(TodoUpdateDatabaseState());
    });
  }
}
